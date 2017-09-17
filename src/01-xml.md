# Duomenų formatai: XML

Interneto technologijos

## Duomenys ir duomenų aprašai

- Paprastai sakant, duomenys – tai kažkam įdomi tam tikra simbolių seka, tinkamame kontekste tampanti informacija:

  ```csv
  Vardenis Pavardenis 1976-10-11 37613111234 Vilnius 
  ```

- Kad trečiai šaliai padėti „susiorientuoti“, kokius duomenis aprašo tam tikra simbolių seka, dažnai naudojami duomenų aprašai (meta-duomenys):

  - Vardas: Vardenis Pavardenis
  - Gimimo data: 1976-10-11
  - Gimimo vieta: Vilnius

- Kitas pavyzdys: visos lentelės paprastai turi antraštes, kad būtų aiškiau, kokie duomenys yra stulpeliuose

## Duomenų formatas

- Susitarimas, kaip duomenis (ir galbūt duomenų aprašus) užrašyti tam tikra simbolių ir skirtukų eilute, vadinamas
duomenų formatu
- Pvz.: dažnai sutinkamas CSV (Comma-separated values, kableliais atskirtos reikšmės) formatas:
  - Vieno įrašo duomenų reikšmės atskiriamos kableliais
  - Naujas įrašas pradedamas naujoje eilutėje
  
  ```csv
  Jonas Jonaitis, 1976-10-11, 37610111234, Vilnius
  Petras Petraitis, 1980-02-03, 38002039999, Kaunas
  ```

## Tekstiniai ir dvejetainiai duomenų formatai

- Duomenų formatas yra tekstinis, jei:
  - šiuo formatu užrašytiems duomenims perskaityti žmogui užtenka turėti paprastą tekstinį redaktorių (pvz.: Notepad)
  - pvz.: anksčiau rodytas CSV formatas yra tekstinis
- Duomenų formatas yra dvejetainis/binarinis, jei:
    - šiuo formatu užrašytiems duomenims perskaityti reikia turėti specializuotą programinę įrangą
    - dvejetainio formato pavyzdys kitoje skaidrėje
    - dvejetainio formato pavyzdys kitoje skaidrėje

## Dvejetainio formato pavyzdys

```bash
ŠĻą į > ž ̇ A C ž ̇ ̇ ̇ >? @ E F 1 Š Q Ņ S
Ō U Ö W Ų Y Ś [ Ü ] Ž _ ą €

̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇
̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇
̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇
̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇ ̇ģ Į _Ą' ųæ Ė by
qD b b 3 Õ b ̇ ̇ ̇ ̇ ̇ ̇ · , , †)
†) , , , $ ̇ ̇ ̇ ̇ :, :, :, P , Ō ^. Ģ :, (Ł & *1 ¤ Ī6 ”
b7 b7 x7 ,F ² ŽM D "P $ Y× [× [× [× [× L( : '
D O C P R O P E R T Y " K V S D o k P a v " \* M E R G E x
3 p r i e ~i kr o s p a s l a u g o s p r o c e d kr a P a
D O C P R O P E R T Y " K V S P a r e n g D a t a " \* M E
T 2 0 0 9 - 0 9 -2 8 D o k u m e n t o v e r s i j a : D O
" K V S V e r s i j a " \* M E R G E F O R M A T 1. 2 D o 
kk l : D O CPROPERTY "KVSBukle" \* MERGEFORMAT GalutinisP:
DOCPROPERTY "KVSPadProj" \* MERGEFORMAT S3Sutarties numer:
DOCPROPERTY "KVSSutNr" \* MERGEFORMAT 22-62Pirmos versija:
DOCPROPERTY "KVSPirmLeidData"
```

## Duomenų struktūrizavimo laipsnis

- Nestruktūrizuoti duomenys
    - Pvz.: laisvos formos tekstas
- Dalinai struktūrizuoti
    - Tekstas išskaidytas į skyrius, duomenys pateikiami lentelėmis, sąrašais, bet yra ir laisvos formos teksto
- Griežtai struktūrizuoti
    - Struktūra apibrėžiama iš anksto, duomenų pateikimo forma (dokumentas) turi šią struktūrą griežtai atitikti
