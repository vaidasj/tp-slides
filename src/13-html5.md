# HTML5 

Interneto technologijos

## Minimalus HTML5 dokumentas

```html
<!DOCTYPE html>
<html lang="lt">

<head>
    <meta charset="UTF-8">
    <title>Pirmas puslapis</title>
</head>

<body>
    HTML5 pavyzdys
</body>

</html>
```

## HTML5 struktūra

- `doctype`
  - tai ne HTML žymė, tai instrukcija nurodanti naršyklei kokia HTML versija parašytas šis dokumentas
  - privalo būti nurodytas HTML dokumento pirmoje eilutėje
- `html`
  - šakninis HTML dokumento elementas
  - jo vaikais gali būti `head` elementas ir po jo einantis `body` elementas
  - HTML5 skatina autorius naudoti `lang` atributą, dokumento turinio kalbai nurodyti (pvz. `lang="lt"`). Palengvina darbą specializuotai programinei įrangai (vertėjams, teksto skaitymo programoms ir t.t.)

???
If there’s anything else before it—even a single blank line—certain browsers will treat your page as if it has no doctype at all. Without a doctype, the browser will render your page in quirks mode. This can be a very difficult error to catch. Extra whitespace usually doesn’t matter in HTML, so my eyes tend to just skip over it, but in this case it’s very important!

## HTML5 struktūra

- `head`
  - pirmasis šakninio elemento (`html`) vaikas
  - talpina metaduomenis – informaciją apie puslapį (pavadinimą, koduotę, stilių lenteles, skriptus ir t.t.)
  - `head` sekcijoje esančio turinio naršyklės vartotojui neatvaizduoja
- `body`
  - antrasis šakninio elemento (`html`) vaikas
  - šiame elemente saugomas dokumento turinys – tai ką autorius nori atvaizduoti vartotojo naršyklėje

## DOCTYPE

- `doctype` nurodo dokumente naudojamą HTML kalbos versiją
- Didžioji dalis naršyklių pagal doctype nusprendžia kokį apdorojimo rėžimą naudoti:
  - **keistybių** (angl. quirks) – naršyklė pažeisdama standartus stengiasi atvaizduoti puslapius sukurtus praėjusio amžiaus pabaigoje
  - **standartų** - apdorojimas vykdomas griežtai laikantis nurodyto standarto
  - **beveik standartų** – iš esmės naudojamas standartų rėžimas išskyrus vykdant vertikalų lentelės celių dydžio nustatymą

## DOCTYPE

- Nors rėžimai trys, skirtingų doctype yra daug daugiau:
  - 15 iššaukiantys standartų rėžimą
  - 5 beveik standartų
  - virš 70 keistybių
- taigi `doctype` nurodyti **būtina**, siekiant užtikrinti, kad dokumentas bus apdorotas standartų rėžimu

???
Kuriant IE 5 Mac Microsoft susidūrė su problema. Naujoji naršyklės versija taip pagerino standartų palaikymą, kad daugumos senų puslapių nesugebėdavo korektiškai atvaizduoti. Tiksliau sakant jie buvo apdorojami teisingai (pagal specifikaciją), bet jų autoriai tikėjosi jog jie bus apdoroti nekorektiškai. Autoriai juos kūrė naudodami keistybes tuo metu egzistavusias tuo metu paplitusiose naršyklėse (Netspace 4 ir IE 4). Taigi IE5 buvo toks pažengęs, kad jis sulaužė WWW.
Microsoft sugalvojo sprendimą, pridėti doctype. Senesni puslapiai jo neturėdavo, todėl juos apdorodavo senu būdu. Noritn aktyvuoti naujų standartų rėžima reikėjo nurodyti teisinga doctype.
Ši idėja paplito tarp visų pagrindinių naršyklių kurėjų. Tačiau Mozilla išleisdama 1,1 versiją pamatė, kad puslapiai naudojantis standartų rėžimą remiasi viena specifine keistybę – taigi jie sukūrė beveik standartų rėžimą.

## DOCTYPE

- HTML 4.01 ir XHTML 1.1 doctype pavyzdžiai:

