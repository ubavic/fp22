# Tipovi i klase tipova

Iako smo do sada u par navrata spomenuli izraz *tip*, nismo još naveli šta je to tačno tip. *Tip* nije ništa drugo nego kolekcija nekakvih vrednosti. Na primer tip `Bool` sadrži dve vrednosti: `True` i `False`, a tip `Int` sadrži sve celobrojne brojeve (koji se mogu izraziti u procesorskoj reči, odnosno u 64 bita).

Važno je znati da u Haskel jeziku svaki izraz ima tip, odnosno, pripada nekakvoj kolekciji vrednosti. Imena svih (konkretnih) tipova u Haskelu počinju velikim slovom (i obrnuto je skoro tačno. Sve što počinje velikim slovom je uglavnom vezano za tipove).

Kao što smo na početku napisali, Haskel jezik ima jak sistem tipova. Preciznije, Haskel poseduje *statički sistem tipova* što znači da su tipovi svih izraza poznati prilikom kompilacije. To je dobro jer se time otklanjaju mnoge greške koje bi mogle srušiti ceo program prilikom izvršavanja.

Još jedna karkteristika koja odlikuje Haskelov sistem tipova je *zaključivanje tipova*. Dok je u jezicima poput C-a ili Jave neophodno navesti tip svake pormenljive ili funkcije, Haskel kompajler skoro uvek može zaključiti tip izraza bez potrebe da programer to navede.

Zaključivanje tipova nam je omogućilo da u prethodnoj sekciji napišemo neke Haskel programe bez posvećivanja mnogo pažnje tipovima. Ipak, tipovi čine značajan deo Haskel jezika, i neophodno je razumeti (barem u osnovama) ovaj sistem. 

## Osnovi tipovi

Kao što smo rekli, u Haskelu svaki izraz poseduje tip. Taj tip možemo saznati u interaktivnom okruženju uz pomoć komande `:t`:

```
> :t True
True :: Bool
```

```
> :t 'a'
'a' :: Char
```

```
x = True
> :t x
x :: Bool
```

Kao što vidimo, potpis tipa se sastoji od imena ili vrednosti izraza, nakon čega sledi `::` sa imenom tipa.

**Napomena**: ako pokušate da pronađete tip nekog broja (npr. `2`) iznenadiće vas tip `2 :: Num p => p` (umesto očekivanog `Int` na primer). Uskoro ćemo objasniti ovu notaciju, a do tada ćemo baratati samo sa tipovima poput `Char` i `Bool`. 

Na prethodnom predavanju, videli smo kako možemo da konstruišemo neke nove tipove podataka od postojećih. Konkretno, prikazali smo kako možemo konstruisati liste i uređene n-torke. Pogledajmo potpise ovih tipova.

Ako je `a` neki tip, tada sa `[a]` označavamo tip svih lista sačinjenih od vrednosti tipa `[a]`:

```
:t [True, False, False, True]
[True, False, False, True] :: [Bool]
```

```
:t "Hello World!"
"Hello World" :: [Char]
```

```
> :t [[True], [False], [True, False]]
[True], [False], [True, False]] :: [[Bool]]
```

Tip uređene n-torke je uređena n-torka odgovarajućih tipova:

```
> :t ('a', True)
('a', True) :: (Char, Bool)
```

```
> :t ('a', 'b', 'c')
('a', 'b', 'c') :: (Char, Char, Char)
```

Posmatrano kroz teoriju skupova, tip poput `(Char, Bool)` odgovara Dekartovom proizvodu skupova `Char` i `Bool` tj `Char ⨯ Bool`. Slično važi i za uređene trojke, četvorke itd...

## Tip funkcije

Rekli smo na početku da svi izrazi u Haskel jeziku poseduju tip. Do sada smo ispitali tipove nekih konstanti, a sada ćemo pogledati tip funkcija. 

Definišimo funkciju `uSlovo` koja logičkim vrednostima dodeljuje jedan karakter:

```haskell
uSlovo x
	| x == True  = 'T'
	| x == False = 'N'
```

