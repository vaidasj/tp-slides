# XML dokumentų vardų sritys

Interneto technologijos

## Vardų galiojimo sritys

- Įvairūs žmonės/organizacijos kuria įvairias kalbas
  - pvz.: Amerikos laikraščių asociacija sukūrė XML kalbą, kuri skirta aprašyti laikraštinius skelbimus
- Kuriant didelę kalbą, yra patogu pasinaudoti jau kitomis sukurtomis kalbomis
  - pvz.: nekilnojamąjį turtą aprašanti kalba gali būti naudojama laikraštinius skelbimus aprašančioje kalboje
- Gali kilti žymių vardų konfliktas – ta pati žymė naudojama skirtingose kalbose (ir dažnai skirtinga prasme)
  - pvz.: žymė `<pavadinimas>` gali reikšti ir laikraščio pavadinimą, ir nekilnojamojo turto kompanijos pavadinimą
- Reikalingos žymių _vardų galiojimo sritys_ (angl. namespace)
- Sutrumpintai tiesiog _vardų sritys_

## W3C specifikacija

- [Namespaces in XML](http://www.w3.org/TR/REC-xml-names), 2009 Gruodis, trečia redakcija
- Aprašo standartinį būdą, kaip paskelbti naują vardų sritį, ir kaip žymes susieti su vardų sritimis, pvz.:

    ```xml
    <?xml version="1.0"?>
    <bk:book
        xmlns:bk="http://loc.gov/books"
        xmlns:isbn="urn:ISBN:0-395-36341-6">
        <bk:title>Introduction to XML</bk:title>
        <isbn:number>1568491379</isbn:number>
    </bk:book>
    ```

- **Pastaba**: dvitaškis įgauna specialią prasmę!
- Internetiniai adresai duoda vardų srities unikalumo problemos sprendimą


## Vardų srities deklaracija

- Vardų sritis turi vieną normalų vardą (paprastai ilgą), ir gali turėti vieną ar kelis sutrumpintus vardus (dar vadinamus prefiksais)
- Sutrumpintas vardas (prefiksas) galioja tik tame XML dokumente, kuriame jis yra naudojamas, ilgas vardas galioja (ir turi būti unikalus) visame pasaulyje

    ```xml
    <book xmlns:`bk`="`http://loc.gov/books`">
       ...
    </book>
    ```
- Pavyzdyje:
  - `bk` - prefiksas
  - `http://loc.gov/books` - vardų srities vardas

## Kvalifikuoti žymių vardai

- Žymę galima susieti su vardų galiojimo sritimi:

    ```xml
    <book xmlns:bk="http://loc.gov/books">
        <bk:title>Introduction to XML</bk:title>
    </book>
    ```

- Čia žymė `<title>` yra susieta su vardų galiojimo sritimi `http://loc.gov/books`
  - Žymės `<title>` **kvalifikuotas (tikras) vardas** yra ne `bk:title`, o `http://loc.gov/books:title`!
  - Kai programos analizuoja XML dokumentą, visi prefiksai yra keičiami normaliais vardų sričių vardais

## Kvalifikuoti žymių vardai

- Žymė `<book>` nėra asocijuota su **jokia** vardų sritimi:

    ```xml
    <book xmlns:bk="http://loc.gov/books">
        <bk:title>Introduction to XML</bk:title>
    </book>
    ```

- O čia jau yra:

    ```xml
    <`bk`:book xmlns:bk="http://loc.gov/books">
        <bk:title>Introduction to XML</bk:title>
    </`bk`:book>
    ```

## Kvalifikuoti atributų vardai

- Tas pats galioja ir atributams, pvz.:

    ```xml
    <bk:book xmlns:`bk`="http://loc.gov/books">
        <bk:title `bk:language`="en">
            Introduction to XML
        </bk:title>
    </bk:book>
    ``` 
    
- Atributo language kvalifikuotas vardas yra: `http://loc.gov/books:language`

## Vardų sričių galiojimo ribos

- Žymėje paskelbta vardų sritis galioja tos ir tik tos žymės viduje
- T.y., jei žymės viduje paskelbsime vardų sritį, tai ją galima su prefiksu susieti su:
  - šita žyme
  - su visomis tos žymės viduje esančiomis žymėmis/atributais – vaikais, anūkais, ..., t.y., visais _įpėdiniais_

## Vardų sričių galiojimo ribos

- Žymės vaikai gali iš naujo apibrėžti (perrašyti) vardų sritį:

    ```xml
    <?xml version="1.0" encoding="UTF-8"?>
    <bk:book `xmlns:bk`="http://loc.gov/books">
        <bk:title `xmlns:bk`="http://www.amazon.com">
            Introduction to XML
        </bk:title>
        <bk:author>John Rembo</bk:author>
    </bk:book>
    ```

- Tas pats prefiksas `bk` reiškia skirtingas vardų sritis!
- Žymė `book` priklauso vardų sričiai [http://loc.gov/books,](http://loc.gov/books,) o žymė `title` - http://www.amazon.com
  - Vos tik išeisime iš `title` vaikinės žymės, pradės galioti sena vardų sritis (t.y., perrašymas galioja tik vaikinėje žymėje)
- Žymė `author` priklauso vardų sričiai [http://loc.gov/books](http://loc.gov/books)

## Vardų sritis pagal nutylėjimą

- Jei prefiksas nėra nurodomas, vardų sritis tampa vardų sritimi agal nutylėjimą

<book xmlns='http://loc.gov/books'>

- Vardų sritis **pagal nutylėjimą** galioja žymės, kurioje ji paskelbta, viduje, ir  galioja tik toms žymėms, kurios neturi prefikso:

    ```xml
    <book `xmlns`="http://loc.gov/books"
        xmlns:isbn="urn:ISBN:0-395-36341-6">
        <title>Introduction to XML</title>
        <isbn:number>1568491379</isbn:number>
    </book>
    ```

- Žymės `book` ir `title` priklauso vardų sričiai `http://loc.gov/books`
- Žymė `number` priklauso vardų sričiai `urn:ISBN:0-395-36341-6`

## Vardų sritys pagal nutylėjimą ir atributai

- Vardų sritis pagal nutylėjimą atributams **negalioja**!

    ```xml
    <book xmlns="http://loc.gov/books">
        <title language="en">
            Introduction to XML
        </title>
    </book>
    ```

- Atributo `language` **kvalifikuotas (pilnas) vardas** yra `language`!

## Vardų sričių galiojimo pavyzdys

- Keičiame sritį pagal nutylėjimą

```xml
<?xml version="1.0" ?>
<book xmlns="urn:loc.gov:books" 
      xmlns:isbn="urn:ISBN:0-395-36341-6">
    <title>Cheaper by the Dozen</title>
    <isbn:number>1568491379</isbn:number>
    <notes>
*       <p xmlns="http://www.w3.org/TR/REC-html40">
            This is a <i>funny</i> book!
        </p>
    </notes>
</book>
```

## Srities pagal nutylėjimą panaikinimas

- Jokios srities pagal nutylėjimą `details` viduje:

```xml
<?xml version="1.0"?>
<Beers>
    <table xmlns="http://www.w3.org/TR/REC-html40">
        <tr>
            <td>
*               <details xmlns="">
                    <class>Bitter</class>
                    <pro>Summer beer</pro>
                    <con>Fragile</con>
                </details>
            </td>
        </tr>
    </table>
</Beers>
```
## Atributų unikalumas

- XML specifikacija **draudžia** žymei turėti du atributus su vienodais kvalifikuotais vardais:

```xml
<x xmlns:n1="http://www.w3.org" 
   xmlns:n2="http://www.w3.org">
    <blogai a="1" a="2"/>
    <blogai n1:a="1" n2:a="2"/>
</x>
```

- Vardų sritys pagal nutylėjimą negalioja atributams:

```xml
<x xmlns:n1="http://www.w3.org" 
   xmlns="http://www.w3.org">
    <gerai a="1" b="2"/>
*   <gerai a="1" n1:a="2"/>
</x>
```