# Representational state transfer

Technologinės platformos

Programų sistemų kūrimas

## REST 

- REpresentational State Transfer
- Introduced and defined in 2000 by Roy Fielding in his PhD
  - http://www.ics.uci.edu/~fielding/pubs/dissertation/top.htm 
- Fielding developed the REST architectural style in parallel with HTTP 1.1 protocol during 1996-1999

## Resource 

- The key abstraction of information in REST is a resource. 
- Any information that can be named can be a resource: 
  - a document or image, 
  - a temporal service (e.g. "today's weather in Los Angeles"), 
  - a collection of other resources, 
  - and so on

## Resource Representation

- REST components _perform actions_ on a resource by using a representation to:
  - capture the current or intended state of that resource and 
  - transferring that representation between components
- A representation is:
  - a sequence of bytes, and 
  - representation metadata to describe those bytes
- The data format of a representation is called _media type_

## JSON Example

```json
{
       "book":{
             "isbn" : "12356789",
             "title" : "Algorithm",
             "author" : [
                           "Cormen",
                           "Rivest",
                           "Stein"
             ],
             "price" : 45.78
       }
}
```

## Idempotence 

- From a RESTful service standpoint, for an operation (or service call) to be idempotent, clients can make that same call repeatedly while producing the same result
- In other words, making multiple identical requests has the same effect as making a single request
- While idempotent operations produce the same result on the server (no side effects), the response itself may not be the same (e.g. a resource's state may change between requests)
- The `PUT` and `DELETE` methods are defined to be idempotent
  - However, there is a caveat on `DELETE`
- `GET`, `HEAD`, `OPTIONS` and `TRACE` methods are defined as safe, meaning they are only intended for retrieving data. This makes them idempotent as well since multiple, identical requests will behave the same.

## REST Constraints 

- **Stateless** – No client context is being stored on the server between requests. 
  - Each request from any client contains _all the information necessary_ to service the request, and session state is held in the client
- **Identification of resources** – individual resources are identified in requests
  - for example using URIs: http://library.org/book/isbn/978-0596801687
- **Resource representation** – information about resource that is enough to create, modify or delete it

## REST vs SOAP

- There is a false equivalence asserted about REST and SOAP that yields more heat than light when they are compared
  - They are not intended to do the same thing even though you can solve many architectural problems with either approach
- In SOAP there is no information about resources, HTTP is treated like a transport protocol and there is no concept of hypermedia
- Unlike SOAP-based web services, there is no _official_ standard for RESTful web APIs
  - REST is an architectural style, while SOAP is a protocol. 
- Even though REST is not a standard per se, most RESTful implementations make use of standards such as:
  - HTTP, URI, JSON, and XML

## Richardson Maturity Model

- A framework for classifying the different kinds of systems many people were inappropriately calling _REST_

| LEVEL | ADOPTION                                                                                                                                                                                                                                                           |
|-------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| 0     | This is basically where SOAP is. There are no information resources, HTTP is treated like a transport protocol, and there is no concept of hypermedia. Conclusion: REST and SOAP are different approaches.                                                         |
| 1     | URLs are used, but not always as appropriate information resources, and everything is usually a GET request (including requests that update server state). Most people new to REST first build systems that look like this.                                        |
| 2     | URLs are used to represent information resources. HTTP is respected as an application protocol, sometimes including content negotiation. Most Internet-facing “REST” web services are really only at this level because they only support non- hypermedia formats. |
| 3     | URLs are used to represent information resources. HTTP is respected as an application protocol including content negotiation. Hypermedia drives the interactions for clients.                                                                                      |

## REST in Java EE

- JAX-RS: Java API for XML – Restful Services
  - [JSR 339](https://jcp.org/aboutJava/communityprocess/final/jsr339/index.html)
  - Standardizes RESTful Service API for Java EE
- JSON-B: Java class to JSON binding specification (annotations)
  - [JSR 367](https://www.jcp.org/en/jsr/detail?id=367)
  - Included from Java EE 8 

## REST Application Config

```java
import javax.ws.rs.ApplicationPath;
import javax.ws.rs.core.Application;

@ApplicationPath("/rest-prefix")
public class ApplicationConfig extends Application {
}
```

## Resource: XML

```java
@Entity
@XmlRootElement
public class User {
    @Id // and other JPA annotations
    private long id;    
    private String name;
    @XmlTransient // cyclic references -> skip
    @ManyToMany
    private List<Course> courseList;
}
```

## Resource: JSON 

```java
@Entity
public class User {
    @Id // and other JPA annotations
    private long id;    
    private String name;
    @JsonbIgnore // in Java EE 8
    @ManyToMany
    private List<Course> courseList;
}
```

## GET Operation

```java
@ApplicationScoped
@Path("/user")
@Produces(MediaType.APPLICATION_JSON)
public class UseCaseController1 {
    @Inject
    private EntityManager em;

    @Path("/{userId}")
    @GET
    public User find(@PathParam("userId") long id) {
        User user = em.find(User.class, id);
        return user;
    }
```

## POST Operation

```java
    @Path("/")
    @POST
    @Consumes(MediaType.APPLICATION_JSON)
    @Transactional
    public User create(User u) {
        em.persist(u);
        return u;
    }
```

## PUT Operation

```java
    @Path("/{userId}")
    @PUT
    @Consumes(MediaType.APPLICATION_JSON)
    @Transactional
    public User create(User u, @PathParam("userId") long id) 
    {
    	User user = em.find(User.class, id);
        if (user == null) {
            throw new IllegalArgumentException("user id " 
                + id + " not found");
        }
        user.setFullname(u.getFullname());
        user.setPassword(u.getPassword());
        user.setEmail(u.getEmail());
        em.merge(user);
        return Response.ok(user).build(); // low level API
    }
```