*Navedena funkcija se može malo elegantnije (kraće) definisati. Možete li da napišete tu definiciju?*

Tip ove funkcije možemo lako pronaći:

```
> :t uSlovo
uSlovo :: Bool -> Char 
```

Tip `Bool -> Char` nam govori da se radi o funkciji koja preslikava vrednosti tipa `Bool` u vrednosti tipa `Char`. Primetimo da je ova oznaka analogna oznaci koju koristimo u matematici za označavanje tipova. U matematici bismo pisali `f: A → B`, dok u Haskelu pišemo `f :: A -> B`.


Kog tipa je naredna funkcija od dve promenljive?

```haskell
nili x y = not x && not y
```

```
> :t nili
nili :: Bool -> Bool -> Bool
```

Za razliku od lambda izraza za koje je važilo pravilo levo asocijativnosti aplikacije, simbol `->` u tipovima je desno asocijativan. Stoga izraz `Bool -> Bool -> Bool` treba tumačiti kao `Bool -> (Bool -> Bool)`.

Šta nam tip `Bool -> (Bool -> Bool)` govori? Funkcija `nili` preslikava vrednost tipa `Bool` u funkciju tipa `Bool`, a to je upravo karijevanje koje smo definisali u lambda računu. 

Funkciju `nili` smo mogli da definišemo i na uređenim parovima tipa `(Bool, Bool)` kao `nili par = not (fst par) && not (snd par)`. U tom slučaju tip funkcije `par` bi bio `(Bool, Bool) -> Bool`, što znači da ne bi bilo karijevanja.

Ovo samo demonstrira činjenicu koju smo već znali, svaka karijevana funkcija može se predstaviti kao funkcija čiji je domen Dekartov proizvod `n` skupova, ali i obrnuto (npr. funkcija tipa `A1 -> A2 -> ... -> An -> B` može se predstaviti kao funkcija `(A1, A2, ..., An) -> B`).

Primetimo jednu očiglednu činjenicu. Primenom (aplikacijom) funkcije tipa `A -> B` na vrednost tipa `A` dobijamo vrednost tipa `B`. Neformalno govoreći, možemo da kažemo da aplikacijom brišemo prvu levu strelicu. Kod karijevanja ovo se takođe dešava.

Primenom funkcije `f` tipa `A1 -> A2 -> ... -> An -> B` na vrednost tipa `A1` dobijamo novu funkciju tipa `A2 -> A3 -> ... -> An -> B`. Sada novodobijenu funkciju možemo primeniti na vrednost tipa `A2` i time dobiti funkciju tipa `A3 -> ... -> An -> B`. Ovaj postupak se može ponavljati sve dok ne stignemo do vrednosti tipa `B`.

### Navođenje tipova

Haskel kompajler je u prethodnim primerima ispravno zaključio tip funkcije jer smo bili oprezni da dobro definišemo funkciju. Ako samo malo promenimo definiciju naše funkciije i pokušamo da tu definiciju učitamo u interaktivno okruženje, dobićemo grešku

```haskell
uSlovo x
	| x == True  = 'T'
	| x == 2 = 'N'
```

```
> :l main.hs
[1 of 1] Compiling Main             ( main.hs, interpreted )

main.hs:3:11: error:
    • No instance for (Num Bool) arising from the literal ‘2’
    • In the second argument of ‘(==)’, namely ‘2’
      In the expression: x == 2
      In a stmt of a pattern guard for
                     an equation for ‘uSlovo’:
        x == 2
  |
3 |    | x == 2 = 'N'
  |           ^
```

Gornja greška je nastala jer ne postoji tip koji istovremeno sadrži vrednosti `True` i `2`. 

Da bismo izbegli ovakve greške, od sada pa nadalje ćemo uvek navoditi tip funkcije pre definicije. Na primer, prethodni primer sada izgleda ovako

```haskell
uSlovo :: Bool -> Char 
uSlovo x
	| x == True  = 'T'
	| x == False = 'N'
```

