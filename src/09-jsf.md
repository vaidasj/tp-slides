# JavaServer Faces

Technologinės platformos

Programų sistemų kūrimas

## Example of an JSF application

Application consists from two HTML pages:
- The first page allows to enter a number, and as a result outputs squared number. Example of declarative validation is shown.
- The second page shows the last calculated result. Example of user session and declarative navigation.

## Backing Bean 

```java
@Named
@SessionScoped 
public class Calculator implements Serializable { 
    // Read/write property "number":  
    private int number = 5;  
    public int getNumber() { return number; }    
    public void setNumber(int number) { 
      this.number = number; 
    }

    // Read-only property "result":
    private Integer result = null;
    public Integer getResult() { return result; }    

    // Method to square a number
    public void square() { result = number * number; }

    // Method to navigate to the second page
    public String bye() { return "bye"; }
}
```

## Data Binding


![JSF Form](images/jsf-form.png "JSF Form")

- We declaratively define what form field must be bind with what class field
- Web framework:
  - moves data through the binding
  - automatically performs conversion and validation

## First HTML Page 

```html
<!DOCTYPE html>
<html lang="en" xmlns="http://www.w3.org/1999/xhtml"
      xmlns:h="http://xmlns.jcp.org/jsf/html"
      xmlns:f="http://xmlns.jcp.org/jsf/core"
      xmlns:p="http://xmlns.jcp.org/jsf/passthrough">
<h:head><title>JSF calculator</title></h:head>
<h:body>
  <h1>JSF calculator</h1>
  <h:form id="f1">
    <h:outputLabel for="number" value="Number: "/>
    <h:inputText id="number" value="#{calculator.number}" 
                 required="true" p:type="number" 
                 p:placeholder="Enter number">
       <f:validateLongRange minimum="-500" maximum="500"/>
    </h:inputText>
    <h:message for="number" style="color: red"/>
      Result: #{calculator.result}               
  <h:commandButton value="Square" 
                actionListener="#{calculator.square}"/>
</h:form>
</h:body>
</html>
```

## Second HTML Page

```html
<!DOCTYPE html>
<html lang="en" xmlns="http://www.w3.org/1999/xhtml"
      xmlns:h="http://xmlns.jcp.org/jsf/html">
<h:head><title>The last result</title></h:head>

<h:body>
  <h1>Bye bye</h1>

  The last result: #{calculator.result}
            
</h:body>

</html>
```

## JSF component suites

- [PrimeFaces](http://www.primefaces.org/)
- [Apache Tobago](https://myfaces.apache.org/tobago/demo.html)
- TreeTable component example (PrimeFaces):

![JSF Component](images/jsf-component.png "JSF Component")

## JSF Best Practices

- [https://jsf.zeef.com/bauke.scholtz](https://jsf.zeef.com/bauke.scholtz)
- [PrimeFaces examples](https://www.primefaces.org/showcase/index.xhtml)

## Thin Client

![Thin Client](images/thin-client.png "Thin Client")

- Client machine runs Browser, that executes:
  - HTML (and HTML is being created on the server)
  - CSS
  - JavaScript, but only for AJAX and/or form field rendering
  - No JavaScript framework is being used (Angular, Backbone, etc.)


## MVC Client

![Fat Client](images/fat-client.png "Fat Client")

- Client still is using only Browser, but:
  - HTML is being created on client-side by JS Framework
  - Some JS framework is being used
  - Often framework is MVC driven



