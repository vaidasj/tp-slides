# Object/Relational Mapping (ORM)

Technologinės platformos

Programų sistemų kūrimas

## Object/Relational Mapping

- https://en.wikipedia.org/wiki/Object-relational_mapping: 
  - ORM is a programming technique for converting data between incompatible type systems in object-oriented programming languages
- RDBMS: Relational Model + Relational Calculus/Algebra
  - https://en.wikipedia.org/wiki/Relational_model 
- OOP: ehh, what is calculus? Let me write my program :)
  - https://en.wikipedia.org/wiki/Object-oriented_programming#Formal_semantics
- OOP is really different from Relational Model 

???

Object-relational mapping (ORM, O/RM, and O/R mapping tool) in computer science is a programming technique for converting data between incompatible type systems using object-oriented programming languages. This creates, in effect, a "virtual object database" that can be used from within the programming language. There are both free and commercial packages available that perform object-relational mapping, although some programmers opt to construct their own ORM tools.

In object-oriented programming, data-management tasks act on object-oriented (OO) objects that are almost always non-scalar values. For example, an address book entry that represents a single person along with zero or more phone numbers and zero or more addresses. This could be modeled in an object-oriented implementation by a "Person object" with attributes/fields to hold each data item that the entry comprises: the person's name, a list of phone numbers, and a list of addresses. The list of phone numbers would itself contain "PhoneNumber objects" and so on. The address-book entry is treated as a single object by the programming language (it can be referenced by a single variable containing a pointer to the object, for instance). Various methods can be associated with the object, such as a method to return the preferred phone number, the home address, and so on.

However, many popular database products such as SQL database management systems (DBMS) can only store and manipulate scalar values such as integers and strings organized within tables. The programmer must either convert the object values into groups of simpler values for storage in the database (and convert them back upon retrieval), or only use simple scalar values within the program. Object-relational mapping implements the first approach.[1]

The heart of the problem involves translating the logical representation of the objects into an atomized form that is capable of being stored in the database while preserving the properties of the objects and their relationships so that they can be r

## Relational Model

![Relational Model](images/relational-model.png "Relational Model")

## Why programming language needs calculus?

```java
public static void main(String[] args) {
	Integer[] intArray = new Integer[]{1, 2, 3};
	Object[] objArray = intArray;
	objArray[1] = "Oi ojojoj...";
}
```

