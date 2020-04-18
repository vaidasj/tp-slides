# Functional Viewpoint

Technologinės platformos

Programų sistemų kūrimas

## View Relationships

![Functional View](images/functional-view.png "Functional View")

## Functional View

- The Functional view of a system defines the architectural elements that deliver the functions of the system being described.
- This view documents the system’s functional structure including:
  - the key functional elements
  - their responsibilities
  - the interfaces they expose
  - the interactions between them
- Taken together, this demonstrates how the system will perform the functions required of it
- The Functional view is the cornerstone of most ADs and is often the first part of the description that stakeholders try to read
- The Functional view usually drives the definition of many of the other architectural views

## Concerns

- Functional Capabilities – _functional decomposition_
- External Interfaces
- Internal Structure – _structural decomposition_
- Functional Design Philosophy:
  - Separation of concerns and High Cohesion
  - Loose Coupling
  - Low Interdependency
  - Extensibility and Functional flexibility

## Concerns: Functional Capabilities

- Functional capabilities define what the system is required to do and, explicitly or implicitly, what it is not required to do (either because this functionality is outside the scope of consideration or because it is provided elsewhere).
- On some projects, you will have an agreed-upon set of requirements at the start of architecture definition, and you can focus in the Functional view on showing how your architectural elements work together to provide this functionality.
  - However, in many projects this isn’t the case, and the architect needs to ensure that there is a clear definition of what the system will (and won’t) be required to do.
- This concern cares about functional decomposition

## Concerns: External Interface

- External interfaces are the _data, event, and control flows_ between your system and others.
  - Data can flow inward (usually resulting in an internal change of system state) and/or outward (usually as a result of internal changes of system state).
  - Events can be consumed by your system (notifying your system that something has occurred) or may be emitted by your system (acting as notifications for other systems).
  - A control flow may be inbound (a request by an external system to yours to perform a task) or outbound (a request by your system to another to perform a task).
- Interface definitions need to consider both the interface syntax (the structure of the data or request) and semantics (its meaning or effect).

## Concerns: Internal Structure

- In most cases, you can design a system in a number of different ways to meet its requirements.
  - It can be built as a single monolithic entity or a collection of loosely coupled components; it can be constructed from a number of standard packages, linked together using commodity middleware, or written from scratch; etc.
- Your challenge is to choose among these many options in order to create an architecture that meets the functional requirements and exhibits the required quality properties.
- The _internal structure_ of the system is defined by its internal elements, what they do (i.e., how they map onto the requirements), and how they interact with each other.
- This concern cares about the structural decomposition

## Concerns: Functional Design Philosophy

- Many of your stakeholders will be interested only in what the system does and the interfaces it presents to users and to other systems.
  - However, some stakeholders will be interested in how well the architecture adheres to established principles of sound design.
- Technical stakeholders, in particular the development and test teams, want a sound architecture, because a well- designed system is easier to build, test, operate, and enhance.
- Other stakeholders, particularly acquirers, implicitly want a well-designed system because it is faster, cheaper, and easier to get such a system into production.

## Design characteristics

- The design philosophy will be underpinned by a number of design characteristics such as:
  - Cohesion
  - Coupling 
  - Interdependency
  - Extensibility and Functional flexibility
  - Coherence, Consistency, Generality, Separation of concerns, Simplicity

## Design characteristics: Cohesion

- Cohesion is a measure of how strongly-related or focused the responsibilities of a single class/component/module are.
- Cohesion is decreased if:
  - The functionalities embedded in a class, accessed through its methods, have little in common.
  - Methods carry out many varied activities, often using coarsely- grained or unrelated sets of data.
- Disadvantages of low cohesion:
  - Increased difficulty in understanding modules
  - Increased difficulty in maintaining a system
  - Increased difficulty in reusing a module
- In a highly-cohesive system, code readability and the likelihood of reuse is increased, while complexity is kept manageable.

## Design characteristics: Coupling

- Coupling can be _low_ (also _loose_ and _weak_) or _high_ (also _tight_ and _strong_)
- Low coupling refers to a relationship in which one module interacts with another module through a simple and stable interface and does not need to be concerned with the other module's internal implementation
- Coupling increases between two classes **A** and **B** if:
  - **A** has an attribute that refers to (is of type) **B**.
  - **A** calls on services of an object **B**.
  - **A** has a method that references **B** (via return type or parameter).
  - **A** is a subclass of (or implements) class **B**.

## Design characteristics: Coupling

- Disadvantages of high coupling:
  - A change in one module usually forces a ripple effect of changes in other modules.
  - Assembly of modules might require more effort and/or time due to the increased inter-module dependency.
  - A particular module might be harder to reuse and/or test because dependent modules must be included.
- Low coupling is often a sign of a well-structured computer system and a good design, and when combined with _high cohesion_, supports the general goals of high _readability_ and _maintainability_

## Achieving loose coupling

Techniques to achieve low coupling are:
- Introduce stable interfaces between communicating components – ripple effect of changes stops at the interface boundary
- Code that creates class/component instances is moved away from classes/components
  - Design patterns – Abstract Factory, Builder
  - Dependency Injection (DI) techniques – EJB, CDI, SpringFramework
  - **Stable interfaces are still mandatory**
