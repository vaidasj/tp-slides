# XML Schema: Sudėtingi tipai

Interneto technologijos

## Turinio rūšys, XML Schema tipai

|                            | Mišrus | Sudėtingas | Paprastas | Tuščias |
|----------------------------|--------|------------|-----------|---------|
| Gali turėti vaikinių žymių | Taip   | Taip       | Ne        | Ne      |
| Gali turėti tekstą         | Taip   | Ne         | Taip      | Ne      |

- XML Schema turi dvi tipų rūšis :
  - **Paprasti tipai** (_simple types_): naudojami paprasto (be atributų) ir tuščio turinio žymių/atributų tipų apibrėžimui. Nusako teksto fragmento formatą
  - **Sudėtingi tipai** (_complex types_): gali būti naudojami visų rūšių turinių apibrėžimui
- Nepainiokite sudėtingo turinio su sudėtingu tipu!

## Sudėtingi tipai

- Sudėtingo tipo deklaracija susideda iš:
    - atributų deklaracijų (nebūtina)
    - turinio rūšies deklaracijos (būtina)
- **Pastaba:** Paprasti tipai negali apibrėžti atributų, t.y., jei žymei priskirtas paprastas tipas, tai joje negali būti jokių atributų. Jei reikia bent vieno atributo, reikia skelbti sudėtingą tipą

Kiekviena sudėtingo tipo deklaracija yra:
- arba kito sudėtingo tipo apribojimas
- arba praplėtimas:
  - paprasto tipo
  - sudėtingo tipo

## Išvedimo būdai

![Tipų su paprastu turiniu išvedimo būdai](images/xml-schema-1.png "Tipų su paprastu turiniu išvedimo būdai")

## Sudėtingo tipo struktūra

```xml
<complexType
  name = NCName
  mixed = boolean : false>

  Content: simpleContent | complexContent

</complexType>
```

## Sudėtingo tipo turinio rūšies deklaracija

- Žymių/atributų turinio rūšys:

| Mišrus | Sudėtingas | Paprastas | Tuščias |
|-------|------------|-----------|---------|
| `complexContent` ir atributas `mixed=true`   | `complexContent`       | `simpleContent`        | `complexContent`, `simpleContent`      |

- Visi šie variantai bus aptariami toliau skaidrėse:
  - Paprastas
  - Sudėtingas
  - Mišrus
  - Tuščias

## Paprasto turinio struktūra

```xml
<simpleContent>
  Content: (annotation?, (restriction | extension))
</simpleContent>

<restriction base = `QName`>
  Content: ( annotation?, 
  	( `simpleType`?,
		( minExclusive | minInclusive | maxExclusive | 
			maxInclusive | totalDigits | fractionDigits | 
			length | minLength | maxLength | enumeration | 
			whiteSpace | pattern)*
		)?,
    (attribute | attributeGroup)*
)	
</restriction>

<extension base = `QName`>
  Content: (`attribute | attributeGroup`)*
</extension>
```

## Paprasto turinio struktūra 

Apribojant:
- Bazinis tipas gali būti arba sudėtingas tipas su paprastu turiniu, arba su sudėtingu turiniu ir sąlyga _minOccurs=0_
- Jei bazinis tipas neturi paprasto tipo (pvz., `anyType` neturi), tai `simpleType` privalomas

Praplečiant:
- Bazinis tipas gali būti paprastas tipas arba sudėtingas tipas su paprastu turiniu
- Praplėtimu galima pridėti naujų atributų (**ir nieko daugiau**)

## Praplėtimo pavyzdžiai

Sukuriame tipą "tekstasSuKalba" su atributu:

```xml
<xs:complexType name="tekstasSuKalba">
    <xs:simpleContent>
       <xs:extension base="`xs:string`">
          <xs:attribute name="kalba" type="xs:language"/>
       </xs:extension>
    </xs:simpleContent>
</xs:complexType>
```

## Praplėtimo pavyzdžiai

