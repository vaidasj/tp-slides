# XML Schema: Patarimai

Interneto technologijos


## XML dokumento be vardų srities susiejimas su schema

- XML dokumentas be vardų srities gali pasisakyti, kad jis  atitinka tam tikrą schemą, pvz.:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<užsakymas data="2006-02-28"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
xsi:noNamespaceSchemaLocation="uzsakymas.xsd"
>
</užsakymas>
```

- Atributas `noNamespaceSchemaLocation` priklauso vardų sričiai _.../XMLSchema-instance_, todėl privalu jį paskelbti su vardų srities prefiksu
- Faile _uzsakymas.xsd_ yra XML Schema dokumentas

## XML dokumento su vardų sritimi susiejimas su schema

- Tarkim, XML dokumento apie užsakymus vardų sritis yra `http://uzsakymai.lt`. Tada susiejimas su schema:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<užsakymas
    xmlns="http://uzsakymai.lt"
xsi:schemaLocation="http://uzsakymai.lt uzsakymas.xsd"
    xmlns: xsi ="http://www.w3.org/2001/XMLSchema-instance">
    <prekiųSąrašas>...</prekiųSąrašas>
</užsakymas>
```

- Atributo _schemaLocation_ struktūra: `xsi:schemaLocation="http://uzsakymai.lt uzsakymas.xsd"`
  - Vardų srities pavadinimas + Kelias iki schema failo

## XML dokumento su vardų sritimi susiejimas su schema

```xml
<xs:schema xmlns:xs="http://www.w3.org/2001/XMLSchema"
targetNamespace="http://uzsakymai.lt" xmlns: mano ="http://uzsakymai.lt"
elementFormDefault="qualified" >
    <xs:element name="užsakymas" type=" mano:UžsakymoTipas "/>
    <xs:complexType name=" UžsakymoTipas ">
        <xs:sequence>
            <xs:element name="prekiųSąrašas" type="PrekiųSąrašoTipas"/>
        </xs:sequence>
    </xs:complexType>
</xs:schema>
```

- Galima naudoti ir vardų sritį pagal nutylėjimą (nereikės rašyti prefiksų prieš savo tipų vardus)
- Naudojant tipą, prefikso reikia
- Paskelbiant tipą, prefikso nereikia

## elementFormDefault

- Prisiminkite, kas yra globalių žymių/elementų deklaracija, ir kas - lokalių žymių/elementų deklaracija (_įvadas į XML Schema_)
  - Praeitame pavyzdyje _užsakymas_ yra **globali** žymė, _prekiųSąrašas_ – **lokali** žymė
- `elementFormDefault` gali turėti šias reikšmes:
  - _unqualified_ (reikšmė pagal nutylėjimą) – lokalios žymės XML dokumente privalo būti nekvalifikuotos (t.y., be vardų srities prefikso, ir  joms neturi galioti vardų sritis pagal nutylėjimą)
  - _qualified_ – lokalios žymės XML dokumente privalo būti su vardų srities prefiksu arba joms turi galioti vardų sritis pagal nutylėjimą
- **Pastaba**: globalios žymės visada privalo priklausyti vardų sričiai (jei XML dokumentas naudoja vardų sritį)


## elementFormDefault (paslėpimas)

```xml
<?xml version="1.0"?>
<xsd:schema
    xmlns:xsd="http://www.w3.org/2001/XMLSchema"
	targetNamespace="http://www.camera.org"
    xmlns:nikon="http://www.nikon.com"
    xmlns:olympus="http://www.olympus.com"
    xmlns:pentax="http://www.pentax.com"
    elementFormDefault="unqualified">

    <xsd:import namespace="http://www.nikon.com"
		schemaLocation="Nikon.xsd"/>
    <xsd:import namespace="http://www.olympus.com"
		schemaLocation="Olympus.xsd"/>
    <xsd:import namespace="http://www.pentax.com"
		schemaLocation="Pentax.xsd"/>
