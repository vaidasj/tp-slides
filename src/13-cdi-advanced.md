# CDI: Producers, Interceptors, Decorators

Technologinės platformos

Programų sistemų kūrimas

## Producers

- CDI injection facility is statically typed
  - What if we need to decide at runtime which implementation of a type to instantiate and inject? 
  - What if we need to inject an object that is obtained by querying a service or transactional resource, for example by executing a JPA query?  _That is, non CDI-bean_
- A _producer method_ is a method that acts as a source of bean instances 
- The method declaration itself describes the bean and the container invokes the method to obtain an instance of the bean **when no instance exists in the specified context**
- A producer method lets the application to take full control of the bean instantiation process

## Producer method

- A producer method is declared by annotating a method of a bean class with the `@Produces` annotation. 

```java
@ApplicationScoped 
public class RandomNumberGenerator { 
   private Random random = new Random(); 
        
   @Produces @Named @Random 
   public int getRandomNumber() { 
      return random.nextInt(100); 
   }
}
```
- By making the method a producer method, we allow the return value of the method—in this case an Integer—to be injected. 


## Producer method

- We can even specify:
  - a qualifier—in this case `@Random` 
  - a scope—which in this case defaults to `@Dependent`
  - an EL name—which in this case defaults to `randomNumber` according to the JavaBeans property name convention 
- Now we can get a random number anywhere: 

```java
@Inject @Random int randomNumber;
```
- Even in a Unified EL expression: 

```html
<p>Your random number is: #{randomNumber}</p>
```

## Producer method

- If the producer method has method parameters, the container will look for a bean that satisfies the type and qualifiers of each parameter and pass it to the method automatically—another form of dependency injection

```java
@Produces Set<Roles> getRoles(User user)
{ 
     return user.getRoles(); 
}
```
- User bean will be injected automatically, no `@Inject` is needed

## Producer method

- The scope of the producer method defaults to `@Dependent`, and so it will be called every time the container injects this field or any other field that resolves to the same producer method.
  - Thus, producer method might be called multiple times for the same context 
- To change this behavior, we can add a scope declaration to the method: 

```java
@Produces @Preferred @SessionScoped 
public PaymentStrategy getPaymentStrategy() { 
     ... 
}
```
- Now, when the producer method is called, the returned `PaymentStrategy` will be bound to the session context. 
  - The producer method won't be called again in the same session. 

## Injection point metadata

- It is possible to implement generic beans that introspect the injection point to which they belong. This makes it possible to implement injection for Loggers, for example:

```java
class Loggers {
  @Produces 
  Logger getLogger(InjectionPoint injectionPoint) {
      return Logger.getLogger( 
        injectionPoint.getMember().getDeclaringClass()
        .getSimpleName() );
  }
}
```

## Disposer methods

- Some producer methods return objects that require explicit destruction. For example, somebody needs to close this JDBC connection: 

```java
@Produces @RequestScoped 
public Connection connect(User user) { 
   return createConnection(...); 
}
```
- Destruction can be performed by a matching disposer method, defined by the same class as the producer method:

```java
void close(@Disposes Connection connection) { 
   connection.close(); 
}
```

## Disposer methods

- The disposer method must have at least one parameter, annotated `@Disposes`, with the same type and qualifiers as the producer method. 
- The disposer method is called automatically when the context ends (in this case, at the end of the request), and this parameter receives the object produced by the producer method. 
- If the disposer method has additional method parameters, the container will look for a bean that satisfies the type and qualifiers of each parameter and pass it to the method automatically. 

## Interceptor Pattern

![Interceptor Pattern](images/interceptor-pattern.png "Interceptor Pattern")

## Interceptor: create

- Create new Java class (annotation actually) with this content:

```java
@InterceptorBinding 
@Target({METHOD, TYPE}) 
@Retention(RUNTIME) 
public @interface MyInterceptor { }
```
- Create Java class with interceptor implementation:

```java
@MyInterceptor 
@Interceptor 
public class MyInterceptorImpl { 
   @AroundInvoke  
   public Object doSomeStuff(InvocationContext ctx)    
                 throws Exception { 
       ... // do some stuff
       Object result = ctx.proceed(); 
       ... // do more stuff
       return result; // or something else
   } 
}
```

## Interceptor: apply

- Put this annotation on top of a class or method: 

```java
@MyInterceptor // all methods will be intercepted
public class MyComponent { 
    @MyInterceptor // just this method will be intercepted
    public void m(…) {
        ...
    } 
}
```

- By default, all interceptors are disabled
- We need to enable our interceptor in the `beans.xml` descriptor