Na ovaj način govorimo GHC kompajleru kog je tipa naša funkcija. U razvojnom okruženju (npr u *Visual Studio Code* editoru sa odgovarajućim Haskel pluginom), ovo značajno može olakšati razvoj programa.

### Prefiksna i infiksna notacija

U matematici primena funkcije na vrednost se označava tako što se ime funkcije napiše ispred te vrednosti koja je postavljena u zagrade (npr. `f(2)`). Slično je i u lambda računu s tim što se zagrade oko argumenta izostavljaju (prethodni primer bi se zapisao `f 2`). Ovaj način zapisivanja funkcija nazivamo *prefiksna* notacija.

Prefiksna notacija se koristi i za funkcije više argumenta, pa se tako piše `f(2, 8.9)` itd... U slučaju funkcija dva argumenta osim prefiksne notacije moguće je primenu funkcija na vrednosti zapisati uz pomoć *infiksna* notacija. U infiksnoj notaciji, ime funkcije se zapisuje između dve vrednosti na koje se primenjuje.

Infiksnu notaciju koristimo svakodnevno. Na primer, operacija sabiranja je funkcija od dva argumenta koju uvek zapisujemo infiksno (`x + y` umesto `+(x, y)`). Slično važi i za ostale aritmetičke operacije.

Haskel dozvoljava infiksni zapis funkcija dva argumentam jedini uslov je da ime funkcije bude sačinjeno od simbola poput `<>+*#@...`. Primer za to su aritmetičke i logičke operacije. U to se možemo lako uveriti:

```
> :t (&&)
(&&) :: Bool -> Bool -> Bool
```

U slučaju kada ispitujemo tip "infiksne funkcije" moramo da koristimo zagrade da kompajler dobro parisirao izraz. Zapravo, zagrade služe da bi se od "infiksne funkcije" doobila "prefiksna funkcija". Na primer

```
> (+) 2 6
8
```

```
> (||) True False
True
```

Često je zgodno učiniti i suprotno, od prefiksne funkcije ad-hoc napraviti infiksnu funkciju. To možemo učiniti tako što ćemo ime funkcije navesti između navodnika \`\`. Na primer, funkciju `nili` možemo ovako koristiti u infiksnom zapisu

```
> True `nili` False
False
```
## Algebarski tipovi podataka

Već smo uspostavili mnogo analogija između matematičkog pojma *skup* i programerskog pojma *tip*. Na početku kursa smo videli da je sa skupovima moguće vršti neke operacije kao što su presek, unija, razlika, Dekartov proizvod itd... Sada ćemo se upoznati sa dve tipske operacije, operacije koje od tipova prave nove tipove. Te dve operacije će odgovarati operacijama unije i Dekartovog proizvoda. Kao što ćemo videti, postoji izvesna analogija između ovih operacija i operacija sabiranja i množenja prirodnih brojeva, zbog čega ovu oblast nazivamo *algebra tipova*.

### Trivijalna konstrukcija

Pre nego što pređemo na sumu i proizvod, pogledajmo jednu trivijalnu konstrukciju. U pitanju je pravljenje novog tipa koji sadrži samo jedan, već kreirani, tip.

```haskell
data Temperatura = Temp Int
  deriving Show
```

*Za sada samo postavljajte `deriving Show` nakon definicije. Kasnije ćemo objasniti šta nam ova linija omogućava.*

Navedenom linijom smo konstruisali novi tip `Temperatura`. Svaka vrednost ovog tipa sadrži samo jednu vrednost tipa `Int`. U gornjem izrazu `Temp` je *konstruktor*. Konstruktori su funkcije uz pomoć kojih konstruišemo vrednosti novog tipa. U našem slučaju, konstruktor `Temp` ima tip `Int -> Temperatura`.

Konstruktori se takođe koriste i za dekonstrukciju tipova. Na primer, ako želimo da konstrušemo funkciju koja nam "oslobađa" `Int` iz tipa `Temperatura`, to možemo učiniti ovako:

```haskell
uInt :: Temperatura -> Int
uInt (Temp x) = x
```

Kako znamo da vrednost tipa `Temperatura` mora biti oblika `(Temp x)`, možemo upotrebiti *pattern-matching* da oslobodimo vrednost `x`.

```
> temperaturaVode = Temp 20
> uInt temperaturaVode
20
```

### Proizvod

Proizvod tipova odgovara Dekartovom proizvodu skupova. Proizvod tipova u Haskelu se jednostavno konstruiše: dovoljno je nakon konstuktora navesti više tipova.

Na primer, vektor dvodimenzionalne ravni možemo definsati kao proizvod tipova `Float` i `Float` na sledeći način:

```haskell
data Vektor2D = Vektor Float Float
  deriving Show