Tipą "tekstasSuKalba" praplečiame dar vienu atributu:

```xml
<xs:complexType name="tekstasSuKalbaIrData">
    <xs:simpleContent>
       <xs:extension base="`tekstasSuKalba`">
          <xs:attribute name="data" type="xs:date"/>
       </xs:extension>
    </xs:simpleContent>
</xs:complexType>
```

## Apribojimo pavyzdžiai

Apribokime tipo "tekstasSuKalbaIrData" teksto ilgį iki 255 simbolių:

```xml
<xs:complexType name="apribotoIlgioTekstas">
	<xs:simpleContent>
		<xs:restriction base="tekstasSuKalbaIrData">
			<xs:maxLength value="`255`"/>
		</xs:restriction>
	</xs:simpleContent>
</xs:complexType>
```

## Atributų uždraudimas

Jei norime uždrausti bazinio tipo atributą, naudojame `use="prohibited"`:

```xml
<xs:complexType name="PastabaTipas">
	<xs:simpleContent>
		<xs:restriction base="tekstasSuKalbaIrData">
			<xs:attribute name="data" use="`prohibited`"/>
		</xs:restriction>
	</xs:simpleContent>
</xs:complexType>
```

## Atributo tipo apribojimas

Tipų apribojimas bus ir tokiu atveju, jei apribosime atributo turinio tipą:

```xml
<xs:complexType name="NaujasTipas">
	<xs:simpleContent>
		<xs:restriction base="tekstasSuKalba">
			<xs:attribute name="`kalba`">
				<xs:simpleType>
					<xs:restriction base="xs:language">
						<xs:enumeration value="en"/>
						<xs:enumeration value="lt"/>
					</xs:restriction>
				</xs:simpleType>
			</xs:attribute>
		</xs:restriction>
	</xs:simpleContent>
</xs:complexType>
```

## Paprasto turinio apibendrinimas

- Naujų sudėtingų tipų su paprastu turiniu išvedimas:
    - _praplėtimu_ gali pridėti naujus atributus (žymių/atributų tipų keisti negali)
    - _apribojimu_ gali apriboti žymės/atributo tipą
    - _apribojimu_ taip pat gali uždrausti bazinio tipo atributų naudojimą

## Tipų išvedimo būdai

![Tipų išvedimo būdai](images/xml-schema-2.png "Tipų išvedimo būdai")

## Apribojimo principas

- **Apribotas tipas negali prieštarauti baziniam tipui**
    - T.y., visi žymių/atributų turiniai, kurie atitinka apribotą tipą, turi atitikti ir bazinį tipą
- Taip apriboti tipo negalima:

```xml
<xs:simpleType name="keistasSkaicius">
	<xs:restriction base="xs:integer">
		<xs:pattern value="`[a-c]{5}`"/>
	</xs:restriction>
</xs:simpleType>
```

## Apribojimo principo pavyzdys

```xml
<xs:complexType name="tekstasSuAtributais">
	<xs:simpleContent>
		<xs:extension base="xs:string">
			<xs:attribute name= "kalba" type="xs:language"/>
			<xs:attribute name= "pastaba" type="xs:string" 
			              use="`required`" />
		</xs:extension>
	</xs:simpleContent>
</xs:complexType>
```

## Apribojimo principo pavyzdys

```xml
<xs:complexType name="tekstasBeAtributu">
    <xs:simpleContent>
       <xs:restriction base="tekstasSuAtributais">
          <xs:attribute name="kalba" use="prohibited"/>
          <xs:attribute name="pastaba" `use="prohibited"`/>
       </xs:restriction>
    </xs:simpleContent>
</xs:complexType>
```

- Negalima uždrausti naudoti atributą *pastaba*
- Atributą *kalba* – galima, nes `use` reikšmė pagal nutylėjimą yra `optional`

## Pavyzdys

- Tarkime, turime paprastą tipą *Pavadinimas*:

