# Rekurzivni tipovi podataka

Rekurzivni tipovi podataka su tipovi čije vrednosti mogu sadržati u sebi vrednosti istog tipa.

Ova apstraktna karakterizacija nam ne znači trenutno mnogo. Zbog toga ćemo se u nastavku poredavanja upoznati sa dva najnačajnija rekurzivna tipa, a to *liste* i *stabla*. Kroz primer ova dva tipa, uvidećemo da su rekurzivni tipovi podataka pogodni za predstavljanje vrednosti neograničene složenosti.  
## Lista

Kao što već znamo, u Haskelu lista predstavlja niz (konačan ili beskonačan) vrednosti istog tipa. Sada ćemo uvideti zašto su liste samo još jedan algebarski tip podatka.

Jednostavnosti radi, pokućemo da konstruišemo tip `Lista` koji predstvalja liste s celobrojnim vrednostima (već znamo da je to `[Int]`, ali ignorišimo to za trenutak). Naivna ideja za konstrukciju bi bila da tip `Lista` konstruišemo kao uniju lista različite dužine:

```haskell
data Lista = PraznaLista | Lista1 Int | Lista2 Int Int | Lista3 Int Int Int | Lista4 Int Int Int Int 
```

Odmah uočavamo problem: ovakva definicija je nečitljiva, ali još bitnije, nikad je ne možemo završiti. Koliko god mi konstruktora napravili, uvek će postojati potreba za još dužom listom. Zbog toga moramo iskoristiti rekurzivnu konstrukciju.

Kao što znamo, prosta rekurzija podrazumeva dva dela: prvi deo u kom svodimo problem na sličan problem manje dimenzije, i drugi deo kojim završavamo rekurziju. Zbog toga, i listu konstruišemo kao sumu dva konstruktora: prvim konstruktorom povezujemo listu sa listom manje dužine, dok drugi konstruktor predstavlja praznu listu:

```haskell
data Lista = Dodaj Int Lista | PraznaLista
```

Konstruktorom `Dodaj` dodajemo novi element na *početak* već postojeće liste i time dobijamo novu listu koja je za jedan element duža od prethodne.

Ono što je neobično u gornjoj konstrukciji je to što smo tip `Lista` iskoristili za definisanje samog sebe. Haskel dozvoljava ovakvu konstrukciju, i bez nje ne bismo mogli da konstruišemo rekurzivni tip podataka. 

Sada lako možemo da predstavimo svaku listu. Na primer, listo od tri elementa `1 , 2, 3` možemo ovako konstruisti

```
> x = Dodaj 1 (Dodaj 2 (Dodaj PraznaLista)) 
```

Da bi smo mogli da štampamo vrednosti tipa `Lista` u konzolu, pridružićemo tip `Lista` klasi `Show`:

``` haskell
instance Show Lista where
    show xs = "<" ++ prikazi xs ++ ">"
        where
        prikazi PraznaLista = ""
        prikazi (Dodaj y PraznaLista) = show y
        prikazi (Dodaj y ys) = show y ++ ", " ++ prikazi ys
```

Našu kistu prikazujemo tako što elemente liste navodimo između uglastih zagrada. Za prikazivanje samih elemenata liste koristili smo pomoćnu rekurzivnu funkciju `prikazi`. Sada možemo elegantno prikazivati vrednosti tipa `Lista`:

```
> x = Dodaj 1 (Dodaj 2 (Dodaj PraznaLista)) 
> x
<1, 2, 3>
```

Sada možemo implementirati mnoge funkcije za rad za tipom `Lista`.

Dužinu prazne liste je lako pronaći. Dužina prazne liste je `0`, a dužina liste nastele spajenjem nekog elementa na listu `xs` je za jedan veća od dužine liste `xs`.

```haskell
duzina :: Lista -> Int
duzina PraznaLista = 0
duzina (Dodaj _ xs) = 1 + duzina xs  
```

Pogledajmo kako se redukuje izraz `duzina x` odnosno kako se funkcija `duzina` izvršava:

```
duzina Dodaj 1 (Dodaj 2 (Dodaj PraznaLista)) 
→ 1 + duzina Dodaj 2 (Dodaj PraznaLista)
→ 1 + (1 + duzina Dodaj PraznaLista)
→ 1 + (1 + (1 + duzina PraznaLista))
→ 1 + (1 + (1 + 0))
→ 3
```

Funkcija `spoji` spaja dve liste vršeći rekurziju po prvoj listi.

```haskell
spoji :: Lista -> Lista -> Lista
spoji PraznaLista xs = xs
spoji (Dodaj x xs) ys = Dodaj x (spoji xs ys)
```

Funkcija `obrni` obrće redosled elemenata liste