```html
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" 
  "http://www.w3.org/TR/html4/strict.dtd">
```

```html
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" 
  http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
```

- HTML5 doctype:

```html
<!DOCTYPE html>
```

- HTML5 standartas leidžia naudoti ir griežtus HTML 4.0, HTML 4.01 bei XHTML 1.0 ir XHTML 1.1 doctype (bet nerekomenduoja)

???
The doctype declaration for the HTML syntax is <!DOCTYPE html> and is case-insensitive. Doctypes from earlier versions of HTML were longer because the HTML language was SGML-based and therefore required a reference to a DTD. This is no longer the case and the doctype is only needed to enable standards mode for documents written using the HTML syntax. Browsers already do this for <!DOCTYPE html>.
Tip: Always add the <!DOCTYPE> declaration to your HTML documents, so that the browser knows what type of document to expect.


The strict doctypes for HTML 4.0, HTML 4.01, XHTML 1.0 as well as XHTML 1.1 are also allowed (but are discouraged) in the HTML syntax.
In the XML syntax, any doctype declaration may be used, or it may be omitted altogether. Documents with an XML media type are always handled in standards mode.

## head elementas

```html
<head>
    <title>Puslapio pavadinimas</title>
    <meta charset="utf-8">
    <link rel="stylesheet" type="text/css" href="style.css">
    <link rel="shortcut icon" href="/favicon.ico">
</head>
```

- `title` _beveik_ visuomet privalomas
- koduotę nurodyti nebūtina, bet rekomenduojama

???
Briefly, this says that the web server thinks it’s sending you an HTML document, and that it thinks the document uses theUTF-8 character encoding. Unfortunately, in the whole magnificent soup of the World Wide Web, few authors actually have control over their HTTP server.

Both of these techniques still work in HTML5. The HTTP header is the preferred method, and it overrides the <meta> tag if present. But not everyone can set HTTP headers, so the <meta> tag is still around. In fact, it got a little easier inHTML5. 

This works in all browsers. How did this shortened syntax come about? Here is the best explanation I could find:
The rationale for the <meta charset> attribute combination is that UAs already implement it, because people tend to leave things unquoted, like:

Character encoding is complicated, and it has not been made any easier by decades of poorly written software used by copy-and-paste–educated authors. You should always specify a character encoding on every HTML document, orbad things will happen. You can do it with the HTTP Content-Type header, the <meta http-equiv> declaration, or the shorter <meta charset> declaration, but please do it. The web thanks you.

<meta http-equiv="Content-Type" content="text/html;charset=ISO-8859-1">

## HTML žymės

- Skyriai
  
  ```html
  <h1>Pirmas skyrius</h1>
  <h2>Pirmas skyrelis</h2>
  ```

- Paragrafai
  
  ```html
  <p>Kartą gyveno ...</p>
  ```

- Pabrėžimas, išryškinimas (pasviręs šriftas)

  ```html
  Čia iš tikrųjų <em>svarbus</em> klausimas!
  ```

## HTML žymės

- Paveiksliukai
  
  ```html
  <img src="auksineZuvele.jpg" width="200" height="150" 
       alt="Žuvelė" title="Žuvelė">
  ```

- Nuorodos
    
    ```html
    Čia yra nuoroda į
    <a href="petras.html">
      Petro puslapį
    </a>
    ```

- Piešinukas kaip nuoroda:

  ```html
   <a href="../index.html">
      <img src="logo.gif" alt="Žuvelė">
   </a>
  ```

???
HTML Block Elements
Most HTML elements are defined as block level elements or as inline elements.
Block level elements normally start (and end) with a new line when displayed in a browser.
Examples: <h1>, <p>, <ul>, <table>
HTML Inline Elements
Inline elements are normally displayed without starting a new line.
Examples: <b>, <td>, <a>, <img>

## Sąrašai

- Nenumeruoti sąrašai:

```html
<ul>
    <li>Įpilti vandens</li>
    <li>Įdėti druskos</li>
    <li>Įdėti pipirų...</li>
</ul>
```

- Numeruoti sąrašai:

```html
<ol>
    <li>Įpilti vandens</li>
    <li>Įdėti druskos</li>
    <li>Įdėti pipirų...</li>
</ol>
```