```xml
<xs:simpleType name="PavadinimoTipas">
	<xs:restriction base="xs:string">
		<xs:maxLength value="30" />
	</xs:restriction>
</xs:simpleType>
```

- Norime jam:
    - pridėti atributą (praplėtimas – _extension_). Rezultate gausime sudėtingą tipą su paprastu turiniu
    - nurodyti apribojimą (_restriction_) – minimalų pavadinimo ilgį padaryti 10

## Pavyzdys

- Kadangi reikia ir praplėtimo, ir apribojimo, tai vienu "žingsniu" mes to nepadarysime
- Pirmu žingsniu reikia sukurti tarpinį tipą, kuris mūsų tipą _Pavadinimas_ **praplės** atributu
- Antru žingsniu šį tarpinį tipą apribosime, nurodydami **ribojimą** jo turiniui

> Negalima apribojimo būdu iš paprasto tipo sukurti sudėtingą tipą - "mažindami" mažą didesnio gauti negalime

## Pavyzdys

- Tarpinis tipas:

```xml
<xs:complexType name="PavadinimasSuAtributu">
	<xs:simpleContent>
		<xs:extension base="`PavadinimoTipas`">
			<xs:attribute name="kalba" type="xs:language" />
		</xs:extension>
	</xs:simpleContent>
</xs:complexType>
```

- Galutinis tipas:

```xml
<xs:complexType name="ApribotasPavSuAtributu">
	<xs:simpleContent>
		<xs:restriction base="`PavadinimasSuAtributu`">
			<xs:minLength value="10" />
		</xs:restriction>
	</xs:simpleContent>
</xs:complexType>
```

## Sudėtingo turinio struktūra

Skirtas aprašyti vaikinių žymių eiliškumui

```xml
<complexContent mixed = boolean>
Content: (annotation?, (restriction | extension))
</complexContent>

<restriction base = QName>
Content: (
annotation?,
(all | choice | sequence | group)?,
( (attribute | attributeGroup)* ) )
</restriction>

<extension base = QName>
Content: (
annotation?,
(all | choice | sequence | group)?,
( (attribute | attributeGroup)* ) )
</extension>
```

## Sudėtingo turinio struktūra

```xml
<all
maxOccurs = 1 : 1
minOccurs = (0 | 1) : 1>
Content: (annotation?, element*)
</all>

<choice
maxOccurs = (nonNegativeInteger | unbounded) : 1
minOccurs = nonNegativeInteger : 1>
Content: (annotation?, (element|choice|sequence)*)
</choice>

<sequence
maxOccurs = (nonNegativeInteger | unbounded) : 1
minOccurs = nonNegativeInteger : 1>
Content: (annotation?, (element|choice|sequence)*)
</sequence>
```

## Pavyzdys

```xml
<xs:element name="author">
	<xs:complexType>
		<xs:sequence>
			<xs:element ref="name"/>
			<xs:element ref="born"/>
			<xs:element ref="dead" minOccurs="0"/>
		</xs:sequence>
		<xs:attribute ref="id"/>
	</xs:complexType>
</xs:element>
```

- Jei nei `simpleContent`, nei `complexContent` nenurodytas, tai laikoma, kad buvo nurodyta `complexContent` su bazinio tipo `anyType` apribojimu

## Pavyzdys

```xml
<xs:complexType name="ttt">
	<xs:sequence `minOccurs="2"` `maxOccurs="3"` >
		<xs:element ref="a" minOccurs="2" maxOccurs="3"/>
		<xs:choice>
			<xs:sequence>
				<xs:element ref="b"/>
				<xs:element ref="c"/>
			</xs:sequence>
			<xs:element ref="d"/>
		</xs:choice>
		<xs:element ref="e"/>
		<xs:element ref="f"/>
	</xs:sequence>
</xs:complexType>
```

- _choice_ ir _sequence_ žymėms galima pasakyti, kiek kartų jos turi būti pakartotos dokumente 
- _choice_ ir _sequence_ viduje galima naudoti ir kitas _choice_ bei _sequence_ žymes

