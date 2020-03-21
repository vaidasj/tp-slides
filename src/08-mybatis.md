# MyBatis

Technologinės platformos

Programų sistemų kūrimas

## Data Mapper: Main idea

![Data Mapper](images/data-mapper.png "Data Mapper")

## Maven MyBatis generator plugin

```xml
<plugin>
	<groupId>org.mybatis.generator</groupId>
	<artifactId>mybatis-generator-maven-plugin</artifactId>
	<version>1.3.5</version>
	<configuration>
	    <contexts>StudentsDB</contexts>
	    <verbose>true</verbose>
	</configuration>
	<dependencies>
	    JDBC driver dependencies...
	</dependencies>
</plugin>
```

> `src\main\resources\generatorConfig.xml`

## generatorConfig.xml

```xml
<generatorConfiguration>
<context id="StudentsDB" targetRuntime="MyBatis3Simple">
    <jdbcConnection driverClass="org.postgresql.Driver"
        connectionURL="jdbc:postgresql://localhost/db"
        userId="postgres"
        password="postgres">
    </jdbcConnection>
    <javaModelGenerator 
    	targetPackage="lt.vu.uc.mybatis.model" 
        targetProject="MAVEN" />
    <!-- Annotation based -->
    <javaClientGenerator type="ANNOTATEDMAPPER" 
         	targetPackage="lt.vu.uc.mybatis.dao" 
            targetProject="MAVEN" /> 
    <!-- XML based -->
    <sqlMapGenerator targetPackage="lt.vu.uc.mybatis.xml" 
                     targetProject="MAVEN" />
    <javaClientGenerator type="XMLMAPPER" 
                     targetPackage="lt.vu.uc.mybatis.dao" 
                     targetProject="MAVEN" />
 ```

## generatorConfig.xml

 ```xml
        <table schema="public" tableName="university">
	        <generatedKey column="id" identity="true" 
	        	sqlStatement="JDBC" />
	        <ignoreColumn column="opt_lock_version" />
	    </table>
	    <table schema="public" tableName="student">
	        <generatedKey column="id" identity="true" 
	        	sqlStatement="JDBC" />
	        <ignoreColumn column="opt_lock_version" />
	    </table>
	    <table schema="public" tableName="course">
	        <generatedKey column="id" identity="true" 
	        	sqlStatement="JDBC" />
	        <ignoreColumn column="opt_lock_version" />
	    </table>
	    <table schema="public" tableName="student_course">
    </table>
</context>
</generatorConfiguration>
```

## Generation Result

![Result](images/my-batis-result.png "Result")


## Maven MyBatis dependencies

```xml
<dependency>
	<groupId>org.mybatis</groupId>
	<artifactId>mybatis</artifactId>
	<version>3.4.2</version>
</dependency>
<dependency>
	<groupId>org.mybatis</groupId>
	<artifactId>mybatis-cdi</artifactId>
	<version>1.0.0-beta7</version>
</dependency>
```

## MyBatis

- **SqlSessionFactory**
  - Once created, the `qlSessionFactory` should exist for the duration of your application execution.
  - The simplest is to use a Singleton pattern or Static Singleton pattern.
- **SqlSession**
  - Each thread should have its own instance of `SqlSession`. Instances of `SqlSession` are not to be shared and _are not thread safe_. Therefore the best scope is request or method scope. 
  - Never keep references to a `SqlSession` instance in a static field or even an instance field of a class. Never keep references to a `SqlSession` in any sort of managed scope, such as `HttpSession` of the Servlet framework. 

???

What makes you say that either a singleton or a static method isn't thread-safe? Usually both *should*be implemented to be thread-safe.

