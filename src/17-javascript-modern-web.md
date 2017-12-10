# JavaScript: WEB karkasai

Interneto technologijos

## Turinys

* AJAX
* Vieno puslapio web aplikacijos
* jQuery ir vieno puslapio web aplikacijos
* Web karkasai
* React.js biblioteka

## AJAX

 - AJAX - Asynchronous JavaScript And XML. Terminas naudojamas nuo 2005 metų
 - Web programavimo technika skirta kurti dinamiškom web aplikacijom
 - AJAX įgalina web puslapį siųsti ir gauti duomenis iš serverio asinchroniškai - neperkraunant puslapio ir nepertraukiant vartotojo darbo su web aplikacija
 - `XMLHTTPRequest` - W3C specifikuotas 2006. 
   - JavaScript objektas leidžiantis naršyklei ir web serveriui apsikeisti duomenimis


???
XMLHTTPRequest - turi funkcijas kaip send, abort. Galima valdyti užklausas į serveri. Nepaisant pavadinimo gali būti naudojamas ne tik XML tipo duomenims gauti bet ir JSON.

### jQuery AJAX

  - jQuery turi funkcijas atlikti asinchroninėms užklausoms į serverį
  - jQuery palengvina darbą su `XMLHTTPRequest`
  - Užklausų rezultatai apdorojami perduodant funkciją, kuri bus iškviesta užklausai pasibaigus

```
$.ajax({
   url: 'https://yesno.wtf/api',
   data: {
      format: 'json'
   },
   error: function() {
      console.error('Error');
   },
   success: function(data) {
      console.log('Received data: ' + data);
   },
   type: 'GET'
});
```

### fetch API
 - Fetch - naujas standartas palengvinantis asinchroninį bendravimą su serveriu
 - Dar nėra palaikomas visose naršyklėse
 ![table](images/fetch-support.png "fetch-support")
 - Fetch funkcija grąžina `Promise` tipo JavaScript objektą

```
fetch('https://yesno.wtf/api')
  .then(function(response) {
    console.log('Success: ' + response)
  })
  .catch(function(error) {
    console.log('Error: ' + error);
  });
```

### Promise tipo objektai

 - Promise - JavaScript objektas, kuris ateityje gražins reikšmę
 - Naudojamas asinchroniniams veiksmams atlikti
 - `Promise` gali būti vienoje iš trijų būsenose:
   - laukiama rezultato (pending)
   - įvykdytas (resolved) 
   - atmestas (rejected)
 - `fetch` funkcija grąžina promise būsenoje _pending_,kai atsakymas iš serverio grįžta `promise` tampa arba _resolved_ (jei sėkmingai įvykdyta) arba _rejected_ (jei įvyko klaida)
 - `Promise` objekte naudojamos funkcijos:
   - `then( successCallback )` - priima funkciją, kuri bus iškviesta jei iš serverio  grįžo rezultatas be klaidų
   - `catch( errorCallback )` - priima funkciją, kuri bus iškviesta jei užklausa buvo nesėkminga


## Tradiciniai web puslapiai

* Vadinami "Multipage Web Applications"
* Vartotojui atlikus veiksmą naršyklė atsisiunčia naują puslapį iš serverio ir jį atvaizduoja
* Didžioji dalis logikos yra serveryje
* Klientinė aplikacijos dalis atsakinga tik už atvaizdavimą
* Siekiant pagerinti vartotojo patirtį dalis informacijos gali būti užkraunama dinamiškai
* Pavyzdžiai: stackoverflow.com, amazon.com

## Vieno puslapio aplikacijos

Single Page Applications (SPA)

* Aplikacija veikianti naršyklėje, kuria naudojantis nereikia perkrauti puslapio
* Puslapio turinys keičiamas dinamiškai (be puslapio perkrovimo)
* Veikimas labiau primena kompiuterio programą ar mobilią aplikaciją, nei tradicinį web puslapį
  * Palyginimui: Microsoft Word prieš Google Docs
* Pavyzdžiai - Gmail, Google maps, github ir daug kitų.

## Kaip veikia SPA ?

* Įvedus interneto adresą naršyklė parsisiunčia HTML dokumentą
* Naršyklė parsisiunčia statinius resursus paskelbtus HTML dokumente
  * CSS stiliai
  * JavaScript kodas (tiek specifinis aplikacijai, tiek bibliotekos ir karkasai)
  * Paveiksliukai
