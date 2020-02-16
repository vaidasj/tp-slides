# Component-Oriented Programming

Technologinės platformos

Programų sistemų kūrimas

## Component-based software engineering

- Component-based software engineering (CBSE), also called as component-based development (CBD), is a branch of software engineering that emphasizes the separation of concerns with respect to the wide-ranging functionality available throughout a given software system. 
- Software engineering practitioners regard components as part of the starting platform for service-orientation. 
- Components play this role, for example, in web services, and more recently, in service-oriented architectures (SOA), whereby a component is converted by the web service into a service and subsequently inherits further characteristics beyond that of an ordinary component.

## Service-Oriented Architecture

- A service-oriented architecture (SOA) is a style of software design where services are provided to the other components by application components, through a communication protocol over a network. The basic principles of service-oriented architecture are independent of vendors, products and technologies.
- A service is a discrete unit of functionality that can be accessed remotely and acted upon and updated independently, such as retrieving a credit card statement online.
- A service has four properties according to one of many definitions of SOA:
  - It logically represents a business activity with a specified outcome.
  - It is self-contained.
  - It is a black box for its consumers.
  - It may consist of other underlying services.

## SOA Elements

![SOA Elements](images/soa-elements.png "SOA Elements")

## Theoretical Component Definitions

- Szyperski: 
  - A software component  is a _unit of composition_ with contractually specified _interfaces_ and _explicit context dependencies only_. A software component can be _deployed_ independently and is subject to _composition_ by third parties
- D'Souza and Wills: 
  - A software component is a coherent _package_ of software artefacts that can be independently developed and _delivered_ as a unit and that can be _composed_, unchanged, with other components to build something larger
- UML v2.4:
  - A component represents a _modular part of a system_ that _encapsulates_ its contents and whose manifestation is _replaceable_ within its environment 
- http://en.wikipedia.org/wiki/Software_componentry

## Concepts: business logic and middleware

- Business logic (Dalykinis funkcionalumas)
  - models real life business objects
  - is part of functional requirements,
  - creates essential added value that customer is willing to pay for.
- Middleware (Sisteminis funkcionalumas) - software that provides services to business logic such as:
  - Transactions, logging, security, memory/thread management, etc.
  - is part of non-functional requirements; 
  - often is not documented at all.

## Explicit Middleware

- Money transfer between two accounts:

```java
void transfer(Account account1, Account account2,             long amount) {
  1: Perform a security check
  2: Create audit log record
  3: Begin a transaction
  4: Load data from the database
  5: account1 -= amount; account2 += amount;
  6: Store updated data to the database
  7: Commit the transaction
}

```

- Business logic is intertwined with the logic to call middleware services
  - Lowers developer productivity, difficult to write and maintain.

## Implicit Middleware

- What if we were able to write only business logic:

```java
void transfer(Account account1, Account account2,               long amount){
   account1 -= amount; account2 += amount;
}
```

- If middleware services are needed, we declare that in:
  - Annotations (e.g. @PersistenceContext, @Role, …), or
  - XML file
- Who calls middleware services?

## Essence of COP

![Essence of COP](images/essence-of-cop.png "Essence of COP")

## Components Characteristics 

The component needs to be:
- fully documented
- thoroughly tested
  - robust - with comprehensive input-validity checking
  - able to pass back appropriate error messages or return codes
- designed with an awareness that it will be put to unforeseen uses