The big difference between a singleton and a bunch of static methods is that singletons can implement interfaces (or derive from useful base classes, although that's less common, in my experience), so you can pass around the singleton as if it were "just another" implementation.

- Singleton pattern restricts the instantiation of a class and ensures that only one instance of the class exists in the java virtual machine.
- The singleton class must provide a global access point to get the instance of the class.
- Singleton pattern is used for [logging](https://www.journaldev.com/977/logger-in-java-logging-example), drivers objects, caching and [thread pool](https://www.journaldev.com/1069/threadpoolexecutor-java-thread-pool-example-executorservice).
- Singleton design pattern is also used in other design patterns like [Abstract Factory](https://www.journaldev.com/1418/abstract-factory-design-pattern-in-java), [Builder](https://www.journaldev.com/1425/builder-design-pattern-in-java), [Prototype](https://www.journaldev.com/1440/prototype-design-pattern-in-java), [Facade](https://www.journaldev.com/1557/facade-design-pattern-in-java) etc.

Since java 5 the best way to do it is to use an enum.

## MyBatisResources.java

```java
@Slf4j
@ApplicationScoped
public class MyBatisResources {

    @Produces
    @ApplicationScoped
    @SessionFactoryProvider
    private SqlSessionFactory produceSqlSessionFactory() {
        try {
            return new SqlSessionFactoryBuilder().build(
                    Resources.getResourceAsStream(
                    	"MyBatisConfig.xml")
            );
        } catch (IOException e) {
            log.error("produceSqlSessionFactory(): ", e);
            throw new RuntimeException(...);
        }
    }
}
```

## MyBatisConfig.xml

```xml
<configuration>
  <typeAliases>
    <typeAlias type="lt.vu.uc.mybatis.model.Student" 
               alias="Student"/>
    ...
  </typeAliases>
  <environments default="development">
    <environment id="development">
      <transactionManager type="MANAGED"/>
      <dataSource type="JNDI">
        <property name="data_source" 
            value="openejb:Resource/StudentsDataSource"/>
      </dataSource>
    </environment>
  </environments>
  <mappers>
    <mapper resource="mybatis/xml/StudentMapper.xml"/>
    ...
  </mappers>
</configuration>

```

## MyBatis Student Model 

```java
@Getter
@Setter
public class Student {

    private Integer id;
    private String firstName;
    private String lastName;
    private Integer universityId;
    private String registrationNo;

    // Added manually
    private University university;
    private List<Course> courses;
}
```

## Student Mapper XML 

```xml
<mapper namespace="lt.vu.uc.mybatis.dao.StudentMapper">
    <delete id="deleteByPrimaryKey" parameterType="java.lang.Integer">
        DELETE FROM public.student
        WHERE id = #{id,jdbcType=INTEGER}
    </delete>
    <insert id="insert" keyColumn="id" keyProperty="id" 
            parameterType="Student" useGeneratedKeys="true">
        INSERT INTO public.student (first_name, last_name, 
        				registration_no, university_id)
        VALUES (#{firstName,jdbcType=VARCHAR}, 
		        #{lastName,jdbcType=VARCHAR}, 
		        #{registrationNo,jdbcType=VARCHAR}, 
		        #{universityId,jdbcType=INTEGER})
    </insert>
    <update id="updateByPrimaryKey" parameterType="Student">
        UPDATE public.student
        SET first_name = #{firstName,jdbcType=VARCHAR},
        last_name = #{lastName,jdbcType=VARCHAR},
        registration_no = #{registrationNo,jdbcType=VARCHAR},
        university_id = #{universityId,jdbcType=INTEGER}
        WHERE id = #{id,jdbcType=INTEGER}
    </update>
```

## Student Mapper XML 

```xml
<resultMap id="BaseResultMap" 
	type="lt.vu.uc.mybatis.model.Student">
  <id column="id" jdbcType="INTEGER" property="id"/>
  <result column="first_name" jdbcType="VARCHAR" 
  	property="firstName"/>
  <result column="last_name" jdbcType="VARCHAR" 
  	property="lastName"/>
  <result column="registration_no" jdbcType="VARCHAR" 
    property="registrationNo"/>
  <result column="university_id" jdbcType="INTEGER" 
  	property="universityId"/>
</resultMap>
```

## Student Mapper XML
```xml
<select id="selectByPrimaryKey" 
parameterType="java.lang.Integer" resultMap="BaseResultMap">
	SELECT id, first_name, last_name, 
	registration_no, university_id
	FROM public.student WHERE id = #{id,jdbcType=INTEGER}
</select>
<select id="selectAll" resultMap="BaseResultMap">
	SELECT s.id, s.first_name, s.last_name, s.registration_no, 
	s.university_id, u.title as university_title
	FROM public.student s
	LEFT JOIN public.university u ON s.university_id = u.id
</select>
```

## Relations

```xml
<resultMap id="BaseResultMap" 
	type="lt.vu.usecases.mybatis.model.Student">
    <!-- Manually added for ManyToOne -->
    <!-- Nested result (no N+1 select problem) -->
    <association property="university" 
    	columnPrefix="university_" 
    	resultMap="lt.vu.uc.mybatis.dao.UniversityMapper.BaseResultMap"/>
    <!-- Manually added for ManyToMany -->
    <!-- Nested select (N+1 select problem) -->
    <collection property="courses" javaType="ArrayList" 
    	ofType="Course" column="id" 
    	select="selectCoursesForStudent"/>
</resultMap>

<!-- Manually added for ManyToMany -->
<select id="selectCoursesForStudent" resultType="Course">
    SELECT c.id, c.name
    FROM public.course c
        JOIN public.student_course sc on c.id = sc.course_id
    WHERE sc.student_id = #{id,jdbcType=INTEGER}
</select>
```


## UniversityMapper.xml

```xml
<mapper namespace="lt.vu.uc.mybatis.dao.UniversityMapper">
    <resultMap id="BaseResultMap" type="University">
        <id column="id" jdbcType="INTEGER" property="id"/>
        <result column="title" jdbcType="VARCHAR" 
        	property="title"/>
    </resultMap>
</mapper>
```

## DAO: StudentMapper

```java
@Mapper // added manually - MyBatis CDI integration
public interface StudentMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Student record);

    Student selectByPrimaryKey(Integer id);

    List<Student> selectAll();

    int updateByPrimaryKey(Student record);
}
```

> Method names matches with attribute `id` in XML file

## Use case controller

```java
@Model 
@Slf4j
public class RequestUseCaseControllerMyBatis {
    @Getter private Course course = new Course();
    @Getter private Student student = new Student();
    @Inject private StudentMapper studentMapper;
    @Inject private CourseMapper courseMapper;
    @Inject private StudentCourseMapper studentCourseMapper;

    public List<Student> getAllStudents() {
        return studentMapper.selectAll();
    }
    @Transactional
    public void createCourseStudent() {
        courseMapper.insert(course);
        studentMapper.insert(student);
        StudentCourse studentCourse = new StudentCourse();
        studentCourse.setCourseId(course.getId());
        studentCourse.setStudentId(student.getId());
        studentCourseMapper.insert(studentCourse);
    }
}

```

## usecase-mybatis.xhtml

```xml
<p:fieldset legend="All students" toggleable="true">
  <p:dataTable var="s"
           value="#{ucMyBatis.getAllStudents()}">

    <p:column headerText="Student">
      <h:outputText value="#{s.firstName} #{s.lastName}"/>
    </p:column>

    <p:column headerText="Courses">
      <ui:repeat var="c" value="#{student.courses}">
        <h:outputText value="#{c.name} " />
      </ui:repeat>
    </p:column>

    <p:column headerText="University">
      <h:outputText value="#{s.university.title}" />
    </p:column>
  </p:dataTable>
</p:fieldset>
```

## N+1 Problem

- We have a collection of `Car` objects (database rows), and each `Car` has a collection of `Wheel` objects (also rows)
- How to iterate through all the cars, and for each one, print out a list of the wheels? Naive O/R implementation:

```sql
SELECT * FROM Cars;
SELECT * FROM Wheel WHERE CarId = ?;
SELECT * FROM Wheel WHERE CarId = ?;
```

- First attempt

```sql
SELECT * FROM Cars;
SELECT * FROM Wheel WHERE CarId IN (?, ?);
```

- Better fix:

```sql
SELECT * FROM Cars c JOIN Wheel w ON w.CarId = c.Id;
```

???
Alternatively, one could get all wheels and perform the lookups in memory: SELECT * FROM Wheel
This reduces the number of round-trips to the database from N+1 to 2. 
Most ORM tools give you several ways to prevent N+1 selects.

## ORM vs Data Mapper

- SQL queries:
  - ORM: generated (out of the box compatibility with different RDBMS )
  - Data Mapper: manual; different RDBMS might require different SQL queries
- SQL performance:
  - ORM: difficult to control (we can provide _hints_)
  - Data Mapper: full control on SQL level
- N+1 select problem:
  - ORM: managed partially (we can define expectations)
  - Data Mapper: full control

## Dynamic SQL

```xml
<select id="findActiveBlogLike" resultType="Blog"> 
  SELECT * FROM BLOG 
  <where> 
    <if test="state != null"> 
        state = #{state} 
    </if> 
    <if test="title != null"> 
        AND title like #{title} 
    </if> 
    <if test="author != null and author.name != null"> 
        AND author_name like #{author.name} 
    </if> 
  </where> 
</select>
```

- The where element knows to only insert `WHERE` if there is any content returned by the containing tags. 
- Furthermore, if that content begins with `AND` or `OR`, it knows to strip it off.

