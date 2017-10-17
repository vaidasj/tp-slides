# XML Schema: Ribojimai

Interneto technologijos

## Ribojimai XML dokumentuose

- Kartais XML dokumentuose turi galioti ribojimai, pvz., jei turime knygų sąrašą, tai visų knygų ISBN kodai turi būti unikalūs
  - t.y., draudžiama sąraše turėti dvi knygas vienodais ISBN kodais
- Apibrėžiant unikalumo ribojimą, svarbu nurodyti unikalumo kontekstą, t.y., sritį, kurioje turi galioti unikalumo ribojimas
- Už konteksto ribų unikalumo ribojimas nebegalioja

## XML dokumento pavyzdys

```xml
<knygųSąrašas>
    <grupė pav="grožinė">
        <knyga isbn="0-596-00252-1">
            <autorius>...</autorius>
        </knyga>
    </grupė>
    <grupė pav="mokslinė">
        <knyga isbn="0-926-13928-3">
            <autorius>...</autorius>
        </knyga>
    </grupė>
</knygųSąrašas>
```


- Žymės _knygųSąrašas_ ir _grupė_ yra du potencialūs kontekstai, kuriuose galima pareikalauti knygų unikalumo.
- Jei kontekstas bus _grupė_, tai unikalumas galios tik grupės viduje, t.y., bus galima dviejose grupėse turėti tą pačią knygą.

## Unikalumo ribojimo pavyzdys

- Rašomas kelias, kaip nuo žymės _knygųSąrašas_ nueiti iki žymės _knyga_
- Kontekstu tampa ta žymė, kurios viduje paskelbiam žymę `unique`

- Kontekstas _grupė_:

```xml
<xs:element name="`grupė`" type="GrupėsTipas">
    <xs:`unique` name="GrupėsRibojimas">
       <xs:selector xpath="knyga"/>
       <xs:field xpath="@isbn"/>
    </xs:unique>
</xs:element>
```

## Unikalumo ribojimo pavyzdys

- Kontekstas _knygųSąrašas_:

```xml
<xs:element name="`knygųSąrašas`" type="SąrašoTipas">
    <xs:`unique` name="VisoSąrašoRibojimas">
       <xs:selector xpath="grupė/knyga"/>
       <xs:field xpath="@isbn"/>
    </xs:unique>
</xs:element>
```

- Žymė `xs:selector` konteksto viduje išrenka žymes, kurios turės būti unikalios
- Žymė `xs:field` nusako, pagal kokį žymės lauką (t.y., atributą arba vidinę žymę) bus tikrinamas unikalumas
- Jei unikalumas apibrėžiamas ne pagal vieną atributą/žymę, o pagal kelis, galima rašyti kelias `xs:field` žymes
- Pvz.: autoriaus unikalumas gali būti tikrinamas pagal vardą ir pavardę

## Pavyzdys – keli xs:field

- Kontekstas _knygųSąrašas_:

```xml
<xs:element name="`knygųSąrašas`" type="...>
    <xs:unique name="KnygųRibojimas">
        <xs:selector xpath="`grupė/knyga`"/>
        <xs:field xpath="`autorius/vardas`"/>
        <xs:field xpath="`autorius/pavarde`"/>
    </xs:unique>
</xs:element>
```

- Kas turi būti unikalu? 
  - **knyga**
- Kada dvi knygos bus laikomos vienodomis?
  - sutampa **vardas** ir **pavardė**
- Kur turi būti unikalu?
  - elemento **knygųSąrašas** viduje

## Raktai

- `xs:unique` leidžia žymei/atributui turėti ir tuščią reikšmę
    - Pvz.: mūsų pavyzdyje knygai nebūtina nurodyti _isbn_ atributą (nebent atributui nurodyta `use="required"`)
- Jei norime, kad unikalumą apibrėžiantys atributai/žymės visada būtų nurodomi (t.y. – privalomi), vietoj `xs:unique` turime naudoti `xs:key`

```xml
<xs:element name="knygųSąrašas" type="SąrašoTipas">
    <xs: key name="KnygosRaktas">
        <xs:selector xpath="grupė/knyga"/>
        <xs:field xpath="@isbn"/>
    </xs:key>
</xs:element>
```

- Šiuo atveju visos knygos privalo turėti netuščią atributą isbn, kurio reikšmės privalo būti unikalios viso knygų sąrašo viduje

## Nuorodos į raktus

- Kartais XML dokumentų vienose žymėse norime duoti nuorodas į kitas žymes

- Pvz.:

```xml
<pirktaKnyga isbnKodas="0-926-13928-3"/>
```

- Norime pareikalauti, kad pirktos knygos ISBN kodas būtų lygus vienam iš knygų sąrašo knygų kodų
- Mums reikia, kad žymės **pirktaKnyga** atributo **isbnKodas** tipas būtų nuoroda į raktą **KnygosRaktas**

## Nuorodos į raktą pavyzdys

```xml
<knygųSąrašas>
    <knyga isbn="0-596-00252-1">
       <autorius>...</autorius>
    </knyga>
    <knyga isbn="0-473-84756-7">
       <autorius>...</autorius>
    </knyga>
    <knyga isbn="0-926-13928-1">
       <autorius>...</autorius>
    </knyga>
    <knyga isbn="0-926-13928-3">
       <autorius>...</autorius>
    </knyga>
    <pirktaKnyga isbnKodas="0-926-13928-3" />
</knygųSąrašas>
```

## Nuorodos į raktą pavyzdys

```xml
<xs:element name="knygųSąrašas" type="SąrašoTipas">
    <xs:key name="KnygosRaktas">
        <xs:selector xpath="knyga"/>
        <xs:field xpath="@isbn"/>
    </xs:key>
    <xs: keyref name="NuorodaĮKnygą" refer="`KnygosRaktas`">
        <xs:selector xpath="`pirktaKnyga`"/>
        <xs:field xpath="@isbnKodas"/>
    </xs:keyref>
</xs:element>
```

- Rakto, į kurį bus nuoroda, pavadinimas: **KnygosRaktas**
- Kelias nuo _knygųSąrašas_ iki _pirktaKnyga_: **pirktaKnyga**

## Pastabos

- Nuorodos gali rodyti ne tik į `xs:key`, bet ir į `xs:unique` apibrėžtas žymes
- `xs:keyref` žymę reikia paskelbti
    - arba toje pačioje žymėje, kaip ir `xs:key` / `xs:unique`
    - arba tos žymės tėvinėje/senelio/... žymėje

## Pastabos dėl vardų sričių

- Jei XML dokumentas naudoja vardų sritis, tai XML Schema dokumente visos XPath išraiškos privalo naudoti žymių vardus su prefiksais!
- Vardų sritis pagal nutylėjimą XPath išraiškų vidaus nepasiekia!

```xml
<xs:schema
    xmlns="http://kuku.lt"
    xmlns:p="http://kuku.lt">
    <xs:element name="knygųSąrašas" type="STipas">
        <xs:key name="KnygosRaktas">
            <xs:selector xpath="p:grupė/p:knyga"/>
            <xs:field xpath="@isbn"/>
        </xs:key>
    </xs:element>
</xs:schema>
```