[Hyrum's Law](https://www.hyrumslaw.com/):
> With a sufficient number of users of an API, it does not matter what you promise in the contract: all observable behaviors of your system will be depended on by somebody.

## Component Containers

Components cannot exist without special environment called container, that:
- creates request interceptors
- creates instances of components and controls their life-cycle
  - but returns reference to request interceptor!
- binds components together (`@Inject`)
  - not directly, but **through request interceptors**
- provides middleware services to components 
  - meta-data (annotations, XML) are used to specify needed services

???

- components communicate with each other via interfaces. When a component offers services to the rest of the system, it adopts a provided interface that specifies the services that other components can utilize, and how they can do so
- components are substitutable, so that a component can replace another (at design time or run-time), if the successor component meets the requirements of the initial component (expressed via the interfaces).

> Software components often take the form of objects (not classes) or collections of objects (from object-oriented programming)

## Main Points

- Component-based technologies enable us to: 
  - **separate business logic from middleware services**
- Components NEVER communicate directly
  - there always will be an intermediary (request interceptor, proxy, etc.)
- Operator `new` is **prohibited**
- Passing reference `this` to other components/programs is **prohibited**

## Modern Component-Oriented Technologies

- CDI (Contexts and Dependency Injection)
  - http://cdi-spec.org/ 
- Spring Beans
  - http://docs.spring.io/spring/docs/current/spring-framework-reference/htmlsingle/#beans 
- EJB (Enterprise JavaBeans)
  - https://java.net/projects/ejb-spec/  
- OSGi Services
  - https://www.osgi.org/developer/architecture/ 
- .NET Core
  - https://docs.microsoft.com/en-us/aspnet/core/fundamentals/dependency-injection

???
https://www.codingame.com/playgrounds/5040/framework-level-dependency-injection-with-asp-net-core

## How to get reference to component?

- `new` is prohibited
- Two possibilities:
  - Lookup by name (e.g. JNDI)
  - Dependency Injection

## JNDI

- Java Naming and Directory Interface (JNDI) is a service locator
- JNDI allows distributed applications to look up services in an abstract, resource-independent way.
- The most common use case is to set up a database connection pool on a Java EE application server. Any application that's deployed on that server can gain access to the connections they need using the JNDI name `java:comp/env/FooBarPool` without having to know the details about the connection.
- You can use the same JNDI name in each environment and hide the actual database being used. 
- Applications don't have to change as they migrate between environments.

## Dependency Injection

- A _dependency_ is an object that can be used (a _service_). 
- An _injection_ is the passing of a dependency to a dependent object (a _client_) that would use it.
- A broader term: [Inversion of Control](https://en.wikipedia.org/wiki/Inversion_of_control)
- DI technologies/frameworks:
  - Contexts and Dependency Injection (CDI)
  - Spring IoC
  - Google Guice

> https://en.wikipedia.org/wiki/Dependency_injection 

## Inversion of Control

Inversion of control serves the following design purposes:

- To decouple the execution of a task from implementation.
- To focus a module on the task it is designed for.
- To free modules from assumptions about how other systems do what they do and instead rely on contracts.
- To prevent side effects when replacing a module.

> "Don't call us, we'll call you."

???

In software engineering, inversion of control (IoC) is a design principle in which custom-written portions of a computer program receive the flow of control from a generic framework. A software architecture with this design inverts control as compared to traditional procedural programming: in traditional programming, the custom code that expresses the purpose of the program calls into reusable libraries to take care of generic tasks, but with inversion of control, it is the framework that calls into the custom, or task-specific, code.

The term is related to, but different from, the dependency inversion principle, which concerns itself with decoupling dependencies between high-level and low-level layers through shared abstractions.

Inversion of control carries the strong connotation that the reusable code and the problem-specific code are developed independently even though they operate together in an application. Software frameworks, callbacks, schedulers, event loops, dependency injection, and the template method are examples of design patterns that follow the inversion of control principle, although the term is most commonly used in the context of object-oriented programming.

## CDI

- The most fundamental services provided by CDI are as follows:
  - **Contexts**: This service enables you to bind the lifecycle and interactions of stateful components to well-defined but extensible lifecycle contexts.
  - **Dependency injection**: This service enables you to inject components into an application in a typesafe way and to choose at deployment time which implementation of a particular interface to inject.
- A major theme of CDI is loose coupling. CDI does the following:
  - [Beans](https://docs.oracle.com/javaee/7/tutorial/cdi-basic003.htm)
  - [Managed Beans](https://docs.oracle.com/javaee/7/tutorial/cdi-basic004.htm)
  - [Giving Beans EL Names](https://docs.oracle.com/javaee/7/tutorial/cdi-basic009.htm#GJBAK)
  - [Scopes](https://docs.oracle.com/javaee/7/tutorial/cdi-basic008.htm)
  - [Post / Pre](https://docs.oracle.com/javaee/7/tutorial/cdi-basic014.htm#BABJFEAI)

## DI example with CDI

```java
@SessionScoped // or other scopes
public class ComponentA {
  public void ma() {...} // some method
}
```

- `@Inject` looks at the component’s A scope, takes corresponding context and if finds instance of component A, uses it. Otherwise creates a new instance of A, puts it to this context, and returns to component B

```java
@RequestScoped // or other scopes
public class ComponentB {
  @Inject 
  private ComponentA a;

  public void mb() {
    a.ma();
    ...
  }
}

```

## CDI Scopes

- The _scope_ of the bean defines: 
  - the lifecycle of each instance of the bean
  - which clients share a reference to a particular instance of the bean
- For example, if we have a _session-scoped_ bean `CurrentUser`:
  - all beans that are called in the context of the same `HttpSession` will see the same instance of `CurrentUser`
  - this instance will be automatically created the first time a `CurrentUser` is needed in that session, and automatically destroyed when the session ends
- If a scope is not explicitly specified, then the bean belongs to a special scope called the _dependent pseudo-scope_. 
  - Beans of this scope live to serve the client into which they were injected. Their lifecycle is bound to the lifecycle of that client

## Predefined CDI Scopes

- Predefined CDI scopes:
  - `@RequestScoped`
  - `@ViewScoped` (JSF)
  - `@ConversationScoped`
  - `@FlowScoped` (JSF)
  - `@TransactionScoped` (JTA)
  - `@SessionScoped`
  - `@ApplicationScoped`
  - `@Dependent` pseudo-scope
- An instances of a dependent bean is never shared between different parents. It is instantiated when the parent it belongs to is created, and destroyed when its parent is destroyed. 

## CDI Contexts

- For a given thread in a CDI application, there may be an _active context_ associated with the scope of the bean. 
  - this context may be unique to the thread (for example, if the bean is request scoped), 
  - or it may be shared with certain other threads (for example, if the bean is session scoped) 
  - or even all other threads (if it is application scoped).
- Clients (for example, other beans) executing in the same context will see the same instance of the bean
- But clients in a different context may see a different instance (depending on the relationship between the contexts)

## CDI Contexts

![CDI Contextx](images/cdi-contexts.png "CDI Contextx")

## Field Injection

```java
@SessionScoped
public class ShoppingCart implements Serializable {
    @Inject
    private User user;

    @Inject
    private PaymentMethod paymentMethod;
    … 
}
```

## Constructor Injection

```java
@SessionScoped
public class ShoppingCart implements Serializable {
  private User user;
  private PaymentMethod paymentMethod;
    
  @Inject
  private ShoppingCart(User user, PaymentMethod paymentMethod) {
      this.user = user;
      this.paymentMethod = paymentMethod;
      …
  }
}
```

## Life-Cycle

```java
@RequestScoped 
public class PirmasKomponentas {
    @Inject
    private KomponentasB b;
    
    @PostConstruct
    public void init() {
      System.out.println(toString() + " constructed.");
    }    
    @PreDestroy
    public void aboutToDie() {
      System.out.println(toString() + " ready to die.");
    }   
}
```

## Demo 

1. Išbandyti DI (su CDI) ir įsitikinti, kad klientas negauna tiesioginės nuorodos į komponentą
2. Panaudoti `@Inject`
3. Atspausdinti gauto objekto klasės vardą: `System.out.println(comp.getClass().getName())`
4. Įsitikinti, kad bus atspausdinta kažkas panašaus į: `ComponentA$WeldProxy`
