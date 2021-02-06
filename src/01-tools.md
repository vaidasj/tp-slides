# Instrumentinės priemonės

Technologinės platformos

Programų sistemų kūrimas

## IDE

- IntelliJ IDEA
  - Mokama. _Mano subjektyvia nuomone geriausia Java IDE_
  - VU turi nemokamą prieigą 
- Eclipse
  - Nemokama
  - Universali, bet reikia „susikomplektuoti“ įskiepius
- Apache NetBeans
  - Nemokama
  - Nėra standartinio Java EE specifikacijų palaikymo

???

Comparison: https://www.lifewire.com/comparing-java-ides-eclipse-vs-netbeans-vs-intellij-2373152

## Surinkimo įrankiai

![Build tools](images/build-tools.png "Build tools")

## Surinkimo įrankiai - Ant

- http://ant.apache.org
- Imperatyvus – jam reikia apibrėžti „receptus“, susidedančius iš paprastų komandų
- Lankstus
- Projekto katalogų struktūrą reikia susigalvoti pačiam
- Apie saugyklas (repositories) buvo pradėta galvoti per vėlai
  - ivy - transitive package manager
- Praktiškai nebesutinkamas

## Surinkimo įrankiai - Maven 

- http://maven.apache.org
- Deklaratyvus – pasakomi norai
- Apibrėžia standartinę projekto katalogų struktūrą
- Apibrėžia modulio sąvoką; moduliai privalo būti talpinami saugyklose (repositories)
  - Centrinė repozitorija: https://search.maven.org/
- Mažiau lankstumo nei Ant
- Bene populiariausias šiandien Java pasaulyje

## Surinkimo įrankiai - Gradle 

- https://gradle.org
- Deklaratyvus – pasakomi norai
- Sukurtas Ant ir Maven pagrindu
- Naudoja Maven repozitorijas
- Trumpesni konfigūraciniai failai
- Galimybė rašyti _skriptus_
- Sudėtingesnis išmokti

???

1. Ant’s readability and Maven’s simplicity are, in my opinion, false arguments that apply only during the short initial Gradle learning curve. 
2. Once one is used to the Gradle DSL, its syntax is shorter and easier to understand than those employed by Ant or Maven. 
3. Moreover, only Gradle offers both conventions and creation of commands. 

Manve:
- Archetypes: https://maven.apache.org/guides/introduction/introduction-to-archetypes.html
- Lifecycles:
    - https://maven.apache.org/guides/introduction/introduction-to-the-lifecycle.html
    - https://image.slidesharecdn.com/continuous-delivery-with-maven-121002134347-phpapp02/95/continuous-deliverywithmaven-23-728.jpg?cb=1349185837

Comparison:

- http://www.baeldung.com/ant-maven-gradle
- https://technologyconversations.com/2014/06/18/build-tools/

Examples:
- https://github.com/vfarcic/JavaBuildTools

## Versijų valdymo sistemos

Populiariausios:
- Centralizuota: SVN (Subversion)
- Decentralizuotos: 
  - Git
  - Mercurial (hg)

Nemokamos projektų saugyklos:

- GitHub (https://github.com)
- GitLab (https://gitlab.com)
- VU projektų saugykla (GitLab pagrindu):
  - https://git.mif.vu.lt/ 

???

Ry's Git Tutorial: https://www.amazon.com/dp/B00QFIA5OC/ref=cm_sw_su_dp

History: https://i.stack.imgur.com/hBZd0.png

## Technologinės platformos sąvoka

Toks technologijų rinkinys, kad įgalinamas visapusiškas: 
- Funkcinių reikalavimų įgyvendinimas:
  - UI, dalykinis funkcionalumas (business logic), prieiga prie DB duomenų (data access / persistence)
- Nefunkcinių (kokybinių) reikalavimų įgyvendinimas:
  - Saugumas, plečiamumas / modifikuojamumas, darna (consistency), išlygiagretinimas (concurrency), asinchroninis komunikavimas, ...
- Technologijos integruotos tarpusavyje
- Platformą įmanoma plėsti (branda)

## Technologinių platformų pavyzdžiai

- Jakarta EE / Java EE (https://jakarta.ee)
  - Eclipse + Java Comunity Process (JCP)
- Spring (https://spring.io/projects/) 
  - Pivotal
- .Net (https://www.microsoft.com/net) 
- OSGi Enterprise (https://www.osgi.org/business/markets-and-solutions/enterprise/)
- Ruby on Rails (http://rubyonrails.org/)
- ... 

## Jakarta EE 

![Java EE](images/java-ee-8.png "Java EE")

Egzistuoja skirtingi [profiliai](https://i.stack.imgur.com/CybGj.png):

- Web Profile
- Servlet-only
- Full Java EE
- _Optional_

???

https://i.stack.imgur.com/CybGj.png

## Spring

![Spring](images/spring.png "Spring")

## .NET

![.NET](images/net.png ".NET")

## Brandžios platformos bruožai

- DI – Dependency Injection (priklausomybių įterpimas)
  - Java EE – CDI (http://cdi-spec.org/) 
  - Spring – Spring Framework IoC
  - .Net - Core Microsoft.Extensions.DependencyInjection

- DI sudaro prielaidas įgalinti modifikuojamumą / plečiamumą
  - Pvz.; Java EE „Portable extensions“ yra CDI standarto dalis.

## Aplikacijų serveriai 

Nemokami:

- Eclipse Glassfish
  - Eclipse Foundation
- Open Liberty
  - IBM Corporation
- Payara Server
  - Payara Services Limited
- WildFly
  - Red Hat

Mokami:

- WebLogic(Oracle) ir kt.