- XML leidžia aprašyti _dalinai_ ir _griežtai_ struktūrizuotus duomenis
    - Mes šiame kurse nagrinėsime tik **griežtos** struktūros duomenų užrašymą XML formatu

## Duomenų apsikeitimas tarp sistemų

![Duomenų apsikeitimas](images/xml-1.png "Duomenų apsikeitimas")

1. Sistema 1 duomenis patalpina į tam tikro formato dokumentą
2. Dokumentas per duomenų perdavimo kanalą nusiunčiamas sistemai 2
3. Sistema 2 „skaito“ dokumentą – paima dokumentu atsiųstus duomenis

## Reikalavimai duomenų formatui

Duomenų apsikeitimui tinkantis formatas turėtų būti:

- **Formalus** – negali būti tos pačios simbolių ir skirtukų eilutės dviejų skirtingų interpretacijų
- **Paprastas** – sistemai (tiksliau, programuotojams) neturi būti sunku sukurti/skaityti tokio formato dokumentus
- **Atviras, standartizuotas** – formato aprašymas būtų nemokamas, visiems prieinamas ir standartizuotas
- **Skaitomas ir mašinai, ir žmogui** – ir žmogus turi galėti skaityti šiuo formatu užrašytus duomenis nenaudodamas specialios programinės įrangos, t.y. formatas turi būti tekstinis
- **Įgalintų aprašomų duomenų evoliuciją** (formato plečiamumas) –laikui bėgant, duomenų struktūra paprastai yra linkusi sudėtingėti. Būtų negerai, jei kiekvieną kartą tektų sistemoje perprogramuoti dokumento formavimą/skaitymą

## Kodėl netinka CSV?

- CSV formatas tenkina tik pirmus keturis reikalavimus
- CSV formatas nėra _plečiamas_ – šiuo formatu užrašytus duomenis skaitančios sistemos prisiriša prie stulpelių pozicijų (pozicinis formatas)
- Negalime įterpti naujų stulpelių į vidurį
- Pabaigoje naujus stulpelius pridėti galime, bet to ne visada pakanka
- Ne visus duomenis pavyksta aprašyti lentelės struktūra, pvz. hierarchinių duomenų CSV formatu užrašyti nepavyks
- **Išvada**: CSV formatas tinka tik santykinai paprastiems duomenims užrašyti

## XML: Extensible Mark-up Language