```haskell
obrni :: Lista -> Lista
obrni [] = []
obrni (Dodaj x xs) =  spoji (obrni xs) x 
```

*Primetimo da rekurzivna funkcija `obrni` koristi u sebi rekurzivnu funkciju `spoji`, zbog čega ova implementacija nije najefikasnija moguća.*

Vidimo da navedene funkcije sa rad sa tipom `Lista` imaju jedan opšti oblik i pritom ne koriste u sebi funkcije koje su isključivo vezane za tip `Int`. Zbog toga ćemo sada predefinisati tip `Lista` kao tipsku funkciju (tipski konstruktor) koja uzima jedan tip. Sada sa našom listom možemo predstaviti listu vrednosti bilo kog tipa.

```haskell
data Lista a = Dodaj a Lista | PraznaLista
```

*U gornjem zapisu `a` je proizvoljan tip. Uzimanjem za `a` tip `Int` dobijamo definicju liste od malopre.*

Definicje funkcija `duzina`, `spoji`, `obrni` ostaju u potpunosti iste ali im se tipovi menjaju

```haskell
duzina :: Lista a -> Int
```

```haskell
spoji :: Lista a -> Lista a -> Lista a
```

```haskell
obrni :: Lista a -> Lista a
```

### Liste u Haskelu

U Haskelu liste su umplementirane upravo onako kako smo i mi to gore uradili. Preciznije:

```haskell
data [] a = [] | a : [] a 
```

Ovim je definisana jedna tipska funkcija `[]` kao i konstruktor prazne liste `[]`. Drugi konstruktor koji je definisan, je konstuktor "dodavanja", i njegove ime je `:`. Kako se ime `:` sastoji od specijalnog znaka, a ne slova, on je infiksni konstruktor, te se nalazi između svoja dva argumenta.

Haskell kompajler dozvoljava da se tip `[] a` zapisuje kao `[a]`. Ovo značajno poboljšava čitljivost tipova.

Funkcije `duzina`, `spoji` i `obrni` su definisane za Haskel liste pod imenima `length`, `(++)` i `reverse`.

### Filter

### Map

### Zip

### Fold

## Binarno stablo



## Zadaci

1. Napraviti tip `AritmetickiIzraz` koji predstavlja aritmetičke izraze sačinjenje od celobrojnih vrednosti i operacija sabiranja i množenja. Uvesti tip `AritmetickiIzraz` u `Show` klasu tipova tj. implementirati `show :: AritmetickiIzraz -> String`. Implementirati funkciju `izracunajAritmeticki :: AritmetickiIzraz -> Int` koja izračunava zadati aritmetički izraz. [*Rešenje*](./aritmeticki_izrazi.hs)
2. Analogno prethodnom zadatku kreirati program koji izračunava logičke izraze. Preciznije: Napraviti tip `LogickiIzraz` koji predstavlja aritmetičke izraze sačinjenje od logičkih vrednosti i operacija konjunkcije i disjunkcije. Uvesti tip `LogickiIzraz` u `Show` klasu tipova tj. implementirati `show :: LogickiIzraz -> String`. Implementirati funkciju `izracunajLogicki :: LogickiIzraz -> Bool` koja izračunava zadati aritmetički izraz. [*Rešenje*](./logički_izrazi.hs)
3. *Za ovaj zadatak je neophodno uraditi oba prethodna zadatka.* Neka je data funkicja `f :: Int -> Bool` sa `f x = if x \=0 then True else False`. Konstruistai funkciju `konvertuj :: AritmetickiIzraz -> LogickiIzraz` koja logički izraz prevodi u aritmetički izraz tako što sabiranje prevodi u disjunkciju, množenje u konjunkciju a brojeve u skladu sa datom funkcijom `f`. Na primer izraz `2 * (7 + 0)` se konvertuje u `⊤ ∧ (⊤ ∨ ⊥)`, a izraz `(-2) * 3 + 2 * 0` u `⊤ ∧ ⊤ ∨ ⊤ ∧ ⊥`. Da li važi `f . izracunajAritmeticki = izracunajLogicki . konvertuj`?
4. Napraviti tip `Izraz` koji prezentuje izraz sačinjen od ralnih brojeva, nepoznate `x`, sabiranja, oduzimanja, množenja, deljenja, stepenovanja, sinusa, kosinusa, eksponencijalne i logaritamske funkcije. Konstruistai funkciju `izvod :: Izraz -> Izraz` koja pronalazi izvod izraza. Konstruistai funkciju `simplify` koja pojednostavljuje izraz koristeći razne matematičke identitete (npr. `a + 0 = a` za svaki izraz `a`). [*Rešenje*](./izvodi.hs)