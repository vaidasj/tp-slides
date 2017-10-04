# XML Schema: Įvadas

Interneto technologijos

## XML Schema: samprata

- Tai kalba, skirta XML dokumento (t.y., kažkieno susikurtos kalbos) struktūros apibrėžimui(t.y., autoriaus taisyklių nusakymui)
- XML Schema leidžia apibrėžti:
    - Kokios žymės ir kokie atributai leistini XML dokumente
    - Koks turi būti žymių eiliškumas
    - Kokio tipo duomenys turi būti žymės/atributo viduje

## XML Schema: kalbos

Egzistuoja keletas skirtingų XML Schema kalbų, populiariausios:
- Document Type Definitions
    - [http://www.w3.org/TR/2004/REC-xml11-20040204/#NT-doctypedecl](http://www.w3.org/TR/2004/REC-xml11-20040204/#NT-doctypedecl)
- RELAX NG
    - REgular LAnguage for XML Next Generation
    - ISO/IEC 19757-2 standartas
    - [http://relaxng.org/](http://relaxng.org/)
- W3C XML Schema - šią kalbą mes nagrinėsime kurso metu
    - Kodėl?

## XML Schema: DTD

```xml
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<!DOCTYPE people_list [
<!ELEMENT people_list (person*)>
<!ELEMENT person (name, birthdate?, gender?,
socialsecuritynumber?)>
<!ELEMENT name (#PCDATA)>
<!ELEMENT birthdate (#PCDATA)>
<!ELEMENT gender (#PCDATA)>
<!ELEMENT socialsecuritynumber (#PCDATA)>
]>
<people_list>
    <person>
        <name>Fred Bloggs</name>
        <birthdate>2008-11-27</birthdate>
        <gender>Male</gender>
    </person>
</people_list>
```

## XML Schema: RELAX NG

```xml
<book>
    <page>This is page one.</page>
    <page>This is page two.</page>
</book>
```

- XML sintaksė:

```xml
<element name="book" xmlns="http://relaxng.org/ns/structure/1.0">
    <oneOrMore>
        <element name="page">
            <text/>
        </element>
    </oneOrMore>
</element>
```
- Kompaktiška sintaksė 

```
start = element book { page+ }
page = element page { text }
```

## XML Schema: W3C

- W3C: [http://www.w3.org/XML/Schema#dev](http://www.w3.org/XML/Schema#dev)
- Specifikacija susideda iš trijų dalių:
    - _XML Schema Part 0: Primer._ Neformalus dokumentas, apžvelgia XML Schema
    - _XML Schema Part 1 : Structures._ Formalus. Apibrėžia struktūrinius XML Schema elementus (atributų, elementų, sudėtingų duomenų tipų apibrėžimai)
    - _XML Schema Part 2: Datatypes._ Formalus. Aprašo duomenų tipus, apibrėžtus pačioje XML Schema specifikacijoje
- _Structures ir Datatypes_ yra sudėtingi dokumentai. Pradedančiajam reiktų skaityti Primer ir trečių šalių įvadinę medžiagą:
    - [http://www.w3schools.com/schema/](http://www.w3schools.com/schema/)

## XML Schema: W3C

- XML Schema Definition (XSD)
- 1.0 versija rekomendacija tapo 2001 metais
- 2012 išleista 1.1 versija:
    - Galimybė naudoti XPath2.0 išraiškas
    - Sąlyginis duomenų tipų priskyrimas
    - Atviro turinio modelio palaikymas
    - Pilnas sąrašas:
    [http://www.w3.org/TR/xmlschema11-1/#ch_specs](http://www.w3.org/TR/xmlschema11-1/#ch_specs)
- 1.1 yra suderinama su 1.0 versija
- Menkas 1.1 versiją palaikančių įrankių skaičius
- Mes kalbėsime apie 1.0 versija

## Pavyzdys: XML dokumentas

```xml
<?xml version="1.0" encoding="UTF-8"?>
<užsakymas data="2006-02-28">
    <pristatyti šalis="LT">
        <vardas>Jonas Jonaitis</vardas>
        <gatvė>Kalvarijų 5</gatvė>
        <miestas>Vilnius</miestas>
        <indeksas>LT-13952</indeksas>
    </pristatyti>
    <apmoka šalis="LT">
        <vardas>Petras Petraitis</vardas>
        <gatvė>Pylimo 2</gatvė>
        <miestas>Vilnius</miestas>
        <indeksas>LT-13434</indeksas>
    </apmoka>
    <pastaba>Dūžtanti prekė</pastaba>
    <prekiųSąrašas>...</prekiųSąrašas>
</užsakymas>
```

## Pavyzdys: XML Schema

```xml
<?xml version="1.0" encoding="UTF-8"?>
<xs:schema xmlns:xs="http://www.w3.org/2001/XMLSchema">
    <xs:element name="užsakymas" type="UžsakymoTipas" />
    <xs:complexType name="UžsakymoTipas">
        <xs:sequence>
            <xs:element name="pristatyti" type="AdresoTipas" />
            <xs:element name="apmoka" type="AdresoTipas" />
            <xs:element name="pastaba" type="xs:string" minOccurs="0" />
            <xs:element name="prekiųSąrašas" type="..." /> 
        </xs:sequence>
        <xs:attribute name="data" type="xs:date" />
    </xs:complexType>
```

## Pavyzdys: XML Schema

```xml
    <xs:complexType name="AdresoTipas">
        <xs:sequence>
            <xs:element name="vardas" type="xs:string" />
            <xs:element name="gatvė" type="xs:string" />
            <xs:element name="miestas" type="MiestoTipas" />
            <xs:element name="indeksas" type="xs:string" />
        </xs:sequence>
        <xs:attribute name="šalis" type="xs:string" fixed="LT" />
    </xs:complexType>
    <xs:simpleType name="MiestoTipas">
        <xs:restriction base="xs:string">
            <xs:maxLength value="20" />
        </xs:restriction>
    </xs:simpleType>
</xs:schema>
```

## XML Schema dokumento antraštė

- XML Schema yra W3C sukurta XML kalba, t.y., turi savo žymes ir atributus, bei savo vardų sritį:
  - [http://www.w3.org/2001/XMLSchema](http://www.w3.org/2001/XMLSchema)
  - Šią vardų sritį būtina naudoti visuose XML Schema dokumentuose

- XML Schema dokumento antraštė: 
```xml
<?xml version="1.0" encoding="UTF-8"?>
<xs:schema xmlns:xs="http://www.w3.org/2001/XMLSchema">
...
</xs:schema>
```

- Žymės, prasidedančios prefiksu `xs`, yra XML Schema kalbos žymės, kitos žymės yra jūsų aprašomos kalbos žymės
- Vietoj `xs` galima naudoti bet kokį kitą patinkantį prefiksą

## Kurso turinys

- Žymių paskelbimas
- Atributų paskelbimas
- Paprasti tipai
- Sudėtingi tipai
- Integralumo apribojimai
    - Raktai, unikalumo reikalavimai
    - Nuorodos į raktus

## Žymių deklaracija

Žymės (sinonimas elementas) deklaracija yra:

1. žymės vardo susiejimas su žymės tipu,
2. žymės pasikartojimo skaičiaus nurodymas (nebūtina)
3. reikšmės pagal nutylėjimą nurodymas (nebūtina)

```xml
<xs:element name="žymėsVardas" type="tipoVardas">
...
</xs:element>
```

## Žymių deklaracija

- Tipas `anyType` yra bazinis tipas (iš jo paveldi visi kiti tipai)
    - Jis niekaip nesuvaržo (t.y., netipizuoja) žymės turinio – žymės viduje gali būti tiek skaičiai, tiek bet koks tekstas, tiek ir kitos žymės
       
```xml
<xs:element name="KnygųSąrašas" type="xs:anyType"/>
```

- Vardų srities prefiksą nurodyti būtina!
- Jei žymės tipas nenurodytas, tai tipas yra `anyType`:

```xml
<xs:element name="KnygųSąrašas"/>
```

## Žymės deklaracijos atributai

- `minOccurs`– kiek kartų mažiausiai žymė gali pasikartoti (pagal nutylėjimą: 1)
- `maxOccurs` – kiek kartų daugiausiai žymė gali pasikartoti (pagal nutylėjimą: 1)
- `default` – žymės turinys/reikšmė (tekstinis) pagal nutylėjimą
    - jei XML dokumente ši žymė turės reikšmę, ji ir bus naudojama (ne reikšmė pagal nutylėjimą)
    - jei žymė dokumente bus, bet reikšmės neturės (tuščias turinys/reikšmė), tai XML parserisžymei įterps reikšmę pagal nutylėjimą
    - jei žymės dokumente nebus, žymė (ir reikšmė pagal nutylėjimą) nebus sukuriami!
- `fixed` –fiksuotas žymės turinys/reikšmė (draudžiama nurodyti kitokią žymės reikšmę)

## Atributų deklaracija

- Atributo deklaracija yra:
    - atributo vardo susiejimas su atributo tipu,
    - atributo pasirodymo apribojimas (nebūtina),
    - atributo reikšmė pagal nutylėjimą

```xml
<xs:attribute name="atributoVardas" type="atributoTipas"/>
```

## Atributų deklaracija

- Deklaracijoje galima naudoti šiuos atributus:
    - `use` – nusako pasirodymo apribojimą. Reikšmės: (`optional` | `prohibited` | `required`), pagal nutylėjimą: `optional`
    - `default` – nusako reikšmę pagal nutylėjimą - jei jūsų atributo nėra XML dokumente, jis bus įterptas su reikšme pagal nutylėjimą
    - `fixed` – nustato fiksuotą reikšmę. Jei atributo nėra, jis įterpiamas su šia reikšme

## Globalios žymės ir atributai

- Globalios žymės/atributai yra sukuriami deklaracijomis, kurios yra žymės `xs:schema` vaikai
- Po sukūrimo, į juos gali būti daroma nuoroda iš kitų deklaracijų pasinaudojant `ref` atributu
- Globalios žymės deklaracija leidžia naudoti šią žymę kaip šakninę viso dokumento žymę
- Globalios deklaracijos negali turėti atributo `ref`, jos privalo turėti atributą `type`
- Globalios deklaracijos negali turėti atributų `minOccurs`, `maxOccurs`, ir `use`

## XML Schema turinio rūšys

|                            | Mišrus | Sudėtingas | Paprastas | Tuščias |
|----------------------------|--------|------------|-----------|---------|
| Gali turėti vaikinių žymių | Taip   | Taip       | Ne        | Ne      |
| Gali turėti tekstą         | Taip   | Ne         | Taip      | Ne      |


- Žymių turinys gali būti visų keturių rūšių
- Atributų turinys gali būti tik paprastas arba tuščias


## Pavyzdžiai

- Paprastas turinys:
    - Žymė: `<pavadinimas>Algebra</pavadinimas>`
    - Atributas: `kalba="lt"`
- Tuščias turinys:
    - Žymė: `<pavadinimas></pavadinimas>`, arba tiesiog `<pavadinimas/>`
    - Atributas: `kalba=""`

## Pavyzdžiai

- Mišrus turinys:

```xml
<pastaba>
    Šita prekė yra
    <b>dūžtanti</b> Ryte <i>nepristatinėti</i>!
</pastaba>
```

- Jei pastabos vaikai būtų tik žymės, tada turinys būtų sudėtingas

## Mišraus turinio pavyzdys

- Čia ne mišrus, o sudėtingas turinys:

```xml
<kažkas>
<aaa>kva</aaa>
<bbb>miau</bbb>
</kažkas>
```

> Žymė "kažkas" tekstinių vaikų neturi! Turi tik vaikines žymes.

## Mišraus turinio pavyzdys

- O čia – mišrus:

```xml
<kažkas>
<aaa>kva</aaa>
<bbb>miau</bbb>
kuku
</kažkas>
```

> O čia turi ir vaikines žymes, ir vaikinį tekstinį mazgą "kuku".

## XML Schema tipų sistema

- Paprastieji tipai (`simpleType`)
    - Standartiniai duomenų tipai: `xs:string`, `xs:integer`, `xs:date`,...
    - Išvestiniai duomenų tipai. Susikuriate savo paprastus duomenų tipus, apribodamistandartinius duomenų tipus
    - Skirti paprastam ir tuščiam turiniui aprašyti
    - **Atributai žymės viduje negalimi!!!**
- Sudėtingi tipai (`complexType`)
    - Standartinių nėra, visus turite susikurti ( _išvesti_ ) patys
    - Skirti visų rūšių turiniams aprašyti
    - **Žymių viduje galima naudoti atributus**

## Naujų tipų išvedimo būdai

- Yra du tipų išvedimo būdai:
    - Apribojimas (restriction) – naujas tipas būna "siauresnis"/"mažesnis" nei
       senas
    - Išplėtimas (extension) – naujas tipas būna "platesnis"/"didesnis" už seną


## Išvedimo būdai

![Tipų su paprastu turiniu išvedimo būdai](images/xml-schema-1.png "Tipų su paprastu turiniu išvedimo būdai")

## Paprastųjų tipų išvedimas

- Pavyzdys: aprašome paprastą turinį – sąskaitos numerį, t.y., tam tikrą šabloną atitinkančią eilutę (string):

```xml
<xs:simpleType name="SąskaitosNr">
    <xs: restriction base="xs:string">
        <xs:length value="20" />
        <xs:pattern value="LT[0-9]{18}" />
    </xs: restriction>
</xs:simpleType>
```

- Tokį tipą galima priskirti tiek žymei, tiek ir atributui:

```xml
<Sąskaita>LT123456789012345678</Sąskaita>
```

```xml
<Sąskaita nr="LT123456789012345678">...</Sąskaita>
```
## Paprastųjų tipų struktūra 

```xml
<simpleType name=N CName>
    Content: (restriction | list | union)
</simpleType>
```

```xml
<restriction base=Q Name>
    Content: (simpleType?, (minExclusive | 
    minInclusive | maxExclusive | maxInclusive | 
    totalDigits | fractionDigits | length | 
    minLength | maxLength | enumeration | pattern)* )
</restriction>
```

## Paprastųjų tipų struktūra – sąrašo tipas

```xml
<list itemType=Q Name>
    Content: (simpleType?)
</list>
```

- Pavyzdys:

```xml
<xs:simpleType name="intList">
    <xs:list itemType="xs:integer" />
</xs:simpleType>
```

- Tarkim, žymė skaičiai turi tipą intList:

```xml
<skaičiai>20003 15037 95977 95945</skaičiai>
```

- Sąrašo tipą galima apriboti, nurodant jo ilgį, šabloną, ir pan.


## Paprastųjų tipų struktūra – sąjungos tipas

```xml
<union memberTypes=L ist of QName>
    Content: (simpleType*)
</union>
```

- Pavyzdys:

```xml
<xs:simpleType name="intDateUnion">
    <xs:union memberTypes="intList xs:date" />
</xs:simpleType>
```

- Tarkim, žymė sąrašas turi tipą intDateUnion:

```xml
<sąrašas>20003 2006-01-02 150 555</sąrašas>
```

## Paprastų tipų apribojimai

Visiems iš `xs:string` išvestiems tipams galima taikyti šiuos apribojimus:
- `length` - ilgis
- `minLength` – mažiausias ilgis
- `maxLength` – didžiausias ilgis
- `pattern` – šablonas (reguliari išraiška)
- `enumeration` – reikšmių išvardijimas

## Paprastų tipų apribojimai

Visiems skaitiniams tipams ir datoms:
- `pattern, enumeration` – tas pats
- `minInclusive` – mažiausias įtraukiant (matematiškai `[`)
- `minExclusive` – mažiausias neįtraukiant (matematiškai `(`)
- `maxInclusive` – didžiausias įtraukiant (matematiškai `]`)
- `maxExclusive` – didžiausias neįtraukiant (matematiškai `)`)
- `totalDigits` – koks turi būti skaičiaus ilgis (skaitmenų skaičius)
- `fractionDigits` – kiek gali būti skaitmenų po kablelio


## `enumeration` pavyzdys

```xml
<xs:simpleType name="Šalys">
    <xs:restriction base="xs:string">
        <xs:enumeration value="LT" />
        <xs:enumeration value="US" />
        <xs:enumeration value="RU" />
        <!-- čia galim rašyti ir kitus apribojimus -->
    </xs:restriction>
</xs:simpleType>
```