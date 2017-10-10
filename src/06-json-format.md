# JSON: Duomenų apsikeitimo formatas

Interneto technologijos

## Kas yra JSON?

- JSON - __J__ava__S__cript __O__bject __N__otation
- _Lengvas_, nuo programavimo kalbos nepriklausomas, tekstinis duomenų apsikeitimo formatas:
  - Lengvai skaitomas
  - Lengvai užrašomas
  - Mažas meta informacijos kiekis
- JSON nėra
  - _Dokumentų_ formatas
  - _Dokumentų_ žymių kalba
  - Dokumentas `!=` Duomenys

## Pavyzdys

```json
{
   "knygos": [
      {
         "autorius": "Eric van der Vlist",
         "pavadinimas": "XML Schema",
         "metai": 2002,
         "kietasViršelis": false,
         "isbn": "0-596-00252-1"
      },
      {
         "autorius": "George Orwell",
         "pavadinimas": "1984",
         "metai": 1949,
         "kietasViršelis": true,
         "isbn": "9-780-14103614-4"
      }
   ]
}
```

## Privalumai

- Aiški sintaksė
- Mažas papildomos informacijos kiekis
  - Tinkamas duomenų apsikeitimui tarp sistemų
- Palaikomas daugelio JavaScript karkasų
- Egzistuoja bibliotekos daugeliui programavimo kalbų
- Naudojamas daugelio atvirų API tiekėjų

## Panaudojimo scenarijai

- Persiųsti duomenis iš / į serverį
- Asinchroninės užklausos - AJAX
- Duomenų saugyklos - NoSQL
- Duomenų saugojimas lokaliame diske (_Local Storage_)
- ir daug kitų

##  Standartas

- Oficialiu standartu tapo 2013, kaip [ECMA-404](http://www.ecma-international.org/publications/files/ECMA-ST/ECMA-404.pdf) standarto dalis
- Douglas Crockford savo tinklapyje [json.org](http://json.org) aprašė dar 2002 m. 
- Yahoo and Google pradėjo naudoti JSON 2005 m. ir 2006 m.
- __Alternatyvus__ [RFC 7158](https://tools.ietf.org/html/rfc7158) standartas pasirodė tais pačiais metais:
  - _ECMA-404_ standartas aprašo tik leistiną sintaksę, _RFC 7158_ papildo saugumo ir suderinamumo aspektais
  - _RFC 7158_ naudoja _ECMA-404_ kaip pamatinį standartą
  - 2014 m. _RFC 7158_ pakeitė [RFC 7159](https://tools.ietf.org/html/rfc7159), kuris laikomas pagrindiniu specifikuojant JSON naudojimą internete (MIME _application/json_)

## JSON ir JavaScript objektas

- Ar JSON yra JavaScript objektas? 
- **Tik iš dalies**, nes:
  - JSON specifikacija sako, kad tai _nuo kalbos nepriklausomas_ __tekstinis__ duomenų formatas
  - JavaScript objektas yra JavaScript kalbos konstruktas
  - Taigi JSON tiesiog sukurta remiantis JavaScript objekto savybėmis, bet turi technologinių skirtumų

## JSON ir JavaScript objektas

- Technologiniai skirtumai:
  - JavaScript objekto raktai nėra _įdėti_ į kabutes

     ```json
    // JavaScript Object
    {
       foo: "bar"
    }
    
    // JSON
    {
       "foo": "bar"
    }
    ``` 

  - JSON palaiko / supranta tik dvigubas kabutes
  - JSON galima saugoti tik tekstinius duomenų tipus (pvz. `Date()` nepalaikoma)
  


## Sintaksė

- JSON remiasi dvejomis struktūromis:
  - **Raktas - reikšmė** porų rinkiniu (_objektas, įrašas, struktūra, ..._)
  
  ```json
  {
  	"vardas": "Vardenis",
  	"gimimoData": 1984
  }
  ```
  
  - Surikiuotu **reikšmių sąrašu** (_masyvas, vektorius, sąrašas, ..._)
  
  ```json
  ["Interneto Technologijos", true, null, 1234]
  ```
  
- Viena iš jų privalo būti šakniniu JSON elementu
  
## Duomenų tipai

JSON apibrėžia šiuos duomenų tipus:
- skaičius (_number_) - dešimtainis skaičius su ženklu ir neprivaloma trupmenine dalimi. Duomenų tipas neapibrėžia skirtumų tarp sveikų ir slankaus kablelio skaičių. Galima naudoti eksponentinę notaciją, bet draudžiama nurodyti ne skaičių (_NaN_)

    ```json
    "metai": 1949
    ```

- eilutė (_string_) - nulio ir daugiau _Unicode_ simbolių seka. Eilutė yra išskirta dvigubomis kabutėmis, atgalinis brukšnys naudojamas, kaip _escape_ simbolis

    ```json
    "pavadinimas": "XML Schema"
    ```

## Duomenų tipai

- loginis (_boolean_) - galimos reikšmės: `true` arba `false`

    ```json
    "kietasViršelis": false
    ```

- masyvas (_array_) - surikiuotas nulio ar daugiau reikšmių sąrašas, kuriame gali būti bet kurio kito tipo duomenys. Aprašomas naudojant laužtinius skliaustus elementus atskiriant kableliais. Negali būti praleistų elementų

    ```json
    "žanras": ["Istorija", "Biografija"]
    ```
    
- `null` - tusčia reikšmė

    ```json
    "pastabos": null
    ```

## Duomenų tipai

- objektas (_object_) - nesurikiuotas, raktas - reikšmė porų rinkinys, kurio raktai yra eilutės. Rekomenduotina, bet neprivaloma, jog raktai objekte būtų unikalūs. Aprašomas naudojant riestinius skliaustus, poros atskiriamos kableliais, raktas ir reikšmė atskiriami dvitaškiu

    ```json
    {
       "autorius"`:` "George Orwell"`,`
       "pavadinimas": "1984",
       "metai": 1949
    }
    ```
- JSON nepateikia sintaksės komentarams
- Leidžiami riboti tarpo simboliai (_space, tab, line feed, carriage return_)

## JSON ir XML palyginimas

|Savybė | XML| JSON|
|-|-|-|
|Galimybė kurti naujas kalbas| Taip| Taip|
|Jau sukurtų kalbų kompozicija ir pakartotinis panaudojimas| Taip (_namespaces_) | Ne |
| Atvaizdavimas programavimo kalbų duomenų struktūromis| Sudėtingesnis - XML reikalauja **duomenų** struktūrą konvertuoti į **dokumento** struktūrą | Intuityvus - JSON tiesiogiai nusako duomenų struktūrą |
|Meta duomenų aprašymas| Duomenų meta duomenys gali būti nusakomi kaip žymės atributai| Duomenys, turintys meta duomenų turi būti užrašomi kaip objektai. Turime įvesti papildomą hierarchinį lygmenį|
|Duomenų apimtis| Nemažą dalį duomenų kiekio sudaro XML kalbos konstruktai | Užrašytų duomenų kiekis artimas _vertingo_ turinio kiekiui|
