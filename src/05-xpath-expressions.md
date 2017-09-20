# XPath: Išraiškos

Interneto technologijos

## XPath išraiškos

- XPath keliai yra dalinis XPath išraiškų atvejis
- Išraiškos papildomai leidžia:
  - vietoj žingsnių naudoti funkcijas (kurios grąžina mazgų aibę)
  - su XPath kelių rezultatais atlikti aritmetines, lyginimo ir aibių sąjungos operacijas
  - išraiškos rezultatas gali būti ne tik mazgų aibė, bet ir _boolean_, _string_, _number_ tipo reikšmė
- Taigi XPath turi viso 4 tipus: _mazgų aibė_, _loginis_, _eilutės_ ir _skaičiai_
- Išraiškoms, kurios grąžina mazgų aibę, galima taikyti predikatus

## Išraiškų pavyzdžiai

- aibių sąjunga: grąžina aibę iš dviejų elementų

```xml
/descendant::knyga[2] | /descendant::knyga[4]
```

- grąžina _true_ arba _false_

```xml
/descendant::knyga[3]/metai > 2005
```

- grąžina skaičių:

```xml
/descendant::knyga[3]/metai – 1
```

## Išraiškų pavyzdžiai

- suskaičiuoja, kiek žymių **knyga** yra dokumente

```xml
count(//knyga)
```

- susumuoja bendrą **kainą**, ir atima vieną centą

```xml
sum(//knyga/kaina) - 0.1
```

- grąžina pirmą dokumento **knygą** (palyginkite su “spąstais”)

```xml
(//knyga)[1]
```

## Operacijų prioritetas

Prioriteto mažėjimo tvarka:

1. Skliausteliai: `(` ir `)`
2. Žingsnių skirtukas: `/` (tai ne dalyba!)
3. Aibių sąjungos operatorius: `|` (dirba tik su aibėmis)
4. Daugyba/dalyba: `*`, `div` (slankiu kableliu), `mod` (liekana)
5. Sudėtis/atimtis: `+`, `- ` (*dirba tik su skaičiais*)
6. Mažiau/daugiau: `<`, `<=`, `>`, `>=` (*dirba tik su skaičiais*)
7. Lygu/nelygu: `=`, `!=` (*su aibėmis nedirba*)
8. Loginis "ir": `and`
9. Loginis "arba": `or`

## Operacijų prioritetas

Pastabos
- loginiam neigimui yra funkcija `not()`

```xml
//knyga[not(kaina > //knyga/kaina)]
```

- funkcijos `true()` ir `false()` grąžina konstantas

## Predikatai, taikomi išraiškoms

- Išraiškų rezultatams galima taikyti predikatus
    - Išraiška privalo grąžinti **mazgų aibę** (ne skaičių, eilutę ar loginį tipą)
    - Predikatai išraiškos rezultatą filtruoja taikydami `child` ašį pagal nutylėjimą

```xml
(//knyga | //žurnalas)[1]
```

- grąžins pirmą dokumento **knygą** arba pirmą **žurnalą**, priklausomai kas bus sutiktas pirmiau

```xml
((//knyga)[last()]/preceding::knyga)[1]
```

