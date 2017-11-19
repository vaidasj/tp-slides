# JavaScript: Įvadas

Interneto technologijos

## JavaScript

- Skripto kalba, sukurta _Netscape_ kompanijos
    - Visos skripto kalbos paprastai yra interpretuojamos ir dinaminės (t.y., tipų surišimas yra dinaminis, kintamieji gali keisti savo tipą programos vykdymo metu)

- **Tai ne Java!**
    - Skirtumų tarp JavaScript ir Java yra daugiau nei panašumų
    - Java nėra nei interpretuojama, nei dinaminė kalba
- Kiekvienas naršyklių gamintojas turi savą JavaScript realizaciją ir variklį:
    - Google Chrome – V8 (JavaScript)
    - Firefox – SpiderMonkey (JavaScript)
    - Edge – Chakra (JScript)

???
Terminas JavasScript narsykliu kontekste reiskia keletas skirtingu dalyku:
Vienas is ju yra bazine kalba – ECMAScript
Kitas Web API rinkinys i kuri ieina ir Dokumento Objektu Modelis (DOM)

ECMAScript yra naudojama ne tik narsykliu aplikose, pvz node.js

## JavaScript kalbos versijos

- 1997 m. Netscape sukurta JavaScript kalba standartizuojama, kaip ECMAScript (ECMA-262 standartas)
- 1999 m. gruodis ECMA-262 trečia redakcija (JavaScript 1.5)
- 2011 birželį išėjo 5.1 ECMA-262 standarto redakcija (JavaScript 1.8.5)
- ECMAScript 6 redakcija - 2015 birželio 17 d.
- ECMAScript Next:
	- ECMAScript 2016
	- ECMAScript 2017
	- ...
- ECMAScript naršyklių palaikymas
    - [http://kangax.github.io/compat-table/](http://kangax.github.io/compat-table/)

???
ECMAScript Next refers to new features of the ECMA-262 standard (commonly referred to as JavaScript) introduced after ECMAScript 2015. 
New versions of ECMAScript specifications are released yearly. 
This year, the ES2016 specification will be released and the ES2017 is the current ECMAScript draft specification.

## JavaScript galimybės

- Kas įmanoma su JavaScript
    - Bendravimas su vartotoju (pranešimai, dialogai)
    - HTML dokumento turinio dinaminis keitimas
    - HTML dokumento stiliaus dinaminis keitimas
    - Bendravimas su HTML puslapyje esančiais komponentais Applets, ActiveX)

- Nauji HTML5 API pateikia daug naujų funkcijų kurių detaliau neaptarinėsime:
	- Piešimas (Canvas 2D API)
	- Failų skaitymas (File API)
	- Užklausos į kitus serverius (XMLHttpRequest2)
	- .....


## JavaScript pavyzdys

- HTML dokumento turinio dinaminio formavimo pavyzdys

```js
<html>
<head>...</head>
<body>
<script type="text/javascript"> 
    document.write("<h2>Table of Factorials</h2>");
    for(var i=1, fact=1; i<10; i++, fact*=i) {
        document.write(i + "! = " + fact);
        document.write("<br>");
    }
</script>
</body>
</html>
```

## Duomenų tipai

- JavaScript turi šiuos duomenų tipus:
    - Skaičiai: _42_ arba _3.14159_
    - Loginės (boolean) reikšmės: _true _arba _false_
    - Eilutės: _"Kuku"_
    - `null`: ši reikšmė yra be tipo. JavaScript yra _case sensitive_ kalba, `null` yra ne tas pats kaip `Null`, `NULL`, ar panašiai.
    - `undefined`: žymi, kad kintamasis yra neinicializuotas
    - Objektai: JavaScript turi kai kurių OO kalbų savybių

- **Masyvai yra objektai!**
- Funkcijos (funkciją galima priskirti kintamajam ir/arba perduoti kaip parametrą)

## Automatinė tipų konversija

- JavaScript yra dinamiškai tipizuota kalba (t.y., tipai kintamiesiems priskiriami tik programos vykdymo metu)
- Kintamųjų paskelbimo metu tipų nurodyti nereikia, pvz.:

```js
var atsakymas = 42
```

- Vėliau tam pačiam kintamajam galima priskirto kito tipo reikšmę:

```js
atsakymas = "Tam param tatam..."
```

- Kintamojo tipas keičiamas _dinamiškai_, **jokios klaidos nebus!**

## Automatinė tipų konversija

- Aritmetiniai operatoriai skirtingų tipų reikšmes konvertuoja į vieno tipo reikšmes automatiškai
- Sudėties operatorius, jei bent vienas operandas nėra skaičius, operandus verčia į eilutės tipo reikšmes:

