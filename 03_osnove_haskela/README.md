# Osnove Haskela

## O haskelu

Haskel je čisto funkcionalni programski jezik. Haskel je dizajniran početkom devedesetih godina prošlog veka, po uzoru na funkcionalne jezike kao što su [Miranda](https://en.wikipedia.org/wiki/Miranda_(programming_language)) i [ML](https://en.wikipedia.org/wiki/ML_(programming_language)).

Haskel je danas sinonim za funkcionalnu paradigmu, jer mnoge karakteristike Haskel jezika vezujemo za funkcionalnu paradigmu:

+ **Funkcije kao građani prvog reda.** Haskel dozvoljava programeru baratanje sa funkcijama kao što je to slučaj sa promenljivama. Specijalno, funkcije se mogu prosleđivati kao argumenti ili vraćati kao povratne vrednosti.
+ **Funkcije su čiste.** Za razliku od imperativnih i objektno orijentisanih porogramskih jezika, funkcije u Haskelu su čiste, što znači funkcije ne zavise od globalnog stanja, niti mogu da menjaju to stanje. Na taj način pojam *funkcije* u Haskelu više odgovara matematičkom pojmu funkcije nego što je to slučaj sa jezicima poput C-a, Jave, Javaskripta, itd...
+ **Lenjo izračunavanje.** Zbog toga što su funkcije u Haskelu čiste, Haskel može da odlaže izračunavanje neke funkcije dokle god je to moguće. Između ostalog, to omogućuje programeru da radi sa beskonačnim strukturama podataka u Haskelu.
+ **Jak sistem tipova.** Veliki deo Haskel jezika (i programiranja u Haskelu) se odnosi na sistem tipova. Haskel je statički tipiziran jezik što znači da su svi tipovi određeni prilikom kompilacije. Takođe, sistem tipova je dovoljno moćan da kompajler može sam zaključiti tip izraza (ovo je omogućeno [Hindley–Milner](https://en.wikipedia.org/wiki/Hindley%E2%80%93Milner_type_system) sistemom tipova).

Haskel je dobio ime po američkom logičaru [Haskell Curry-ju](https://en.wikipedia.org/wiki/Haskell_Curry).

## Instalacija Haskel okruženja

Iako je tokom istorije Haskela razvijeno nekoliko kompajlera, danas se koristi samo *Glasgow Haskell Compiler* (GHC). Osim kompajlera, za bilo kakav ozbiljniji rad potreban je i jedan od paketa menadžera, *Stack* ili *Cabal*. Takođe je korisno imati instaliran i *Haskell Language Server* (HSL).

Instalacija navedenih programa može se razlikovati u zavisnosti od sistema do sistema. Trenutuno se za sve operativne sisteme (Linux, Windows, Mac) preporučuje [GHCup](https://www.haskell.org/ghcup/) kao alat za automatsku instalaciju svih potrebnih programa.

Za prve korake u Haskelu često nije potrebno instalirati kompajler lokalno, već je sasvim dovoljno koristiti neku od onlajn razvojnih okruženja za Haskel, kao što je [Replit](https://replit.com/languages/haskell).

## GHCI

Kompajler *GHC* dolazi sa interaktivnim okruženjem *GHCi*. Ovo okruženje radi po principu *REPL*-a ((*read-eval-print loop*). Koristeći *GHCi*, programer može da direktno unosi Haskell kod u konzolu, koji će se zatim evaluirati a rezultat biti vraćen. Ovaj postupak je značajno brži nego kompajliranje a zatim i pokretanje Haskell koda. Mi ćemo se u ovoj lekciji ograničiti samo na *GHCi*, a kasnije ćemo objasniti i proces kompilacije Haskell programa.

Da bismo pokrenuli interaktivno Haskel okruženje, u terminalu pokrenimo program `ghci`. Pojaviće se tekst poput sledećeg

```plaintext
GHCi, version 8.10.7: https://www.haskell.org/ghc/  :? for help
Prelude> 
```

Linija `Prelude>` označava prompt, odnosno prostor za unos Haskel koda (*Prelude* je ime standardnog Haskell modula).

Osim Haskel koda, *GHCi* prihvata i određene naredbe koje se mogu koristiti samo unutar interaktivnog okruženja. Te naredbe isključivo počinju sa `:`. Na primer, naredba `:quit` prekida *GHCi* petlju. Prompt se može promeniti, u npr. `>`, pomoću naredbe `:set prompt ">"`. U nastavku teksta ćemo koristiti `>` za prompt. Sa ostalim naredbama upoznaćemo se kasnije.

## Aritmetički i logički izrazi

Grubo govoreći, Haskell kod se sastoji od *izraza* ili *dekleracija*. *Izrazi* su sačinjeni od vrednosti i funkcija primenjenih na te vrednosti. U *GHCi* okruženju, svaki izraz će biti *evaluiran* i vrednost te evaluacije će nam bit vraćena (ako postoji).

Aritmetika u Haskelu se ne razlikuje mnogo od aritmetike u drugim programskim jezicima. Na primer, ako unesemo `25+6` u *GHCi* prompt (i zatim pritisnemo *Enter*), dobićemo očekivani rezultat:

```
> 25 + 6
31
```

Naravno, osim sabiranja, moguće je koristiti i operacije množenja `*`, oduzimanja `-`, deljenja `/` i stepenovanja `^`, kao i zagrade `()`.

Na primer upisivanjem izraza `(1 - 2/3) ^ 2` dobijamo `0.1111111`. Obratite pažnju da `/` uvek vraća rezultat u pokretnom zarezu, pa se tako izraz `1 / 3` evaluira u 0.33333`. S celobrojnim deljenjem uskoro ćemo se upoznati.

I logički izrazi u Haskelu funkcionišu slično kao u ostalim jezicima. Za logičke konstante, *Tačno* i *Netačno* koriste se se  *True* i *False*. Logičke operacije konjukcija i disjunkcija označavaju se binarnim operatorima `&&` i `||`, dok se negacija označava sa `not`. Na primer:

```
> (True || False) && not True
False
```

Brojeve možemo porediti onako kako smo na to navikli u drugim jezicima. Rezultat poređenja je logička vrednost

```
> 2 < 3
True
> 2 == 3
False
> 2 > 3
False
> 2 <= 3 
True
> 2 >= 3
False
```

Štaviše i same logičke vrdnosti možemo porediti pa imamo

```
> False < True
True
> False == True
False
> False > True
False
> False <= True
True
> False >= True
False
```

Međutim, vrednosti različitog tipa ne možemo porediti (kao što je to slučaj u npr. javasckriptu), te će nas pokušaj poređenja broja i logičke vrednosti dovesti do greške:

```
> 2 < True

<interactive>:4:1: error:
    • No instance for (Num Bool) arising from the literal ‘2’
    • In the first argument of ‘(<)’, namely ‘2’
      In the expression: 2 < True
      In an equation for ‘it’: it = 2 < True
```

## Funkcije

Haskel jezik je zapravo lambda račun sa tipovima. U prošloj sekciji smo se upoznali sa netipiziranim lambda računom, a kroz Haksel ćemo se upoznati i sa sistemom tipova. Mnoge karakteristike lambda računa koje smo ranije opisali, mogu se direktno preneti na Haskel.

U lambda računu, izraze oblika `λx.M`, tzv. apstrakcije, interpretirali smo kao definicije funkcija. U Haskelu funkcije možemo definisati pomoću lambda apstrakcija:

```
> f = (\x -> (2 * x))
>
```

Gornjom linijom definisana je funkcija `f` koja vraća dvostruki argument (u matematici napisali bismo `f(x) = 2 * x`). Nakon što smo definisali funkciju `f`, ghci će osloboditi prompt za nove izraze, pritom pamteći definiciju funkcije `f`.

U lambda računu, izraze oblika `(M N)`, tzv. aplikacije, interpretirali smo kao primene funkcija na vrednosti. I ova notacija se prenosi u Haskel. Stoga, ako želimo da izračunamo `f(10)` napisaćemo `f 10` u prompt.

```
> (f 10)
20
```

U gornjem primeru, u prompt smo uneli jedan redeks (apstrakciju apliciranu na neku vrednost). Ghci je pokušao da beta redukuje taj redeks sa normalnu formu, u čemu je i uspeo, a zatim je tu normalnu formu ispisao.

```
(f 10) ≡ ((λx. (2 * x)) 10) → (2 * 10) → 20
```

Da bismo definisali funkcije više promenljivih koristićemo tehniku karijevanja koju smo opisali u prethodnoj sekciji. Npr. funkciju zbir možemo definisati na sledeći način:

```
zbir = (\x -> (\y -> (x + y))) 
```

Zbir brojeva 22 i 33 izračunaćemo aplikacijom funkcije `zbir` na 22, a zatim aplikacijom dobijene vrednosti na 33:

```
> ((zbir 22) 33)
55
```

I u ovom slučaju, ghci je uspešno beta redukovao izraz do normalne forme:

```
> ((zbir 22) 33) ≡ (((λx.λy. (x + y)) 22) 33) → ((λy. (22 + y)) 33) → (22 + 33) → 55 
```

U lamda račun su uvedene neke konvencije koje nam omogućuju da obrišemo zagrade u lambda izrazima. Te konvencije postoje i u Haskelu:

1. Spoljne zagrade ne zapisujemo. Npr. umesto `(f 20)` pišemo `f 20`.
2. Aplikacija lambda izraza je levo-asocijativna. Npr. umesto `(zbir 22) 33` pišemo `zbir 22 33`.
3. Apstrakcija je desno asocijativna. Npr. umesto `\x -> (\y -> x + y)` pišemo `\x -> \y -> x + y`.
4. Aplikacija ima veći prioritet u odnosu na apstrakciju: Npr. umesto `\x -> (f x)` pišemo `\x -> f x`.
5. Višestruke apstrakcije se mogu svesti pod jednu lambdu: Npr. umesto `\x -> \y -> x + y` pišemo `\x y -> x + y`.

Iako ove konvencije pojednostavljuju lambda izraze, Haskel podržava još jedan način definicije funkcije koji je značajno pregledniji. Taj način se sastoji u tome da se nakon imena funkcije navedu promenljive od kojih zavisi funkcija, a zatim znak jednakosti iza kog sledi telo funkcije.

Na primer prehodne funkcije `f` i `zbir` smo mogli i ovako da definišemo

```
f x = 2 * x
```

```
zbir x y = x + y
```

## Liste

Liste u Haskelu su homegene strukture podataka, što znači da mogu sadržati vrednosti samo jednog tipa (npr. samo brojeve ili samo logičke vrednosti). Liste se konstruišu navođenjem vrednosti unutar uglastih zagrada: 

```
> x = [1, 2, 3, 4 , 5] 
```

```
praznaLista = []
```


Elementu liste možemo pristupiti pomoću operatora `!!` (obratite pažnju da su liste indeksirane od nule):

```
> x !! 2
3
```

Dužinu liste možemo pronaći sa `length` funkcijom

```
> length x
5
> length []
0
```

Dve liste možemo spojiti pomoću operatora `++`:

```
> x ++ [6, 7, 8, 9]
[1, 2, 3, 4, 5, 6, 7, 8, 9]
```

Za "uzimanje" prvog elementa liste, možemo iskoristiti funkciju `head`

```
> head x
1 
```

Funkcija `tail`` vraća ostatak liste bez početnog elementa

```
> tail x
[2, 3, 4, 5]
```

Analogno postoje i funkcije `last` i `init` koje redom vraćaju poslednji element liste i listu bez poslednjeg elementa.

Funkcija `reverse` obrće listu:

```
> reverse [1, 2, 3, 4, 5]
[5, 4, 3, 2, 1]
```

Kad god konstruišemo liste od tipova koji se mogu međusobno porediti, tada i te liste možemo porediti. To poređenje se vrši član po član. Na primer:

```
> [0, 2, 3] <= [1, 2, 5]
True 
```

Prethodno poređenje je tačno zato što je svaki od elemenata prve liste manji ili jednak odgovarajućem elementu druge liste.

```
> [0, 2, 3] <= [1, 2, 1]
False 
```

Prethodno poređenje je netačno jer je treći element prve liste strogo veći od trećeg elementa druge liste.


Ako su liste različitih dužina, a jedna čini početak one druge, tada je manja ona sa manje elemenata

```
>  [1, 2, 3] < [1, 2, 3, 4]
True
```
## Stringovi

Naravno, u Haskelu možemo raditi i sa karakterima i stringovima. Pojedinačni karakteri se navode pod jednostrukim navodnicima:

```
> slovo = 'a'
> slovo
'a'
```

Karakteri su vrednosti sa kojima ne možemo mnogo štošta raditi (kao što je to slučaj sa brojevima koje možemo sabirati, oduzimati, itd...). Međutim, karaktere, kao i brojeve i logičke vrednosti, možemo porediti. To poređenje je ustanovljeno UTF kodiranjem karaktera. Stoga imamo

```
> 'a' < 'b'
True
> 'a' < 'B'
False
> 'a' < 'ш'
True
```

Stringovi se navode pod dvostrukim navodnicima:

```
> pozdrav = "hello world"
pozdrav
"hello world"
```

Stringovi u Haskelu nisu ništa drugo nego nizovi karaktera. String `pozdrav` je mogao biti i ovako definisan

```
> pozdrav = ['h', 'e', 'l', 'l', 'o', ' ', 'w', 'o', 'r', 'l', 'd']
```

Kako su stringovi zapravo nizovi, sa njima možemo koristiti funkcije za rad sa nizovima poput `++`, `head`, `tail`, `last`, `init`, `reverse` a možemo ih i porediti

```
> tail "hello world"
"ello world"
```

```
> reverse "anavolimilovana"
"anavolimilovana"
```

```
> "abrakadabra" < "Banana"
True
```

## Uređene n-torke

Liste sadrže različit broj elemenata istog tipa. Za razliku od toga, uređene n-torke sadrže fiksiran broj elemenata ne nužnog istog tipa. Uređene n-torke se konstruišu navođenjem vrednosti odvojenih zarezima između zagrada `( )`

Najznačajnije uređene n-torke su svakako uređeni parovi. Uređeni par sadrži dve vrednosti, koje ne moraju biti istog tipa. Na primer sa uređenim parom `osoba = ("Ana", 19)` možemo predstaviti jednu osobu, njeno ime pomoću stringa i njen broj godina pomoću celobrojne vrednosti. 

Nad svakim uređenim parom možemo pozvati funkciju `fst` i `snd` koje redom vraćaju prvu i drugi koordinatu uređenog para.

``` haskell
> fst ("Milan", 28)
"Milan"
```

``` haskell
> snd ("Milan", 28)
28
```

Uređeni parovi su posebno korisni za predstavljanje koordinata vektora dvodimenzionalnog prostora. Lako možemo definisati funkcije sabiranja vektora, množenja vektora skalarom (brojem), skalarnog proizvoda, itd...


```haskell
zbirVektora v w = (fst v + fst w, snd v + snf w)
```

```haskell
skaliranjeVektora a v = (a * fst w, a * snd w)
```

```haskell
skalarniProizvod v w = (fst v) * (fst w) + (snd v) * (snf w)
```

Uređene trojke, četvorke, itd,n se ređe koriste, te za njih ne postoje funkcije poput `fst` i `snd`. U narednim sekcijama ćemo videti kako možemo konstruisati odgovarajuće funkcije.   

## Još sintakse za funkcije

Jedna od glavnih karteristika funkcionalnih programskih jezika je ta što funkcije zaista odgovaraju *matematičkim funkcijama*. U imperativnim jezicima (poput C-a ili javaskripta), izraz *funkcija* je rezervisan za niz naredbi nakon kojih se vraća neka vrednost:

```C
int funkcija(int a) {
  int x = 0, y = 1;
  x = poziv1(a, x);
  y = poziv2(x);
  ...
  return a * x + y;
}
```

Iako znamo da je Haskel ekspresivan isto koliko i bilo koji drugi programski jezik, ipak nam Haskel sintaksa koju smo do sada savladali ne omogućuje da na jednostavan način zapišemo mnoge programe. Zbog toga ćemo ovde videti još par sintaksnih konstrukcija koje će nam pomoći da se izrazimo.

### if-then-else

Iako `if-then-else` nije konstrukcija koja se često koristi u Haskelu (videćemo uskoro zašto), navodimo je ovde prvu jer je svima dobro poznata. Sintaksa je sasvim jednostavna što sledeći primer demonstrira:

```haskell
> daLiJePozitivan x = if x > 0 then "Jeste" else "Nije"
> daLiJePozitivan 5
"Jeste"
```

Funkcija `daLiJePozitivan` daje odgovor da li je broj pozitivan u vidu stringa. Za konstrukciju `if-then-else` u Haskelu vаžno je:

1. iza `if` klauze mora se navesti izraz koji je logička vrednost (`True` ili `False`),
2. moraju se navesti povratne vrednosti za oba slučaja: i kada je uslov tačan i kada je uslov netačan,
3. povratne vrednosti za oba slučaja moraju biti istog tipa.

Ništa ne sprečava da zakomplikujemo povratne vrednosti u nekim od slučajeva. Prema tome možemo da napišemo i ovakvu funkciju

```haskell
duplirajNegativan = if x < 0 then 2 * x else x
```

### Guards

*Guards* je sintaksa pomoću koje je moguće testirati više uslova. Svaki od uslova se piše nakon vertikalne crte `|` nakon čega je potrebno staviti izraz koji se vraća u slučaju da je uslov tačan. *Guards* vraća vrednost koja odgovara prvom uslovu koji je zadovoljen. 

Na primer, funkciju koja vraća opis jačine zemljotresa na osnovu njegove jačine u Rihterima, možemo napisati ovako

```haskell
opisZemljotresa r
  | (r >= 0.0) && (r < 4.0) = "Mikro"
  | (r >= 2.0) && (r < 4.0) = "Manji"
  | (r >= 4.0) && (r < 5.0) = "Lakši"
  | (r >= 5.0) && (r < 6.0) = "Srednji"
  | (r >= 6.0) && (r < 7.0) = "Jak"
  | (r >= 7.0) && (r < 8.0) = "Velik"
  | (r >= 8.0) && (r < 10.0) = "Razarajući"
  | r >= 10 = "Epski"
```

Ako pozovemo `opisZemljotresa 5.6`, tada će prvi zadovoljen uslov biti `(r >= 5.0) && (r < 6.0)` zbog čega dobijamo kao rezultat `"Srednji"`.


Kao i kod `if-then-else` konstrukcije, i kod *guards* konstrukcije sve povratne vrednosi moraju biti istog tipa.

U prethodnom primeru možemo primetiti da uslove možemo pojednostaviti. Naime kako su uslovi poređani redom po jačini zemljotresa, možemo se osloboditi dela uslova kojim se proverava da je jačina zemljotresa jača od nekog inteziteta. Stoga funkciju `opisZemljotresa` možemo i ovako definisati

```haskell
opisZemljotresa r
  | (r >= 0.0) && (r < 4.0) = "Mikro"
  | r < 4.0 = "Manji"
  | r < 5.0 = "Lakši"
  | r < 6.0 = "Srednji"
  | r < 7.0 = "Jak"
  | r < 8.0 = "Velik"
  | r < 10.0 = "Razarajući"
  | r >= 10 = "Epski"
```

Ovako definisana funkcija `opisZemljotresa` nije totalna, što znači da nije definisana za svaku vrednost domena (u ovom slučaju to su realni brojevi). Na primer, pozivanjem `opisZemljotresa (-7)` dobijamo grešku, koja nas upozorava da naš argumen ne zadovoljava ni jedan od uslova.

```
Exception:
Non-exhaustive patterns in function opisZemljotresa
```

Da bi sprečila ovakva greška uobičajno je da se na kraju *guards*-a postavi slučaj koji je uvek zadovoljen. Taj slučaj se obelešava sa `otherwise`:

```haskell
opisZemljotresa r
  | (r >= 0.0) && (r < 4.0) = "Mikro"
  | r < 4.0 = "Manji"
  | r < 5.0 = "Lakši"
  | r < 6.0 = "Srednji"
  | r < 7.0 = "Jak"
  | r < 8.0 = "Velik"
  | r < 10.0 = "Razarajući"
  | r >= 10 = "Epski"
  | othervise = "Greška"
```

Zapravo, `otherwise` nije ništa drugo nego konstanta `True`. Zbog toga će *guards* konstrukcija uvek vratiti vrednost koja odgovara uvom uslovu kad stigne do njega.

*Guard* sintaksa može zameniti `if-then-else` sintaksu. Sledeće dve funkcije su jednake (gde su sa `s`, `a` i `b` označeni neki Haskel izraz koji potencijalno zavise od `x`).

```haskell
f x = if s then a else b
```

```haskell
f x 
  | s = aB 
  | otherwise = b 
```

### where

Dok je u imperativnim programskim jezicima moguće definisati i koristiti lokalne promenljive unutar tela neke funkcije, u Haskelu je tako nešto nemoguće. Sve vrednosti koje se definišu u Haskelu su konstantne i ne mogu se menjati.

Ali ipak je moguće pri definiciji funkcija definisati neke lokalne konstante izraze. Takvi izrazi se definišu pomoću naredbe `where`.


Na primer, funkciju koja vraća uređen par korena kvadratne jednačine sa koeficijentima `a`, `b` i `c` možemo ovako napisati (ova funkicja nije totalna ali to ćemo sada ignorisati):

```haskell
koreni a b c = ((-b - sqrt (b*b - 4*a*c))/(2 * a), (-b + sqrt (b*b - 4*a*c))/(2 * a))
```

Iako ova funkcija vraća korene kad god je diskriminanta veća od nule, definicija funkcije je nečitljiva. Zbog toga ćemo iskoristiti `where` da bi smo (lokalno) definisali diskriminantu `d`.

```haskell
koreni a b c = ((-b - d)/(2 * a), (-b + d)/(2 * a))
  where d = sqrt (b * b - 4* a * c)
```
Zapis je mnogo pregledniji sada. Ako želimo, možemo slično postupiti i sa koeficijentom `2 * a`:

```haskell
koreni a b c = ((-b - d)/s, (-b + d)/s)
    where d = sqrt (b * b - 4 * a * c)
    s = 2 * a
```

## Zadaci

1. Napisati funkciju `povrsinaKruga` koja za zadati poluprečnik kruga vraća njegovu površinu

2. Napisati funkciju `zapremina` koja na osnovu tri argumenta računa zapreminu kvadra čije su dužine stranica zadate tim argumentima.

3. Napisati program koji ispisuje maksimum tri uneta broja.

4. Napisati funkciju `fibonaci` koja za argument `n` računa `n`-ti Fibonačijev broj.

5. Napisati funkciju `sgn` koja računa znak broja (Znak predstavljamo brojevima `-1`, `0` i `1`. Npr. `sgn (-14) = -1`, `sgn 14 = 14`

6. Napisati program koji za unete koordinate temena ravanskog trougla izračunava njegov obim i površinu. Koordinate trougla predstaviti uređenim parovima brojeva.

7. Napisati program koji proverava da li je data niska palindrom (čita se isto sleva i zdesna, na primer, `"anavolimilovana"`).