```

## elementFormDefault (paslėpimas)

```xml
    <xsd:element name="camera">
        <xsd:complexType>
            <xsd:sequence>
                <xsd:element name="body" 
                	type="nikon:body_type" />
                <xsd:element name="lens" 
                	type="olympus:lens_type" />
                <xsd:element name="manual_adapter"
					type="pentax:manual_adapter_type" />
            </xsd:sequence>
        </xsd:complexType>
    </xsd:element>
</xsd:schema>
```

## elementFormDefault (paslėpimas)

```xml
<?xml version="1.0"?>
<my:camera
    xmlns:my="http://www.camera.org"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xsi:schemaLocation="http://www.camera.org Camera.xsd">
    <body>
        <description>Ergonomically</description>
    </body>
    <lens>
        <zoom>300mm</zoom>
        <f-stop>1.2</f-stop>
    </lens>
    <manual_adapter>
        <speed>1/10,000 sec to 100 sec</speed>
    </manual_adapter>
</my:camera>
```

## Apibendrinimas

- XML Schema sudėtingas standartas
- Dažnai sunku nuspręsti:
    - nuo ko pradėti
    - kurį kelią pasirinkti
- Pamėginsime palyginti kelias galimas XML Schema kūrimo strategijas
- Patarimai parengti atsižvelgiant į xml-dev bendruomenės patarimus ir nuomones:
    - [http://www.xml.org/xml-dev](http://www.xml.org/xml-dev)

## Pagrindinės problemos

- Globalūs ar lokalūs XML Schema komponentai?
- Naudoti elementų ar tipų apibrėžimus?
- Vardų sritis pagal nutylėjimą. XML Schemos ar mūsų?


## Lokalus ar globalus?

- Prisiminkime – globalus komponentas yra tiesioginis schema vaikas, o lokalus esantis kito komponento viduje
- Egzistuoja keli skirtingi projektavimo šablonai:
    - Matrioškos
    - Saliami gabalėlio
    - Žaliuzių
- XML

```xml
<Book>
    <Title>Illusions</Title>
    <Author>Richard Bach</Author>
</Book>
```

## Matrioškos šablonas

- Idėja – atkartoti XML dokumento struktūrą

```xml
<xsd:element name="Book">
    <xsd:complexType>
        <xsd:sequence>
            <xsd:element name="Title" type="xsd:string"/>
            <xsd:element name="Author" type="xsd:string"/>
        </xsd:sequence>
    </xsd:complexType>
</xsd:element>
```

- Elementai yra aprašomi iš eilės (einant vaikiniu ryšiu) ir atkartojant XML dokumentą. Tarsi konstruotumėme matriošką, _mažesnį_ elementą įdėdami į didesnio vidų.

## Matrioškos šablono savybės

- _Nepermatomas_ turinys
    - Negalimas pakartotinis panaudojimas
- Lokali apibrėžimo sritis
    - Galimybė lokalizuoti/paslėpti elementus naudojant `elementFormDefault=unqualified`
- Kompaktiškumas
- Komponentų tarpusavio atsiejimas
    - Komponentai savarankiški, vieno pakeitimas turi ribotą poveikį
- Rišlumas
    - Visi susieję duomenys sugrupuoti į savarankiškus komponentus

## Saliami gabalėlio šablonas

- Idėja – išskirti kiekvieną iš XML dokumento elementų, jį aprašyti kaip globalų elementą ir juos susieti tarpusavyje (naudojant nuorodas į elementus).

```xml
<xsd:element name="Title" type="xsd:string"/>
<xsd:element name="Author" type="xsd:string"/>
<xsd:element name="Book">
    <xsd:complexType>
        <xsd:sequence>
            <xsd:element ref="Title"/>
            <xsd:element ref="Author"/>
        </xsd:sequence>
    </xsd:complexType>