- Compiles successfully
  - Crashes during runtime.. :(
- Java doesn’t have formal calculus
  - Scala has: [DOT calculus](http://www.scala-lang.org/blog/2016/02/03/essence-of-scala.html)

## Calculus

- There have been several attempts at formalizing the concepts used in object-oriented programming 
- The following concepts and constructs have been used as interpretations of OOP concepts:
  - co algebraic data types
  - abstract data types (which have existential types) allow the definition of modules but these do not support dynamic dispatch
  - recursive types
  - encapsulated state
  - inheritance
  - records are basis for understanding objects
- Attempts to find a consensus definition or theory behind objects have not proven very successful

???

Calculus is the study of continuous change, so anything that changes in a continuous way will involve calculus. Specifically everything you see in a video game is likely driven by models from calculus, all physics, all shading and almost all animations.

Objects are the run-time entities in an object-oriented system. They may represent a person, a place, a bank account, a table of data, or any item that the program has to handle.

For example, some definitions focus on mental activities, and some on program structuring. One of the simpler definitions is that OOP is the act of using "map" data structures or arrays that can contain functions and pointers to other maps, all with some syntactic and scoping sugar on top. Inheritance can be performed by cloning the maps (sometimes called "prototyping").

Scala: The tricky bit is to carefully distinguish between the full typing rules, which allow inconsistencies, and the typing rules arising from runtime values, which do not.

## Object/Relational Mapping

![ORM](images/orm.png "ORM")

## Main Idea of ORM

![ORM Idea](images/orm-idea.png "ORM Idea")

## Mapping Strategies

1. Database first – Java classes are generated from DB
2. Domain model (Java classes) first – DB schema is generated
3. _Meet in the middle_ – both domain model and DB are designed by hand, somebody struggles to map the two

> For prototypes, start-ups, short-term projects the second approach is recommended.

## ORM and JPA (Java Persistence API)

- JPA is ORM standard (API specification) for Java
- Most popular JPA implementations:
  - Hibernate (Red Hat)
  - EclipseLink (Eclipse.org)
  - OpenJPA (Apache)

???

The Java Persistence API (JPA) is a Java application programming interface specification that describes the management of relational data in applications using Java Platform, Standard Edition and Java Platform, Enterprise Edition.

> The technical objective of this work is to provide an object/relational mapping facility for the Java application developer using a Java domain model to manage a relational database.

Persistence in this context covers three areas:

- the API itself, defined in the javax.persistence package
- the Java Persistence Query Language (JPQL)
- object/relational metadata

> The reference implementation for JPA is EclipseLink. https://en.wikipedia.org/wiki/Java_Persistence_API

## JPA Entities

- JPA Entity is simple (POJO) Java class satisfying requirements of _JavaBeans specification_
  - Setters and getters must conform to strict form
- Every entity must have _primary key_
  - Annotation `@Id` marks the property that will be used as the entitie’s primary key
- Entities may have simple business logic methods
  - These methods should operate only with entities internal fields
- Complex business logic should be implemented in dedicated _business components_

## Java Bean

- A JavaBean is just a standard
  - All properties private (use getters/setters)
  - A public no-argument constructor
  - Implements Serializable

> That's it. It's just a convention. Lots of libraries depend on it though.

???

With respect to Serializable, from the API documentation:

Serializability of a class is enabled by the class implementing the java.io.Serializable interface. Classes that do not implement this interface will not have any of their state serialized or deserialized. All subtypes of a serializable class are themselves serializable. The serialization interface has no methods or fields and serves only to identify the semantics of being serializable.

In other words, serializable objects can be written to streams, and hence files, object databases, anything really.

Also, there is no syntactic difference between a JavaBean and another class -- a class defines a JavaBean if it follows the standards.

## Example of Entity

```java
@Entity
public class Account {
  @Id // The primary key
  @GeneratedValue(strategy=GenerationType.IDENTITY)
  private int accountNumber;

  @Column(name = "OWNER_NAME", nullable="false")
  private String ownerName; // Persistent property

  private int balance;      // Persistent too

  private transient int tmpVariable; // Not persistent!

  // Entities must have a public no-arg constructor
  public Account() {}

  // setters and getters; better with Lombok @Getter/@Setter
  ...
  // Deposit a given amount (simple business method)
  public void deposit(int amount) { balance += amount; }
}
```

## JPA requirements for entity classes

- JPA requires only two pieces of metadata when you are creating a persistent class: 
  - the `@javax.persistence.Entity` annotation denotes that the class should be mapped to your database, 
  - the `@javax.persistence.Id` annotation marks which property in your class will be used as the primary key. 
- The persistence provider will assume that all other properties in your class will map to a column of the same name and of the same type. 
- The table name will default to the unqualified name of the bean class 

## Additional Requirements (Best Practices)

- Every independent entity additionally to JPA requirements should define:
  - business key
  - methods `equals()` and `hashCode()` that operate with business key
  - field annotated with `@Version` – used for optimistic locking
- What is an indepenent entity? 
  - Life cycle of independent entity doesn’t depend upon other entities
  - `Student` and `Univertity` are independent entities
  - Entity `Study journal` is dependent upon entity `Student` – study journal cannot exist without a student

???

hashCode() is used for bucketing in Hash implementations like HashMap, HashTable, HashSet, etc.

The value received from hashCode() is used as the bucket number for storing elements of the set/map. This bucket number is the address of the element inside the set/map.

When you do contains() it will take the hash code of the element, then look for the bucket where hash code points to. If more than 1 element is found in the same bucket (multiple objects can have the same hash code), then it uses the equals() method to evaluate if the objects are equal, and then decide if contains() is true or false, or decide if element could be added in the set or not.

https://www.baeldung.com/java-hashcode

## Business Key

- Primary key is used by RDBMS to guarantee referential integrity of data
  - its value must not be meaningful (_e.g.: 32213523_)
  - it shouldn’t be shown in user interface
- Conversely, business key is a meaningful property (maybe composite property) of the entity that uniquely identifies the entity among other entities in some domain
- Entity may have multiple business keys, for example, entity `Student` might have these business keys:
  - student’s number
  - student’s social security number
  - student’s personal code

## Business Key

- What properties of an entity comprise business key decide domain experts and/or logical data model designers
- In relational databases business keys will be:
  - marked as `NOT NULL`
  - covered by _unique index_
- Examples:
  - Entity `University` – university’s title
  - Entity `Student` – student’s number
  - Entity `Course` – course code

## Methods equals() and hashCode()

- These methods are used by Java Collections API 
  - `Set`, `HashSet`, `List`, `ArrayList`, `Map`, etc.
- There are three choices for each entity:
  - these methods are absent;
  - we leave the methods generated by IDE (IntelliJ / Eclipse). Such methods use entity’s primary key (property annotated with `@Id`)
  - we override these methods and make them use only entity’s business key

## Comparison of three choices

| | Without methods equals() and hashCode() | Methods use only @Id property | Methods use business key |
|------------------------------------------------|-------------------------------|--------------------------|-----|
| May be used in composite key? | No | Yes | Yes |
| Multiple new instances in set? | Yes | No | Yes |
| Equal to same entity from other EntityManager? | No | Yes | Yes |
| Collections intact after saving to DB? | Yes | No | Yes |

> https://developer.jboss.org/wiki/EqualsAndHashCode 

## Requirements Summary

- Every entity must have:
  - Primary Key (@Id)
  - Business Key. This property will have _unique index_ (`NOT NULL`, `UNIQUE`) in database 
  - `equals()` and `hashCode()` methods that use only business key
  - Field annotated with `@Version` – used for optimistic locking

## Example

```java
@Entity
public class University 
       implements Serializable {
  @Id
  @GeneratedValue(strategy=
      GenerationType.IDENTITY)
  private Integer id;

  private String title;

  @Version
  private int optLockVersion;


  @Override
  public int hashCode() {
    int hash = 3;
    hash = 59 * hash + 
      (this.title != null 
         ? this.title.hashCode() 
         : 0);
      return hash;
  }
```

## Example continue

```java
  @Override
  public boolean equals(Object obj) {
    if (obj == null) return false;
    if (getClass() != obj.getClass()) 
        return false;

    final University other = (University) obj;
  
    if ((this.title == null) 
      ? (other.title != null) : !this.title.equals(
         other.title)) {
      return false;
    }
  
    return true;
  }
}
```

## Example with Lombok

```java
@Entity
@Getter
@Setter
@EqualsAndHashCode(of={"title"})
public class University implements Serializable {
  @Id
  @GeneratedValue(strategy=GenerationType.IDENTITY)
  private Integer id;

  @Column(name = "TITLE", nullable="false")
  private String title;

  @Column(name = "OPT_LOCK_VERSION")
  @Version
  private int optLockVersion;
  
}
```