```xml
<interceptors>
    <class>package.MyInterceptorImpl</class>
</interceptors>
```
- This activation only applies to the beans in one archive

## Interceptor: priority

- The interceptors that you specify in the `beans.xml` file apply only to classes in the same archive. 
- Use the `@Priority` annotation to specify interceptors globally for an application that consists of multiple modules:

```java
@MyInterceptor 
@Interceptor 
@Priority(Interceptor.Priority.APPLICATION) 
public class MyInterceptorImpl {
... 
}
```

- Interceptors with smaller priority values are called first. 
- You do not need to specify the interceptor in the `beans.xml` file when you use the `@Priority` annotation.

## Interceptor: summary

- Interceptors allow us to capture and separate concerns which are orthogonal to the application
  - Means to implement **non-functional requirements**. _Examples: transaction management, security, logging, audit._
- However, by nature, interceptors are unaware of the actual semantics of the events they intercept
  - Thus, interceptors aren't an appropriate tool for implementing **cross-cutting functional requirements**


## Decorator Pattern

![Decorator Pattern](images/decorator-pattern.png "Decorator Pattern")

## Decorator

- A decorator intercepts invocations only for a certain _Java interface_, and is therefore aware of all the semantics attached to that interface. 
- Since decorators directly implement operations with business semantics, it makes them the perfect tool for implementing **cross-cutting functional requirements**
- Interceptors and decorators, though similar in many ways, are _complementary_

## Decorator: example

- Suppose we have an interface that represents accounts:

```java
public interface Account { 
   public BigDecimal getBalance(); 
   public User getOwner(); 
   public void withdraw(BigDecimal amount); 
   public void deposit(BigDecimal amount); 
}
```
- Several different CDI beans in our system implement the _Account interface_ 
- Requirement: for any kind of account, large transactions must be recorded by the system in a special log

## Decorator: example

- A decorator is a bean (possibly even an abstract class) that implements the type it decorates and is annotated `@Decorator`

```java
@Decorator 
public abstract class LargeTransactionDecorator 
                      implements Account {
 
   @Inject @Delegate @Any Account  account; 
        
   public void withdraw(BigDecimal amount) { 
      account.withdraw(amount); 
      if ( amount.compareTo(LARGE_AMOUNT)>0 ) { 
         em.persist( new LoggedWithdrawl(amount) ); 
      } 
   } 
     
   public void deposit(BigDecimal amount); 
       ...
   } 
}
```

## Decorator

- Decorators have a special injection point, called the _delegate injection point_, with the same type as the beans they decorate, and the annotation `@Delegate` 
  - There must be exactly one delegate injection point
- A decorator is bound to any bean which:
  - has the type of the delegate injection point as a bean type, and
  - has all qualifiers that are declared at the delegate injection point.
- This delegate injection point specifies that the decorator is bound to all beans that implement _Account_ 

```java
@Inject @Delegate @Any Account  account;
```

## Decorator

- A delegate injection point may specify any number of qualifier annotations. The decorator will only be bound to beans with the same qualifiers. 

```java
@Inject @Delegate @Foreign Account  account;
```
- By default, all decorators are disabled. 
- We need to enable our decorator in the `beans.xml` descriptor of a bean archive. 
- This activation only applies to the beans in that archive.

```xml
<decorators>
  <class>
    lt.mif.vu.decorators.LargeTransactionDecorator
  </class>
</decorators>
```

## Decorator

- Declaration in `beans.xml`: 
  - enables us to specify a total ordering for all decorators in our system, ensuring deterministic behavior, and 
  - it lets us enable or disable decorator classes at deployment time
- Unlike other beans, a decorator may be an abstract class. 
  - If there's nothing special the decorator needs to do for a particular method of the decorated interface, you don't need to implement that method. 
- Interceptors for a method are called before decorators that apply to the method. 

## Asynchronous components

- From CDI specification:
  - the built-in request and application context objects are active during servlet, web service and EJB invocations, 
  - the built in session and request context objects are active during servlet and web service invocations. 
  - the context associated with a built-in normal scope _propagates_ across local, synchronous Java method calls. 
  - the context **does not propagate** across remote method invocations or to asynchronous processes

## Asynchronous transactions

- Same logic applies for transactions: they are not propogated to asynchronous methods
- Asynchronous method should be annotated with `@Transactional(REQUIRES_NEW)`
- If `EntityManager` is used it can not be `RequestScoped`

```java
@Produces `@TransactionScoped`
private EntityManager createJTATransactionalEM() {
    return emf.createEntityManager(
       SynchronizationType.SYNCHRONIZED);
}
```