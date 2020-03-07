# JPA Relationships

Technologinės platformos

Programų sistemų kūrimas

## Relationship Example

![Relationship Example](images/relationship.png "Relationship Example")

## Unidirectional one-to-one

```java
@Entity 
@Getter 
@Setter
public class StudyJournal implements Serializable {
  ...
  
  @OneToOne
  private Student student;
  
  ...
}
```

> Table StudyJournal has foreign key to table Student – it is _owner_

## Bidirectional one-to-one

```java
@Entity 
@Setter 
@Getter
public class Student implements Serializable {
  ... 
  
  @OneToOne(mappedBy=”student”)
  private StudyJournal studyJournal;
  
}
```

## Owning Side

- Why is the notion of a owning side necessary:
  - The idea of a owning side of a bidirectional relation comes from the fact that in relational databases there are no bidirectional relations like in the case of objects. In databases we only have unidirectional relations - foreign keys.
- What is the reason for the name owning side:
  - The owning side of the relation tracked by JPA is the side of the relation that owns the foreign key in the database.
- What is the problem that the notion of owning side solves?


## Example

```java
@Entity
@Table(name="PERSONS")
public class Person {
    @OneToMany
    private List<IdDocument>  idDocuments;
}

@Entity
@Table(name="ID_DOCUMENTS")
public class IdDocument {
    @ManyToOne
    private Person person;
}
```

## Owning Side

- From a OO point of view this mapping defines not one bi-directional relation, but two separate uni-directional relations.
- The mapping would create not only tables `PERSONS` and `ID_DOCUMENTS`, but would also create a third association table `PERSONS_ID_DOCUMENTS`:


```sql
CREATE TABLE PERSONS_ID_DOCUMENTS
(
  persons_id bigint NOT NULL,
  id_documents_id bigint NOT NULL,
  CONSTRAINT fk_persons FOREIGN KEY (persons_id) 
              REFERENCES persons (id),
  CONSTRAINT fk_docs FOREIGN KEY (id_documents_id) 
              REFERENCES id_documents (id),
  CONSTRAINT pk UNIQUE (id_documents_id)
)
```

- Notice the primary key pk on `ID_DOCUMENTS` only. In this case JPA tracks both sides of the relation independently: 

## Owning Side

- If you add a document to relation `Person.idDocuments`, it inserts a record in the association table `PERSON_ID_DOCUMENTS`.
- On the other hand, if we call `idDocument.setPerson(person)`, we change the foreign key person_id on table `ID_DOCUMENTS`. JPA is creating two unidirectional (foreign key) relations on the database, to implement one bidirectional object relation.
- Many times what we want is only a foreign key on table `ID_DOCUMENTS` towards `PERSONS` and no extra association table.
- To solve this we need to configure JPA to stop tracking the modifications on relation `Person.idDocuments`. JPA should only track the other side of the relation `IdDocument.person`, and to do so we add mappedBy.

## Unidirectional many-to-one

```java
@Entity 
@Getter 
@Setter
public class Student implements Serializable {
  ...
  @ManyToOne
  private University university;

}
```

> Table Student contains a foreign key to table University. Student is _owner_.

## Bidirectional many-to-one

```java
@Entity 
@Getter 
@Setter
public class University implements Serializable {
  ...
  @OneToMany(mappedBy="university")
  private List<Student> students = new ArrayList<>();

}
```

## `mappedBy`

- It means something like: "modifications on this side of the relation are already _Mapped By_ the other side of the relation `IdDocument.person`, so no need to track it here separately in an extra table."
- Using `mappedBy`, If we only call `university.getStudents().add(student)`, the foreign key will NOT be linked to the new student, because this is not the owning /tracked side of the relation
- To link the student to the new university, you need to explicitly call `student.setUniversity(university)`, because that is the owning side of the relation.
- When using `mappedBy`, it is the responsibility of the developer to know what is the owning side, and update the correct side of the relation in order to trigger the persistence of the new relation in the database.

## Unidirectional many-to-many

```java
@Entity 
@Setter 
@Getter
public class Student implements Serializable {
  @ManyToMany
  @JoinTable(name=”STUDENT_COURSE”)
  private List<Course> courses = new ArrayList<>();

}
```

> Student - Course

## Bidirectional many-to-many

```java
@Entity 
@Getter 
@Setter
public class Course implements Serializable {
  @ManyToMany(mappedBy="courses")
  private List<Student> students = new ArrayList<>();

}
```

## What has to be known

- For one-to-one bidirectional relationships, the _owning_ side corresponds to the side that contains the corresponding _foreign key_
- The many side of one-to-many / many-to-one bidirectional relationships _must be the owning side_
- For many-to-many bidirectional relationships either side may be the owning side
- Bidirectional relationships will be persisted based on references held by the _owning side_ of the relationship
- **It is the developer’s responsibility to keep the in-memory references held on the owning side and those held on the inverse side consistent with each other when they change**

