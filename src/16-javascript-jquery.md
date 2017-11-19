# JavaScript: jQuery

Interneto technologijos

## HTML dokumento stiliaus modifikavimas

- HTML:

```html
<h1 id="i1" >Skyrius 1</h1>
```

- JavaScript:

```js
var element = document.getElementById("i1");
element.style.color = "red";
```

## HTML turinio modifikavimas

- HTML fragmentas

```html
<`p` title="The test paragraph">
This is a sample of some
<`span`>HTML you might<`br`>have</`span`>
in your document
</`p`>
```

## Dokumento objektinis modelis

![DOM](images/javascript-1.png "DOM")

???
The Document Object Model (DOM) is a cross-platform and language-independent convention for representing and interacting with objects in HTML, XHTML and XML documents.[1] Objects in the DOM tree may be addressed and manipulated by using methods on the objects. The public interface of a DOM is specified in its application programming interface (API). The history of the Document Object Model is intertwined with the history of the "browser wars" of the late 1990s between Netscape Navigator andMicrosoft Internet Explorer, as well as with that of JavaScript and JScript, the first scripting languages to be widely implemented in the layout engines of web browsers.

## Kaip prieiti prie žymės `p`

- Jei žymei `p` pridėsime atributą `id` su reikšme _p15_ (rekomenduotinas būdas):

```js
pTag = document.getElementById('p15')
```

- Galime ieškoti pagal žymės vardą, bet gausime visų žymių su tokiu vardu sąrašą – pagal indeksą reikės pasiimti tą, kurio reikia:

```js
document.getElementsByTagName('p')[3]
```

- Galime eiti tiesiai nuo DOM medžio šaknies:

```js
window.document.childNodes[0].childNodes[1].childNodes[4]
```

## Kaip eiti toliau

- Jei turime _pTag_, galime eiti į:
    - sekantį brolį: `pTag.nextSibling`
    - prieš tai einantį brolį: `pTag.previousSibling`
    - tėvą: `pTag.parentNode`
    - vaikus: `pTag.childNodes`
    - atributus: `pTag.attributes`
    - atributo vardas: `pTag.attributes[0].nodeName`
    - atributo reikšmė: `pTag.attributes[0].nodeValue`
    - ieškoti žemiau medyje esančių mazgų pagal žymės vardą: `pTag.getElementsByTagName("b")`
- Atributą galima pasiekti ir paprasčiau:
    - `alert(pTag.getAttribute("title"));`

## Atributo reikšmės keitimas

- Paragrafui pakeičiame atributo `class` reikšmę į _paragrafas_ (jei atributo nebuvo, jis bus pridėtas):

```js
pTag.setAttribute("class", "paragrafas");
```

- Kai kuriuos atributus galima ir išmesti:

```js
pTag.removeAttribute("class");
```

## Žymės tekstinio turinio paėmimas

- Reikia nueiti iki vaiko - tekstinio mazgo, ir jam paimti  `nodeValue` savybę:

```js
pTag.childNodes[0].nodeValue
```

- Pirmą vaiką sutrumpintai galime nurodyti su `firstChild`:

```js
pTag.firstChild.nodeValue
```

- Turinio parodymas pranešimo lange:

```js
alert(pTag.firstChild.nodeValue);
```

## Žymės tekstinio turinio pakeitimas

- Priskiriame naują reikšmę savybei `nodeValue`:

```js
pTag.firstChild.nodeValue = "Naujas tekstas";
```

## Naujų žymių kūrimas

- Sukuriame naują paragrafą su tekstu:

```js
var newParagraph = document.createElement("p");

var paragraphText = document.createTextNode("Naujas txt");

newParagraph.appendChild(paragraphText);
```

- Pridedame jį kaip paskutinį žymės `body` vaiką:

```js
var bodyTag = document.getElementsByTagName("body")[0];

bodyTag.appendChild(newParagraph);
```

## Žymių trynimas

- Žymes ištrinti galima su `removeChild`:

```js
bodyTag.removeChild(newParagraph)
```

## Naujos žymės susiejimas su JavaScript funkcija