## HTML žymės

- Priverstinė eilutės pabaiga

```html
Čia viena eilutė, `<br>`o čia jau kita
```

- Specialūs tarpai

```html
Aš mėgstu Coca`&nbsp;`Colą
```

- Kiti specialūs simboliai:
  - `&lt;` - <
  - `&gt;`  - >
  - `&amp;` - &

## Lentelės

```html
<table>
    <tr>
        <th>Year</th>
        <th>Sales</th>
    </tr>
    <tr>
        <td>2000</td>
        <td>$18M</td>
    </tr>
    <tr>
        <td>2001</td>
        <td>$25M</td>
    </tr>
    <tr>
        <td>2002</td>
        <td>$36M</td>
    </tr>
</table>
```

## Lentelės

```html
<table `border="1"`>
    <tr>
        <th `rowspan="2"`>Year</th>
        <th `colspan="3"`>Sales</th>
    </tr>
    <tr>
        <th>North</th>
        <th>South</th>
        <th>Total</th>
    </tr>
    <tr>
        <td>2000</td>
        <td>$10M</td>
        <td>$8M</td>
        <td>$18M</td>
    </tr>
</table>
```

- `table` atributą `border` geriau pakeisti CSS taisykle

???
The border attribute may be specified on a table element to explicitly indicate that the table element is not being used for layout purposes. If specified, the attribute's value must either be the empty string or the value "1". The attribute is used by certain user agents as an indication that borders should be drawn around cells of the table.

## Formos

```html
<form name="forma" action="rezultatas.html" method="post">
    Vardas: <input type="text" name="vardas"><br> 
    Pavardė: <input type="text" name="pavarde"><br>
    Pašto adresas: <input type="text" name="email"><br>
    <label>
        <input type="radio" name="lytis" value="V"> vyras
    </label>
    <br>
    <label>
        <input type="radio" name="lytis" value="M"> moteris
    </label>
    <br>
    <input type="submit" value="Siųsti">
    <input type="reset" value="Išvalyti">
</form>
```

## `input` komponentų rūšys

```html
<input type="<tipas>" name="..." value="..."/>
```

- Tipas gali būti:
  - _button_ - mygtukas
  - _text_ – tekstinis vienos eilutės laukas
  - _password_ – slaptažodžio laukas
  - _checkbox_
  - _radio_
  - _submit_
  - _reset_
  - ... HTML5 pridėjo 13 naujų tipų
- Visi komponentai (ne tik `input`) privalo būti paskelbti žymės `form` viduje!


## HTML5 `input` tipai

- Tipai: 
  - _tel, search, url, email, datetime, date_
  - _month, week, time, datetime-local_
  - _number, range, color_
- Atributai:
  - pridėtas naujas atributas _placeholder_, nurodantis tekstą, kurį rodyti kol įvedimo laukas tuščias
  - pridėtas _autofocus_ atributas skirtas sufokusuoti nurodytą lauką
  - pridėtas _required_ atributas, nurodantis jog įvedimo lauką užpildyti būtina

???
The idea of these new types is that the user agent can provide the user interface, such as a calendar date picker or integration with the user's address book, and submit a defined format to the server. It gives the user a better experience as his input is checked before sending it to the server meaning there is less time to wait for feedback. novalidate

## Sąrašo (pasirinkimo) komponentas

```html
<SELECT multiple size="4" name="manoMeniu">
    <OPTION selected value="r">Raudona</OPTION>
    <OPTION selected value="g">Geltona</OPTION>
    <OPTION value="z">Žalia</OPTION>
    <OPTION value="m">Mėlyna</OPTION>
</SELECT>
```

- `multiple` reiškia, kad vienu metu galima pažymėti kelis
- `size` nurodo, kiek eilučių bus komponente (jei meniu didesnis, atsiras slankjuostė)
- jei `size` bus nurodytas _1_ (ir `multiple` nebus nurodytas), gausime iškrentančio sąrašo komponentą

## Kelių eilučių teksto komponentas