- Tiesioginis vertimas: “plečiama duomenų aprašų kalba”
- Pirmą versiją sukūrė W3C konsorciumas 1998 m. vasario 10 d.
- Tenkinami visi aukščiau išvardinti reikalavimai
- Aktuali yra:
    - versijos [1.0 penkta redakcija](https://www.w3.org/TR/REC-xml/), priimta 2008 m. lapkričio 26 d. 
    - versijos [1.1 antra redakcija](https://www.w3.org/TR/xml11/), priimta 2006 m. rugpjūčio 16 d.

## World Wide Web Consortium

- W3C – pasaulinio tinklo konsorciumas (šiai organizacijai priklauso beveik visos didžiosios IT kompanijos)
- [http://www.w3.org/](http://www.w3.org/)
- W3C kuria technologijas (specifikacijas, įrankius, ir t.t.), vienaip ar kitaip susijusias su Internetu
- Specifikacijos pereina šiuos paruošimo etapus:
    - Working draft – darbinis juodraštis
    - Candidate recommendation – kandidatas į rekomendaciją
    - Proposed recommendation – siūloma rekomendacija
    - Recommendation – rekomendacija (priimtas standartas)

## XML šiandieniniame pasaulyje

- XML formatas labai sparčiai išplito visame pasaulyje – nemaža dalis sistemų šiandien duomenimis apsikeičia būtent šiuo formatu
- XML taikymo pavyzdžiai:
    - Microsoft Office – dokumentai saugomi XML formatu nuo 2007 ofiso versijos
    - OpenOffice – dokumentai irgi saugomi XML formatu
    - Programuotojams skirtos technologijos: *XHTML, SOAP (web services), RSS, Atom*, ir daug kitų

## XML dokumento pavyzdys

```xml
<?xml version="1.0" encoding="UTF-8"?>
<`KnygųSąrašas`>
    <`knyga` kalba="en">
        <autorius>Eric van der Vlist</autorius>
        <pavadinimas>XML Schema</pavadinimas>
        <metai>2002</metai>
        <ISBN>0-596-00252-1</ISBN>
    </`knyga`>
    <knyga>
        <!-- Čia komentaras -->
        ...
    </knyga>
    ...
</`KnygųSąrašas`>
```

> XML standartas nusako taisykles, kurioms turi paklusti visi XML dokumentai

## Duomenų aprašai XML formate

XML formatas turi dvi duomenų aprašų rūšis:

- Žymės (angliškai tag / element), pvz.: 

```xml
<`autorius`>Jonas Jonaitis</`autorius`>
```

- **Jonas Jonaitis** yra duomuo, `autorius` yra duomens aprašas – žymė, **<** ir **>** yra skirtukai
- Atributai, pvz.:

```xml
<knyga `kalba`="lt">
```
- **lt** yra duomuo, `kalba` yra duomens aprašas – atributas, **=** yra skirtukas
- Atributai privalo būti paskelbti žymės viduje

## Detaliau apie žymes

- Angliškai: tag / element
- Žymė susideda iš trijų dalių:
  - _atidarančios_ žymės, apskliaustos skirtukais < ir > (`<autorius>`)
  - žymės turinio: duomenys ir/arba kitos žymės (`Jonas Jonaitis`)
  - _uždarančios_ žymės, apskliaustos skirtukais </ ir > (pvz.: `</autorius>`)
- Atidaranti žymė žymi duomenų pradžią, uždaranti žymė – duomenų pabaigą

```xml
<autorius>Jonas Jonaitis</autorius>
```

## Žymės gali apimti kitas žymes

- Žymės viduje gali būti arba duomenys, arba kitos žymės

```xml
<knyga>
    <autorius>Jonas Jonaitis</autorius>
    <pavadinimas>Raudonkepuraitė</pavadinimas>
    <metai>2002</metai>
    <ISBN>0-596-00252-1</ISBN>
</knyga>
```

- Čia žymė knyga viduje turi keturias žymes: _autorius, pavadinimas, metai ir ISBN_
- Kitaip sakant, žymės gali formuoti **hierarchinę struktūrą**

## Detaliau apie atributus

- Atributas yra nebūtina žymės sudėtinė dalis, susidedanti iš trijų dalių:
  - atributo pavadinimo (`kalba`)
  - skirtuko `=` 
  - duomenų (`lt`)
- Atributai privalo būti paskelbti kokios nors žymės viduje:

```xml
<knyga kalba="lt">
```

## Tuščios žymės

- Jei žymė neturi duomenų (_žinios, kad duomenų nėra, irgi yra informacija_), galima sutrumpinta notacija
- Vietoj:

```xml
<pageidavimai></pageidavimai>
```

- Galima rašyti:

```xml
<pageidavimai/>
```

- Tuščios žymės (kaip ir normalios) gali turėti atributus:

```xml
<pageidavimai kalba="lt"/>
```

## Apribojimai žymėms ir atributams

- XML formatas reikalauja, kad:
    - žymės ir atributų pavadinimuose nebūtų tarpų
    - atidarančios žymės pavadinimas sutaptų su uždarančios žymės
       pavadinimu
    - viena žymė neturėtų dviejų atributų tuo pačiu pavadinimu
    - egzistuotų viena ir tik viena šakninė žymė
    - daug kitų techninių reikalavimų, kurių neaptarinėsime
- Apribojimas apie šakninę žymę yra labai svarbus – jis reiškia, kad XML formato dokumentas yra _griežtos medžio struktūros_

## Detalesnis XML apibrėžimas

XML – žmogui ir kompiuteriui suprantama hierarchinė plečiama duomenų aprašymo meta-kalba

- **Žmogui suprantama** – XML dokumentai yra tekstinio (ne binarinio) formato
- **Kompiuteriui suprantama** – visi XML dokumentai turi atitikti tam tikrą _reguliarią gramatiką_ (turi tenkinti XML standarto taisykles)
- **Meta-kalba** – kalba, skirta kitų kalbų kūrimui
- Pirmoje praktinėje užduotyje jūs turite susikurti savo kalbą: savo žymes ir atributus, bei taisykles, kokios žymės turi būti kokių žymių viduje

## Hierarchinė, plečiama kalba

- XML – hierarchinė kalba
    - Kiekviena žymė gali turėti vaikines žymes
    - Gali būti tik viena šakninė žymė
    - XML dokumentas yra žymių medis
- XML – plečiama kalba
    - Jau sukurtai kalbai galima pridėti naujų žymių, t.y., galima plėsti savo kalbą
    - **Pastaba**: plečiamas yra ne pats XML standartas, o tik autoriaus susikurta kalba!


## XML standartas (specifikacija)

- Apibrėžia, kas yra:
    - Žymė (elementas), atributas, komentaras
    - Deklaracija, apdorojimo instrukcija (processing instruction), nuoroda į simbolį (character reference), nuoroda į esybę (entity reference) – apie šiuos nešnekėsim
- Pateikia _reguliarią gramatiką_ (EBNF – Extended Backus-Naur Form), kurią turi atitikti kiekvienas XML dokumentas
- Analogija: tekstinis dokumentas yra Java programa, jei atitinka Java kalbos reguliarią gramatiką
- Panašiai ir su XML: tekstinis dokumentas yra XML dokumentas, jei jis atitinka XML reguliarią gramatiką

## Supaprastinta XML gramatika

> Egzaminui nereikia

```ebnf
document ::= prolog element Misc*

prolog ::= XMLDecl? Misc* ( **_dtd_** Misc*)?

XMLDecl ::= '<?xml' VersionInfo EncodingDecl? S? '?>'

VersionInfo::=S 'version=' '"' 1.0 '"'

EncodingDecl::= S 'encoding=' '"' EncName '"'

Misc ::= Comment | S

Comment ::= '<!--' Char* '-->'

S ::= (#x20 | #x9 | #xD | #xA)+
```

## Supaprastinta XML gramatika

```ebnf
element ::= EmptyElemTag | STag content Etag

EmptyElemTag ::= '<' Name Attribute* '/>'

STag ::= '<' Name Attribute* '>'

ETag ::= '</' Name '>'

content ::= CharData? (
   (element | Comment) CharData?
)*

Attribute ::= Name '=' AttValue

AttValue ::= '"' Char* '"'

Name ::= (Letter | '_' | ':') (NameChar)*

NameChar ::= Letter|Digit|'.'|'-'|'_'|':'
```

## Dokumento tipo deklaracija

- XML dokumento pradžioje gali būti to dokumento struktūros apibrėžimas – nuoroda į autoriaus taisykles, užrašytas tam tikra kalba (XML Schema)
- Kurdami savo kalbą jūs pasakote, kokias žymes jūsų dokumente galima naudoti, bei kokia tvarka, t.y., apibrėžiate  taisykles, kurias turi tenkinti jūsų dokumentai
- Taigi yra du taisyklių rinkiniai:
  - XML standarto taisyklės (XML gramatika, ...)
  - XML dokumento autoriaus taisyklės, nusakomos XML Schema arba kitomis kalbomis

## Savo XML kalbos kūrimas

Ką reiškia susikurti _savo kalbą_?

- Sugalvoti žymių/atributų vardus
- Sugalvoti, kokios reikšmės bus saugomos žymėse/atributuose:
   - Žymėse gali būti kitos žymės ir/arba duomenys (tekstas, skaičiai, base64 užkoduoti binariniai duomenys, ...)
   - Atributuose gali būti tik duomenys
- Nusakyti taisykles, kokios žymės/atributai kur ir kada gali būti naudojami (t.y. apibrėžti jūsų kalba rašomų dokumentų _struktūrą_ )
- Tokios taisyklės aprašomos su DTD, XML Schema arba kitomis dokumento struktūros aprašymo kalbomis

## Teisingai struktūrizuoti ir validūs XML dokumentai

- Tekstinis dokumentas vadinamas _teisingai struktūrizuotu_ (angl. well-formed) XML dokumentu, jei jis atitinka XML gramatiką (t.y. XML standarto reikalavimus)
- Teisingai struktūrizuotas XML dokumentas, kurio struktūra atitinka išreikštinai nurodytą DTD/XML Schemą, vadinamas validžiu (angl. valid) dokumentu
- Pirma pratybų užduotis – sukurti teisingai struktūrizuotą XML dokumentą, antra – patikrinti, ar jis validus (t.y., tenkina jūsų susikurtas autoriaus taisykles)
- Tikrinimą, ar tekstinis dokumentas yra teisingai struktūrizuotas / validus XML dokumentas atlieka programinė įranga, vadinama XML parseriais (leksiniais analizatoriais)
- Dauguma XML redaktorių parserius turi viduje ir dokumentų validumą tikrina automatiškai


## XML 1.0 ir 1.1 skirtumai

- Kokius simbolius galima naudoti žymių varduose?
    - XML 1.0 pateikia sąrašą Unicode simbolių, kuriuos galima naudoti (kitus – draudžiama)
    - XML 1.1 teigia, kad galima naudoti visus simbolius, kurių nėra uždraustų sąraše (netgi ir tokius, kurių dabar nėra, bet atsiras ateityje)
- XML 1.1 atpažįsta naujus eilutės pabaigos simbolius - `#x85` ir `#x2028`
- Rekomenduojama naudoti XML 1.0 versiją (didžioji dauguma įrankių palaiko būtent šią versiją)
- Versija paskelbiama XML dokumento antraštėje:
  
  ```xml
  <?xml `version="1.0"` encoding="UTF- 8 "?>
  ```

## Kaip nereikia daryti

Bandoma aprašyti geografinę šalių informaciją:

```xml
<Pasaulis>
    <Lietuva>
        <Vilnius>
            <GyventojųSk>100000</GyventojųSk>
        </Vilnius>
        <Kaunas>
            ...
        </Kaunas>
        ...
    </Lietuva>
    <Graikija>
        ...
    </Graikija>
</Pasaulis>
```

## Kodėl?

- Kaip savo kalbos autoriai mes pasiūlome **baigtinį** žymių rinkinį, kurio turi pakakti mūsų kalbos naudotojams
- Šioje kalboje mes turime tokias žymes:
    - Lietuva, Graikija, GyventojųSk, ...
- Mūsų kalbos naudotojai **negalės** aprašyti Latvijos ar Bulgarijos, nes mes neduodame tokių žymių!!!
- T.y., mūsų kalba visiškai netinkama žmonėms, kurie nori aprašyti kitas šalis


## Pataisytas variantas
```xml
<Valstybės>
    <Valstybė pav="Lietuva">
        <Miestas pav="Vilnius">
            <GyventojųSk>...</GyventojųSk>
        </Miestas>
        <Miestas pav="Kaunas">
            ...
        </Miestas>
    </Valstybė>
    <Valstybė pav="Graikija">
        ...
    </Valstybė>
</Valstybės>
```

- Dabar jau kalba susideda iš tokių žymių: _Valstybės, Valstybė, Miestas, GyventojųSk_
- Panašiai kaip programavimo kalbose yra **kintamųjų tipai** ir jų **reikšmės**, taip ir savo kalboje turite turėti žymes kaip kintamųjų tipus, o reikšmes kaip duomenis (žymių/atributų reikšmes)

## Taip irgi yra negerai

```xml
<Miestai>
    <Miestas_1>Vilnius</Miestas_1>
    <Miestas_2>Kaunas</Miestas_2>
    ...
    <Miestas_15>Marijampolė</Miestas_15>
</Miestai>
```

- Problema ta pati: jei jūsų kalbos naudotojas norės turėti daugiau nei 15 miestų, jis negalės pasinaudoti jūsų kalba, nes jūs leisite turėti **TIK** 15 miestų
- Trumpai sakant, numeracijos daryti nereikia – jei bus reikalinga numeracija, sunumeruos programinė įranga (dažniausiai interneto naršyklė) automatiškai (apie tai kalbėsime kitose paskaitose)