- grąžins **pirmą** (ne paskutinę) dokumento _knygą_ (nepaisant to, kad paskutinis žingsnis grąžins visų knygų aibę išrikiuotą priešinga tvarka nei dokumentas (**ašis yra einanti atgal**)


## Tipų konvertavimai

- Jei operacijos operandai yra skirtingų tipų, tipų konvertavimas atliekamas automatiškai/priverstinai
- Niekada nebus klaidų pranešimų dėl blogų tipų!
- Pavyzdys: 

```xml
3 > 2 > 1
```

- Operacijos apdorojamos visada iš kairės į dešinę, taigi perrašome kaip `(3 > 2) > 1`
- `(3 > 2)` grąžina true, gauname `true > 1`
- Operacija `>` reikalauja, kad abu operandai būtų skaičiai, taigi `true` yra automatiškai verčiamas į skaičių kviečiant funkciją `number(true)`, kuri grąžina `1`, gauname: `1 > 1`
- **Atsakymas**: `false`

## Tipų konvertavimai

Koks bus rezultatas?

```xml
1 < 2 < 3
```

```xml
1 + //kaina - true() = “0”
```

## Tipų konvertavimai

XPath turi 4 tipus:
- Struktūrinį:
   - aibė
- Paprastus:
   - loginis (boolean)
   - eilutė (string)
   - skaičius (number)
- Aibės tipą galima paversti į bet kokį paprastą tipą
- Bet kokį paprastą tipą galima paversti į bet kokį kitą paprastą tipą
- Vertimams (konversijai) yra trys funkcijos:
    - _boolean(), string(), number()_

## Funkcija boolean()

Argumentas verčiamas į loginę konstantą `true` arba `false` tokiu būdu:

- mazgų aibė verčiama į `true`, jei ji ne tuščia
    - pvz.: `boolean(//knyga)` grąžins _true_ jei dokumente yra bent viena knyga; priešingu atveju – _false_
- skaičiai: nulis ir NaN (not a number) verčiami į `false`, kiti skaičiai – `true`
    - Pvz.: `boolean(5)` grąžins _true_
- eilutė verčiama į `true`, jei jos ilgis > 0
    - Pvz.: `boolean("kuku")` grąžins _true_
    - `boolean("")` grąžins _false_

## Funkcija string()

Jei argumentas yra mazgų aibė:
- Jei ji tuščia, grąžinama tuščia eilutė (ilgis 0)
- Jei netuščia, imamas **pirmas** aibės elementas (mazgas) ir jei tai yra:
   - **žymė**, tai imami jos visi įpėdiniai tekstiniai mazgai (`descendant::text()`) ir jie sujungiami į vieną eilutę
   - **atributas**, tai imama jo reikšmė kaip eilutė
   - **tekstinis mazgas**, tai imama jo reikšmė
     
## Funkcija string()

- Jei argumentas yra skaičius:
    - NaN yra verčiamas į eilutę `"NaN"`
    - teigiama begalybė verčiama į `"Infinity"`
    - neigiama begalybė verčiama į `"-Infinity"`
    - kiti skaičiai į natūralų jų atvaizdavimą eilute    
- Jei argumentas yra loginė konstanta:
    - _true_ verčiamas į `"true"`
    - _false_ verčiamas į `"false"`
- Jei argumentas praleistas, automatiškai sukuriama mazgų aibė, `self::node()` ir paduodama kaip argumentas 


## Funkcija number ()

Argumentas verčiamas į skaičių tokiu būdu:
- **eilutė** verčiama į artimiausią matematinę skaitinę išraišką:
    - jei paversti į skaičių neįmanoma (ne skaičius), tai grąžinamas skaičius `NaN` (not a number)
- **loginis** _true_ verčiamas į `1`, _false_ verčiamas į `0`
- **mazgų aibė** pirmiausia paverčiama į **eilutę** kviečiant funkciją `string()`, tada verčiama į skaičių kaip nusakyta pirmame punkte
- jei argumentas praleistas, automatiškai sukuriama mazgų aibė `self::node()` ir paduodama kaip argumentas

## Loginės išraiškos

- Tai išraiškos, naudojančios operatorius `or`, `and`, funkcijas `true()`, `false()`, `not()` bei palyginimo operacijas `<`, `<=`, `>`, `>=`
- Jei operatorių `or` ir `and` argumentai nėra loginio tipo, jie priverstinai paverčiami į loginį tipą, kviečiant funkciją `boolean()`

```xml
/descendant::knyga[1]/kaina > 50 
and 
/descendant::žurnalas[2]/kaina < 30
```

```xml
//knyga or 0 or "kuku"
```

- Ar aibė tuščia: 

```xml
boolean(//kuku) = false()
```

## Lyginimo operacijos <, <=, >, >= be aibių

- Jei lyginami operandai yra ne aibės:
```xml
true() > “kuku”
```

- Tai abu operandai yra verčiami į **skaičius** kviečiant funkciją `number()`

## Lyginimo operacijos <, <=, >, >= su aibėmis

- Pavyzdžiai
    - `//knyga > 5`
    - `//knyga <= //žurnalas`
- Sutrumpinimai:
    - A – aibė (aibė gali susidėti tik iš dokumento mazgų, negali susidėti iš skaičių, eilučių, loginių reikšmių)
    - m – mazgas (pvz.: /, žymė, tekstas, atributas)
    - l – loginė reikšmė (`boolean`)
    - s – skaičius (`number`)
    - e – eilutė (`string`)
    - ◦ - lyginimo operacija `{ <, <=, >, >= }`


## Lyginimo operacijos <, <=, >, >= su aibėmis

- Atsikratome aibių, perrašydami taip:
  - A<sub>1</sub> ◦ A<sub>2</sub> ↔ ∃m<sub>1</sub> ∈A<sub>1</sub> ir ∃m<sub>2</sub> ∈A<sub>2</sub> : number(m<sub>1</sub>) ◦ number(m<sub>2</sub>)
  - A<sub>1</sub> ◦ s ↔ ∃m<sub>1</sub> ∈A<sub>1</sub> : number(m<sub>1</sub>) ◦ s
  - A<sub>1</sub> ◦ e ↔ ∃m<sub>1</sub> ∈A<sub>1</sub> : number(m<sub>1</sub>) ◦ number(e)
  - A<sub>1</sub> ◦ l ↔ number(boolean(A<sub>1</sub>)) ◦ number(l)

> Pirmi trys punktai atlieka aibių Dekarto sandaugą – imame visas galimas poras, jei bent viena pora duoda rezultatą **true**, tai galutinis rezultatas irgi **true**.

## Lyginimo operacijos = ir != be aibių

- Jei lyginami operandai yra ne aibės

```xml
5 = "kuku"
```

- Tai:
    - Jei bent vienas operandas yra **loginio** tipo, tai kitas operandas yra paverčiamas į **loginį** tipą kviečiant funkciją `boolean()`
    - Priešingu atveju, jei bent vienas operandas yra **skaičius**, tai kitas operandas yra verčiamas į **skaičių** kviečiant funkciją `number()`
    - Priešingu atveju abu operandai yra verčiami į **eilutes** kviečiant funkciją `string()`


## Lyginimo operacijos = ir != su aibėmis

- Pavyzdžiai
    - `//knyga != 5`
    - `//knyga = //žurnalas`
- Sutrumpinimai:
    - A – aibė (aibė gali susidėti tik iš dokumento mazgų, negali susidėti iš skaičių, eilučių, loginių reikšmių)
    - m – mazgas (pvz.: /, žymė, tekstas, atributas)
    - l – loginė reikšmė (`boolean`)
    - s – skaičius (`number`)
    - e – eilutė (`string`)
    - ◦ - lyginimo operacija `{=, !=}`

## Lyginimo operacijos = ir != su aibėmis

- Atsikratome aibių, perrašydami taip:
    - A<sub>1</sub> ◦ A 2 ↔ ∃m<sub>1</sub> ∈A<sub>1</sub> ir ∃m<sub>2</sub> ∈A<sub>2</sub> : string(m<sub>1</sub>) ◦ string(m<sub>2</sub>)
    - A<sub>1</sub> ◦ s ↔ ∃m<sub>1</sub> ∈A<sub>1</sub> : number(m<sub>1</sub>) ◦ s
    - A<sub>1</sub> ◦ e ↔ ∃m<sub>1</sub> ∈A<sub>1</sub> : string(m<sub>1</sub>) ◦ e
    - A<sub>1</sub> ◦ l ↔ boolean(A<sub>1</sub>) ◦ l
    
> Pirmi trys punktai atlieka aibių Dekarto sandaugą – imame visas galimas poras, jei bent viena pora duoda rezultatą **true**, tai galutinis rezultatas irgi **true**.

## Naudingos funkcijos

- _number_ **last**()
    - Grąžina konteksto dydį (šiuo metu predikato apdorojamos mazgų aibės elementų skaičių)
- _number_ **position**()
    - Grąžina einamojo mazgo poziciją predikato apdorojamoje mazgų aibėje, atsižvelgiant į ašies ėjimo kryptį
- _number_ **count**(_mazgų aibė_)
    - Grąžina argumento (mazgų aibės) elementų skaičių
- _number_ **sum**(_mazgų aibė_)
    - Pirmiausia kiekvienas argumento (mazgų aibės) elementas verčiamas į eilutę (kviečiant `string()` funkciją), tada kiekviena eilutė verčiama į skaičių (kviečiant `number()` funkciją), ir visi skaičiai susumuojami

## Naudingos funkcijos

- _boolean_ **not**(_boolean_)
    - Atlieka neigimo operaciją
- _string_ **concat**(_string_, _string_, _string_,*)
    - Atlieka parametrų konkatenaciją (eilučių apjungimą)
- _string_ **normalize-space**(_string_?)
    - Ištrina eilutės–parametro pradžioje ir pabaigoje esančius tarpus (ir kitus  nematomus simbolius – whitespace) bei viduje esančių tarpų grupes keičia vienu tarpu, ir grąžina gautą rezultatą

## Unikalumo tikrinimas

Sakykime, atributą **id** galima rašyti bet kurioje dokumento žymėje. Kaip patikrinti, ar visame dokumente visų šių atributų reikšmės unikalios?

> **Pagalba**: jei operacijos `=` abu operandai yra mazgų aibės, tai ji padaro tų aibių Dekarto sandaugą ir lygina kiekvieną porą atskirai. Jei bent vienai porai būna lygu, tai ir atsakymas _true_.

## Atsakymas

- Kyla noras parašyti taip (kairėje ir dešinėje visų dokumento atributų **id** aibės):

```xml
//@id = //@id
```

- Tačiau čia tas pats atributas kairėje bus palygintas su savimi pačiu dešinėje, ir bus blogai. 
- Išeitis - atsistojus "ant" kažkokios einamosios žymės, pereiti visas kitas žymes, einančias dokumente žemiau jos, ir palyginti jų atributus su jos atributu:

```xml
//*[@id = following::*/@id]
```

- Ši išraiška grąžins žymes, kurių atributas **id** turi reikšmę, pasikartojančią kažkur žemiau dokumente. 


## Atsakymas

Bet čia liko dar viena problemėlė, kad following neima žymių, kurios yra einamosios žymės įpėdiniai, todėl pridedam dar ir descendant:

```xml
//*[@id = following::*/@id or @id=descendant::*/@id]
```

## Didžiausio/mažiausio paieška

- Rasti mažiausią knygos kainą

```xml
//knyga[kaina < //knyga/kaina]
```

- Deja neveikia – operatorius `<` grąžina, ar _kaina_ yra mažesnė už **bent vieną kitą kainą**, o mums reikia, kad būtų mažesnė už **visas kitas**
- Rasti kainą, kuri **nėra didesnė nė už vieną kitą kainą**:

```xml
//knyga[not(kaina > //knyga/kaina)]
```