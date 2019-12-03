# Įvadas į node.js

Interneto technologijos

## Interneto technologijos
- Turinio aprašymas: `HTML`
- Turinio atvaizdavimas: `CSS`
- Interaktyvumas: `JS`
- Duomenų apsikeitimas: `JSON`, `XML`

Kaip visa tai pasiekia jūsų kompiuterį?

## Interneto naršyklės ir http serverio komunikacija
![HTTP basics](images/basic http.png)

## HTTP protokolo elementai: URL

http://www.example.com:80/path/to/myfile.html?key1=value1&key2=value2#SomewhereInTheDocument

- `http`: schema
- `www.example.com`: domeno vardas
- `80`: prievadas (port)
- `path/to/myfile.html`: resurso lokacija
- `key1=value1&key2=value2`: užklausos parametrai (query, query parameters)
- `SomewhereInTheDocument`: anchor

Šaltinis: [MDN](https://developer.mozilla.org/en-US/docs/Learn/Common_questions/What_is_a_URL)

## HTTP protokolo elementai: metodai

GET, POST, PUT, PATCH, DELETE, OPTIONS, HEAD

- Kartu su URL nusako skirtingas operacijas:
	- GET http://localhost:8080/books 
	- POST http://localhost:8080/books 
	- PATCH http://localhost:8080/books/1 
	- DELETE http://localhost:8080/books/1 
- Naudojimo paskirtį nusako [RFC standartas](https://tools.ietf.org/html/rfc2616#page-51)
- Funkcionalumą įgyvendina serveris

## HTTP protokolo elementai: antraštės(headers)

"Content-type", "Authorization", "Accept", "Cookie", "Set-Cookie", "Location"...

- Naudojami klientui ir serveriui apsikeisti papildoma informacija
- Gali būti užklausos(request) ir atsakymo (response) header'iai
- Gali būti naudojami ir nestandartiniai header'iai: "x-my-custom-header"

Daugiau informacijos [MDN](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers)

## HTTP protokolo elementai: statuso kodai
- Sveiki skaičiai, nusakantys operacijos rezultatą: `200`, `404`, `500`...
- Tipas nustatomas pagal pirmą simbolį:
	- `1xx`: Informational
	- `2xx`: Success
	- `3xx`: Redirection
	- `4xx`: Client error
	- `5xx`: Server Error

- Apibrėžti [RFC standarto](https://tools.ietf.org/html/rfc2616#section-6.1.1)

## HTTP web aplikacijų raida 
- Statinis html turinys
- Dinamiškai generuojamas html turinys
- Interaktyvios web aplikacijos
- Single page web aplikacijos

[Kodo pavyzdžiai](https://github.com/JMJustas/simple_http_server)


## HTTP web aplikacijų raida: statinis turinys
- Interneto svetainė yra tarpusavyje nuorodomis susietų puslapių rinkinys
- Serveris pateikia statinius failus esančius tam tikroje direktorijoje

## HTTP web aplikacijų raida: dinaminis turinys
- HTML turinys yra sugeneruojamas serverio http užklausos metu
- Klientas gali paduoti užklausos parametrus
- Naudojami skirtingi http metodai
- Kiekvienas vartotojo veiksmas - nauja užklausa į web serverį

## HTTP web aplikacijų raida: interaktyvios web aplikacijos
- Serveris generuoja HTML turinį 
- HTML'e yra `<script></script>` žyma, nurodanti Javascript failus
- Naršyklė atsisiunčia JS failus iš nurodytos lokacijos(serverio, CDN, etc...)
- Kai kurie puslapio struktūros (DOM) pakeitimai gali būti daromi Javascript pagalba, nereikalaujant užklausos į serverį
- Sumažina apkrovą web serveriui
- Sukuria greitesnės reakcijos į vartotojo veiksmus pojūtį

## HTTP web aplikacijų raida: single page web aplikacijos
- Web serveris sugeneruoja tik dalį html puslapio
- Naršyklė atsisiunčia reikalingus javascript failus
- javascript kodas yra atsakingas už tolimesnę naršyklės saveiką su serveriu: http užklausos, DOM pakeitimai, 

## Kas yra node.js
- Javascript vykdymo aplinka (runtime environment)
- Node.js išpopuliarino javascript naudojimą ne tik naršyklėje bet ir serveryje. 
- Veikia visose populiariose operacinėse sistemose
- Populiarus tiek didelėse kompanijose, tiek startuoliuose (linkedin, netflix, paypal)

## Node.js nėra
- Node.js nėra programavimo kalba - javascript yra programavimo kalba
- Node.js nėra karkasas 
<br/>
<br/>
**Node.js yra javascript vykdymo aplinka**

## Truputėlis istorijos
 - Sukurta Ryan Dahl 2009 metais.
 - Panaudotas google sukurtas javascript variklis - V8
 - 2010 metais pristatytas **npm** - node package manager.
 - 2011 išleista node.js versija veikianti windows operacineje sistemoje
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
<small>Pirmas Ryan Dahl [pranešimas](https://www.youtube.com/watch?v=ztspvPYybIY]) pristatantis node.js</small>

## Node.js architektūra
![node-arch](images/node-arch.png "Node.js architecture")
## Node.js populiarumo priežastys
 - Greitis - v8 variklis 
 - Javascript kalbos universalumas 
 - Didelis cloud services palaikymas (aws, google cloud ir t.t.)
 - MEAN stacko išpopuliarėjimas nuo 2013 metų
 - Milžiniška ekosistema - gausybė node js atviro kodo bibliotekų

## Kas yra I/O ?
 - I/O - įvesties išvesties operacijos
 - Programos komunikacija su išoriniu pasauliu:
   - Failų sistema
   - Duomenų baze
   - Http užklausos
 - I/O operacijos įvykdomos ne iš karto - reikia laukti kol atsakovas atsakys (http serveris, duomenų bazė, failų sistema)
 - Yra gausybė aplinkybių dėl kurių I/O operacija gali nepavykti.

## Sinchroninė įvestis/išvestis (Synchronous/Blocking IO)
- Linijinis, lengvai skaitomas kodas	
- Vykdant IO operacijas, gija blokuojama
- Norint aptarnauti daugiau klientų, kuriama daugiau gijų	
- Nėra optimalu (neišnaudojamas procesorius, švaistoma atmintis)

```js
const fs = require('fs');
fs.writeFileSync("/tmp/test", "Hey there!");
console.log("The file was saved!");
```

## Asinchroninė įvestis/išvestis (Async/Non-blocking IO)	
- Kodas yra sudėtingesnis rašyti bei suprasti
- IO operacijų vykdymas neblokuoja gijos
- Efektyviai išnaudojamas procesorius
- Plačiai pritaikoma web aplikacijų kontekste(Nginx, node.js)	

```js
const fs = require('fs');
fs.writeFile("/tmp/test", "Hey there!", function(err) {
	if(err) {
		return console.log(err);
	}
	console.log("The file was saved!");
}); 
```


## Node.js ypatybės
- Asinchroninė įvestis/išvestis (Async IO)
- Viena gija (single threaded execution)
- Įvykių apdorojimo sistema (event loop)	

## Įvykių apdorojimo sistema (event loop)
- Pradinis įvykis: skriptas
- Visi įvykiai (nauja http užklausa irgi yra įvykis) programoje patenka į [įvykių apdorijimo sistemą](https://nodejs.org/de/docs/guides/event-loop-timers-and-nexttick/)	
- Programos veikimas stabdomas pasibaigus visiems įvykiams

```js
process.on('exit', () => {
	console.log('Exiting the process');
});
console.log('started work');
setTimeout(() => {
	console.log("I'm still here!");
}, 1000);
console.log('finished work');
```


## Viena gija (single threaded execution)
- Su globaliais kintamaisiais vis tiek elgtis reikia atsargiai:

```js
const request = require('request');
let urlLastHit;
function loadData (url) {
	request(url, {}, () => {
		urlLastHit = url;
	});
}
loadData('https://google.com');
loadData('https://delfi.lt');
setTimeout(() => console.log(urlLastHit), 2000)
```


???
Nors viskas veikia vienoje gijoje mes niekada negalime garantuoti kokia tvarka pasibaigs asinchronines operacijos
Tai priklauso nuo isoriniu faktoriu nepriklausanciu nuo musu programos kaip to li web serveris, ir pan.


## Viena gija (single threaded execution)
- Netinkama intensyviems skaičiavimams

```js
let count = 0;
function workForALongTime(time){
	const start = new Date().getTime();
	while(new Date().getTime() < start + time){}
}
function countSeconds(){
	workForALongTime(2000);
	count++;
	console.log('count' + count);
}
setInterval(countSeconds, 1000);
```


## Asinchroninis programavimas: callback mechanizmas
- Rezultato apdorojimo funkcijos paduodamos kaip paskutinis funkcijos argumentas
- Rezultato apdorojimo funkcijos turi bent vieną parametrą (gali būti ir daugiau)
- Klaidos apdorojamos per callback mechanizmą

## Asinchroninis programavimas: callback mechanizmas

```js
const request = require('request');
const url = 'http://someurl.com';
function loadData() {
	request(url, {}, function (err, res) {
		if (err) return console.error(err);
		return console.log(res);
	});
});
loadData();
```


???
javascript kalba pirmiausia buvo naudojama event loop architekturoje. Javascript narsykleje veikia irgi vienoje gijoje. Todel javascript programuotojam nera sunku programuoti eventu based architekturoje.

## Asinchroninis programavimas: callback hell
- Apsunkina kodo skaitymą
- Tenka rašyti daug pasikartojančio kodo (klaidų apdorojimas)
- Buvo sukurta bibliotekų, palengvinančių darbą su asinchroninėmis funkcijomis([async.js](https://caolan.github.io/async/docs.html#waterfall))

```js
operation1(function(err1, res1) {
	if (err1) return handleError(err1);
	operation2(function(err2, res2) {
		if (err2) return handleError(err2);
		operation3(function(err3, res3) {
			if (err3) return handleError(err3);
			operation4(function(err4, res4) {
				if (err4) return handleError(err4);
			});
		});
	});
});
```


## Asinchroninis programavimas: promises
- Perduoda paskutinės funkcijos rezultatą kitai grandinėje aprašytai funkcijai
- Oficialiai aprašytas ES6 standarte(2015)
- Padeda išspręsti asinchroninio kodo skaitomumo problemą	
- Leidžia rašyti moduliarų kodą

```js
operation1()
	.then((res1) => operation2(res1))
	.then((res2) => operation3(res2))
	.then((res3) => operation4(res3))
	.then((res4) => console.log(res4))
	.catch((err) => handleError(err));
```

---
## Asinchroninis programavimas: promises

```js
Promise.resolve(1) // "Promise grandinės" inicijavimas
	.then(x => x + 1) // Galima grąžinti reikšmę
	.then(x => Promise.resolve(x + 1)) // Galima grąžinti Promise 
	.then(x => Promise.resolve(2) 		//Galima grąžinti "Promise grandinę"
		.then(y => x + y)
	)
	.then(addTwo)				// Argumentas gali būti ir atskirai aprašyta funkcija
	.then(x => console.log(x)) // ...kol pasieksime norimą rezultatą (išvestis)
	.catch(err => console.log(err)); // klaidų apdorojimas
```


### Asinchroninis programavimas: async / await

 - palaikomas nuo node.js 7.6.0
 - Naudojami kalbos konstruktai `async` ir `await`
   - `async` - pažymėti funciją kuri grąžina `Promise` tipo objektą
   - `await` - pažymėti, kad Javascript "laukia" rezultato ir iki tol nevykdo kitos eilutes
 - `async/await` palengvina kodo skaityma, bet techniškai nesiskiria nuo Promises

```js
async function asyncFunction() {
	try {
		const res1 = await operation1();
		const res2 = await operation2(res1);
		const res3 = await operation3(res2);
		return res4;
	} catch (err) {
		handleError(err);
	}
}
await asyncFunction();
```


## Node package manager (NPM)
- Įrankis valdyti projektą:
	- Projekto inicializavimas (`npm init`)
	- Kompiliavimo, publikavimo, testavimo užduočių automatizvimas (`npm run`)
	- Bibliotekų instaliavimas (`npm install`)
- Instaliuojamas kartu su node.js		
- Alternatyvos: grunt, gulp, yarn

## NPM public registry
 - Didžiausia pasaulyje atviro kodo bibliotekų repositorija
 - Gausybė bibliotekų tiek skirtų tiek node.js tiek veikimui naršyklėse
 - Kritikuojama dėl saugumo bei galimybės lengvai pašalinti naudojama biblioteką ([left pad problema](https://www.theregister.co.uk/2016/03/23/npm_left_pad_chaos/))
<img src="images/node_modules.png" width="400">

## node.js privalumai
- Efektyviai išnaudoja resursus programose su daug IO operacijų
- Didžiulė ekosistema(NPM)
- Lengva greitai pradėti naują projektą, labai gerai tinka prototipavimui
- Galima naudoti tą pačią kalbą (JavaScript) kurti tiek kliento, tiek serverio aplikacijoms	

## node.js trūkumai
- Nėra efektyvu rašyti programas, kur atliekami sudėtingi skaičiavimai
- Nėra garantijos, kad pasirinktos bibliotekos bus atnaujinamos (nėra korporacijų palaikymo)
- Asinchroninis programavimas reikalauja daugiau įgūdžių:
