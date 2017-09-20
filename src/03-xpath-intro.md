# XPath: Įvadas

XML dokumento dalių adresavimas

Interneto technologijos

## XPath standartas

XPath 1.0 yra W3C standartas, skirtas XML dokumentų dalių adresavimui:
  - [http://www.w3.org/TR/xpath](http://www.w3.org/TR/xpath)
  - pamatinis XSLT ir XQuery elementas
  - **apie šią versiją bus kalbama per paskaitas**
    
## XPath standarto versijos

- 2007 m. sausio 23 baigta ruošti XPath 2.0 versija
    - [http://www.w3.org/TR/xpath20](http://www.w3.org/TR/xpath20) (2010 gruodis, antra redakcija)
    - praplečia 1.0 versiją naujais duomenų tipais (XMLSchema paprastais tipais), naujomis funkcijomis, ir pan.
    - netapo plačiai vartojama, nepilnas suderinamumas su 1.0 versija
    - mažas įrankių realizuojančių šią standarto versiją skaičius: [http://www.w3.org/XML/Query/#xpath2implementations](http://www.w3.org/XML/Query/#xpath2implementations)
       - tiesiogiai nepalaikoma nei vieno naršyklių _variklio_
- XPath 3.0 – W3C rekomendacija 2014 balandžio 8
    - pagrindinė naujovės - tiesioginis funkcijų palaikymas

## Loginė XML dokumento struktūra

- XPath modeliuoja XML dokumentą kaip **mazgų medį**
- Yra šios mazgų rūšys:
    - šakninis mazgas: `/`
       - Tai **ne šakninė XML žymė!** XPath įveda papildomą mazgą, kurio vienas
          iš vaikų yra XML šakninė žymė. Kiti šio mazgo vaikai gali būti
          komentarai ir apdorojimo instrukcijos
    - žymės: `knyga`
    - tekstas: `"Raudonkepuraitė"`
    - atributai: `rūšis, isbn`
    - komentarai: `<!-- komentaras -->`
    - kiti mazgai (apdorojimo instrukcijos, vardų sritys, ...), juos numato XML specifikacija, šiame kurse neanalizuosime


## Pavyzdys

```xml
<KnygųSąrašas>
    <grupė rūšis="grožinė">
        <knyga isbn="12345">
            <pavadinimas>
                Raudonkepuraitė
            </pavadinimas>
        </knyga>
        <knyga isbn="3214">
            ...
        </knyga>
    </grupė>
    <grupė rūšis="mokslinė">
        <knyga isbn="454654">
            ...
        </knyga>
        <knyga isbn="98765436">
            ...
        </knyga>
    </grupė>
</KnygųSąrašas><!– komentaras -->
```

## Knygų sąrašas kaip mazgų medis

- Rodyklės rodo ryšį "tėvas-vaikas"
- Atributai **nėra žymių vaikai(!)**, bet turi žymes kaip tėvus

![Mazgų medis](images/xpath-intro-1.png "Mazgų medis")

## Užklausos pavyzdys

- Užklausa lietuvių kalba: 
  - Kokia yra knygų sąrašo antros grupės penktos knygos ISBN atributo reikšmė?
- Ta pati užklausa XPath kalba:

    ```xml
    /knygųSąrašas/grupė[2]/knyga[5]/@isbn
    ```
    
## Ašys

![Ašys](images/xpath-intro-2.png "Ašys")

## Ašys

Sakykime, kad pasirinkome XML dokumento mazgų medyje vieną mazgą (jį vadinsime einamuoju mazgu), tuomet ašys:

- `child` : vaikiniai mazgai (išskyrus atributus!)
- `attribute` : einamojo mazgo atributai, jei einamasis mazgas yra žymė
- `parent` : tėvinis mazgas (galima taikyti ir atributui – bus grąžinta jį turinti žymė)
- `descendant` : mazgai-įpėdiniai (vaikai, anūkai, ..., išskyrus atributus)
- `ancestor` : mazgai-protėviai (tėvai, seneliai, ...)

## Ašys

- `following-sibling` : mazgai-broliai, einant į priekį nuo einamojo mazgo; netaikoma atributams
- `preceding-sibling` : mazgai-broliai, einant atgal nuo einamojo mazgo; netaikoma atributams
- `following` : visi mazgai, einant į priekį nuo einamojo mazgo, **išskyrus einamojo mazgo įpėdinius** ir išskyrus visus atributus
- `preceding` : visi mazgai, einant atgal nuo einamojo mazgo, **išskyrus einamojo mazgo protėvius** ir išskyrus visus atributus
- `self` : einamasis mazgas
- `descendant-or-self` : einamasis mazgas ir visi įpėdiniai
- `ancestor-or-self` : einamasis mazgas ir visi protėviai

## Ašys – pastabos

Pasirinkus bet kokį XML dokumento einamąjį mazgą, ašys: 
- `ancestor`
- `descendant`
- `following`
- `preceding`
- `self`

suskaido visų mazgų aibę į *penkis* **nepersikertančius** poaibius, kurie kartu apima visą dokumentą

## Ašys

![Ašys](images/xpath-intro-3.png "Ašys")

> Einamasis mazgas yra _self_

## Pavyzdys

```xml
<KnygųSąrašas>
    <grupė rūšis="grožinė">
        <knyga isbn="12345">
            <pavadinimas>
                Raudonkepuraitė
            </pavadinimas>
        </knyga>
        <knyga isbn="3214">
            ...
        </knyga>
    </grupė>
    <grupė rūšis="mokslinė">
        <knyga isbn="454654">
            ...
        </knyga>
        <knyga isbn="98765436">
            ...
        </knyga>
    </grupė>
</KnygųSąrašas><!– komentaras -->
```

## XPath kelių pavyzdžiai

- `child::knyga` – išrenka einamojo mazgo vaikines _žymes_ vardu knyga
- `child::*` - išrenka einamojo mazgo visas vaikines _žymes_ (bet tik žymes,  o ne kitas mazgų rūšis)
- `child::text()` – išrenka einamojo mazgo _tekstinius_ vaikus
- `child::node()` – išrenka einamojo mazgo _visų rūšių_ vaikinius mazgus
- `attribute::isbn` – išrenka einamojo mazgo (žymės) _atributą_ vardu  _isbn_ (kaip matome, einama ne child, o attribute ašimi)
- `attribute::*` - išrenka visus einamojo mazgo atributus

> Kiekvienas kelias grąžina mazgų aibę, galbūt tuščią

## XPath kelių pavyzdžiai

- `descendant::knyga` – išrenka visas žymes _knyga_, kurios yra einamojo mazgo įpėdiniai (vaikai, anūkai, proanūkiai, ir t.t.)
- `ancestor::*` – išrenka visas žymes, kurios yra einamojo mazgo protėviai (tėvas, senelis, prosenelis, ir t.t.)
- `ancestor-or-self::knyga` – išrenka visas žymes, kurios turi vardą knyga ir yra einamojo mazgo protėviai (tėvas, senelis, prosenelis, ir t.t.), įtraukiant ir einamajį mazgą (jei jis yra žymė ir jo vardas yra *knyga*)
- `self::grupė` – išrenka einamajį mazgą, jei jis yra žymė vardu “grupė", priešingu atvejų nieko neišrenka (grąžina tuščią aibę)
- `child::knyga/descendant::aprašymas` – (**du žingsniai**) išrenka visas žymes aprašymas, kurios yra žymių knyga įpėdiniai, kurios yra einamojo mazgo vaikai (rezultatas yra žymių aprašymas aibė, **žymės** **knyga į rezultatą neįtraukiamos!** )

## XPath kelių pavyzdžiai

- `child::*/child::knyga` – išrenka visas žymes vardu knyga, kurios yra einamojo mazgo anūkai
- `/` - išrenka šakninį mazgą ( **ne šakninę XML dokumento žymę!** )
- `/child::*` - išrenka šakninę XML dokumento žymę
- `/descendant::knyga` – suformuoja visų dokumento žymių vardu "knyga" aibę

## Kelių su predikatais pavyzdžiai

- `child::knyga[position()=1]` – išrenka pirmą einamojo mazgo vaikinę žymę _knyga_
- `child::knyga[position()=last()]` – išrenka paskutinę einamojo mazgo vaikinę žymę _knyga_
- `child::para[position()=last()-1]` – išrenka priešpaskutinę einamojo mazgo vaikinę žymę _knyga_
- `following-sibling::knyga[position()=1]` – išrenka einamojo mazgo pirmą žymę-brolį vardu _knyga_, kuri XML dokumente yra toliau nei einamasis mazgas
- `/descendant::knyga[position()=42]` – išrenka 42-ą žymę dokumente vardu _knyga_
- `child::knyga[attribute::isbn="0123456789"]` –  išrenka visas einamojo mazgo vaikines **žymes** vardu _knyga_, kurios turi **atributą** _isbn_ su reikšme `0123456789`

## Sutrumpinta notacija

- _child_ ašis yra ašis pagal nutylėjimą (ją galima praleisti)
    - `knyga` == `child::knyga`
    - `*` == `child::*`
    - `knyga/autorius` == `child::knyga/child::autorius`
- _attribute_ ašies sutrumpinimas: `@`
    - `@isbn` == `attribute::isbn`
    
## Sutrumpinta notacija
    
- `//` atitinka `/descendant-or-self::node()/`
    - `//knyga` == `/descendant-or-self::node()/child::knyga`
    - `knyga//autorius` == `child::knyga/descendant-or-self::node()/child::autorius`
- `.` atitinka `self::node()`
    - `.//knyga` == `self::node()/descendant-or-self::node()/child::knyga`
- `..` atitinka `parent::node()`
    - `../title` == `parent::node()/child::title`

## Sutrumpinta notacija - pastabos

`m//n` grąžina mazgų aibę, kuri yra tokių aibių sąjunga:
- `m/n`
- `m/*/n` (`child::m/child::*/child::n`)
- `m/*/*/n`
- `m/*/*...*/*/n` ir t.t.

## Sutrumpinta notacija - pastabos

`//n` analogiškai yra sąjunga tokių aibių:
- `/n` (šaknies **vaikai** _n_)
- `/*/n` (/`child::*/child::n` – šaknies **anūkai** _n_)
- `/*/*/n` (šaknies **proanūkiai** n)
- `/*/*...*/*/n` ir t.t. (šaknies **įpėdiniai** _n_)