- Remove the dependency between the two components 
  - Event-driven techniques (e.g. CDI, SpringFramework)

## Cohesion and Requirements

Applying _Separation of Concerns_ and _High Cohesion_ principles to requirements specification we can distinguish these kinds of requirements:
- **Localizable functional requirements** (implemented in SINGLE module). _Example: Internal bank money transfer_
- **Crosscutting functional requirements** (tend to be scattered throughout the whole code-base)
  - **Not-impacting cross-cut functionality** (Observer Pattern). _Example: if payment exceeds some limit, inform Tax_
  - **Impacting cross-cut functionality** (Decorator Pattern). _Example: if money are incoming from other bank, charge commissions_
- **Non-functional requirements** (Interceptor/Proxy Pattern). Always crosscutting. _Examples: transactions, security checks, logging_

## Cohesion and Requirements: Example

![Cohesion example](images/cohesion-requirements.png "Cohesion example")

## Functional vs. Non-functional

- A functional requirement is a requirement about what an application should do. This is manifested in a form that the user can easily observe: _Business rules, UI logic, etc._
- A non-functional requirement is a requirement about how an application should work. This is what a user typically doesn't see: _Logging, caching, threading, etc._
- Which of these are functional and which are non-functional? Why?
  - Addresses should be US-only, ZIP Codes must be five digits
  - Every method call should log its own name and arguments to a text file
  - When returning a list of Customers, only Customers the current user is authorized to see should be returned
  - When submitting a new Customer, it must be put in a pending queue for approval by an administrator

## Cross cutting concerns

- The crosscutting concern is a concern which is applicable throughout the application and it affects the entire application.
- Cross-cutting concerns **are often non-functional** requirements. 
- These concerns often cannot be cleanly decomposed from the rest of the system in both the design and implementation, and can result in either scattering (code duplication), tangling (significant dependencies between systems), or both.
 - For example: logging, security and data transfer are the concerns which are needed in almost every module of an application, hence they are cross-cutting concerns.

## Crosscutting Requirements and DRY principle

- Loose Coupling is very important for implementation of crosscutting functional requirements
- Modern technological platforms should provide means how to implement crosscutting functional requirements:
  - Without code duplication (DRY principle) 
  - With loose coupling (or no coupling at all)

## Concurrency Patterns and Asynchronous Communication

- If use case implementation algorithm takes long time, consider splitting it to concurrently running parts
  - Concurrency patterns help to choose best algorithm decomposition scheme: _Producer-Consumer, Work pool, Map-Reduce, Fork- Join, etc._
  - Often communication between parts will have to be _asynchronous_

## Design characteristics: Interdependency

- What proportion of processing steps involves interactions between elements as opposed to within an element?
- Communicating between certain types of elements can be an order of magnitude more expensive (in terms of processing time and elapsed time), and significantly less reliable, than performing an operation within a functional element.
  - Especially if communication occurs via the network

## Design characteristics: Extensibility and Functional flexibility

- _Extensibility_ – Will the architecture be easy to extend to allow the system to perform new functions in the future?
- Functional flexibility – How amenable is the system to supporting changes to the _functions already provided_?
  - Systems that are designed to be easy to change are usually harder to build and typically don’t perform as well as systems that are less adaptable.
- Modifiability is independent quality property and has dedicated perspective

## Functional Structure Model

- The functional structure model typically contains the following elements:
  - **Functional elements**: A functional element is a well-defined runtime (as opposed to design-time) part of the system that has particular responsibilities and exposes well-defined interfaces that allow it to be connected to other element
  - **Interfaces**: An interface is defined by the inputs, outputs, and semantics of each operation offered and the nature of the interaction needed to invoke the operation.
  - **Connectors**: Connectors are the pieces of your architecture that link the elements together to allow them to interact
  - **External entities**: External entities are other systems, software programs, hardware devices, or any other entity with which your system interacts.

## Functional Structure Model

![Functional Structure Model](images/functional-model.png "Functional Structure Model")

## Functional Structure Model: UML notation

- What is not obvious from this diagram:
  - The responsibilities of the components aren’t clear,
  - The details of their interfaces aren’t clear, and
  - The details of how the components interact aren’t clear.
- This impresses on us the need to complete the textual descriptions that underpin the diagram and the need to understand the system via a number of models rather than just one

## Analyze the Interactions

- Given the impact that excessive inter-element interactions can have, it is useful to analyze the chosen structure from the point of view of the number of inter-element interactions taken during common processing scenarios.
- _Refining the functional structure to reduce inter-element interactions to a (feasible) minimum usually results in a well-structured system with cohesive, loosely coupled elements._
  - It is typically an important step toward an efficient and reliable system.
- You’ll have to make tradeoffs

## Functional Structure Model: Common Pitfalls

- Infrastructure Modeled as Functional Elements
  - In general, you should not model underlying infrastructure as functional elements. The Deployment view defines the infrastructure in more detail
- _God Elements_
  - Software designers often see object-oriented designs that have a single huge object in the center, with lots of small objects attached to it.
  - This situation is often dubbed the _God object_ problem.
- The underlying problem in such cases is usually an inappropriate partitioning of responsibilities among design elements — the large object (often called _Manager_) is really the entire program, and the small objects are often just data structures that this object uses

## God Element

![God Element](images/god-element.png "God Element")