* Naršyklė pritaiko atsisiųstus CSS stilius ir vykdo JavaScript kodą
* Iš serverio naudojant AJAX užklausas parsiunčiami (arba išsiunčiami) duomenys
  * Dažniausiai duomenys apsikeičiami JSON duomenų formatu
  * Gali būti atsisiunčiami ir video/audio failai, bei kitas _sudėtingas_ turinys.

## SPA veikimo diagrama

![diagram](images/single-page-app-diagram.png "Single page app diagram")

> Serveris nebūtinai vienas. Naršyklė gali kreiptis į skirtingus serverius, skirtingiems duomenims gauti

### Pavyzdinis SPA HTML dokumentas

```html
<!doctype html>
<html lang="lt">
<head>
  <meta charset="utf-8">
  <title>Vieno puslapio aplikacija</title>
  <link rel="stylesheet" type="text/css" href="styles.css">
</head>

<body>
  <noscript>
    Puslapio veikimui yra būtinas JavaScript.
  </noscript>
  <script src="app.js"></script>
  <div id="root"></div>
</body>
</html>
```

### Be JavaScript neveikiantys puslapiai

![no-js](images/facebook-no-js.png "no-js")

## SPA trūkumai

* Reikalauja daugiau kliento naršyklės resursų - apkrova persikelia iš serverio į naršyklę
* Ne visi paieškos varikliai vykdo JavaScript kodą. Tie kurie nevykdo nematys turinio _(facebook pavyzdys be JavaScript)_, tačiau Google vykdo
* Pirmas puslapio užkrovimas sąlyginai lėtas. Dalinai sprendžiama progresyviu JavaScript užkrovimu

## SPA privalumai

* Po pirmo puslapio užkrovimo veikia greitai
  * Pvz: navigacija tarp puslapių, kuomet duomenys reikalingi naujam puslapiui jau buvo užkrauti
* **Gera varotojo patirtis** - nereikia laukti kol persikraus visas puslapis naviguojant
  * Vartotojo patirtis panaši, kaip naudojantis mobiliąja aplikacija

## jQuery ir SPA

* jQuery turi reikiamas funkcijas SPA kūrimui:
  * Galima dinamiškai keisti turinį, manipuliuoti HTML medžiu naudojantis `$()` selektorius
  * Galima dinamiškai užkrauti duomenis į naršyklę `$.ajax()` pagalba

## jQuery ir SPA

* Populiarėjant vieno puslapio aplikacijoms (SPA) programos veikiančios naršyklėje tapo vis sudėtingesnės
* Sudėtingesnės reiškia - daugiau kodo, daugiau taisyklių, lengviau pasimesti ir įvelti klaidų
* Kuriant sudėtingas aplikacijas programuotojai turi laikytis disciplinos:
  * kodas išskaidytas pagal atsakomybes
  * atvaizdavimo sluoksnis atskirtas nuo logikos
  * nedublikuoti kodo - stengtis išskaidyti į pernaudojamus komponentus

## jQuery ir SPA

* jQuery visiškai nesprendžia kodo moduliarumo, skaitomumo ir pernaudojamo problemų
* jQuery tinka mažom web aplikacijom kurti - tam turi visas reikiamas funkcijas
* Tačiau kai prie vienos sudėtingos aplikacijos dirba daug žmonių disciplinos laikytis tampa vis sudėtingiau, tai išspręsti padeda web karkasai.

## Web karkasų paskirtis

* Suteikia vienodą kodo struktūrą ir terminologiją tarp skirtingų projektų naudojančiu tą patį karkasą
* Skatina kurti moduliarią aplikaciją - suteikia funkcijas kurti UI komponentus, šablonus, modelius ir panašius perpanaudojamus elementus (DRY principas)
* Palengvina kodo skaitymą ir navigaciją tarp elementų
* Naudojant web karkasą aiškiai atskiriama aplikacijos logiką nuo atvaizdavimo
* Kuo aplikacija didesnė - tuo aukščiau išvardintos ypatybės yra svarbesnės

## Web karkasų istorija