```js
 x = "Ats.: " + 42 // reikšmė: "Ats.: 42"
 y = 42 + " Lt."   // reikšmė: "42 Lt."
```

- Kiti operatoriai bando eilutės tipo reikšmes versti į skaitines:

```js
"37" - 7 // 30
"37" + 7 // 377
```

## Kintamieji

- Kintamąjį paskelbti galima dviem būdais:
    - Naudojant raktinį žodį `var`:
     
     ```js
     var x = 42
     ```

    - Nenaudojant `var`:
     
     ```js 
     x = 42
     ```

## Kintamieji

- Neinicializuotų kintamųjų naudojimas:
    - Jei kintamasis buvo paskelbtas be `var`, bus klaida
       
    ```js   
    x;
    y = x+1; // klaida
    ```

    - Jei su `var`, skaitiniame kontekste jo reikšmė bus `NaN`, kituose - `undefined`

	```js
	var x;
	y = x+1; // NaN
	```

## `undefined` ir `null` reikšmės

- Yra galimybė patikrinti, ar kintamasis buvo inicializuotas:

```js
var input;
if (input === undefined) {
    doThis();
} else {
    doThat();
}
```

- `undefined` loginėse išraiškose yra verčiama į `false`:

```js
function suma(a, b) {
    if (a && b)
        return a + b;
    else return 0;
}
```

## `undefined` ir `null` reikšmės

- `null` reikšmė elgiasi kaip nulis skaitinėse išraiškose, ir kaip `false` loginėse išraiškose:

```js
var n = null;
n * 32; // bus 0
```

## Kintamųjų galiojimo sritys

- Kintamieji, paskelbti funkcijų viduje, yra _lokalūs_ kintamieji, visi kiti yra _globalūs_ kintamieji
- Globalius kintamuosius galima paskelbti ir su `var`, ir be `var`, lokalius – tik su `var`

```js
var x; // globalus
y;     // globalus

function suma(a, b) {

    var s = a + b; // s yra lokalus

    return s;
}
```

## Skaitinės ir loginės konstantos

- JavaScript neskiria sveikų skaičių nuo realių (kol kintamojo reikšmė sveika, kablelis nespausdinamas)
- Šešioliktainiai skaičiai gali būti užrašyti, pridedant prefiksą `0x`:
  - `0xFFFF`
- Yra dvi loginės konstantos:
  - `true`
  - `false`


## Eilutės (_string_)

- Apskliaudžiamos kabutėmis arba apostrofais:
  - "kuku"
  - 'aha'
  - "Katinas pasakė 'miau'"
  - "pirma eilutė \n antra eilutė"
