# JPA and COP Integration

Technologinės platformos

Programų sistemų kūrimas

## Concepts

- **Connection pool** – DB connection store:
  - making a new connection is expensive, therefor some number of connections are being created during the startup of a system and stored within a pool
  - connection pool specifies: DBMS host/port, DB name, minimum/maximum number of connections, etc.
- **Data Source** is a pair: `{name, connectionPool}`
  - thus connection pool can be retrieved by its name
- **Persistence Unit** specifies data source and optional list of database tables
  - is defined in `persistence.xml` file

## persistence.xml

```xml
<?xml version="1.0" encoding="UTF-8"?>
<persistence version="2.1" ...>
  <persistence-unit name="StudentsPU" 
                    transaction-type="JTA">
    <jta-data-source>
      java:global/StudentsDataSource
    </jta-data-source>
  </persistence-unit>
  <persistence-unit name="ManualPU" 
                    transaction-type="RESOURCE_LOCAL">
    <non-jta-data-source>
      java:global/StudentsDataSource2
    </non-jta-data-source>
  </persistence-unit>
</persistence>
```

## Persistence Context and EntityManager

- **Persistence Context** – _cache_ of Entity objects
  - each EntityManager instance has its own single non-shared Persistence Context: one-to-one relationship
- _Official definition_:
  - a persistence context is _a set of managed entity instances_ in which for any persistent entity identity there is a unique entity instance. Within the persistence context, the entity instances and their lifecycle are managed by the entity manager.
- **EntityManager** – API to work with Persistence Context
  - to manage the cache programmatically

## Entity’s life-cycle 

![Entity’s life-cycle](images/entity-lifecycle.png "Entity’s life-cycle")

???

1. While entity is in managed state, changes are synchronized with DB automatically
2. Persistence Context (cache) contains only managed entities

## Entity’s life-cycle: states

- `new` – the entity instance was created in memory, but not yet in the database
  - Changes to the entity are not synchronized with the database – entity is not yet managed
- `managed` – the entity has a persistent identity in the database and is synchronized with the database 
  - Changes to the entity will be synchronized with the database automatically
- `detached` – the entity does have a persistent identity but is not synchronized with the database
- `removed` – the entity is deleted from the database

## Automatic Entity synchronization with DB

- While an entity is in managed state its persistent fields are automatically synchronized with database
  - Most often synchronization happens just before transaction commit
  - Changes in database (performed by some other application) are not brought back to entity – **database is not being monitored for changes**
- Sometimes we want the synchronization to happen in the middle of the transaction
  - for example: we made some changes and we want these changes to be visible in the query that is executed later in this transaction
  - `flush()` forces to performe the synchronization at once

## Manual Entity refresh/save

- `refresh(entity)`
  - data from database are overwritten over entity’s data (at the end of transaction)
- `entity2 = merge(entity1)`:
- if `entity1` is managed
  - data of `entity1` is written to DB (at the end of transaction)
  - `entity1` is returned as result
- if `entity1` is not managed (is detached)
  - `entity1` is cloned
  - the clone is made managed (_entity1 remains detached_)
  - clone’s data is written to DB (at the end of transaction)
  - clone is returned as the result of `merge()` operation

## Entity Life-cycle: summary

- While entity is in managed state its data is automatically synchronized with database
  - less worries for a developer
- Managed state may be lost in two ways:
  - by asking to delete the entity from database by calling method `remove()`
  - when Persistence Context (cache) is destroyed (_in the picture: "Persistence context ends"_)
  - this can be done manually by calling: `EntityManager.close()`

## Manual EntityManager creation

```java
EntityManagerFactory emf = 
    Persistence.createEntityManagerFactory("StudentsPU");

// EM created manually
EntityManager em = emf.createEntityManager();

try {
  // manual transaction start
  em.getTransaction().begin();
  em.persist( new Student("Jonas Jonaitis") );
  em.getTransaction().commit();
} finally {
  // manual transaction end
  em.close();
}
```

## Challenges for Developers

- EntityManagers must not only be created but also closed too
  - otherwise free memory will end soon, since entities loaded by EntityManager are being cached