</xsd:element>
```


## Saliami gabalėlio šablono savybės

- _Permatomas_ turinys
    - Galimas pakartotinis panaudojimas
- Globali apibrėžimo sritis
    - Elementų vardų sritis pateikiama XML dokumente
- Aiškumas/išsamumas
- Stipri sankiba
    - Komponentai tarpusavyje susiję, vieno pakeitimas įtakoja kitą
- Rišlumas
    - Visi susieję duomenys sugrupuoti į savarankiškus komponentus

## Matrioška prieš saliamį

- Tai dvi priešingybės. Jeigu galvotumėme apie elementus ar tipus, kaip apie dėžes, tai
    - Matrioškos šablonas, egzistuoja viena dėžė, į kurią yra įdėta mažesnė  dežė, į šią dar mažesnė ir t.t.
    - Saliami gabalėlio šablono atveju egzistuoja daug atskirų dėžių, kurios  yra surenkamos kartu į norimą formą.
- Du svarbiausi skirtumai:
    - Matrioškos šablonas įgalina vardų galiojimo sričių sudėtingumo paslėpimą/lokalizavimą, saliami šablonas to neleidžia
    - Saliami gabalėlio šablonas įgalina komponentų pakartotiną panaudojimą, matrioškos šablonas to neleidžia

## Žaliuzių šablonas

- Idėja – išskiriame atskirus komponentus, tačiau juos aprašome ne kaip elementus, o kaip tipus

```xml
<xsd:complexType name="Publication">
    <xsd:sequence>
        <xsd:element name="Title" type="xsd:string"/>
        <xsd:element name="Author" type="xsd:string"/>
    </xsd:sequence>
</xsd:complexType>
<xsd:element name="Book" type="Publication"/>
```

## Žaliuzių šablono savybės

- _Maksimalus_ pakartotinis panaudojimas
    - Pradinis pakartotinio panaudojimo komponentas yra duomenų tipas
- Vardų srities slėpimas/lokalizavimas
- Lengvas perėjimas nuo paslėptos prie visiem matomos vardų srities
    - Pakanka pakeisti `elementFormDefault` reikšmę
- Stipri sankiba
    - Komponentai tarpusavyje susiję, vieno pakeitimas įtakoja kitą
- Rišlumas
    - Visi susieję duomenys sugrupuoti į savarankiškus komponentus

## Kurį šabloną pasirinkti?

- Žaliuzių šablonas pats lanksčiausias. Naudoti jeigu:
    - Svarbus pakartotinis panaudojimas
    - Reikalingas lengvas ir greitas vardų srities paslėpimo/rodymo perjungimas
    - Norite sėkmingai atsiskaityti IT pratybų praktinę užduotį
- Saliami gabalėlio šabloną naudoti, kai reikia suteikti galimybę vykdyti elementų sukeitimą (nenagrinėta šiame kurse)
- Matrioškiosšabloną naudoti jei reikalinga kompaktiška XML schema ir tarpusavyje atsieti komponentai


## Modeliuoti kaip tipą ar elementą?

- Jeigu griežtai naudosime žaliuzių šabloną naudosime tipus
- Jei deriname skirtingus šablonus:
    - Kai abejojate sukurkite tipą - iš jo visada galima sukurti elementą
    - Jei komponentas niekada nebus elementu XML dokumente kurkite tipą
    - Jei komponento turinys turi būti panaudotas kituose komponentuose kurkite tipą


## Vardų sritis pagal nutylėjimą

- Galimi trys variantai:
    - XML Schema vardų sritis pagal nutylėjimą
    - Autoriaus (_targetNamespace_) vardų sritis pagal nutylėjimą
    - Jokios vardų srities pagal nutylėjimą

```xml
<schema
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
		targetNamespace="http://www.library.org"
    	xmlns="http://www.library.org"
		elementFormDefault="qualified">
</schema>
```

- Nėra aiškaus geriausio varianto, daugiau stiliaus klausimas
- Praktinėse užduotyse siūlyčiau naudoti antrą variantą