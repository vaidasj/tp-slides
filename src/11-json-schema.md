# JSON Schema

Interneto technologijos

## Specifikacija

- Oficialaus standarto nėra
- Populiariausia specifikacija: _json-schema.org_
  - JSON Schema (core)
  - JSON Schema Validation
  - JSON Hyper-Schema
- Leidžiama, kaip IETF projektas / šablonas:
  - [draft-wright-json-schema](https://datatracker.ietf.org/doc/draft-wright-json-schema/)
- Aktuali versija: [draft-wright-json-schema-01](https://tools.ietf.org/html/draft-wright-json-schema-01)
  - draft-06 (nustojo galioti 2017 m. spalio 17d.)
- Teiktina versija: [draft-07 (wright-\*-02)](http://json-schema.org/work-in-progress)
  - svarstymas iki 2017 m. lapkričio 20 d.


## JSON Schema

- JSON paremtas formatas apibrėžiantis JSON duomenų struktūrą
- Sukurta remiantis XML Schemos konceptais
- Nėra standartinio plėtinio - siūlomas _.schema.json_
- Pirmoji versija išleista 2010 m.
- Stengiamasi palaikyti versijų _atgalinį_ suderinamumą
- Vizija: tapti IETF darbo grupės patvirtintu standartu
- Įrankiai:
  - Internete: [https://jsonschemalint.com](https://jsonschemalint.com)
  - Kiti: [http://json-schema.org/implementations.html](http://json-schema.org/implementations.html)
  - **Pastaba:** skirtingi įrankiai palaiko skirtingas specifikacijos versijas

## Pavyzdys - JSON

- Objektas _knyga_

```json
{
  "pavadinimas": "Gyvulių Ūkis",
  "isbn": "978-9380070520",
  "kaina": 25.5,
  "autorius": {
    "vardas": "George",
    "pavardė": "Orwell"
  }
}
```

## Pavyzdys - JSON Schema

- Objekto _knyga_ JSON Schema

```json
{
  "type": "object",
  "properties": {
    "pavadinimas": { "type": "string" },
    "isbn": { "type": "string" },
    "kaina": { "type": "number", "minimum": 0 },
    "autorius": {
      "type": "object",
      "properties": {
        "vardas": { "type": "string" },
        "pavardė": { "type": "string" }
      }
    }
  }
}

```

## Duomenų tipai

- Aprašomas naudojant `type`:
  - reikšmė: eilutė arba masyvas
  - masyvas įgalina nurodyti kelis skirtingus tipus
- Baziniai tipai:
  - eilutės: `string`
  - sveiko skaičiaus: `integer`
  - skaičiaus: `number`
  - objekto: `object`
  - masyvo: `array`
  - loginis: `boolean`
  - tuščias: `null`

## Duomenų tipai

- vienas galimas tipas:

```json
"pavadinimas": { "type": "string" },
```

- keli galimi tipai:

```json
"pavadinimas": { "type": ["number", "string"] }
```

> masyve privalo būti nurodyti tik unikalūs elementai

## `string` tipas

- Unicode simbolių seka
- Validatoriai:
  - eilutės ilgio:

  ```json
  { "type": "string", "minLength": 2, "maxLength": 3 }
  ```

  - reguliarios išraiškos

  ```json
  {  "type": "string", "pattern": "^[0-9]{4}$" }
  ```

  - standartiniai formatai: _date-time, email, hostname, ipv4, ipv6, uri_

  ```json
{  "type": "string", "format": "email" }
  ```

## Skaitiniai tipai

- `integer` - sveiki skaičiai
- `number` - sveiki ir slankaus kablelio skaičiai
- Validatoriai:
  - Kartotinio: `multipleOf`
  
  ```json 
  { "type": "number", "multipleOf" : 10 }  
  ```

  - Rėžio: `minimum`, `maximum`, `exclusiveMinimum`, `exclusiveMaximum`

  ```json
  {
    "type": "number",
    "minimum": 0,
    "maximum": 100,
    "exclusiveMaximum": true
  }
  ```

## `object` tipas

- Skirtas JSON objekto struktūrai aprašyti
- `properties`: raktas - reikšmė poros, skirtos savybei aprašyti
- `additionalProperties` - leidžia uždrausti arba aprašyti elgseną neaprašytų savybių atvžilgiu
- Validatoriai:
  - `required` - nurodo privalomas savybės
  - `minProperties` ir `maxProperties` leidžia nurodyti savybių objekte skaičių

  ```json
{ "type": "object",
  "properties": {
    "pavadinimas": { "type": "string" },
    "isbn":        { "type": "string" },
    "kaina":       { "type": "number" }
  },
  "required": ["pavadinimas", "isbn"] }
  ```

## `array` tipas

- Skirtas surikiuotiems sąrašams aprašyti
- `items` raktažodis aprašo sąrašo elementų ribojimus
- `additionalItems`  kontroliuoja neaprašytų elementų validaciją
- `minItems` ir `maxItems` kontroliuoja elementų sąraše skaičių
- `uniqueItems` nurodo elementų sąraše unikalumą

```json
{
  "type": "array",
  "items": {
    "type": "number"
  },
  "minItems": 2,
  "maxItems": 3,
  "uniqueItems": true
}

```

## Enumeracija

- `enum` raktažodis leidžia apriboti galimas elemento reikšmes

```json
{
  "type": "string",
  "enum": ["red", "amber", "green"]
}
```

- Galima _type_ ir nenurodyti

```json
{
  "enum": ["red", "amber", "green", null, 42]
}
```

- Bet negalima pažeisti nurodyto _type_

```json
{
  "type": "string",
  "enum": ["red", "amber", "green", `null`]
}
```

## Schemų apjungimas

## Schemų praplėtimas

## Schemų pakartotinis panaudojimas