* **Backbone.js** (2010 metai) - pirmasis labai plačiai naudojamas JavaScript karkasas
  * Atsirado sulig padidėjusiu SPA populiarumu
  * Atnešė struktūrą į JavaScript projektus. Moto: _Backbone.js gives structure to web applications_
  * Kodas organizuojamas atskiruose `.js` failuose, ir po to sujungiamas į vieną failą
  * Suteikia funkcijas kurti atskirus elementus (modelius, šablonus, įvykius) iš kurių "lipdoma" aplikacija
  * Dažnai naudojamas kartu su jQuery biblioteka
  * Turi palyginti nedaug funkcionalumo - todėl užima nedaug vietos. Dažnai vadinamas biblioteka, o ne karkasu

## Web karkasų istorija

* **AngularJS 1.X** - (2010 metai, Google) - kiek vėliau populiarumu pralenkė _Backbone_
* Turi daugiau funkcionalumo nei backbone. (_two-way data binding_, _dependency injection_)
* Lygiai taip pat kaip **backbone**, padeda struktūrizuoti aplikaciją, atskirti elementus pagal paskirtį.
* Angular 2 versija buvo visiškai perdaryta. Dėl to migracija iš 1 versijos į 2 buvo pakankamai sudėtinga. 2 ir vėlesnių Angular versijų populiarumas sąlyginai mažėjo

## React.js

* **React.js** (2013 metai, Facebook) - šiuo metu dažniausiai naudojama JavaScript biblioteka vieno puslapio aplikacijų kūrimui
* Biblioteka pritaikyta kurti lengvai plečiamas (_scalable_) vieno puslapio web aplikacijas
* Palaikoma didelius resursus ir puikius inžinierius turinčios kompanijos Facebook

![react-popularity](images/react-graph.png "React popularity graph")

### React.js - UI komponentų kūrimo biblioteka

* React nėra priskiriamas prie web karkasų
* Yra atsakingas tik už vieną dalyką, UI komponentų kūrimą, todėl vadinamas UI komponentų kūrimo biblioteka
* Apie react.js sakoma - sprendžia tik vieną dalyką, bet daro tai labai gerai.
* React yra tik **V** iš **MVC**
* React, priešingai nei web karkasasi (pvz. Angular), neturi funkcijų:
  - bendravimui su serveriu
  - navigavimui aplikacijoje
  - aplikacijos duomenų valdymui (data layer)
  - _event_ mechanizmo

## React.js komponentai

* Naudodami _react.js_ dirbame su UI komponentais
* Komponentai gali būti:
  * paprasčiausias mygtukas
  * registracijos forma
  * _youtube_ video leistuvas
* Komponentai yra perpanaudojami skirtingose aplikacijos vietose
  * Pavyzdžiui toks pat mygtukas dažnai naudojamas visoje aplikacijoje. Todėl sukuriame vieną komponentą ir naudojame jį visur
* React yra tarsi įrankis kurį naudojame vartotojo sąsajos konstravimui iš blokų (komponentų)


## React komponentų pavyzdys

![react-components](images/react-components-example.png "react-components-example")


### Komponentai yra UI elementų abstrakcija

* Kurdami komponentus mes kuriame UI elementų abstrakciją. Todėl komponentus galime lengvai skaityti, pavyzdžiui:

```html
  <Page>
    <Header />
    <Content />
    <Footer />
  <Page />
```

* Skaitant šį kodą mums nerūpi kas yra `Content` komponento viduje. `Content` - yra abstrakcija. Čia matome tai koks yra puslapio išdėstymas ir to pakanka
* Tai puikiai parodo kaip `react` paslepia nuo programuotojo realizacijos detales. Taip palengvina kodo skaitomumą.

## JSX sintaksė

- React komponentų kūrimui yra naudojama JSX sintaksė
- **JSX** - **J**avascript **S**yntax **E**xtension. JavaScript sintaksės praplėtimas
- JSX yra tarsi `HTML` ir `JavaScript` kalbų mišinys, jis leidžia rašyti `JavaScript` kodą `HTML` kodo viduje, pavyzdžiui: `<div>{1 + 2}</div>`
- Privalumai:
   - komponentų kodas yra lengvai skaitomas, tarsi skaitytume `HTML` dokumentą
   - galima išnaudoti JavaScript kalbos funkcijas

## JSX pavyzdys

