# JPA Declarative Transactions

Technologinės platformos

Programų sistemų kūrimas

## Transactions and Transaction Managers

- There are many transactional resources
  - Databases
  - Messaging middleware
- As programmers, we want _abstract_ transactions:
  - we do not want to deal with some transaction API specific to only Oracle or DB2
  - we might want to be able to have in one transaction:
  - several operations with several databases
  - several operations with several messaging providers

## Transaction Managers

- Transaction Managers (TM) provide us with such _abstract_ transactions
  - TM hides any complexities and API differences of particular transactional resources
  - TM provides for programmer _unified transaction_ API
- In Java EE these (unified) APIs are:
  - **Java Transaction API** (JTA) is meant for Software System programmers
  - **Java Transaction Service** (JTS) - is meant for Application Server implementers

## How to use Java Transaction API

- Client managed transactions
  - client programmer directly calls JTA API
- Component managed transactions
  - client is unaware of transactions, component programmer calls JTA API
- Container managed transaction
  - neither client nor component programmer calls JTA API, container does it **automatically**
  - also known as _declarative transactions_

???

https://docs.oracle.com/javaee/6/tutorial/doc/bncij.html
http://webdev.jhuep.com/~jcs/ejava-javaee/coursedocs/content/html/ejbtx-container.html#ejbtx-container-pc-propagation

A transaction is tied to a database connection which means you would have to share that connection between several threads. This is not safe. Also asynchronous code may for some reason be executed with large delay, e.g. under high CPU load. This would keep your transaction open for unnecessarily long time.
>https://stackoverflow.com/a/10549984

## Client-managed transactions

![Client-managed transactions](images/client-managed-tx.png "Client-managed transactions")

## Component-managed transactions

![Component-managed transactions](images/component-managed-tx.png "Component-managed transactions")

## Container-managed transactions

![Container-managed transactions](images/container-managed-tx.png "Container-managed transactions")

## Transaction attributes

![Transaction attributes](images/transaction-attributes.png "Transaction attributes")

## Transaction attribute `Required`

- Transactional attribute `Required`:
  - If a client invokes the component’s method while the client is associated with a transaction context, the container invokes the component’s method _in the client’s transaction context_. 
  - If the client invokes the component’s method while the client is not associated with a transaction context, the container automatically _starts a new transaction_ before delegating a method call to the component’s method. 
- If the business method invokes other components, the container passes the transaction context with the invocation. 
- The container attempts to commit the transaction when the method that _started the transaction_ has completed. 

## Container-managed transaction

![Example](images/container-managed-prop.png "Example")

## Example

```java
@RequestScoped
public class TellerBean implements Teller {

  @PersistenceContext private EntityManager em;

  @Transactional(Transactional.TxType.REQUIRED)
  public void transferFunds(long amount, 
  	String fromAccount, String toAccount) {

    // Load entities from DB:
    BankAccount ba1=em.find(BankAccount.class, fromAccount);
    BankAccount ba2=em.find(BankAccount.class, toAccount);

    ba1.withdraw(amount);
    ba2.deposit(amount);
  }
```

## Distributed transactions 

- In the following figure, a client invokes the enterprise bean X. 
- Bean X updates data using two database connections A and B. 
- Then X calls another enterprise bean, Y. 
  - Bean Y updates data in database C. 
- The Application Server (TM actually) ensures that the updates to databases A, B, and C are either all committed or all rolled back.

## Distributed transactions 

![Distributed Example](images/distributed-tx.png "Distributed Example")

## Distributed transactions 

- The application programmer does not have to do anything to ensure transactional semantics. 
- Behind the scenes, the TM enlists the database connections as part of the transaction. 
- When the transaction commits, the TM and the database systems perform a _two-phase commit_ protocol to ensure atomic updates across all three databases.

## Two-phase Commit

![Two-phase Example](images/two-phased.png "Two-phase Example")

> Two-phase commit protocol makes it possible to perform the updates to databases A and B in a single transaction

???

- https://www.ibm.com/developerworks/websphere/techjournal/0408_wakelin/0408_wakelin_images/transactions2.gif
- https://3.bp.blogspot.com/-K22oADAqfT0/VtwJiKtahHI/AAAAAAAAIHg/ZF1cHw7raQU/s1600/fig1.jpg

## Client-managed transactions

![Client-managed Example](images/distributed-client.png "Client-managed Example")

## What about .Net?

- Also has declarative transactions:
  - .NET Windows Communication Foundation (WCF) Transactions 
  - introduced in .NET 3.0 and built on top of System.Transactions available in .NET 2.0. 
- Provides a declarative approach to transaction management that is implemented using various attributes and properties, such as: 
  - `TransactionScopeRequired`
  - `TransactionAutoComplete` 
  - `TransactionFlow`