```html
<`TEXTAREA` name="tekstas" rows="5" cols="30">

  Pirma teksto eilutė. 
  
  Antra teksto eilutė

<`/TEXTAREA`>
```

## HTML5. Semantiniai elementai

![Pirmasis WWW puslapis](images/html5-1.png "Semantiniai elementai")

## HTML5. Semantiniai elementai

- `<section>`
  - Elementas nurodantis tam tikrą dokumento dalį/skyrių. 
  - Skirtas tematiniam turinio grupavimui. 
  - Dažniausiai turi antraštę. 
  - Tinklapis gali būti padalintas į kelias sekcijas: naujienos, kontaktai ir t.t.
- `nav` 
  - Elementas nurodantis dokumento dalį, kuri turi nuorodas į kitus dokumentus ar to paties dokumento dalis. 
  - Visų dokumento nuorodų į _nav_ dėti nereikia, tai turėtų būti tik pagrindiniai navigaciniai blokai. Pvz. puslapio apačioje esančiom nuorodoms pakanka _footer_ elemento.

## HTML5. Semantiniai elementai

- `article`
  - Elementas talpinantis tam tikrą informaciją, kuri gali būti platinama nepriklausomai nuo kitos informacijos. 
  - Pvz: forumo pranešimas, blogo įrašas, vartotojo komentaras.
- `aside`
  - Nurodo puslapio dalį, kuri susideda iš turinio, kuris nėra tiesiogiai susijęs su turiniu esančiu apie jį. 
  - Galima naudoti reklaminiam blokam, citatoms ir pan.
- `hgroup` 
  - Nurodo dokumento dalies antraštę. 
  - Naudojamas grupuoti _h1-h6_ elementus, kai antraštė yra kelių lygių.

## HTML5. Semantiniai elementai

- `header` 
  - Nurodo įžanginių ar navigacinių elementų grupę. Dažniausiai viduje turi _h1-h6_ arba _hgroup_ elementus.
- `footer`
  - Nurodo dokumento artimiausio protėvio sekcijos poraštę. Dažniausiai nurodoma informacija apie tą sekciją: kas ją parašė, autorių teisės, data ir pan.
- `time`
  - Nurodo laiką 24 valandų formate arba tikslią datą. Papildomai gali būti nurodyta ir laiko zona.
- `mark` 
  - Nurodo teksto dalį pažymėtą ar paryškintą dokumente. Pvz.: paieškos rezultatuose raktažodį, pagal kurį ieškota.

## HTML5 API

- HTML5 standarte atsirado ir naujų API (angl. _Application Programming Interface_). 
- Keletas iš įdomesnių:
  - _Canvas 2D API_ – skirta grafinių elementų kūrimui realiuoju laiku
  - _HTML5 Audio and Video API_ – audio ir video turinio atkūrimas
  - _Geolocation API_ – patikimiems puslapiams leidžia gauti vartotojo buvimo vietos ilgumą ir platumą
  - _HTML5 Web Storage_ – leidžia saugoti raktas-reikšmė tipo poras  vartotojo sistemoje
  - _Offline Web Applications_ – įgalina vartotojus dirbti su tinklapiu net ir nutrūkus interneto ryšiui

???
https://developer.mozilla.org/en-US/docs/Web/Guide/HTML/Canvas_tutorial/Basic_usage
http://www.w3schools.com/html/tryit.asp?filename=tryhtml5_video_all
http://www.w3schools.com/html/tryit.asp?filename=tryhtml5_geolocation
http://www.w3schools.com/html/tryit.asp?filename=tryhtml5_webstorage_local
http://html5demos.com/offlineapp
http://www.whatwg.org/demos/offline/clock/live-demo/clock.html

## HTML5 validatoriai

- Norėdami įsitikinti ar jūsų sukurtas HTML dokumentas yra validus HTML 5 dokumentas, galite pasinaudoti HTML validatoriais:
  - [http://validator.nu/](http://validator.nu/)
  - [http://validator.w3.org/](http://validator.w3.org/)

> Atsiskaitant praktinę užduotį būtina nurodytų HTML5 validatorių pagalba pademonstruoti, jog jūsų sukurtas dokumentas yra validus HTML5 dokumentas