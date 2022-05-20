# Rekurzivni tipovi podataka

Rekurzivni tipovi podataka su tipovi čije vrednosti mogu sadržati u sebi vrednosti istog tipa.

Ova apstraktna karakterizacija nam ne znači trenutno mnogo. Zbog toga ćemo se u nastavku poredavanja upoznati sa dva najnačajnija rekurzivna tipa, a to *liste* i *stabla*. Kroz primer ova dva tipa, uvidećemo da su rekurzivni tipovi podataka pogodni za predstavljanje vrednosti neograničene složenosti.  

## Lista

Kao što već znamo, u Haskelu lista predstavlja niz (konačan ili beskonačan) vrednosti istog tipa. Sada ćemo uvideti zašto su liste samo još jedan algebarski tip podatka.

Jednostavnosti radi, pokućemo da konstruišemo tip `Lista` koji predstvalja liste s celobrojnim vrednostima (već znamo da je to `[Int]`, ali ignorišimo to za trenutak). Naivna ideja za konstrukciju bi bila da tip `Lista` konstruišemo kao uniju lista različite dužine:

```haskell
data Lista = PraznaLista | Lista1 Int | Lista2 Int Int | Lista3 Int Int Int | Lista4 Int Int Int Int 
```

Odmah uočavamo problem: s ovakvom definicijom nikad je ne možemo obuhvatiti sve liste. Koliko god mi konstruktora napravili, uvek će postojati potreba za još dužom listom. Zbog toga moramo iskoristiti rekurzivnu konstrukciju.

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

Našu listu prikazujemo tako što elemente liste navodimo između uglastih zagrada. Za prikazivanje samih elemenata liste koristili smo pomoćnu rekurzivnu funkciju `prikazi`. Sada možemo elegantno prikazivati vrednosti tipa `Lista` u interakticnom okruženju:

```
> x = Dodaj 1 (Dodaj 2 (Dodaj PraznaLista)) 
> x
<1, 2, 3>
```

Sada možemo implementirati mnoge funkcije za rad za tipom `Lista`. Kako je i sama priroda tipa `Lista` rekurzivna, i ove funkcije će biti (uglavnom) rekurzivne.

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

*Primetimo da rekurzivna funkcija `obrni` koristi u sebi drugu rekurzivnu funkciju `spoji`, zbog čega ova implementacija nije najefikasnija moguća.*

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

U Haskelu liste su implementirane upravo onako kako smo i mi to gore uradili. Preciznije:

```haskell
data [] a = [] | a : [] a 
```

Ovim je definisana jedna tipska funkcija `[]` kao i konstruktor prazne liste `[]`. Drugi konstruktor koji je definisan, je konstuktor "dodavanja", i njegove ime je `:`. Kako se ime `:` sastoji od specijalnog znaka, a ne slova, on je infiksni konstruktor, te se nalazi između svoja dva argumenta.

Haskell kompajler dozvoljava da se tip `[] a` zapisuje kao `[a]`. Ovaj izuzetak u Haskell sintaksi značajno poboljšava čitljivost tipova.

Funkcije `duzina`, `spoji` i `obrni` su definisane za Haskel liste pod imenima `length`, `(++)` i `reverse`. 

U nastavku ćemo se upoznati sa još nekim funkcijama koje se često koriste prilikom rada sa listama.

### Filter

Funkcija višeg reda `filter` nam omogućuje da iz nekog niza izdvojimo samo elemente koji zadovoljavaju neki uslov. Tip ove funkcije je

```haskell
filter :: (a -> Bool) -> [a] -> [a]
```

Prvi argument funkcije je funkcija tipa `a -> Bool`. Ova funkcija treba da vrati vrednost `True` ako element treba da ostane u listi, odnosno `False` ako je element potrebno ukloniti iz liste. Drugi argument funkcije je lista koju filtriramo. Rezultat je prosleđena lista iz koje su uklonjeni elementi koji ne zadovoljavaju predikat.

Na primer, ako želimo da "uzmemo" samo parne projeve iz liste `[1, 2, 3, 4, 5, 6, 7, 8, 9, 10]` možemo napisati naredni program:

```
> filter (\x -> mod x 2 == 0) [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
[2, 4, ,6 , 8, 10]
```

*Neka su `p` i `q` dve funkcije tipa `a -> Bool`. Zašto su `filter p . filter q` i `filter (\x -> p x && q x)` iste funkcije?*

### Map

Još jedna funkcija višeg reda koja se često koristi sa listama je `map`. Funkcija `map` primenjuje neku drugu funkciju na svaki element niza i vraća niz dobijenih vrednosti. Tip funkcije `map` je:

