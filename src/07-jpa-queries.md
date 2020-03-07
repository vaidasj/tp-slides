# JPA Queries

Technologinės platformos

Programų sistemų kūrimas

## Entity Lookup and Query API

- Find by primary key:

```java
public <T> T find(Class<T> entityClass, Object primaryKey);
```
- Create a Query for executing an JPA QL statement:

```java
public Query createQuery(String ejbqlString);
```

- Create a Query for executing a native SQL statement:

```java
public Query createNativeQuery(String sqlString);
```

## JPA QL example:

```java
public List<Account> listAccounts() {
  Query query = manager.createQuery(
      “SELECT a FROM Account a”);

  return query.getResultList();
}
```

## Named Queries

```java
@Entity
@NamedQuery(name=”findThem”, 
            queryString=”SELECT a FROM Account a”)
public class Account implements Serializable {
...

public List<Account> listAccounts() {
  Query query = manager.createNamedQuery(“findThem”);
  return query.getResultList();
}
```

## JOIN Operations

- A table will have a foreign key that corresponds to the primary key in another table

```java
SELECT c FROM Customer c JOIN c.orders o 
WHERE o.status = 1
```
> Only customers having at least one order will be returned

- Fetch Join (employees list gets preloaded from DB):

```java
SELECT d
FROM Department d JOIN FETCH d.employees 
WHERE d.deptno = 1
```

## More examples

```java
SELECT DISTINCT o
FROM Order o JOIN o.lineItems l JOIN l.product p
WHERE p.productType = ‘office_supplies’
```

- may equivalently be expressed as follows:

```java
SELECT DISTINCT o
FROM Order o JOIN o.lineItems l
WHERE l.product.productType = 'office_supplies'
```

- and as follows:

```java
SELECT DISTINCT o
FROM Order o
WHERE o.lineItems.product.productType = 'office_supplies'
```

## Queries with parameters

```java
...
@PersistenceContext
EntityManager manager;
...
public List findByName(String name) {
  return manager.createQuery(
      "SELECT e FROM Employee e "+
      "WHERE e.name LIKE :empName")
    .setParameter("empName", name)
    .listResults();
}
...
```

## Queries and SQL Injection Attacks

- Queries with Parameters Prevent SQL Injection Attacks
- They are precompiled on DB server, too, what is good for repeatedly executed queries (better performance)

![SQL Injection](images/sql-injection.png "SQL Injection")

## Object Construction in SELECT Statements

```java
@PersistenceContext
EntityManager manager;

public List getSomeInfo() {
 return manager.createQuery(
   "SELECT NEW pack.EmployeeInfo(c.name, e.name)"
   + "FROM Employee e JOIN e.company c"

 ).getResultList();
}
```

## Left Outer Join

- Return all clients and their orders (if some client doesn’t have an order, order will be NULL):

```java
SELECT NEW pack.ClientOrder(c, o)
FROM Customer c LEFT JOIN c.orders o
```