- Paragrafui priskirkime funkciją, kuri aktyvuosis su pele paspaudus virš paragrafo, ir ištrins paragrafo žymę iš tėvinio elemento:

```js
newParagraph.onclick = function () {
   this.parentNode.removeChild(this);
};
```

- `this` yra objektas, kuris iškviečia funkciją (mūsų atveju objektas _newParagraph_)


## Naujos eilutės lentelėje sukūrimas

- Lentelės pabaigoje pridedame naują eilutę:

```js
var table = document.getElementById("table1");

var row = document.createElement("tr");

table.tBodies[0].appendChild(row);
```

- Eilutei pridedame celes (tarkime, kad lentelė turi 5 stulpelius):

```js
for (var i = 1; i <= 5; i++) {

    var td = document.createElement("td");

    td.appendChild(document.createTextNode("Tekstas"));

    row.appendChild(td);

}
```

## jQuery – JavaScript biblioteka

- JavaScriptbibliotekos (ne karkasai):
    - jQuery
    - Prototype
    - MooTools
    - DojoToolkit
- jQuery - populiariausia iš visų (naudohjama 72.9% tinklapių pasaulyje)
    - [http://w3techs.com/technologies/details/js-jquery/all/all](http://w3techs.com/technologies/details/js-jquery/all/all)
- Aktualios versijos:
    - jQuery / jQuery Compat 3.x (3.2.1)
    - jQuery 2.x (2.2.4)
    - jQuery 1.x (1.12.4)  

???
JavaScript biblioteka tai iš anksto parašytos JavaScipt funckijos leidžiančios paprasčiau ir greičiau kurti JavaScript paremtus tinklapius ar aplikacijas.

jQuery greita, nedidele, daug savybiu turinti JavasScript biblioteka. Ji suspaprastina navigavima HTML dokumente, jo manipulaivima, ivykiu apdorojima, AJAX uzklausu kurima. Palaiko visas pagrindes narsykles. Turi daugybe pluginu sukurtu jQuery pagrindu.

Biblioteka ar karkasas?
Karksas: nurodo struktura kaip kurti koda. Galime ziureti kaip i kodo sablona, su papildomai pagalbiniai irankiais, pvz: backbone, angular.js
Bibolteka: irankiu rinkinys, aukstesnis abstrakcijos lygis.
Even tho this question is highly subjective, my personal opinion about those two is this

Version 1.0: First stable release.
Version 2.0: Dropped IE 6–8 support for performance improvements and reduction in filesize
Version 3.0: Promises/A+ support for Deferreds, $.ajax and $.when, .data() HTML5-compatible

With the release of version 3.0 both versions 1.11.1 and 2.1.1 will be upgraded to jQuery Compat 3.0 and jQuery 3.0. jQuery Compat 3.0 will still support older browsers like Internet Explorer 8 while the regular version 3.0 will only support evergreen browsers (the current and previous versions of a specific browser).

With the release of Version 3.0 there's no reason to stick to either version 1.0 or 2.0. A few notes from the official jQuery blog:

## jQuery. Pavyzdys

```html
<!doctype html>
<html>

<head>
    <meta charset="utf-8" />
    <title>Demo</title>
</head>

<body>
    <script src="jquery.js"></script>
    <script>
        // Autoriaus JavaScript kodas.
    </script>
</body>

</html>
```

## jQuery. Iš kur užkrauti biblioteką?

- jQuery biblioteką galima tiek parsisiųsti į savo kompiuterį, tiek naudoti CDN (angl. content delivery network) talpinamas jos versijas, pvz:

```html
<script src="https://code.jquery.com/jquery-3.2.1.min.js">
</script>

<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js">
</script>
```

## `jQuery()` funkcija

- `jQuery()` arba `$()` pagrindinė jQuery abstrakcija per kurią ir dirbama su jQuery biblioteka 
- Grąžina specialų JavaScript objektą kuriame yra DOM elementų masyvas
- Funkcijai kaip parametrai paduodami CSS selektoriai, DOM elementai, HTML kodas, objektai, kitos funkcijos:

```js
var element = $("#i1");

jQuery(function() {
  $("div.pirmas").hide();
});
```

- Kita paskirtis – jQuery vardų srities prefikso nurodymas

```js
var trimmed = $.trim(someString);
var trimmed = jQuery.trim(someString);
```

## jQuery. Dokumento užkrovimo apdorojimas

- Gera praktika, kai JavaScript elgsena atskiriama nuo dokumento struktūros
- Galime pradėti vykdymą tik tuomet, kai visi DOM elementai yra pilnai užkrauti
- Standartinis metodas:

```js
window.onload = function() {
    // JavaScript kodas
};
```

- _jQuery_ metodas:

```js
$(document).ready(function() {
    // JavaScript kodas
});
```

???
So we’re performing operations on the page elements outside of the document markup that creates them. 

Pirmuoju metodu funckijos viduje aprasytas kodas yra ivykdomas po to kai dokumentsa pilnai uzkrautas. Deja narsykle ne tik sustbado ivykdyma iki tol kol bus uzkrautas DOM medis, bet ir laukia kol visi isoriniai resursai bus uzkrauti ir atvaizduoti narsykles langa. Tai ne tik paveiksliukai, bet ir Flash video. Taigi galima gauti nemaza uzlaikyma tarp to kada vartotojas pamato pirmini puslapio vaizda ir to kada ivykdymomas onload esantis kodas.

Daug gersnis sprendimas yra sulaukti tol kol dokumento struktura apdorota  ir narsykle html koda paverte i DOM medi. Tai nera lengvas variantas skirtinguose narsykles, bet jQuery tai mum palengvina ready funkcijos pagalba.

Ready kvietimu gali būti kiek norime, onload tik vienas.

## jQuery. Selektoriai.

jQuery palaiko beveik visus CSS3 selektorius:

- `$("#myId");`
- `$(".myClass");`
- `$("input[name='first_name']");`
- `$("#contents ul.people li");`
- `$("tr:odd");`
- `$("ul > li");`
- ...

## jQuery. Stiliaus keitimas

- Skaitom CSS taisykles:

```js
$("h1").css("fontSize");  // Pvz. "19px".
$("h1").css("font-size"); // Analogiška.
```

- Nurodom CSS taisykles:

```js
$("h1").css("fontSize", "100px");
```

- Nurodom kelias CSS taisykles:

```js
$("h1").css({
    fontSize: "100px",
    color: "red"
});
```

## jQuery. Elementų slėpimas ar rodymas

- Du specialūs metodai:
    - `hide()`
    - `show()`
- Faktiškai manipuliuoja _CSS_ `display` savybe
- Naudojant papildomus parametrus galima slėpimo / rodymo animacija

```js
$("p").hide();

$("p").show();

$("p").hide("slow");
```

## jQuery. Navigavimas

- pirmas elementas iš grąžintos aibės

  ```js
  var listItem = $( "li" ).first();
  ```

- elemento broliai

  ```js
  var siblings = listItem.siblings();
  ```

- tėvas

  ```js
  var list = listItem.parent();
  ```

- vaikai

  ```js
  var listItems = list.children();
  ```

## jQuery. Turinio manipuliavimas

Metodai:

- `.html()` – Gauti arba keisti HTML turinį;
- `.text()` – Gauti ar keisti tekstinį turinį.HTML bus pašalintas;
- `.attr()` – Gauti ar keisti nurodyto atributo reikšmę;
- `.val()` – Gauti ar nustatyti formos elemento reikšmę.

```js
// Keičiam paragrafo turinį
$("p:first").text("Naujas tekstas");

// Pridedam atributą
$("p").attr("class", "nauja");
```

## jQuery. Elementų kūrimas ir šalinimas

- Sukuriame naują `li` elementą ir pridedam į `ul` elementą

```js
var myNewElement = $("<li>New element</li>");
myNewElement.appendTo("ul");
```

- Sukuriame ir pridedam elementą (vienas žingsnis)

```js
$("ul").append("<li>list item</li>");
```

- Pašaliname paskutinį `li` elementą

```js
$("ul > li").last().remove();
```