```

Sada ponovo u funkcijama možemo koristiti *pattern matching*:

```
zbirVektora :: Vektor -> Vektor -> Vektor
zbirVekotra (Vektor x y) (Vektor z w) = Vektor (x + z) (w + z)
```

Naravno ne moramo koristiti iste tipove u proizvodu niti ih mora biti samo dva. Sledeći tip prestavlja jednu osobu (njeno ime, godine, i to da li je državljanin Srbije)

```haskell
data Osoba = Osoba [Char] Int Bool
  deriving Show
```

Navedeni primer demonstira da je moguće da tip i konstruktor imaju isto ime (ovo se često koristi u Haskel kodovima).
### Suma

Suma dva tipa `A` i `B` je tip koji sadrži sve vrednosti koje poseduju tipovi `A` i `B`. Suma tipova odgovara uniji dva skupa stim što se uvek smatra da je ta unija disjunktna.

Suma tipova se vrši postavljanjem vertikalne crte između tipova. Na primer:

```haskell
data SlovoIliBroj = Slovo Char | Broj Int
    deriving Show
```

Ovim smo definisali tip koji možemo da shvatimo kao skup sačinjen od svih slova i brojeva.

Da bi smo radili sa sumama, ponovo ćemo koristit *pattern matching*:

```haskell
daLiJeSlovo :: SlovoIliBroj -> Bool
daLiJeSlovo (Slovo x) = True
daLiJeSlovo (Broj x) = False
```

Kao i u slučaju proizvoda tipova, moguće je "sabrati" više tipova od jednom. Na primer sledeći tip označava dužinu u različitim mernim jednicama

```
data Duzina = Metar Float | Milja Float | SvetlosnaGodina Float 
```


### Jedinični tip


### Prazan tip


### Bonus: Stepenovanje


### Algebra tipova

## Vrste

### Maybe

## Klase tipova

### Klasa Eq

### Klasa Ord

### Klasa Show

### Klasa Read

## Zadaci

1. Funkcija `slikaj` prihvata funkciju tipa `a -> b` i jedan niz tipa `[a]`, a vraća niz tipa `[b]` koji je nastao preslikavanjem svakog elementa niza tipa `[a]` pomoću funkcije. Na primer `slikaj (\x -> not x) [True, True, False, False, True]` ima vrednost `[False, False, True, True, False]`. Koji je tip funkcije `slikaj` (iskazan u tipskim promenljivama)? Definišite funkciju `slikaj`.

2. Kreirati algebarski tip podataka `Vektor` koji predstavlja vektor u dvodimenzionalnoj ravni (Koristiti `Float` tip za koordinate). Kreirati funkcije za sabiranje vektora, množenje vektora skalarem, skalarnog množenja vektora i računanja dužine vektora.

3. Kreirati algebarski tip `Valuta` koji može da predstavi neke valute (npr, RSD, EUR, USD) i funkcije koje vrše koverziju između ovih valuta. Kreirati algebarski tip `Smer` koji označava smer u kom se šalje novac (npr. *od* banke ili *ka* banci). Kreirati algebarski tip `Transakcija` koji sadrži količinu (`Float`), zatim valutu i smer. Kreirati jedan proizvoljan niz `Transakcija` od 5 članova ili više. Kreirati funkciju koja računa promenu stanja računa nakon svih izvršenih transakcija.




