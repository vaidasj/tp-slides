# JavaScript: node.js

Interneto technologijos

## Kas yra node.js?

- JavaScript vykdymo aplinka (runtime environment)
- Sukurta Ryan Dahl 2009 m.	
- Naudoja Google v8 variklį.
- [Išleidžiamos dvi versijos metuose](https://nodejs.org/en/download/releases/)

## Prielaidos atsiradimui

- C10K problema
- Cloud computing(Salesforce 1999, AWS 2002, Google apps 2009)
- Mobiliųjų įrenginių paplitimas

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
- Plačiai pritaikoma web aplikacijų kontekste(Nginx, node.js, vertx.io)	

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
- Visi įvykiai(nauja http užklausa irgi yra įvykis) programoje patenka į [įvykių apdorijimo sistemą](http://voidcanvas.com/setimmediate-vs-nexttick-vs-settimeout/)	
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

- Programuotojų kodas vykdomas tik vienoje V8 variklio gijoje
- Supaprastina darbą su atmintimi
- Kalbose, kurios palaiko gijų mechanizmą reikalingas sinchronizavimas

```java
public class Counter {
	private int count = 0;

	public synchronized increaseCount() {
		count++;
	}
}
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
loadData('www.google.com');
loadData('www.delfi.lt');

setTimeout(() => console.log(urlLastHit), 2000)
```

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
- Rezultato apdorojimo funkcijos turi bent vieną parametrą(gali būti ir daugiau)
- Klaidos apdorojamos per callback mechanizmą

## Asinchroninis programavimas: callback mechanizmas

```js
const request = require('request');
const url = 'http://someurl.com';

function loadData(cb) {
	request(url, {}, function (err, res, body) {
		if (err) return cb(err);
		return cb(null, JSON.parse(body));
	});
});

loadPersonalData(function (err, data) {
	if (err) { 
		return console.error(err) 
	}
	return console.log(data)
});

```

## Asinchroninis programavimas: callback pyramid of doom

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

## Pritaikymas web aplikacijų kūrime(Demo http serveris)

- Http modulis leidžia sukurti paprastą http serverį
- Programuotojai paprastai naudoja papildomas bibliotekas (viena populiariausių - express.js)

```js
var http = require('http');

http.createServer(function (req, res) {
	res.writeHead(200, {'Content-Type': 'application/json'});
	res.end(JSON.stringify({ message: 'hello, world!'}));
}).listen(8080);
```

## Modulių sistema (Require/exports)

- Leidžia importuoti bibliotekas (`require`)
- Leidžia skirstyti savo kodą į modulius ()
- Reikėtų vengti ciklinių priklausomybių!

## Node package manager (NPM)

- Įrankis valdyti projektą:
	- Projekto inicializavimas (`npm init`)
	- Kompiliavimo, publikavimo, testavimo užduočių automatizvimas (`npm run`)
	- Bibliotekų instaliavimas (`npm install`)
- Instaliuojamas kartu su node.js		
- Alternatyvos: grunt, gulp, yarn

## Node bibliotekų versijų žymėjimas(semver)
- Naujausia versija: `*`
- Leidžia "minor" versijų atnaujinimus: `^1.2.0`
- Leidžia "patch" versijų atnaujinimus: `~1.2.0`
- tiksli versija `1.2.0`

## node.js privalumai

- Efektyviai išnaudoja resursus programose su daug IO operacijų
- Didžiulė ekosistema(NPM)
- Minimalistinis karkasas
- Lengva greitai pradėti naują projektą, labai gerai tinka prototipavimui
- Galima naudoti tą pačią kalbą (JavaScript) kurti tiek kliento, tiek serverio aplikacijoms	

## node.js trūkumai

- Nėra efektyvu rašyti programas, kur atliekami sudėtingi skaičiavimai
- Nėra garantijos, kad pasirinktos bibliotekos bus atnaujinamos (nėra korporacijų palaikymo)
- Asinchroninis programavimas reikalauja daugiau įgūdžių