## Pastabos apie xs:all

- **xs:all** viduje galima naudoti tik **xs:element** su atributais `minOccurs=0 arba 1`, `maxOccurs=1`
- Taip negalima:

```xml
<xs:complexType name="Rinkinys">
 <xs:all>
   <xs:element ref="a" minOccurs="0" `maxOccurs="unbounded"` />
   <xs:element ref="b" minOccurs="0" `maxOccurs="unbounded"` />
 </xs:all>
</xs:complexType>
```

- Bet galima taip:

```xml
<xs:complexType name="Rinkinys">
    <xs:choice minOccurs="0" maxOccurs="unbounded">
       <xs:element ref="a"/>
       <xs:element ref="b"/>
    </xs:choice>
</xs:complexType>
```

## Dviprasmiško turinio taisyklė

- Schema procesorius, atlikdamas žymės validavimą, ir žiūrėdamas tik į tą žymę, niekada neturi dvejoti, kokioje schema šakoje jis yra

```xml
<xs:complexType name="name">
	<xs:choice>
		<xs:sequence>
			<xs:element ref="name"/>
			<xs:element ref="nick-name"/>
		</xs:sequence>
		<xs:sequence>
			<xs:element ref="name"/>
			<xs:element ref="middle-name" minOccurs="0"/>
			<xs:element ref="last-name"/>
		</xs:sequence>
	</xs:choice>
</xs:complexType>
```

- Kai sutiksim žymę _name_, nežinosim, ar po jos privalo eiti _nick-name_, ar _middle-name_

## Neprieštaringo deklaravimo taisyklė

- Draudžiama deklaruoti dvi žymes vienodais pavadinimais ir skirtingais tipais

```xml
<xs:choice>
  <xs:element name="`name`" type="xs:string"/>
  <xs:element name="`name`" type="Autorius"/>
</xs:choice>
```

- Tačiau deklaruoti dvi žymes vienodais pavadinimais ir skirtingais tipais galima, jei jos yra **skirtingų** žymių vaikinės žymės

## Naujų sudėtingo turinio tipų išvedimas praplėtimu

```xml
<xs:complexType name="Person">
	<xs:sequence>
		<xs:element ref="name"/>
		<xs:element ref="born"/>
	</xs:sequence>
</xs:complexType>
```

- Pridedame naują žymę (**pridėjimas galimas tik į pabaigą**):

```xml
<xs:complexType name="Author">
	<xs:complexContent>
		<xs:extension base="Person">
			<xs:sequence>
				<xs:element ref="dead" minOccurs="0"/>
			</xs:sequence>
		</xs:extension>
	</xs:complexContent>
</xs:complexType>
```

## Naujų sudėtingo turinio tipų išvedimas apribojimu

```xml
<xs:complexType name="person">
	<xs:sequence>
		<xs:element ref="name"/>
		<xs:element ref="dead" minOccurs="0"/>
		<xs:element ref="qualification" minOccurs="0"/>
	</xs:sequence>
</xs:complexType>
```

## Naujų sudėtingo turinio tipų išvedimas apribojimu

- Uždraudžiam žymę _qualification_, žymę _dead_ padarome privaloma:

```xml
<xs:complexType name="author">
	<xs:complexContent>
		<xs:restriction base="person">
			<xs:sequence>
				<xs:element ref="name"/>
				<xs:element ref="dead"/>
			</xs:sequence>
		</xs:restriction>
	</xs:complexContent>
</xs:complexType>
```

> Negalima pažeisti apribojimo principo!

## Tipų išvedimo būdai

![Tipų išvedimo būdai](images/xml-schema-2.png "Tipų išvedimo būdai")


## Pavyzdys: XML dokumentas

