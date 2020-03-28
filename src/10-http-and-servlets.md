# HTTP and Java Servlets

Technologinės platformos

Programų sistemų kūrimas

## HTTP protocol

- Web system communicates with end-user via HTTP protocol
- HTTP protocol methods:
  - `GET`, `POST`, `HEAD`, `PUT`, `OPTIONS`, `DELETE`
- HTTP protocol is **stateless**
  - Server does not know whether this is your first request, or not, and whether this request is yours at all

## HTTP request 

- Structure: 
```http
Method URL Version cr lf
Header field name: value cr lf
.
.
.
Header field name: value cr lf
cr lf
Data
```

- Example:
```http
GET /~vaidasj/index.html HTTP/1.1¶
Host: www.mif.vu.lt¶
User-agent: Mozilla/4.0¶
Accept-language: en¶
¶
```

## HTTP response 

- Structure: 
```http
Version status code phrase cr lf
Header field name: value cr lf
.
.
Header field name: value cr lf
cr lf
Data
```

- Example:
```http
HTTP/1.1 200 OK
Date: Wed, 03 Mar 2004 10:00:15 GMT
Server: Apache/1.3.27 (Unix)
Last-Modified: Mon, 01 Mar 2004 12:15:34 GMT
Content-Length: 6821
Content-Type: text/html
¶
<html>...</html>
```

## Java Servlet Technology

Java Servlet – component framework, that:
- allows to process incoming HTTP requests: 
  - to retrieve request parameters as Java data structures,
  - to convert the response to HTTP protocol format
- provides means to identify end-users and associate state with them (so called session)
  - Cookies
  - URL rewriting
  - Hidden form fields
- components in this framework are called servlets

Java Servlets _do not provide_ functionality for sending HTTP requests

## Java Servlet example

```java
public class SimpleServlet extends HttpServlet { 
    public void doGet (HttpServletRequest request,
                       HttpServletResponse response)
            throws ServletException, IOException {
        String title = "Hello World !";
        String selectedProductID = 
            request.getParameter(“selectedProduct”);

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        out.println("<HTML><HEAD><TITLE>");
        out.println(title);
        out.println("</TITLE></HEAD><BODY>");
        out.println("<H1>" + title + "</H1>");
        out.println("<P>This is output from SimpleServlet.");
        out.println("</BODY></HTML>");
        out.close();
    }
}
```

## Servlets are Components

Servlet container: 
- creates instances of servlets (programmers don’t use operator new) 
- controls life-cycle of servlets – invokes following methods for each servlet:
  - `init()` – once upon initialization of a servlet
  - as request are coming from clients: `doGet()`, `doPost()`, and others
  - `destroy()` – once before servlet container shutdown

Servlets have packaging format – WAR archives

## Web application packaging

All files of a web application must be organized in the following way:
- In root directory (and its subdirectories) static content is placed (e.g.: images, CSS & JavaScript files, static HTML, etc.)
- Root directory must contain subdirectory named `WEB-INF`; its content will not be accessible to clients:
  - `/WEB-INF/web.xml` – configuration file (deployment descriptor);
  - `/WEB-INF/classes/` – contains compiled Java classes;
  - `/WEB-INF/lib/` – contains libraries used by web application;

- Root directory and its content are put to Java archive with extension `.war`. This WAR file can be deployed to any Servlet container

## Web application packaging

![WAR](images/java-war.png "WAR")

## Mapping requests to servlets

- Request format:

```xml
http[s]://host[:port][/<context>][/<servlet>][/<parameters>]
```
- Context path binds the request with specific web application. Binding can be configured in file: `application.xml`
  - In IDEs by default context path is the same as projects name
- Servlet path binds the request with specific web system‘s servlet. Binding is specified in file `/WEB-INF/web.xml`
- Parameters do not participate in binding – they just pass some parameters to some specific servlet

## Example of `web.xml`

```xml
<web-app>
    <servlet>
        <servlet-name>catalog</servlet-name>
        <servlet-class>
            com.mycorp.CatalogServlet
        </servlet-class>
    </servlet>

    <servlet-mapping>
        <servlet-name>catalog</servlet-name>
        <url-pattern>`/catalog/*`</url-pattern>
    </servlet-mapping>

    <session-config>
        <session-timeout>30</session-timeout>
    </session-config>
</web-app>
```