```html
<div>
  {isUserLoggedIn ? <UserHeader /> : <AnonymousHeader />}
  <Tweet>React.js - library for building UI</Tweet>
  <Comment>
    <span className="comment-text">Comment text</span>
    <span className="comment-date">2017-12-06</span>
  </Comment>
</div>
```

* JSX nėra palaikomas naršyklių. Todėl norint naudoti reikia sutranspiliuoti į JavaScript kodą
* Tam naudojami papildomi įrankiai, pvz. [Babel](https://babeljs.io/) 
* [Transpiliuoto kodo pavyzdys](https://goo.gl/MqfRvx)


## JSX taisyklės

 - Kiekvienas programuotojo sukurtas komponentas turi prasidėti iš didžiosios raidės
 - Iš mažosios raidės prasideda `HTML` elementai. pvz: `div`, `h1`, `button`
 - JavaScript kodas turi būti apskliaustas `{` `}`, pavyzdžiui: 
 
 ```html
 <span>{hasError ? 'Error occured' : 'No error'}</span>
 ```
 - Elementu rinkinys visuomet turi būti apvilktas į vieną tėvinį elementą, pavyzdžiui:

```html
<div>
  <TodoItem />
  <TodoItem />
</div>
```

## React komponento pavyzdys

```js
class ButtonCounter extends React.Component {
  constructor() {
    super();
    this.state = { count: 0 };
    this.counterIncrease = this.counterIncrease.bind(this);
  }
  counterIncrease() {
    this.setState({ count: this.state.count + 1 });
  }
  render() {
    return (
      <button
        onClick={this.counterIncrease}
        className="button">
        {this.state.count}
      </button>
    );
  }
}
```

[Demo](https://jsfiddle.net/zygisx/j8nsdban/5/)

## React komponentų atsinaujinimas

 - React komponentai yra dinamiški - vartotojo naršyklėje elementai atsinaujina vartotojui atlikus veiksmą
 - Komponentas "persipiešia" tuomet kai pakeičiama jo būsena - iškviečiama funkcija `setState`
 - Iškvietus šia funkciją react žino kad komponento būsena pasikeitė, todėl reikia atnaujinti reprezentaciją - iškviečiama komponento funkcija `render`

> Iš tiesų React komponentų gyvavimo ciklas yra sudėtingesnis, plačiau galite [paskaityti dokumentacijoje](https://reactjs.org/docs/state-and-lifecycle.html)

## React Virtualus DOM

 - React komponentai "perpiešiami" kai pasikeičia jų būsena, tačiau perpiešimas yra brangi operacija, reikalauja daug naršyklės resursų
 - Jei vartotojui atliekant bet kokį veiksmą puslapiui reikėtų iš naujo perpiešti (rerender) visus elementus - puslapis veiktų labai lėtai ir nebūtų našus
 - React tai sprendžia su virtualiu DOM
 - Perpiešimas atliekamas ne su realiu DOM medžiu, bet su virtualia jo reprezentacija atmintyje (_virtual DOM_)
 - Kuomet komponentai perpiešiami atmintyje, react palygina virtualų DOM medį su realiu HTML dokumentu ir pakeičia tik tas vietas kurios pasikeitė


## React privalumai

 - Su `react` labai lengva kurti perpanaudojamus UI elementus - tai skatina kodo perpanaudojamumą (_reusability_)
 - Puikiai veikia komandose kuriuose programuotojai dirba kartu su dizaineriais. React padeda bendradarbiauti - visi UI komponentų kalba, suvienodinami terminai
 - Kodas atsakingas už vartotojo sąsaja yra aiškus ir lengvai skaitomas
 - Vartotojo sąsaja yra lengvai plečiama (_scalable_)

### Keli trūkumai

 - Reikalauja nemažai konfigūracijos. 
 - JSX turi būti transipiuojamas į JavaScript
 - Jei aplikacija maža ir nėra daug dinaminio turinio verčiau naudoti paprastesnę biblioteką
 - Nepalaiko Internet Explorer 8 ir žemesnių versijų

### React Demo

[Demo](https://jsfiddle.net/zygisx/6zpx8pah/)

<section style="display: flex; flex-direction: row;">
  <img width="300" src="images/react-demo-app.png">
  <img width="500" src="images/react-demo-app-components.png ">
</section>