- `\` naudojamas kaip _escape_ simbolis

## Escape simboliai

| Simbolis | Reikšmė |
| -------- | ------- |
| `\b`  | Backspace |
| `\f`  | Form feed |
| `\n`  | New line |
| `\r`  | Carriage return | 
| `\t`  | Tab |
| `\'`  | Apostrophe or single quote |
| `\"`  | Double quote |
| `\\`  | Backslash character (`\`) |

## Masyvai

- Masyvai - paskelbiami su `[]`, numeruojami nuo **0**. 
- Pvz.: trijų elementų masyvas:

```js
var spalvos = ["juoda", "balta", "raudona"];
```

- Kai kuriuos masyvo elementus galima praleisti:

```js
var spalvos = ["juoda", , "balta", "raudona"];
spalvos[0]; // "juoda",
spalvos[1]; // undefined
```

- Masyvo elementai gali būti skirtingų tipų!

```js
var strange = ["abc", 14, true, new Date()];
```

## Objektai 

- Objektą paskelbti galime naudodami riestinius skliaustelius `{}`, kurių viduje rašomos savybės ir jų reikšmės :

```js
 var automobilis = {
     marke: "Audi",
     turis: 2.0,
     spalva: "raudona"
 }

 console.log(automobilis.marke);
```

## Priskyrimo operatorius `=`

| Operatorius | Reikšmė |
| ----------- | ------- |
| `x += y`    | `x = x + y` |
| `x -= y`    | `x = x - y` |
| `x *= y`    | `x = x * y` |
| `x /= y`    | `x = x / y` |
| `x %= y`    | `x = x % y` |
| `x <<= y`   | `x = x << y` |
| `x >>= y`   | `x = x >> y` |
| `x >>>= y`  | `x = x >>> y` |
| `x &= y`    | `x = x & y` |
| `x ^= y`    | `x = x ^ y` |

## Palyginimo operatoriai


| Operatorius  | Aprašymas                       | Palyginimas (x = 5) | Rezultatas |
|-----------|-----------------------------------|-----------|---------|
| ==        | equal to                          | x == 8 <br> x == 5 <br> x == "5"   | false <br> true <br> true  | 
| ===       | equal value and equal type        | x === 5 <br>  x === "5"    | true <br> false    |          
| !=        | not equal                         | x != 8    | true    |  
| !==       | not equal value or not equal type | x !== 5 <br> x !== "5" <br> x !== 8  | false <br> true <br> true    |        
| >         | greater than                      | x > 8     | false   | 
| <         | less than                         | x < 8     | true    | 
| >=        | greater than or equal to          | x >= 8    | false   |  
| <=        | less than or equal to             | x <= 8    | true    | 

## Aritmetiniai operatoriai

- Įprasti: 
 - `+` - sudėtis
 - `-` - atimti
 - `*` - sandauga
 - `/` - dalyba
 - `%` - dalyba su liekana 
 - `++` - padidina skaičių vienetu
 - `--` - sumažina skaičių vienetu

- `/` visada atlieka **realių** skaičių dalybą (net jei abu operandai sveiki skaičiai)

```
1/2 // grąžina 0.5 JavaScript
1/2 // grąžina 0 Java
```	

## Loginiai operatoriai

- `&&` - loginis IR 
  - `expr1 && expr`
- `||` - loginis ARBA
  - `expr1 || expr`
- `!`  - loginis neigimas
  - `!expr` 

## Specialūs operatoriai

- `new` – skirtas kurti objektus

```js
var date = new Date();
```

- `this` – skirtas prieiti prie einamojo objekto

```js
<input type="text" name="amzius" onchange="validate(this)"/>

 function validate(obj) {

     if ((obj.value < 0) || (obj.value > 200))

         alert("Bloga reikšmė!")

 }
 ```

## Sakiniai

- Blokai _if-then-else_, _switch_, _for_, _while_, _do-while_ tokie patys kaip ir Java/C++ kalbose
- Sakiniai baigiami kabliataškiu
- **`for` ciklo kintamuosius reikia paskelbti su `var`, ne su `int`**

```js
 for (var i = 1, var fact = 1; i < 10; i++, fact *= i) {

     document.write(i + "! = " + fact);

     document.write("<br>");

 }
```

## Funkcijos

- Paskelbiamos su raktiniu žodžiu `function`
- Gali grąžinti rezultatą, gali ir negrąžinti

```js
 function suma(a, b) {

     if (a && b)

         return a + b; // else atveju nieko negrąžiname

 }
```

- Funkciją kviesti galima su bet kokiu parametrų skaičiumi

```js
suma(1, 2); 
suma(1); 
suma(); 
suma("lala", 14, true);
```

## Funkcijos argumentų masyvas

- Visi funkcijai paduoti argumentai yra saugomi masyve `arguments[]`

- Pavyzdys: funkcija, sujungianti visus argumentus į eilutę, naudodama pirmą argumentą kaip skirtuką:

```js
function myConcat(separator) {

    result = "";
    // praleidžiam pirmą argumentą (skirtuką):
    for (var i = 1; i < arguments.length; i++) {
        result += arguments[i] + separator;
    }
    return result;
}
```

- Galime šia funkciją kviesti taip:

```js
myConcat(":", "AB", "CD", "EF");
```

## Standartinės funkcijos

- `parseInt(String [, radix])` – verčia eilutę į skaičių pagal nurodytą skaičiavimo sistemą (dešimtainė pagal nutylėjimą)

```js
parseInt("123") === 123;   // true
parseInt("12abc") === 12;  // true
parseInt("a", 16) === 10;  // true
parseInt("a");             // NaN
```
- patikrinimas, ar kintamojo reikšmė sveikas skaičius: 

```js
parseInt(x) == x;
```

- `isNaN(value)` – tikrina, ar paduotas argumentas yra reikšmė `NaN`

???
Note: Only the first number in the string is returned!
A Number. If the first character cannot be converted to a number, NaN is returned

## Taikymai: datos validavimas

```js
function checkDate(yearStr, monthStr, dayStr)
    if (yearStr != parseInt(yearStr)) {
        return false;
    }
    ...
    
    year = parseInt(yearStr);
    month = parseInt(monthStr)-1; // Sausis - 0
    day = parseInt(dayStr);
    if (month < 0 || month > 11) {
        ...
    }
    var date = new Date(year, month, day);
    if (date.getDate() != day) {
        alert("Neteisinga data");
        return false;
    }
}
```


## Įvykių apdorojimas

- Pavyzdys:

```html
 <form name="manoforma" action="...">
 ...
 <input type="button" value="Paspausk" onClick="funk()" />
 ...
 </form>
```

- Kiti įvykiai:
    - _onChange_
    - _onFocus, onBlur_
    - ...