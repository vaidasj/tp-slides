# HTML: Įvadas

Interneto technologijos

## HTML

- **HyperText Markup Language** – hiperteksto žymių kalba
    - Žymių kalba, skirta vizualizuoti duomenis (paprastai vizualizaciją atlieka naršyklės)
- _HTML 5.1 2nd Edition_ (ir XHTML5) W3C rekomendacija 2017 m. spalio 3
    - [https://www.w3.org/TR/html51/](https://www.w3.org/TR/html51/)
- _HTML 4.01_ – W3C standartas 1999 gruodis
    - [http://www.w3.org/TR/html401/](http://www.w3.org/TR/html401/)

## HTML standartas

- HTML bene daugiausiai diskusijų keliantis interneto standartas. Kodėl?
- Vieno Mozilla programuotojo mintys:
    _Nesinori turėti galutinės realizacijos kol specifikacija nėra pabaigta, nes žmonės pradės pasikliauti konkrečiomis realizacijos savybėmis, kurios apribos specifikaciją. Kita vertus, nesinori jog specifikacija būtų pabaigta, kol nėra realizacijos ir vartotojų patirties dirbant su realizacija, kadangi norisi turėti atgalinį ryšį iš vartotojo. Taigi reikia pastoviai balansuoti tarp šių dviejų kraštutinumų ir stumtis toliau.. Manau kad mums tai sekasi._
- Originalas čia: [http://lists.w3.org/Archives/Public/public-html/2010Jan/0107.html](http://lists.w3.org/Archives/Public/public-html/2010Jan/0107.html)

## HTML. Kas yra hipertekstas

- Hipertekstas konceptualiai buvo apibrėžtas dar 1941 metais
- Dabartinis apibrėžimas: **hipertekstas** tai tekstas rodomas kompiuterio ar kito elektroninio įrenginio ekrane, turintis nuorodas (angl. hyperlink) į kitą tekstą kurį skaitytojas gali nedelsiant pasiekti.
- 1980-aisiais buvo sukurta pirmoji hiperteksto taikomoji programa _Hypercard_
- Hiperteksto taikymų pradėjo daugėti, tačiau visi jie turėjo vieną trūkumą – visos hiperteksto nuorodos galėjo būti tik lokalios (į failus tame pačiame kompiuteryje)
- Poreikis pateikti hiperteksto nuorodas globaliame kontekste buvo viena pagrindinių interneto vystymosi idėjų

## HTML ir WWW. Pradžia

- 1989 metais Tim Berners-Lee iš CERN pasiūlo sukurti sistemą leidžiančią organizuoti ir dalintis CERN informacija
- 1990 metais jis sukuria pirmąsias HTML ir HTTP versijas
  - HTML struktūrinė kalba, nepririšta prie specifinių įrenginių savybių
  - HTML kuriama, kaip SGML kalba
  - Tim Berners-Lee sukuria ir pirmąją naršyklę
- 1993 metais išleidžiama NCSA Mosaic naršyklė ir prasideda WWW bumas
  - WWW duomenų srautas išauga 341634%
  - CERN paskelbia kad WWW technologija gali būti naudojama viešai ir nemokamai
  - Išleidžiama pirmoji formali HTML [specifikacija](http://www.w3.org/MarkUp/draft-ietf-iiir-html-01.txt)

## Pirmasis WWW puslapis

![Pirmasis WWW puslapis](images/html-intro-1.png "Pirmasis WWW puslapis")

## HTML. Kaip kuriami standartai (1)

- Paveiksliukų įterpimui skirta žymė `<img src =".. ">` atsirado dar 1993 metais

Kodėl ji tokia?

- [Interneto archyve](http://1997.webhistory.org/www.lists/www-talk.1993q1/0182.html) pateikiamas pirmųjų interneto naršyklių autorių susirašinėjimas norint praplėsti HTML paveiksliukų įterpimo galimybėmis

Trumpa santrauka:

- Marc Andreessen – Mosaic autorius rašė:
_Norėčiau pasiūlyti naują žymę IMG su privalomu atributu SRC nurodančiu paveiksliuko lokaciją. Žymė neturi uždarančios žymės, pvz:_

```html
<IMG SRC="file://foobar.com/foo/bar/blargh.xbm">
```

## HTML. Kaip kuriami standartai (2)

- Tony Johnson atsakymas:

_Mes turime kažką labai panašaus Midas 2.0, tik skiriasi visi pavadinimai ir dar turime papildomą atributą **name**:_ 

```html
<ICON name="NoEntry" href="http://note/foo/bar/NoEntry.xbm">
```

- Tim Berners-Lee pridėjo:

    _Aš galvoju kad figūros turėtų būti atvaizduojamos, taip:_

```html    
<a name=fig1 href="fghjkdfghj" REL="EMBED, PRESENT">Figure </a>
```

_Tokiu atveju nereikia pridėti naujos HTML žymės_

- Taigi kodėl HTML standartu tapo pirmasis pasiūlymas?

## HTML. Kaip kuriami standartai (3)

- Atsakymas paprastas – Marc Andreessen pirmasis realizavo savo pasiūlymą praktiškai _Mosaic_ naršyklėje
- Išleistas kodas nugalėjo prieš teorines diskusijas, nors ir:
  - Nenurodė naudojamo grafikos formato
  - Neapibrėžė, kaip formatuoti apie jį esantį tekstą
  - Nenumatė suderinamumo su paveiksliukų nepalaikančiomis naršyklėmis mechanizmo
  - O praėjus 20 metų nuo išleidimo vis dar yra didžiulis saugumo spragų šaltinis
- Tai tik vienas iš daugelio pavyzdžių, kuomet HTML standarto evoliucija yra įtakojama faktinių naršyklių kūrėjų realizacijų

## MIME tipai

- Kiekvienos HTTP užklausos metu serveris apart puslapio turinio atsiunčia ir kelias antraštes (angl. headers)
- Jos nėra naršyklių atvaizduojamos vartotojams, tačiau nurodo naršyklei kaip traktuoti gaunamą informaciją, pvz: `Content-Type: text/html`
- _Content type_ dar vadinama _MIME type_, nurodo gaunamos informacijos tipą
- Tai vienintelis dalykas, kuris apsprendžia, kaip interpretuoti gaunamą informaciją, pvz:
  - Paveiksliukai: `image/jpeg`, `image/png`
  - HTML: `text/html`
- Klientas siųsdamas užklausą serveriui taip pat gali pasakyti kokius MIME tipus jis palaiko

## HTML istorija. Retro-specifikacijos

- 1994 m. įkuriamas World Wide Web Consortium (W3C)
- 1995 m. išleidžiamas HTML 2. Tai _retro-spec_ standartas formalizuojantis populiariausias HTML savybes pasirodžiusias iki 1994 birželio
- 1996 m. išleidžiamas HTML 3. Vėl retro-specifikacija formalizuojantis lenteles, teksto formatavimą apie paveiksliukus
- 1997 m. gruodis išleidžiama HTML 4.
- 1999 m. gruodis pasirodo HTML 4.01
- Didžioji dalis HTML versijų buvo retro-specifikacijos, bandančios pasivyti naršyklių kūrėjus ir tuo pačiu pakreipti WWW vystymąsi teisinga linkme
- HTML niekada nebuvo _grynas_ standartas ir visi bandymai jį išgryninti baigėsi nesėkmingai


## HTML ir XHTML (1)

- 1998 metai pasirodžius XML buvo svarstoma, kuria kryptimi pasukti HTML vystymą
- Nuspręsta kurti naują kalbą XHTML, kurioje:
  - Visos žymės privalo būti uždarytos ir teisingai struktūrizuotos
  - Žymių ir atributų vardai rašomi mažosiomis raidėmis
  - Atributų reikšmės rašomos tarp kabučių
  - `<html>`, `<head>`, `<title>` ir `<body>` žymės yra privalomos
  - `<html>` žymė privalo turėti vardų srities atributą
  - `DOCTYPE` privalomas
  - Naujas MIME tipas: `application/xhtml+xml`

## HTML ir XHTML (2)

- 2000 m. pasirodo XHTML 1.0 Iš esmės tai HTML performuluotas XML terminais, nepridedant naujų elementų ar atributų
- XHTML 1.0 priede C yra leidžiama nenaudoti naujojo MIME tipo, taip palengvinant perėjimą nuo HTML prie XHTML
- 2001 gegužę pasirodo XHTML 1.1:
  - Panaikinama C priede nurodyta išlyga
  - Įvedami keli smukūs [pakeitimai](http://www.w3.org/TR/2001/REC-xhtml11-20010531/changes.html#a_changes)

## HTML ir XHTML. Klaidų apdorojimas

- Naršyklės visuomet atlaidžiai žiūrėjo į HTML pasitaikančias klaidas:
  - Užmiršote parašyti <title></title> žymę, panaudojote vieną žymė kitos viduje, nors to neleidžia HTML specifikacija
- Naršyklė vis tiek bandys atvaizduoti puslapį, kaip geriausiai sugeba
- Kai kurie šaltiniai teigia kad 99% interneto puslapių turi bent vieną klaidą
- Tačiau nėra klaidų pranešimų vartotojams - klaidos nėra taisomos
- XHTML bandymas spręsti šią problemą

## XHTML. MIME tipas

- Visi dokumentai siunčiami su naujuoju MIME tipu: `application/xhtml+xml` tikrinami taikant drastišką klaidų apdorojimą (angl. draconian error handling)
- Jei XHTML puslapyje randama bent viena klaida naršyklė nustoja apdoroti dokumentą ir galutiniam vartotojui rodo klaidos pranešimą
- Tai nepatiko didžiajai daliai tinklapių kūrėjų, todėl paprasčiausiai pasirinkimas buvo naudoti XHTML 1.0 su C priede numatyta išimtimi:
  - Naudoti XHTML sintaksę, bet turinio tipą nurodyti, kaip: `text/html`

## XHTML. MIME tipas

- Tuomet naršyklė naudoja klaidoms atlaidų apdorojimo mechanizmą ir galutiniai vartotojai nemato jokių klaidų pranešimų
- Ir šiandien didžioji dalis puslapių teigiančių, jog yra parengti XHTML, iš tiesų pateikia save kaip save vartotojas, kaip HTML puslapius

## Kelias link HTML

- 2004 m. W3C konferencijos metu grupė naršyklių atstovų pristato savo HTML vystymo vizija:
  - Future of the Web: an evolution of the existing HTML 4 standard to include new features for modern web application developers
  - Suderinamumas su senomis versijomis
  - Apibrėžtas klaidų apdorojimo mechanizmas
  - Vartotojams nerodyti autorių klaidų
  - Praktiškumas
  - Atviras tobulinimo procesas
- Balsavimo metu W3C atmeta šią viziją ir nusprendžia koncentruotisį XHTML 2
- Atmestų pasiūlymų autoriai nusprendžia įkurti savo organizaciją „WHAT Working Group“

## Kelias link HTML5. WHAT WG

- Suderinamumas su senomis versijomis akivaizdžiai kertasi su XHTML standartu
- WHAT WG sugebėjo dokumentuoti HTML dokumento apdorojimo procesą (http://www.whatwg.org/specs/web-apps/current-work/multipage/parsing.html)
- Jame nenumatyta jokio apdorojimo nutraukimo dėl autoriaus klaidų paliktų klaidų
- Parengė Web Forms 2.0 specifikaciją praturtinančią HTML formas naujomis savybėmis
- Parengė Web Applications 1.0:
  - Paišimo drobė (Drawing Canvas)
  - Audio ir video palaikymas nenaudojant trečiųjų šalių įskiepių

## Kelias link HTML5. W3C

- 2006 m. tapo akivaizdu kad WHAT WG daug stipriau pasistūmėjo į priekį
- XHTML2 vis dar buvo tik šablonas, kurio nerealizavimo nei  vienas iš didžiųjų naršyklių gamintojų
- W3C nusprendė prisidėti prie WHAT WG darbų
- Įsteigta nauja W3C HTML darbo grupė
- “Web Applications 1.0” specifikacija pervadinta į “HTML
- 2009 m. spalį nutraukiama XHTML2 darbo grupės veikla
- Taigi, kas pirmi pateikia kodą – tie ir laimi


## HTML5 pavyzdys

```html
<!DOCTYPE html>
<html>

  <head>
      <meta charset="UTF-8">
      <title> Pirmas puslapis </title>
  </head>

  <body>
      HTML5 pavyzdys
  </body>

</html>
```
