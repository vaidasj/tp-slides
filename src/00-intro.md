# Technologinės platformos

**Programų sistemų kūrimas**

Organizaciniai klausimai

## Apie kursą

Kursą dėsto partnerystės docentas Vaidas Jusevičius:

- El. paštas: [vaidas.jusevicius@mif.vu.lt](vaidas.jusevicius@mif.vu.lt)
- Tinklapis: [http://www.mif.vu.lt/~vaidasj/tp](http://www.mif.vu.lt/~vaidasj/tp)
- Modulio aprašas: [programų sistemų kūrimas](http://klevas.mif.vu.lt/~vaidasj/tp/6s_PSkurimas_2021_LT.pdf)

> Atkreipkite dėmesį į savarankiško darbo valandų kiekį!

## Tinklapis

Jame:

- Skaidrės
- Reikalavimai grupiniam projektui
- Reikalavimai laboratoriniams darbams
- Papildoma mokomoji medžiaga
- Informacija:
  - Atsiskaitymų terminai
  - Naujienos

Nebus:

- Informacijos apie TSP (bet ji bus kito dėstytojo puslapyje)

## Kurso turinys

**3-tier Multilayer Reference Architecture**

![3-tier Multilayer](images/3-tier-architecture.png "3-tier Multilayer")

## Kurso turinys

- UI (Presentation)
  - JS Web Frameworks (client-side) vs MVC server-side Web Frameworks
  - Kada kokį pasirinkti?
- Dalykinis funkcionalumas (Business logic):
  - Kodėl vyrauja komponentinės technologijos? Kas tai yra?
  - Kas yra Dependency Injection? Kuo tai naudinga?
- Duomenų prieiga (Data access):
  - Kas yra ORM? 
  - Kas yra DAO? 
  - Kuo jie skiriasi? Kada kurį geriau naudoti?

## Kurso turinys

- Įvadas į Java EE ir praktiniai patarimai 
  - JPA – Java Persistence API
  - DAO – MyBatis
  - CDI – Contexts and Dependency Injection
  - JSF – JavaServer Faces
  - JAX-RS – RESTful services
- Svetainėje pateiktų skaidrių neužteks!
  - Daug kas bus pasakoma per paskaitas žodžiu

## Kurso turinys

**Sistemų evoliucija**

- eBay (penkta karta)
  - monolitinis Perl -> monolitinis C++ -> Java -> microservices
- Twitter (trečia karta)
  - monolitinis Rails -> JS / Rails / Scala -> microservices
- Amazon (n-ta karta)
  - monolitinis C++ -> Perl / C++ -> Java / Scala -> microservices

> https://www.infoq.com/presentations/reactive-services-scale/

- Kas yra reaktyvi sistema?

???

It is convenient to distinguish roughly between three kinds of computer programs. 

- Transformational programs compute results from a given set of inputs; typical examples are compilers or numerical computation programs. 
- Interactive programs interact at their own speed with users or with other programs; from a user point of view, a time-sharing system is interactive. 
- Reactive programs also maintain a continuous interaction with their environment, but at a speed which is determined by the environment, not the program itself. 

Interactive programs work at their own pace and mostly deal with communication, while reactive programs only work in response to external demands and mostly deal with accurate interrupt handling. Real-time programs are usually reactive. However, there are reactive programs that are not usually considered as being real-time, such as protocols, system drivers, or man-machine interface handlers.

## Kurso turinys

- Kodėl programų sistemos modifikuojamumas / plečiamumas toks svarbus? 
- Kaip pagerinti modifikuojamumą?
- Įvadas į:
  - Dependency Injection (DI)
  - Interceptors, Decorators, Events
  - Component-Oriented Programming (COP)
  - Kas komponentinėse technologijose įgalina modifikuojamumą/plečiamumą?
- Ką tokio ypatingo turi objektinis programavimas (OOP), kad jis toks populiarus?

## Klausimas

Ką atsakytumėte, jei per potencialaus darbdavio interviu būtų klausimas:

> Kuo iš esmės objektinis programavimas naudingas kuriant didelę ir potencialiai ilgai eksploatuojamą sistemą?

## Kurso turinys

Aspektai, kuo programų sistemų kūrimas skiriasi nuo programų kūrimo
- Atminties valdymas
- Saugumas
- Konkurencinis daugelio naudotojų darbas ir duomenų darna
- Modifikuojamumas/plečiamumas

## I laboratorinis darbas – 1 balas

1. Pasirinkti instrumentines priemones ir suorganizuoti projekto versijų kontrolę, automatinį surinkimą bei išeities failų kūrimą su IDE (15% vertinimo). 
2. Suprojektuoti ir sukurti duomenų bazę, ir:
  - sukurti duomenų esybių klases su ORM ir DAO technologijomis (25%).
3. Įgyvendinti vieną panaudos atvejį, įtraukiantį naudojo interfeisą bei duomenų modifikavimą duomenų bazėje (60%).
  - būtinos DB transakcijos


- Detalesni reikalavimai dalyko puslapyje
- Praėjus atsiskaitymo terminui (5 pratybos), įvertinimas mažinamas po 0,1 balo už kiekvieną vėluojamą savaitę.

## II laboratorinis darbas – 1 balas

1. Studentai turi suprojektuoti ir įgyvendinti kelis PS panaudos atvejus (use-case), įtraukiančius: 
  - darbą su DB, 
  - dalykinio funkcionalumo komponentus ir 
  - naudotojo interfeisą
  - kitus reikalavimus, kurie bus pateikti dalyko svetainėje. 


- Atsiskaityti reikia pratybų metu (galima ir per paskutines pratybas). 
- Sesijos metu atsiskaitymai nevyks.

## Ribojimai

- Laboratorinius darbus atsiskaityti galima tik pratybų metu ir tik pas paskirtą pratybų dėstytoją
  - Ne el. laiškais, ne sesijos metu
- Neužtenka, kad demonstruojamas kodo fragmentas veikia
  - Turite gebėti paaiškinti teorinę medžiagą, atsakyti į dėstytojo klausimus
- Nedelskite iki paskutinių pratybų
  - Visada yra ką galima pagerinti/pataisyti

## Slenkstis

1. Neatsiskaičius abiejų laboratorinių darbų (kiekvieno bent 50% reikalavimų) galutinis įvertinimas ne didesnis už 4.
2. Komandinį projektą leidžiama ginti: 
  - pateikus techninę projekto ataskaitą;
  - pateikus ataskaitą apie komandinio programų kūrimo proceso (TSP) taikymą

## Projektas

- Reikalavimai techniniam komandinio projekto išpildymui bus pateikti dalyko svetainėje
- Leistinos technologinės platformos
  - Ribojimai
- Nefunkciniai/kokybiniai reikalavimai
