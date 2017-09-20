# XPath: Formalioji pusė

Interneto technologijos

## XPath kelias

Neformaliai: kelias susideda iš _žingsnių_, žingsnis susideda iš _ašies_ (nusako kryptį), _mazgo testo_ (filtras) ir nebūtinų _predikatų_ (filtrų)

```ebnf
Kelias ::= SantykinisKelias | AbsoliutusKelias

AbsoliutusKelias ::= '/' SantykinisKelias?

SantykinisKelias ::= Žingsnis |

SantykinisKelias '/' Žingsnis

*Žingsnis ::= AšiesVardas '::' MazgoTestas Predikatas*

MazgoTestas ::= '*' | Vardas | text() | node() | ...

Predikatas ::= '[' Išraiška ']'
```

## Ašių kryptys ir mazgų pozicija mazgų aibėje

- Kiekviena ašis yra arba einanti į priekį (forward), arba einanti atgal (reverse)
  - `ancestor`, `ancestor-or-self`, `preceding` ir `preceding-sibling` ašys eina atgal
  - visos kitos ašys eina į priekį
  - `self` ašiai kryptis nesvarbi (niekur neiname)
- Kiekvienas mazgas mazgų aibėje turi eiliškumo numerį (poziciją)
- Jei ašis yra einanti į priekį, tai didesni eiliškumo numeriai yra suteikiami mazgams, kurie yra toliau nuo dokumento pradžios
- Jei ašis yra einanti atgal, tai didesni eiliškumo numeriai yra suteikiami mazgams, kurie yra arčiau dokumento pradžios
- Pirmas eiliškumo numeris yra 1

## Mazgų pozicija 

![Ašių kryptys](images/xpath-formal-1.png "Ašių kryptys")

Čia yra einama descendant ir ancestor ašimis

## XPath kelias ir žingsniai

![XPath kelias ir žingsniai](images/xpath-formal-2.png "XPath kelias ir žingsniai")

## XPath kelias ir žingsniai

![XPath kelias ir žingsniai](images/xpath-formal-3.png "XPath kelias ir žingsniai")

## Operacijos su mazgų aibėmis

- Žingsniui įėjime paduodama aibė A (susidedanti iš mazgų)
- Kiekvienam šitos aibės mazgui a<sub>i</sub>:

![Operacijos žingsnyje](images/xpath-formal-4.png "Operacijos žingsnyje")

- Kiekvienam mazgui a<sub>i</sub> buvo gauta aibė B<sub>i</sub><sup>m</sup>
- Galutinė aibė B (žingsnio rezultatas) gaunama atliekant visų šitų aibių B<sub>i</sub><sup>m</sup> _sąjungą_ (**vienodi mazgai nedubliuojami**):

## Predikatai

- Predikatas, atsižvelgdamas į ašį, filtruoja mazgų aibę ir sukuria jos poaibį (kaip rezultatą)
- Kiekvienam mazgų aibės mazgui yra skaičiuojama predikato išraiška (_toliau kontekstas_ ir _aibė_ sinonimai):
  - su tuo mazgu kaip kontekstiniu mazgu(galima gauti su `self` arba `.`)
  - su mazgų skaičiumi mazgų aibėje kaip _konteksto dydžiu_ (grąžina funkcija `last()`)
  - ir su mazgo pozicija mazgų aibėje (atsižvelgiant į ašį) kaip konteksto pozicija(grąžina funkcija `position()`)

## Predikatai

- Jei šiam mazgui išraiška grąžina `true`, tai jis įtraukiamas į rezultato aibę, jei `false` – neįtraukiamas
- Jei išraiška grąžina:
  - skaičių, tai tas skaičius bus konvertuotas į `true`, jei jis lygus konteksto pozicijai, ir `false` priešingu atveju. Taigi ``para[3]`` yra tas pats kaip ir ``para[position()=3]``
  - mazgų aibę arba eilutę (string), tai jie konvertuojami į loginę reikšmę iškviečiant funkciją `boolean()`
       
## Predikatų pavyzdžiai

```xml
child::knyga[attribute::isbn="012"][position()=5]
``` 

- iš visų einamojo mazgo vaikinių žymių išrenka tas, kurios turi vardą **knyga**, tada iš jų išrenka tas, kurios turi atributą **isbn** su reikšme _0123456789_, tada iš jų išrenka **penktą** žymę

```xml
child::knyga[position()=5][attribute::isbn="012"]
```

- iš visų einamojo mazgo vaikinių žymių išrenka tas, kurios turi vardą **knyga**, tada iš jų išrenka **penktą** žymę, tada, jei ji turi atributą **isbn** su reikšme _0123456789_, grąžina šią žymę

```xml
child::knyga[child::pavadinimas='XML Schema']
```

- išrenka einamojo mazgo vaikines žymes vardu **knyga**, kurios turi vaikines žymes vardu **pavadinimas**, kurių turinys (**ne vardas!**) yra tekstas _XML Schema_

## Predikatų pavyzdžiai

```xml
child::*[self::knyga or self::žurnalas]
```

- išrenka visas einamojo mazgo vaikines žymes, kurių vardas yra arba **knyga**, arba **žurnalas**

```xml
//knyga[../@rūšis="grožinė"] 
```

- grąžins visas **knygas**, kurių tėvinė žymė turi atributą **rūšis** su reikšme _grožinė_

```xml
//knyga[autorius=//knyga[@isbn="5"]/autorius] 
```

- grąžins visas **knygas**, kurių **autorius** toksai pats kaip ir **knygos** su **isbn** kodu _12345_ autorius

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
        ...
    </grupė>
</KnygųSąrašas> 
```

## "Spąstai"

- Pabandykit pasakyti, ką grąžina šitas XPath kelias 

```xml
//knyga[1]
```

- Kyla noras interpretuoti kaip 

```xml
/descendant::knyga[1]
```

- Grąžina pirmą XML dokumento knygą (aibė bus arba tuščia – knygų išvis nėra, arba iš vieno mazgo – rastos knygos)

- Teisinga interpretacija(perrašius ilga notacija):

```xml
/descendant-or-self::node()/child::knyga[1]
```

- **Grąžina visas knygas, kurios yra kokių nors mazgų pirmi vaikai** (aibė gali būti iš daugiau nei vienos knygos)

## "Spąstai"

Su "KnygųSąrašo" dokumentu:

```xml
//knyga[1] 
```

grąžins pirmą ir trečią knygas (skaičiuojant nuo šakninės žymės), t.y., aibę iš dviejų elementų