```xml
<?xml version="1.0" encoding="UTF-8"?>
<užsakymas data="2006- 02 - 28">
	<pristatyti šalis="LT">
		<vardas>Jonas Jonaitis</vardas>
		<gatvė>Kalvarijų 5</gatvė>
		<miestas>Vilnius</miestas>
		<indeksas>LT-13952</indeksas>
	</pristatyti>
	<apmoka šalis="LT">
		<vardas>Petras Petraitis</vardas>
		<gatvė>Pylimo 2</gatvė>
		<miestas>Vilnius</miestas>
		<indeksas>LT-13434</indeksas>
	</apmoka>
	<pastaba kalba="lt">Dūžtanti prekė</pastaba>
	<prekiųSąrašas>...</prekiųSąrašas>
</užsakymas>
```

## Pavyzdys: XML Schema

```xml
<?xml version="1.0" encoding="UTF-8"?>
<xs:schema
	xmlns:xs="http://www.w3.org/2001/XMLSchema">
	<xs:element name="užsakymas" type="UžsakymoTipas" />
	<xs:complexType name="`UžsakymoTipas`">
		<xs:sequence>
			<xs:element name="pristatyti" type="AdresoTipas" />
			<xs:element name="apmoka" type="AdresoTipas" />
			<xs:element name="pastaba" type="PastabosTipas" 
			            minOccurs="0" />
			<xs:element name="prekiųSąrašas" type="..." />
		</xs:sequence>
		<xs:attribute name="data" type="xs:date" />
	</xs:complexType>
```

## Pavyzdys: XML Schema

```xml
<xs:complexType name="`AdresoTipas`">
	<xs:sequence>
		<xs:element name="vardas" type="xs:string"/>
		<xs:element name="pavardė" type="xs:string"/>
		<xs:element name="miestas" type="xs:string"/>
		<xs:element name="indeksas" type="xs:decimal"/>
	</xs:sequence>
	<xs:attribute name="šalis" type="xs:NMTOKEN" fixed="LT"/>
</xs:complexType>
<xs:complexType name="`PastabosTipas`">
	<xs:simpleContent>
		<xs:extension base="xs:string">
			<xs:attribute name="kalba" type="xs:language"/>
		</xs:extension>
	</xs:simpleContent>
</xs:complexType>
</xs:schema>
```

## Tuščias turinys

- Tuščio turinio pavyzdys (per sudėtingą tipą su sudėtingu turiniu):

```xml
<xs:element name="book">
	<xs:complexType>
		<xs:attribute name="isbn" type="isbnType"/>
	</xs:complexType>
</xs:element>
```

- Žymės _book_ viduje gali būti tik atributas. Kitos žymės ir tekstas – draudžiami.

## Mišrus turinys

```xml
<xs:element name="book">
	<xs:complexType `mixed="true"` >
		<xs:all>
			<xs:element name="title" type="xs:string"/>
			<xs:element name="author" type="xs:string"/>
		</xs:all>
		<xs:attribute name="isbn" type="xs:string"/>
	</xs:complexType>
</xs:element>
```

- Šią schemą atitinkantis XML fragmentas:

```xml
<book isbn="0836217462">
Funny book by 
	<author> Charles M. Schulz </author>.
Its title 
	<title> Being a Dog Is a Full-Time
Job </title> says it all!
</book>
```

## Mišrus turinys

- Čia ne mišrus, o sudėtingas turinys (žymė kažkas tekstinių vaikų neturi! Turi tik vaikines žymes)

```xml
<kažkas>
	<aaa>kva</aaa>
	<bbb>miau</bbb>
</kažkas>
```

- O čia – mišrus (turi ir vaikines žymes, ir vaikinį tekstinį mazgą "kuku")

```xml
<kažkas>
	<aaa>kva</aaa>
	<bbb>miau</bbb>
kuku
</kažkas>
```

## Žodynėlis

- Žymė - element
- Paprastas turinys – simple content
- Sudėtingas turinys – complex content
- Paprastas tipas – simple type
- Sudėtingas tipas – complex type
- Apribojimas – restriction
- Išplėtimas – extension