# CSS – kaskadinės stilių lentelės

Interneto technologijos

## Cascading Style Sheets

- Kalba (_ne žymių!_), skirta vizualizuojamų duomenų stiliui apibrėžti
- CSS 2.1 – W3C rekomendacija 2011 m. liepa:
  - [http://www.w3.org/TR/CSS21/](http://www.w3.org/TR/CSS21/)
- CSS 3.0 – nėra vienos monolitinės CSS 3 specifikacijos, yra daug skirtingų modulių (apie 50), kurių specifikacijos vystomos atskirai:
  - [https://www.w3.org/Style/CSS/](https://www.w3.org/Style/CSS/)
- CSS Snapshot 2017 - CSS Working Group apibrėžtas _stabilių_ modulių rinkinys:
  - [https://www.w3.org/TR/css-2017](https://www.w3.org/TR/css-2017)

## Cascading Style Sheets

- W3C rekomendacijos:
  - Media Queries Level 3 (2012 birželis)
  - CSS Namespaces (2011 rugsėjis)
  - Selectors Level 3 (2011 rugsėjis)
  - CSS Color Level 3 (2011 birželis)
- Vystomos ir kelios Level 4 specifikacijos, pvz:
  - CSS Selectors Level 4: [http://www.w3.org/TR/selectors4/](http://www.w3.org/TR/selectors4/)

???
CSS yra standartinė kalba vizualziuojamų duomenų stiliui apibrėžti. Naujų savybių paklausa ir kiekis buvo didžiulė ir W3C suprato kad tam prireiks ne vienų metų. Todėl nenorėdami užlaikyti aktualiausių savybių formalizavimo, kol nėra apibrėžtos ne tokios svarbios, nusprendė padalinti CSS 3 į atskirus modulius. Prie kiekvieno modulio dirbama atskirai ir jų realizacijos bei tapimo rekomendacija procesai irgi atskiri.

Darbas prie CSS3 iš tiesš prasidėjo 1998, metai po t kai išleistas CSS2. Naršyklių CSS2 realizacijos buvo nevienodos ir W3C nusprendė grįžti prie CSS 2 ir sukurti CSS 2.1 kuris standartizuotų ir suvienodintų esančias realizacijas. 2005 metais CSS 3 moduliai buvo gražinti į juodraščio statusą ir visa procesas prasidėjo iš naujo. IE nerodė noro realizuoti CSS3 ir kol neatsirado rimtesnės konkurencijos standartas nesivystė. 

The CSS Working Group sometimes publishes "Snapshots", a collection of whole modules and parts of other drafts that are considered stable, interoperably implemented and hence ready to use.

## CSS – naršyklių palaikymas

- Išsamiausias šaltinis:
    - [http://caniuse.com/#cats=CSS](http://caniuse.com/#cats=CSS)
- W3C rekomendacijomis tapusios CSS specifikacijos su tam tikromis išlygomis palaikomos visų naujausių naršyklių versijų
- Tačiau žvelgiant į senesnes naršyklių versijas (ypač Internet Exlorer iki 8 versijos) suderinamumas su CSS 2.1, jau nekalbant apie CSS 3, yra prastas

???
2009 išleistas IE8 teigė, kad tai pirmoji naršyklė pilnai palaikanti visą CSS 2.1 specifikaciją. 

## CSS dokumento pavyzdys

```css
div#header {
    margin: 0 0 5em 0;
    padding: 6px 0 2px 10px;
    text-align: left;
}

div#branding {
    float: left;
    width: 40%;
    text-align: left;
}

ul li a:active {
    text-decoration: none;
    font-weight: bold;
    color: black;
}
```

## CSS dokumento struktūra

- CSS dokumentas susideda iš CSS _taisyklių_ sąrašo
- CSS taisyklė turi šią struktūrą:

```css
<selektorių sąrašas> {
  <savybė>: <reikšmė>;
  <savybė>: <reikšmė>;
  ...
}
```

- Pavyzdys:

```css
h1 {
  color: red;
  background: white
}

```


## HTML ir CSS susiejimas

```html
<html>

<head>
    <title>My home page</title>
    <style type="text/css">
        h1,
        h2 {
            color: black;
            background: white;
        }
    </style>
</head>

<body>
    <h1>My home page</h1>
    <p>Some story...</p>
</body>

</html>
```

## CSS dokumentas atskirame faile

```html
<html>

<head>
  <title>My home page</title>
  `<link rel="stylesheet" href="stilius.css" type="text/css">`
</head>

<body>
    ...
</body>

</html>
```

## CSS media anotacijos

```html
<html>

<head>
    <title>My home page</title>
    <style type="text/css">
        @import url("css/stilius1.css");
        @import url("css/stilius2.css") print
    </style>
    <style type="text/css" media="print">
        @import url("css/stilius3.css");
        @import url("css/stilius4.css")
    </style>
</head>

<body>
    ...
</body>

</html>
```

## Media tipai

- Nusako įrenginį, kuriame vyks duomenų vizualizacija
  - Stilius bus pritaikytas tik jei dokumentas yra vizualizuojamas nurodytame įrenginyje
- Media tipai:
  - **screen** – dokumento vizualizacija kompiuterio ekrane
  - **print** – dokumento vizualizacija spausdinimui
- CSS standartas numato dar kitus media tipus (projection, tv, ...)
  - pagal nutylėjimą galioja **all** t.y., stilius taikomas visiems media tipams

## Media tipai

- _Media Queries Level 3_ suteikia dar daugiau galimybių
- Pagrindinė problema – **screen** per platus tipas. 
- Tiek mobilieji telefonai, tiek planšetės, tiek personaliniai kompiuteriai turi _tilpti_ po vienu **screen** media tipu. O jų ekranų dydžiai kardinaliai skiriasi
- Sprendimas – media užklausos leidžiančios tiksliau nustatyti įrenginio kuriame vyksta vizualicazija charakteristikas

  ```css
  @media screen and (max-width: 420 px) { ... }
  ```
  ```css
  @media only screen and (orientation: portrait) { ... }
  ```
  ```css
  <link href="desktop.css" rel="stylesheet" 
        media="screen and (min-device-width: 480px)">
  ```

???
https://www.w3schools.com/css/css3_mediaqueries_ex.asp
https://www.w3schools.com/css/tryit.asp?filename=trycss3_mediaqueries_ex6

## Selektoriai

- Universalus selektorius `*` atitinka bet kurią HTML dokumento žymę:

```css
 * {color: green}
```

- Jei jis yra didesnio selektoriaus dalis, tai gali būti praleistas:

```css
 *[lang="fr"]
 [lang="fr"]
```

```css
 *.warning
 .warning
```

```css
 *#myid 
 #myid
```

## Žymės ir įpėdinio selektoriai

- Žymės selektorius (rašomas žymės vardas)

```css
h1 { font-family: sans-serif }
```

- Įpėdinio selektorius

```css
h1 em { color: blue }
```

- Spalva nurodoma `em` žymei, ne `h1`!

```html
<h1>
  this <span>headline is <em>`very`</em> important</span>
</h1>
```

## Vaiko selektorius

- Vaiko selektorius

```css
h1 > em { color: blue; }
```

- Spalva nurodoma `em` žymei, ne `h1`!

```html
<h1>
  this headline is <em>very</em> important
</h1>
```

- Šiuo atveju spalva nebus mėlyna:

```html
<h1>
  this 
  <span>
    headline is <em>very</em> important
  </span>
</h1>
```

## Atributų selektoriai

- Atitinka, kai žymė **h1** turi atributą **att**

```css
 h1[att]
```

- Atitinka, kai bet kokia žymė turi atributą **att** su reikšme _val_ (`*` galima praleisti)

```css
 *[att="val"]
```

- Atitinka, kai žymė turi atributą **att**, kurio reikšmė yra žodžiai, atskirti tarpais, ir vienas iš tų žodžių yra _val_

```css
 [att~="val"]
```

- Pavyzdys:

```css
 *[valiuta="LTL"] {color: blue;}
```

## Atributų selektoriai (Level 3)

- Atitinka, kai bet kokia žymė turi atributą **att** kurio reikšmė prasideda _val_

```css
[att^="val"]
```

- Atitinka, kai žymė turi atributą **att**, kurio reikšmė baigiasi _val_

```css
[att$="val"]
```

- Atitinka, kai žymė turi atributą **att**, kurio reikšmės bet kurioje vietoje galima rasti _val_

```css
[att*="val"]
```

## Klasės selektorius

- Atributas _class_ yra specialus, jis vadinamas **klase**

```css
 žymė[class~="val"]
 žymė.val
```

```css
 *.val
 .val
```

- Pavyzdys

```css
p.juodas {
  color: black
}
```

```html
<p class="juodas">Gyveno kartą...</p>
```

## ID selektorius

- Specialus atributo selektorius

```css
 div[id="a15"]
 div#a15
```

- Tačiau sutrumpintas variantas yra labiau specifinis už nesutrumpintą kaskadų mechanizme

```css
 *#a15
 #a
```

## Selektoriai – pseudo klasės

- `:link` ir `:visited`
- `:link` galioja `<a>` žymėms, kurios dar nebuvo aktyvuotos (pvz., paspaustos pele)
- `:visited` galioja `<a>` žymėms, kurios jau buvo aktyvuotos

- Pavyzdys:

```css
a:link { color: red }
a:visited { color: blue }
```

## Selektoriai – pseudo klasės

- `:hover` atitinka žymę, jei virš jos turinio šiuo metu yra pelė (bet pelės mygtukas nepaspaustas)
- `:active` atitinka žymę, jei jos turinys šiuo metu paspaustas su pele
- `:focus` atitinka žymę, kuri šiuo metu turi fokusą (paprastai tai būna HTML formų komponentai)

```css
a:link { color: red }     /* unvisited links */
a:visited { color: blue } /* visited links   */
a:hover { color: yellow } /* user hovers     */
a:active { color: lime }  /* active links    */
```

- galima ir taip:

```csss
žymė:focus:hover {color: red}
```

## Selektoriai – pseudo elementai

- `:first-line` - atitinka pirmą teksto eilutę (priklausomai nuo to, kaip šiuo metu naršyklė sukilnojo tekstą)

```css
p:first-line {
  text-transform: uppercase
}
```

- `:first-letter` - atitinka pirmą teksto raidę

```css
p:first-letter {
  font-size: 200%;
}
```

## Grupavimas

- Kablelis `,` yra grupavimo simbolis

```css
h1 { font-family: sans-serif }
h2 { font-family: sans-serif }
h3 { font-family: sans-serif }
```

yra tas pats kaip ir:

```css
h1, h2, h3 { font-family: sans-serif }
```

## Stiliaus suformavimo procesas

1. HTML dokumentas paverčiamas į žymių medį.
2. Identifikuojamas einamasis media tipas (ekranas, printeris, ...).
3. Pakraunamos (aktyvuojamos) visos stilių lentelės, susietos su einamuoju media tipu.
4. Žymėms, surastoms pritaikius selektorius, yra suformuojamas stilius (paisoma kaskadų ir paveldėjimo taisyklių).
5. Sugeneruojama formatavimo (stiliaus) struktūra.
6. Formatavimo (stiliaus) struktūra pernešamą į einamąjį įrenginį (ekraną, printerį)

## Paveldėjimas

- Kai kurios CSS savybės yra paveldimos
  - Pvz.: `color`, `font-family`, `font-size`, `text-align`, `visibility`
- Kitos – nėra paveldimos
    - Pvz.: `background-color`, `background-image`, `margin`, `padding`
- Jei savybė paveldima, tai visi žymės, turinčios savybę, įpėdiniai pagal nutylėjimą taip pat įgauną tą savybės reikšmę
- Jei ta pati savybė yra nurodyta ir įpėdiniui, jis įgyja nurodytą (o ne paveldėtą) tos savybės reikšmę
- Panašiai kaip OO kalbose, paveldėtos savybės reikšmę galima _perrašyti_

## Paveldėjimo pavyzdys

```html
<html>
<head>
  <style>
  body {color: red;}
  </style>
</head>
<body>
  <p>
    <span>Tekstas</span>
  </p>
</body>
</html>
```


- `body` žymei priskirta savybė _color_
- Visos vaikinės žymės paveldi savybės _color_ reikšmę (t.y., visas tekstas `<body>` viduje bus raudonas)

## Paveldėjimo pavyzdys

- Perrašant paveldimą savybę, galima ne tik nurodyti visiškai naują reikšmę, bet ir pakeisti (nurodant procentus) paveldėtą

```css
body { font-size: 10pt }
h1 { font-size: `130%` }
```

- Procentai ne visada reiškia, kad bus imama paveldėta reikšmė - reikia žiūrėti savybės dokumentaciją

Kokios savybės paveldimos
- CSS 2.1 specifikacijos priede F kiekvienai savybei yra pasakyta, ar ji paveldima, ar ne 
  - [http://www.w3.org/TR/CSS21/propidx.html](http://www.w3.org/TR/CSS21/propidx.html)
- CSS 3 atveju reikia žiūrėti į konkretaus modulio specifikaciją arba į šį dokumentą: [http://www.w3.org/TR/CSS/#properties](http://www.w3.org/TR/CSS/#properties)

## Raktinis žodis `inherit`

- Jei savybė pagal dokumentaciją nėra paveldima, vaikas (**bet ne įpėdinis!**) vis tiek gali paveldėti jos reikšmę, jei panaudos raktinį žodį `inherit`

```css
h1 {border: solid red}
em {border: inherit}
```

## CSS dokumentai

- CSS dokumentai į naršyklę paprastai pakliūna iš WWW serverio (t.y., juos sukuria svetainės autorius)
  - Tokie CSS dokumentai vadinami **autoriaus** dokumentais
- Vartotojas irgi turi teisę susikurti savo CSS dokumentus ir (jei naršyklė turi tokias galimybes) liepti naršyklei visus puslapius vizualizuoti su jo stiliais
  - Tokie CSS dokumentai vadinami **vartotojo** CSS dokumentais
- Naršyklė taip pat turi savo stilių lentelę, su kuria ji suteikia stilių tiems HTML dokumentams, kuriems nėra asocijuotų nei autoriaus, nei vartotojo CSS dokumentų
  - Tai taip vadinamas **naršyklės** CSS dokumentas
- Atskiru atveju HTML dokumentui gali būti nurodytas tiek autoriaus, tiek vartotojo CSS dokumentas (naršyklės CSS dokumentas yra  visada neišreikštinai nurodytas)

## Stilių konfliktas

- Paprasčiausias stilių konflikto pavyzdys:

```css
p {color: blue}
body p {color: red}
```

- Abi taisyklės nustato žymės `<p>` spalvą. Klausimas, kokia gi ta spalva bus?
- Konfliktas gali kilti ir dėl to, kad yra keli autoriaus stilių dokumentai (konfliktuojantys tarpusavyje), ir dėl to, kad vartotojas papildomai nusirodė savo stiliaus dokumentą
- Jei yra bent vienas stiliaus dokumentas (autoriaus arba vartotojo), tai jis greičiausiai konfliktuos su naršyklės stiliumi, kuris apibrėžia išvaizdą pagal nutylėjimą


## Kaskadų mechanizmas

- Stilių konfliktas  sprendžiamas, taisyklėms priskiriant prioritetus
- Pirmiausia vertinamas stilių šaltinis ir taisyklių svarba:
    1. naršyklės stiliai (mažiausias prioritetas)
    2. vartotojo stiliai
    3. autoriaus stiliai
    4. autoriaus _svarbūs_ stiliai
    5. vartotojo _svarbūs_ stiliai (didžiausias prioritetas)
- Jei konflikto išspręsti nepavyko, tai:
    1. Nugali ta CSS taisyklė, kurios selektoriaus _specifiškumas_ yra didesnis
    2. Jei specifiškumas vienodas, nugali vėliau paskelbta taisyklė

## Svarbūs stiliai

- Savybė gali būti paskelbta svarbia, naudojant raktinį žodį `!important`

```css
p {font-style: italic !important}
```

- Šį raktinį žodį savo stilių dokumentuose naudoti gali tiek autorius, tiek vartotojas

## Specifiškumo skaičiavimas

- Taisyklės specifiškumui skaičiuoti naudojamas vektorius 
  - `(a, b, c, d)`.
- Reikšmės įvertinamos taip:
  - `a` = jei CSS taisyklė paskelbta HTML žymės atribute style (o ne stilių lentelėje), tai `a=1`, priešingu atveju `a=0`. Jeigu `a=1`, tai visos kitos reikšmės `(b, c, d)` lygios 0
  - `b` = {ID selektorių skaičius}
  - `c` = {atributų/klasių selektorių ir pseudo-klasių skaičius}
  - `d` = {žymių selektorių ir pseudo-elementų skaičius}
- Taisyklės specifiškumas gaunamas atlikus _a, b, c, d_ reikšmių konkatenaciją: `abcd`. 
- Pvz.: `(0, 1, 4, 1)` pavirsta į skaičių **0141**.

## Specifiškumo skaičiavimas

 | Taisyklė            |     |     |     |     |
 |---------------------|-----|-----|-----|-----|   
 | `*`                 | a=0 | b=0 | c=0 | d=0 |
 | `li`                | a=0 | b=0 | c=0 | d=1 |
 | `li:first-line`     | a=0 | b=0 | c=0 | d=2 |
 | `ul li`             | a=0 | b=0 | c=0 | d=2 |
 | `body ol > li`      | a=0 | b=0 | c=0 | d=3 |
 | `ol > [att=up]`     | a=0 | b=0 | c=1 | d=1 |
 | `div ol li.red`     | a=0 | b=0 | c=1 | d=3 |
 | `li#x34`            | a=0 | b=1 | c=0 | d=1 |
 | `style="color:red"` | a=1 | b=0 | c=0 | d=0 |



## Savybės display ir visibility

- `display`: _inline | block | none | ..._
- `visibility`: _visible | hidden | ..._
- Abi šios savybės kontroliuoja, ar žymės turinys bus matomas naršyklės lange, ar nebus matomas
- Skirtumai:
  - jei stilių lentelėje žymei nurodysite savybę `visibility:hidden`, žymės turinys nebus rodomas, bet jam bus palikta (rezervuota) tuščia vieta
  - `display:none` atveju žymės turinys nerodomas, ir tuščia vieta nepaliekama (rezultatas toks, tarsi tos žymės HTML dokumente iš viso nėra)

## inline ir block skirtumai

- `block` reiškia, kad žymės turinys bus vaizduojamas naršyklės lange atskiru bloku (stačiakampio formos sritimi)
  - Taip elgiasi žymės _h1-h6, p, div_ ir daugelis kitų
- `inline` reiškia, kad žymės turinys naujo bloko nekurs, o bus atvaizduotas einamojo bloko eilutėje
  - Žymės _i, b, em, strong, span_, ir t.t.

- CSS:
```css
p {display: inline}
```

- HTML dokumentas:

```html
<p>Pirmas paragrafas.</p>
<p>Antras paragrafas.</p>
```