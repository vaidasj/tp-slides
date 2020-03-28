# CDI: Alternatives and Specializes

Technologinės platformos

Programų sistemų kūrimas

## CDI overview

- A set of interlocking functionality:
  - **typesafe** dependency injection, 
  - contextual lifecycle management for injectable objects, 
  - interceptors, 
  - decorators, 
  - events
- Based around the philosophy of _loose coupling with strong typing_

## Loose coupling

- Decouple service consumer from service provider
  - Using well-defined types and _qualifiers_
  - Allows service implementations to vary
- Decouple life cycle of collaborating components
  - Automatic contextual life cycle management
  - Stateful components interact like services
- Decouple orthogonal concerns (AOP)
  - Interceptors – decouple technical concerns from business logic
  - Decorators – allow business concerns to be compartmentalized
- Decouple message producer from message consumer
  - Events

## Strong typing

- Eliminate reliance on string-based names
- Compiler can detect typing errors
- Report errors early
  - At deployment
  - Tooling can prevent ambiguous dependencies

## CDI bean

- A bean comprises the following attributes:
  - A (nonempty) set of _bean types_
  - A (nonempty) set of _qualifiers_
  - A _scope_
  - Optionally, a bean _EL name_
  - A bean _implementation_
  - A set of _interceptor bindings_
  - A bean may or may not be an _alternative_

## Stereotypes

- A _stereotype_ models a common role in your application architecture. 
- It encapsulates various properties of the role, including scope, interceptor bindings, qualifiers, etc, into a single reusable package.
- CDI defines standard stereotype, `@Model`, which is expected to be used frequently in web applications: 

```java
@Named  
@RequestScoped  
@Stereotype  
@Target({TYPE, METHOD})  
@Retention(RUNTIME)  
public @interface Model {}
```
## Strategy Design Pattern

![Stategy Pattern](images/strategy-pattern.png "Stategy Pattern")

## Multiple implementations

- For a given bean type, there may be multiple beans which implement the type. 
- For example, an application may have two implementations of the interface _PaymentProcessor_:

```java
class MasterCardPaymentProcessor implements PaymentProcessor 
{ 
  ...
}

class VisaPaymentProcessor implements PaymentProcessor 
{ 
  ...
}
```

- Now this is ambiguous:

```java
@Inject PaymentProcessor paymentProcessor;
```

## Qualifier types

- A _qualifier_ type represents some client-visible semantics associated with a type that is satisfied by some implementations of the type (and not by others)
  - For example, we could introduce qualifier types representing synchronicity and asynchronicity.
- In Java code, qualifier types are represented by annotations:

```java
@MasterCard
class MasterCardPaymentProcessor implements PaymentProcessor 
{ 
  ...
}

@Visa
class VisaPaymentProcessor implements PaymentProcessor 
{ 
  ...
}
```

## Qualifier types at injection points

- Finally, qualifier types are applied to injection points to distinguish which implementation is required by the client. 

```java
@Inject @MasterCard PaymentProcessor paymentProcessor;

@Inject @Visa PaymentProcessor paymentProcessor;
```

- The container inspects the qualifier annotations and type of the injected attribute to determine the bean instance to be injected
- An injection point may even specify multiple qualifiers

## Qualifier type declarations

```java
@Qualifier
@Retention(RUNTIME)
@Target({METHOD, FIELD, PARAMETER, TYPE})
public @interface MasterCard {}
```

```java
@Qualifier
@Retention(RUNTIME)
@Target({METHOD, FIELD, PARAMETER, TYPE})
public @interface Visa {}
```

???

Retention - CLASS, RUNTIME, SOURCE
Target - https://stackoverflow.com/questions/3550292/what-do-java-annotation-elementtype-constants-mean


## Qualifiers with members

- Java annotations can have members. We can use annotation members to further discriminate a qualifier. This prevents a potential explosion of new annotations
- Instead of creating several qualifiers representing different payment methods, we could aggregate them into a single annotation with a member: 

```java
@Qualifier 
@Retention(RUNTIME) 
@Target({METHOD, FIELD, PARAMETER, TYPE}) 
public @interface PayBy { 
   PaymentMethod value(); 
}
```
- Then we select one of the possible member values when applying the qualifier: 

```java
private @Inject @PayBy(PaymentMethod.CHECK) PaymentProcessor checkPayment;
```

## Specialization

- Specialization is a single override

```java
@Specializes
public class SecureVisaPaymentProcessor 
  extends VisaPaymentProcessor { 
    ... 
}
```

- All places that use it will get instance of _SecureVisaPaymentProcessor_

```java
@Inject 
private VisaPaymentProcessor processor;
```

## Alternatives

- Sometimes we have an interface (or other bean type) whose implementation varies depending upon the deployment environment.  
- An _alternative_ may be declared by annotating the bean class with the `@Alternative` annotation

```java
@Alternative
public class FastPaymentProcessor 
       implements PaymentProcessor { ... }
```

```java
public class StandardPaymentProcessor 
       implements PaymentProcessor { ... }
```

## Alternatives

- We can choose between alternatives at deployment time by selecting an alternative in the CDI deployment descriptor `META-INF/beans.xml` of the jar or Java EE module that uses it. 

```xml
<beans>
    <alternatives>
        <class>lt.vu.FastPaymentProcessor</class>
    </alternatives>
</beans>
```

- You can also have several beans that implement the same interface, all annotated `@Alternative`. In this case, you **must** specify in the beans.xml file which of these alternative beans you want to use. 
- Different modules can specify that they use different alternatives

## `@Default` qualifier

- If an injection point does not explicitly specify a qualifier, it has the default qualifier, `@Default`
- If a bean does not explicitly specify a qualifier, it has the default qualifier, `@Default`

```java
@Default
public class FastPaymentProcessor 
       implements PaymentProcessor { ... }
```