- EntityManager is not **thread-safe**
  - different threads must use different EntityManagers
- It is the responsibility of the application to ensure that an instance is managed by only a single EntityManager
- **So, one global EntityManager per whole system is not a solution**

## Unmanaged and Managed Persistence Contexts

- JPA comes with only **unmanaged** Persistence Contexts, developers must:
  - create and close EntityManager instances
  - manage memory
  - manage threads
- COP technologies (CDI, EJB, Spring) are capable to:
  - Create EntityManager instances automatically
  - Close EntityManager instances automatically, thus free memory
  - Manage threads

## Transactions (TX), EntityManager (EM), CDI, EJB

```xml
<persistence version="2.1" ...>
  <persistence-unit name="StudentsPU" 
    transaction-type="JTA">
    <jta-data-source>
      StudentsDataSource
    </jta-data-source>
  </persistence-unit>

  <persistence-unit name="ManualPU" 
    transaction-type="RESOURCE_LOCAL">
    <non-jta-data-source>
      StudentsDataSource2
    </non-jta-data-source>
  </persistence-unit>
</persistence>
```

## Transactions (TX), EntityManager (EM), CDI, EJB

|   | TX: Manual (RESOURCE_LOCAL) | TX: Declarative (JTA) |
| - | --------------------------- | --------------------- |
| EM: Manual      | emf.createEntityManager();<br><br>em.getTransaction().begin()/.commit() | emf.createEntityManager(SYNC_TYPE);<br><br>@Transactional |
| EM: CDI         | @Inject/@Produces/@Disposes<br><br>em.getTransaction().begin()/.commit() | @Inject/@Produces/@Disposes<br><br>@Transactional |
| EM: Spring, EJB | @PersistenceContext<br><br>em.getTransaction().begin()/.commit() | @PersistenceContext<br><br>Spring: @Transactional<br>EJB: @TransactionAttribute |

## CDI and JPA (declarative transactions)

- `@Inject EntityManager em`;
- Life-cycle:
  - Create - `@Produces`
  - Destroy - `@Disposes`
- Scope:
 - `@RequestScoped`
 - `@TransactionScoped`

## Request flow

![Request flow](images/request-flow.png "Request flow")

## Life-cycle management

```java
@ApplicationScoped
public class Resources {

    @PersistenceUnit
    private EntityManagerFactory emf;

    @Produces
    @RequestScoped
    private EntityManager createJTAEntityManager() {
      
        // Create a new JTA application-managed EntityManager.
        return emf.createEntityManager(
          SynchronizationType.SYNCHRONIZED);
    }

    private void closeUnsynchronizedEntityManager(
      @Disposes EntityManager em) {
        em.close();
    }
}
```

## Controller

```java
@Model // @Named and @RequestScoped
public class RequestUseCaseController {
    @Getter
    private Course course = new Course();
    @Getter
    private Student student = new Student();
    @Inject
    private CourseDAO courseDAO;
    @Inject
    private StudentDAO studentDAO;

    @Transactional
    public void createCourseStudent() {
        student.getCourseList().add(course);
        course.getStudentList().add(student);
        courseDAO.create(course);
        studentDAO.create(student);
    }

    public List<Student> getAllStudents() {
        return studentDAO.getAllStudents();
    }
}
```

## Data Access Object (DAO)

```java
@ApplicationScoped
public class StudentDAO {
    @Inject
    private EntityManager em;

    public void create(Student student) {
        em.persist(student);
    }

    public List<Student> getAllStudents() {
        return em.createNamedQuery(
                  "Student.findAll", Student.class)
                 .getResultList();
    }
}
```

## Summary

- CDI, Spring, EJB and JPA are well integrated
  - automatic transactions, automatic cache life-cycle management, persistence context (cache) propagation
- Without CDI/Spring things would be much more difficult:
  - manual transactions
  - manual EntityManager creation and closing
  - EntityManagers would have to be passed as parameters to other components implementing the same use-case
  - manual thread management: developers would have to ensure that two threads are not using the same EntityManager
