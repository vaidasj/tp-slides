# Databases: Isolation and Locking

Technologinės platformos

Programų sistemų kūrimas

## Isolation 

- In database systems, isolation determines how transaction integrity is visible to other users and systems
- Isolation is one of the ACID (Atomicity, Consistency, Isolation, Durability) properties
- Most DBMSs offer a number of transaction isolation levels, which control the degree of locking that occurs when selecting data
- For many database applications, the majority of database transactions can be constructed to avoid requiring high isolation levels (e.g. _SERIALIZABLE_ level), thus reducing the locking overhead for the system.
- The programmer must carefully analyze database access code to ensure that any relaxation of isolation does not cause software bugs that are difficult to find

## Locking 

- Two-phase locking is the most common transaction concurrency control method in DBMSs, used to provide both serializability and recoverability for correctness
- In order to access a database object a transaction first needs to acquire a lock for this object
- Depending on the access operation type (e.g., reading or writing an object) and on the lock type, acquiring the lock may be blocked and postponed, if another transaction is holding a lock for that object
- If higher isolation levels are used, the possibility of deadlock is increased, which also requires careful analysis and programming techniques to avoid

## Concepts: Dirty read

- A dirty read (aka uncommitted dependency) occurs when a transaction is allowed to read data from a row that has been modified by another running transaction and not yet committed

![Dirty Reads](images/dirty-reads.png "Dirty Reads")

## Concepts: Non-repeatable read

- A non-repeatable read occurs, when during the course of a transaction, a row is retrieved twice and the values within the row differ between reads

![Non-rep read](images/non-rep-read.png "Non-rep read")

## Concepts: Phantom Read

- A phantom read occurs when, in the course of a transaction, new rows are added by another transaction to the records being read.

![Phantom read](images/phantom-read.png "Phantom read")

## Concepts: Deadlock

- In concurrent computing, a deadlock is a state in which each member of a group is waiting for some other member to take action, such as sending a message or more commonly releasing a lock

![Deadlock](images/deadlock-in-dbms.png "Deadlock")

## Isolation levels

- **Read Uncommitted**
  - _Dirty reads_ are allowed, so one transaction may see not-yet-committed changes made by other transactions
- **Read Committed**
  - _Non-repeatable reads_ phenomenon CAN occur (`SELECT` single record may return different values)
- **Repeatable Reads**
  - _Phantom reads_ CAN occur (`SELECT COUNT(*)` returns different results)
- **Serializable**
  - Perfect? No. Concurrent work is very slow, high probability of deadlocks

## Isolation levels

- Since each isolation level is stronger than those below, in that no higher isolation level allows an action forbidden by a lower one
- The standard permits a DBMS to run a transaction at an isolation level stronger than that requested
  - E.g. _Read committed_ transaction may actually be performed at a _Repeatable read_ isolation level
- Most RDBMS by default set _Read Committed_ transaction isolation level
- Both _Repeatable Read_ and _Serializable_ are too expensive most of the time
- But sometimes we want to have _Repeatable Read_ semantics temporarily
  - Request or conversation type use-cases

## Optimistic locking

- _Read Committed_ isolation level is not sufficient to guarantee data consistency, but it has sufficiently good DB performance profile
- _Repeatable Reads_ isolation level solves most data consistency problems, but DB performance suffers
- **Optimistic locking** can be a solution from application side
- Using optimistic locking in JPA rises isolation level to **Repeatable reads**
  - JPA achieves Repeatable reads in the simplest way possible - by preventing _Non-Repeatable read_ phenomenon
  - JPA is not sophisticated enough to keep snapshots of your reads
  - It simply prevents second read from happening by rising an exception (if the data has changed from the first read).

## Optimistic locking: JPA

- Each table must have additional column storing version information (a number)
- Corresponding field of JPA entity must be marked with `@Version`
- By default `LockModeType.OPTIMISTIC` is being used
  - no manual work is needed by programmer
  - combined with _Read Committed_ isolation level solves most data consistency problems
- `LockModeType.OPTIMISTIC_FORCE_INCREMENT` may be used additionally to prevent Phantom Reads phenomenon

## JPA: Lock modes

- No lock mode – version attributes are being checked _only for entities that were updated_
- The use of optimistic lock modes causes the persistence provider to check the version attributes:
  - for entities that _were read_ during a transaction, 
  - and _were updated_
- The use of _pessimistic lock_ modes requires JPA to immediately acquire long-term read or write locks for the database data corresponding to entity state

```java
EntityManager.find(entityClass, primaryKey, 
  LockModeType lockMode)
EntityManager.lock(LockModeType lockMode)
```

## Only @Version

![Basic](images/opt-1.png "Basic")

## When @Version not enough

![Advanced](images/opt-2.png "Advanced")

## LockModeType.OPTIMISTIC

- If transaction T1 calls for a lock of type `LockModeType.OPTIMISTIC` on a versioned object, the entity manager must ensure that neither of the following phenomena can occur:
  - _Dirty read_: Transaction T1 modifies a row. Another transaction T2 then reads that row and obtains the modified value, before T1 has committed or rolled back. Transaction T2 eventually commits successfully.
  - _Non-repeatable read_: Transaction T1 reads a row. Another transaction T2 then modifies or deletes that row, before T1 has committed. Both transactions eventually commit successfully.
- Calling `LockModeType.OPTIMISTIC_FORCE_INCREMENT` on a versioned object, will also force an update (increment) to the entity's version column.

## Fix non-repeatable read

![Advanced](images/opt-2-g.png "Advanced")

## Association handling

![Advanced](images/opt-3.png "Advanced")

## OPTIMISTIC_FORCE_INCREMENT

![Advanced](images/opt-3-g.png "Advanced")

## Recovering from OptimisticLockException

- From JPA specification:
  - An OptimisticLockException always causes the transaction to be marked for rollback
  - Transaction rollback causes all pre-existing managed instances to become detached
- Thus execption handling code must initiate new transaction:
  - `@Transactional(REQUIRES_NEW)`

## Conclusions

- Using:
  - Read Committed isolation level in DB, plus
  - Optimistic locking in your application
- gives Repeatable Reads isolation level semantics without hindering DB transaction throughput
- With optimistic locking the faster transaction always wins
- Use pessimistic locking if that is not OK