```haskell
map :: (a -> b) -> [a] -> [b]
```

Prvi argument funkcije je funkcija tipa `a -> b`, a drugi argument je niz tipa `[a]`. Rezultat je niz tipa `[b]` koji je nastao od prosleđenog niza primenom prosleđene funkcije na svaki element niza.

Na primer, ako želimo da kvadriramo svaki element niza `[1, 2, 3, 4]`, možemo napisati program 

```haskell
> map (\x -> x ** 2) [1, 2, 3, 4]
[1, 4, 9, 16]
```

*Neka je `f :: a -> b` i `g :: b -> c`. Zašto su `map g . map f` i `map (g . f)` iste funkcije?*

### Zip

Zip je funkcija koja od dva niza pravi novi niz kojeg čine uređeni parovi elemenata iz prva dva niza. Pridruživanje se vrši redosledom kojim su elementi navedeni u nizu. Tip funkcije `zip` je:

```haskell
zip :: [a] -> [b] -> [(a, b)]
```

Funkciju `zip` ćemo demonstrirati na konkretnom primeru:

```
> zip [1, 2, 3, 4] ['a', 'b', 'c'] 
[(1,'a'),(2,'b'),(3,'c')]
```

Primetimo da je povratni niz iste dužine kao i kraći od prosleđenih nizova.

## Binarno stablo



## Zadaci

1. Svi prirodni brojevi manji od 10 koji su deljivi sa 3 ili 5 su 3, 5, 6 i 9. Njihov zbir je 23. Naći zbir svih prirodnih brojeva manjih od 100 koji su deljivi sa 3 ili 5.
2. Palindromski broj je prirodan broj koji se čita isto i sa leva i sa desna. Najveći palindromski broj koji je proizvod dva dvocifrena broja je 9009 (jer je 9009 = 91 x 99). Naći najveći palindromski broj koji je proizvod dva trocifrena broja.
3. Implementirati `filter`, `map`, `zip` i `fold`.
3. Napraviti tip `AritmetickiIzraz` koji predstavlja aritmetičke izraze sačinjenje od celobrojnih vrednosti i operacija sabiranja i množenja. Uvesti tip `AritmetickiIzraz` u `Show` klasu tipova tj. implementirati `show :: AritmetickiIzraz -> String`. Implementirati funkciju `izracunajAritmeticki :: AritmetickiIzraz -> Int` koja izračunava zadati aritmetički izraz. [*Rešenje*](./aritmeticki_izrazi.hs)
4. Analogno prethodnom zadatku kreirati program koji izračunava logičke izraze. Preciznije: Napraviti tip `LogickiIzraz` koji predstavlja aritmetičke izraze sačinjenje od logičkih vrednosti i operacija konjunkcije i disjunkcije. Uvesti tip `LogickiIzraz` u `Show` klasu tipova tj. implementirati `show :: LogickiIzraz -> String`. Implementirati funkciju `izracunajLogicki :: LogickiIzraz -> Bool` koja izračunava zadati aritmetički izraz. [*Rešenje*](./logički_izrazi.hs)
5. *Za ovaj zadatak je neophodno uraditi oba prethodna zadatka.* Neka je data funkicja `f :: Int -> Bool` sa `f x = if x \=0 then True else False`. Konstruistai funkciju `konvertuj :: AritmetickiIzraz -> LogickiIzraz` koja logički izraz prevodi u aritmetički izraz tako što sabiranje prevodi u disjunkciju, množenje u konjunkciju a brojeve u skladu sa datom funkcijom `f`. Na primer izraz `2 * (7 + 0)` se konvertuje u `⊤ ∧ (⊤ ∨ ⊥)`, a izraz `(-2) * 3 + 2 * 0` u `⊤ ∧ ⊤ ∨ ⊤ ∧ ⊥`. Da li važi `f . izracunajAritmeticki = izracunajLogicki . konvertuj`?
6. Napraviti tip `Izraz` koji prezentuje izraz sačinjen od ralnih brojeva, nepoznate `x`, sabiranja, oduzimanja, množenja, deljenja, stepenovanja, sinusa, kosinusa, eksponencijalne i logaritamske funkcije. Konstruistai funkciju `izvod :: Izraz -> Izraz` koja pronalazi izvod izraza. Konstruistai funkciju `simplify` koja pojednostavljuje izraz koristeći razne matematičke identitete (npr. `a + 0 = a` za svaki izraz `a`). [*Rešenje*](./izvodi.hs)
