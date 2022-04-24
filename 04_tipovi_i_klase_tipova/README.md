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

Primetimo jednu očiglednu činjenicu. Primenom (aplikacijom) funkcije tipa `A -> B` na vrednost tipa `A` dobijamo vrednost tipa `B`. Neformalno govoreći, možemo da kažemo da aplikacijom brišemo prvu levu strelicu.

Primenom funkcije `f` tipa `A1 -> A2 -> ... -> An -> B` na vrednost tipa `A1` dobijamo novu funkciju tipa `A2 -> A3 -> ... -> An -> B`. Sada novodobijenu funkciju možemo primeniti na vrednost tipa `A2` i time dobiti funkciju tipa `A3 -> ... -> An -> B`. Ovaj postupak se može ponavljati sve dok ne stignemo do vrednosti tipa `B`.

### Navođenje tipova

Haskel kompajler je u prethodnim primerima ispravno zaključio tip funkcije jer smo bili oprezni da dobro definišemo funkciju. Ako samo malo promenimo definiciju naše funkcije i pokušamo da tu definiciju učitamo u interaktivno okruženje, dobićemo grešku

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

Na ovaj način govorimo GHC kompajleru kog je tipa naša funkcija. U razvojnom okruženju (npr. u *Visual Studio Code* editoru sa odgovarajućim [Haskel pluginom](https://marketplace.visualstudio.com/items?itemName=haskell.haskell)), ovo značajno može olakšati razvoj programa.

### Prefiksna i infiksna notacija

U matematici primena funkcije na vrednost se označava tako što se ime funkcije napiše ispred te vrednosti koja je postavljena u zagrade (npr. `f(2)`). Slično je i u lambda računu s tim što se zagrade oko argumenta izostavljaju (prethodni primer bi se zapisao `f 2`). Ovaj način zapisivanja funkcija nazivamo *prefiksna* notacija.

Prefiksna notacija se koristi i za funkcije više argumenta, pa se tako piše `f(2, 8.9)` itd... U slučaju funkcija dva argumenta osim prefiksne notacije moguće je primenu funkcija na vrednosti zapisati uz pomoć *infiksne* notacija. U infiksnoj notaciji, ime funkcije se zapisuje između dve vrednosti na koje se funkcija primenjuje.

Infiksnu notaciju koristimo svakodnevno. Na primer, operacija sabiranja je funkcija od dva argumenta koju uvek zapisujemo infiksno (`x + y` umesto `+(x, y)`). Slično važi i za ostale aritmetičke operacije.

Haskel dozvoljava infiksni zapis funkcija dva argumenta. Jedini uslov je da ime funkcije bude sačinjeno od simbola poput `<>+*#@...`. Primer za to su aritmetičke i logičke operacije. U to se možemo lako uveriti:

```
> :t (&&)
(&&) :: Bool -> Bool -> Bool
```

U slučaju kada ispitujemo tip "infiksne funkcije" moramo da koristimo zagrade da bi kompajler dobro parisirao izraz. Zapravo, zagrade služe da bi se od "infiksne funkcije" dobila "prefiksna funkcija". Na primer

```
> (+) 2 6
8
```

```
> (||) True False
True
```

Često je zgodno učiniti i suprotno, od prefiksne funkcije *ad-hoc* napraviti infiksnu funkciju. To možemo učiniti tako što ćemo ime funkcije navesti između navodnika \`\`. Na primer, funkciju `nili` možemo ovako koristiti u infiksnom zapisu

```
> True `nili` False
False
```

Mogućnost lakog definisanja infiksnih funkcija dodatno utvrđuje činjenicu da je u Haskelu pojam funkcije postavljen na prvo mesto.

## Algebarski tipovi podataka

Već smo uspostavili mnogo analogija između matematičkog pojma *skup* i programerskog pojma *tip*. Na početku kursa smo videli da je sa skupovima moguće vršti neke operacije kao što su presek, unija, razlika, Dekartov proizvod itd... Sada ćemo se upoznati sa dve tipske operacije, operacije koje od tipova prave nove tipove. Te dve operacije će odgovarati operacijama unije i Dekartovog proizvoda. Kao što ćemo videti, postoji izvesna analogija između ovih operacija i operacija sabiranja i množenja prirodnih brojeva, zbog čega ovu oblast nazivamo *algebra tipova*.

### Trivijalna konstrukcija

Pre nego što pređemo na sumu i proizvod, pogledajmo jednu trivijalnu konstrukciju. U pitanju je pravljenje novog tipa koji sadrži samo jedan, već kreirani, tip.

```haskell
data Temperatura = Temp Int
  deriving Show
```

*Za sada ignorišite `deriving Show` nakon definicije. Ovo nam samo omogućava ispis verednosti definisanog tipa. Kasnije ćemo detaljnije objasniti `deriving`.*

Navedenom linijom smo konstruisali novi tip `Temperatura`. Svaka vrednost ovog tipa sadrži samo jednu vrednost tipa `Int`. U gornjem izrazu `Temp` je *konstruktor*. Konstruktori su funkcije uz pomoć kojih konstruišemo vrednosti novog tipa. U našem slučaju, konstruktor `Temp` ima tip `Int -> Temperatura`.

Konstruktori se takođe koriste i za dekonstrukciju tipova. Kako znamo da vrednost tipa `Temperatura` mora biti oblika `(Temp x)`, možemo upotrebiti *pattern-matching* da oslobodimo vrednost `x`:

```haskell
uInt :: Temperatura -> Int
uInt (Temp x) = x
```

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

```haskell
zbirVektora :: Vektor -> Vektor -> Vektor
zbirVekotra (Vektor x1 y1) (Vektor x2 y2) = Vektor (x1 + x2) (y2 + y2)
```

Naravno ne moramo koristiti iste tipove u proizvodu niti ih mora biti samo dva. Sledeći tip prestavlja jednu osobu (njeno ime, godine, i to da li je državljanin Srbije)

```haskell
data Osoba = Osoba [Char] Int Bool
  deriving Show
```

Navedeni primer demonstira da je moguće da tip i konstruktor imaju isto ime (ovo se često koristi u Haskel kodovima).

### Suma

Suma dva tipa `A` i `B` je tip koji sadrži sve vrednosti koje poseduju tipovi `A` i `B`. Suma tipova odgovara uniji dva skupa s tim što se uvek smatra da je ta unija disjunktna.

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

```haskell
data Duzina = Metar Float | Milja Float | SvetlosnaSekunda Float
  deriving Show
```

Za tip `Duzina` možemo da definišemo ovakvu funkciju konverzije:

```haskell
uMetre :: Duzina -> Duzina
uMetre (Milja x) = Metar (1609.344 * x)
uMetre (SvetlosnaSekunda x) = Metar (299792458 * x)
uMetre x = x
```

```
> duzinaStaze = Milja 6
> uMetre duzinaStaze
Metar 9656.064
```

### Jedinični tip

kao sto smo videli, konstrukcija proizvoda tipova ima oblik `Konstruktor T1 T2 T3 ... Tn`, gde su `T1`, ... `Tn` neki tipovi. U specijalnom slučaju možemo napraviti tip čiji konstruktor ne uzima nijedan dodatni tip.

```haskell
data MojTip = MojKonstruktor
```

U ovom slučaju konstruktor `MojKonstruktor` je funkcija arnosti 0, odnsno konstanta tipa `MojTip`. Drugim rečima tip `MojTip` sadrži samo jednu vrednost a to je `MojKonstruktor`. Zbog toga za `MojTip` kažemo da je *jediničan tip*.

Ovakva konstrukcija nije mnogo korisna sama po sebi, ali je veoma korisna kada se koristi unutar suma. Na primer, sada lako (i logično) možemo da predstavimo tipove sa konačno mnogo članova:


```haskell
data Pol = Musko | Zensko
```

```haskell
data ZnakKarte = Herc | Karo | Tref | Pik
```

```haskell
data MojeBoje = Crna | Bela | Crvena | Plava | Zelena | Zuta
```

*Napomena: Navedeni tipovi nisu jedinični (npr. `ZnakKarte` sadrži 4 vrednosti), ali su dobijeni sumom jedničnih tipova.*


Zapravo, u Haskelu postoji jedan 'standardan' jediničan tip `()`. Njegova definicija je 

```haskell
data () = ()
```

Ovo je još jedan primer gde konstruktor i tip imaju isto ime.

### Algebra tipova

Na početku kursa smo istakli dve činjenice 

+ Ako su `A` i `B` konačni disjunktni skupovi, tada je `|X ⊔ Y| = |X| + |Y|`. 
+ Ako su `A` i `B` konačni skupovi, tada je `|X × Y| = |X| * |Y|` 

Nije teško uveriti se da ovakve jednakosti važe i za tipove koji imaju konačno mnogo vrednosti. Ovo nagoveštava izvesnu sličnosti između aritmetičkih operacija sabiranja i množenja sa tipskim operacijama sume i proizvoda. Međutim, te sličnosti su mnogo dublje od prostih jednakosti sa kardinalnostima.

Jednakosti sa prirodnim brojevima mogu se često direktno primeniti na tipove. Na primer za prirodne brojeve važi zakon distributivnosti `a * (b + c) = a * b + a * c`. Na jeziku skupova (a samim tim i tipova) navedena jednakost postaje `A × (B ⊔ C) ≅ A × B ⊔ A × C` gde znak `≅` označava da postoji bijekcija između navedenih skupova (ti skupovi nisu *jednaki* ali jesu *izomorfini*).

Navedena jednakost se može lako ilustrovati u Haskelu. Konstruićemo na dva načina tip koji predstavlja osobu, i zatim ćemo uspostaviti bijekciju između ovih tipova

```haskell
-- Tip (B ⊔ C) moramo posebno da definišemo
data Pol = Musko | Zensko
-- A × (B ⊔ C)
data Osoba1 = Osoba1 [Char] Pol

-- A × B ⊔ A × C
data Osoba2 = MuskaOsoba [Char] | ZenskaOsoba [Char]

konvertuj1 :: Osoba1 -> Osoba2
kovertuj1 (Osoba1 x Musko) = MuskaOsoba x
kovertuj1 (Osoba1 x Zensko) = ZenskaOsoba x

konvertuj2 :: Osoba2 -> Osoba1
konvertuj2 (MuskaOsoba x) = Osoba1 x Musko
konvertuj2 (ZenskaOsoba x) = Osoba1 x Zensko
```

Svejedno je da li koristimo tip `Osoba1` ili tip `Osoba2` za prezentovanje osobe. Bitno je da znamo da nijedna od ove dve prezentacije nije suštinski bolja od one druge.

Analogije postoje između broja `1` i tipa `()` (ili bilo kog drugog jediničnog tipa). Na primer u aritmetici važi `m * 1 = m`. Na jeziku skupova (i tipova) ta jednakost postaje `A × () ≅ A`. Zaista, množenjem nekog tipa sa jediničnim tipom, suštinski ne dobijamo novi tip:

```haskell
data Tip = Tip Int ()

uTip :: Int -> Tip
uTip x = Tip x

uInt :: Tip -> Int
uInt (Tip x ()) = x
```

Ovim je demonstrirano da `Int × () ≅ Int`.

## Možda tip

Sada ćemo kreirati tip `MoždaBroj` kojim možemo da predstavimo ili jednu celobrojnu vrednost ili izostanak bili kakve smislene vrednosti (nešto poput vrednosti `null` u javaskriptu). Ovaj tip ćemo konstrusati kao 'uniju' tipova `Int` i jediničnog tipa `Nista` (ništa):

```haskell
data MozdaBroj = SamoBroj Int | Nista 
```

Ovaj tip je koristan kad god hoćemo da radimo u programu sa nekim vrednostima koje možda čak nisu ni zadate. Na primer, ako očitvamo temperaturu s nekog senzora, onda je dobro to očitavanje predstaviti jednom celobrojnom vrednošću (pretpostavimo da senzor ima rezoluciju od 1°C). Međutim, u nekim situacijama naš senzor ne mora vraćati očitanu tempraturu (usled nekih hardverskih problema, itd...). U tom slučaju treba koristiti specijalnu vrednost koja označava da do očitavanja temperature nije ni došlo. Nezgodno bi bilo koristiti vrednost `0` jer se tada ne mogu razlikovati ispravna očitavanja temerature 0°C od neispravnih.

Sa ovakvim tipom je lako raditi. Na primer ako želimo da računamo apsolutnu razliku dve temperature, možemo napisati ovakvu funkciju

```haskell
apsolutnaRazlika :: MozdaBroj -> MozdaBroj -> MozdaBroj
apsolutnaRazlika (SamoBroj x) (SamoBroj y) = SamoBroj abs(x - y)
apsolutnaRazlika _ _ = Nista
```

Prethodna fuknkcija će vratiti vrodnost oblika `SamoBroj i` kad god prosledimo dve vrednosti istog oblika. U svim drugim slučajevima, barem jedna od prosleđenih vrednosti će biti `Nista`, i stoga smisla vratiti samo vrednost `Nista`.

*U Haskelu sa `_` označavamo parametre čija nas vrednost ne interesuje. Znak `_` možemo koristiti na više mesta levo od znaka `=` ali ni jednom desno od znaka `=`.*

Slično tipu `MozdaBroj` možemo konstruisati tip `MozdaNiska`:

```haskell
data MozdaNiska = SamoNiska String | Nista   
```

Jedan od čestih slučajeva u kom bi ovakav tip bio koristan je predstavljanje korisničkog unosa. Na primer, tipom `MozdaNiska` možemo predstaviti mejl adresu korisnika koja potencijalno nije uneta...

Kao što vidimo, konstrukcija tipa je `MozdaNiska` je u potpunosti analogna konstrukciji tipa `MozdaBroj`. I sličnu konstrukciju možemo ponoviti za bilo koji tip.

Ali, da ne bismo istu konstrukciju ponavljali za isti tip, u Haskelu možemo kreirati tip koji zavisi od nekog drugog tipa:

```haskell
data Mozda a = Samo a | Nista
```

U navedenom izrazu, simbol `a` predstavlja proizvoljan tip. U slučaju kada za `a` uzmemo `Int`, dobijamo tip identičan `MoždaBroj` tipu, itd... Vidimo da smo sa jednom linijom obuhvatili konstrukciju svih mogućih "možda tipova".

Primer, od malopre, sada bi izgledao ovako

```haskell
apsolutnaRazlika :: Mozda Int -> Mozda Int -> Mozda Int
apsolutnaRazlika (Samo x) (Samo y) = Samo abs(x - y)
apsolutnaRazlika _ _ = Nista
```

'Možda tipovi' su veoma korisni u praksi. Zbog toga je u standardnoj Haskell biblioteci definisan tip `Maybe` na već viđen način:

```haskell
data Maybe a = Just a | Nothing
```

Mnoge funkcije koriste *maybe* tipove za povratne vrednosti. Već smo se upoznali sa funkcijom `head :: [a] -> a` koja vraća prvi element liste. Međutim, pozivanje ove funkcije nad praznom listom `[]` dovodi do greške koja prekida izvršavanje programa (izuzetak). Zbog toga, na mnogim mestima Haskell programeri će koristiti funkciju `maybeHead :: [a] -> Maybe a` koja vraća prvi element liste "zapakovan" u `Just` ako ta lista nije prazna, a u suprotnom vraća `Nothing`. Za razliku od funkcije `head`, funkcija `maybeHead` je totalna.

## Vrste

U prethodnoj sekciji upoznali smo se sa apstraktnim algebarskim tipom podataka

```haskell
data Maybe a = Just a | Nothing
```

Na osnovu prethodne definicje, možemo dobiti tipove poput `Maybe Int`, `Maybe Bool`, `Maybe [Char]`, itd... Međutim, sam `Maybe` ne predstavlja tip sam za sebe (ne postoji vrednost tipa `Maybe`). Šta je onda `Maybe`?

Ako se pogledamo bolje, videćemo da `Maybe` od tipova "pravi" nove tipove: od `Int` dobijamo `Maybe Int`, od `[Char]` dobijamo `Maybe [Char]` itd... Prema tome, `Maybe` predstavlja *funkciju nad tipovima* (*tipsku funkciju*).

Možemo se zapitati koji je tip ove funkcije nad tipovima? Da bismo odgovorili na to, prvo moramo definisati tip tipa.

U Haskelu, tip tipova se naziva *vrsta* (eng. *kind*). Svi konkretni tipovi, tj. oni tipovi koji nisu tipske funkcije (npr. `Int`, `Float`, `Char`, `[Char]`), poseduju vrstu `*`. Za razliku od konkretnih tipova, vrsta `* -> *` tipske funkcije `Maybe` označava da `Maybe` uzima jedan konkretan tip i daje drugi konkretan tip.

U interaktivnom okruženju, vrste tipova možemo saznati uz pomoć naredbe `:kind` (skraćeno `:k`). Na primer

``` 
> :k Int
Int :: *
> :k Maybe
Maybe :: * -> *
> :k Maybe Int
Maybe Int :: *
```

Slično tipu `Maybe`, koristi se i tip `Either`:

```haskell
data Either a b = Left a | Right b 
```

Tip `Either` se često koristi za prezentovanje grešaka i "dobrih" vrednosti. Uobičajno se greške predstavljaju uz pomoć konstruktora `Left`, a "dobre" vrednosti uz pomoć konstruktora `Right`.

Tip `Either` je vrste `* -> * -> *` jer uzima dva konkretna tipa:

```
> :k Either
Either :: * -> * -> *
```

Međutim kada `Either` apliciramo na neki konkretan tip, dobijamo tipsku funkciju jedne promenljive:

```
> :k (Either Int)
(Either Int) :: * -> *
```

Dakle, i na nivou tipova imamo pojmove apstrakcije i aplikacije.

Iako priča o vrstama i tipskim funkcijama deluje apstraktno, mi smo se sa tipskim funkcijama susreli na samom početku učenja Haskela. Tipska funkcija `([]) :: * -> *` prevodi tip `a` u tip nizova tog tipa `[a]`. Jedina razlika je u tome što za ovu tipsku funkciju koristimo specijalnu sintaksu (`[a]` a ne `[] a`). Zaista:

```
> :k ([])
([]) :: * -> *
> :k (([]) Int)
(([]) Int) :: *
``` 

*Napomena: ne treba mešati tipsku funkciju `[]` sa konstruktorom praznog niza `[]`*

Još jedna tipska funkcija koja se svuda koristi je `(->) :: * -> * -> *`. Funkcija `(->)` primenjena na dva tipa `a` i `b` daje tip svih preslikavanja iz `a` u `b`. Taj tip označavamo upravo sa `a -> b`.

*Posmatrajući sada tip `Maybe` kroz algebru tipova, shvatamo da `Maybe` odgovara funkciji sledbenika `f(x) = x + 1`. Zaista, funkcija `Maybe` konstruiše novi tip tako što na njega dodaje jednu vrednost.*

## Klase tipova

### Klasa Eq

### Klasa Ord

### Klasa Show

### Klasa Num

## Zadaci


1. Kreirati algebarski tip podataka `Vektor` koji predstavlja vektor u dvodimenzionalnoj ravni (Koristiti `Float` tip za koordinate). Kreirati funkcije za sabiranje vektora, množenje vektora skalarem, skalarnog množenja vektora i računanja dužine vektora.

2. Kreirati algebarski tip `Valuta` koji može da predstavi neke valute (npr, RSD, EUR, USD) i funkcije koje vrše koverziju između ovih valuta. Kreirati algebarski tip `Smer` koji označava smer u kom se šalje novac (npr. *od* banke ili *ka* banci). Kreirati algebarski tip `Transakcija` koji sadrži količinu (`Float`), zatim valutu i smer. Kreirati jedan proizvoljan niz `Transakcija` od 5 članova ili više. Kreirati funkciju koja računa promenu stanja računa nakon svih izvršenih transakcija.

3. Koji je pandan zakonu komutativnosti `m * n = n * m` na jeziku tipova? Kako bi ste tu jednakost iskazali u Haskelu?

