# Lambda račun

## Istorija

### Pojam izračunljivosti

Početkom XX veka matematičari su pokušali da formalno definišu pojam izračunljivosti. Tokom  tridesetih godina prošlog veka pojavilo se nekoliko različitih formalizama:

+ Kurt Gedel je zasnovao pojam izračunljivosti na osnovu *μ rekurzivnih funkcija*.
+ Alan Tjuring je pojam izračunljivost definisao pomoću pojma tzv. *Tjuringove mašine*.
+ Alonco Čerč je definisao λ račun za potrebe istraživanja matematičke logike, da bi ubrzo uvideo da se λ račun takođe može iskoristiti za definiciju izračunljivosti.

Ubrzo nakon publikovanja ovih formalizama, ispostavilo se da su formalizmi isti! Tačnije, za funkciju `f: ℕ → ℕ` sledeća tvrđenja su ekvivalentna:

+ `f` pripada klasi *μ rekurzivnih funkcija*.
+ `f` se može izračunati Tjuringovom mašinom.
+ `f` je λ izračunljiva.

Činjenica da su tri nezavisno definisana formalizma međusobno ekvivalentna, ide u prilog *Čerč-Tjuringovoj* tezi koja tvrdi da *svaka intuitivno izračunljiva funkcija je Tjuring izračunljiva*.

### Zašto su formalizmi bitni?

Osim što daju odgovor na pitanje izračunljivosti funkcija, navedeni formalizmi imaju dublji smisao.

Gedelova teorija rekurzivnih funkcija je dala odgovore na mnoga duboka pitanja matematičke logike i teorijskog računarstva. Slično je i sa Tjuringovim formalizmom, koji je osim toga dao i model modernog računara.

Čerčov λ račun je najjednostavniji ali i najapstraktniji od sva tri navedena formalizma. Lambda račun je povezan s ostalim matematičkim teorijama (teorija dokaza i teorija kategorija), i predstavlja teorijsku osnovu svih funkcionalnih programskih jezika.

## Račun

Lambda račun je sistem koji opisuje osnovne načine kombinacija funkcija i primena tih funkcija na vrednosti. U osnovi lambda računa su lambda izrazi koji odgovaraju definicijama funkcija.

Definicija funkcija

```
Klasičan oblik   f(x) = x² + 2
Lambda račun     f = λx.x² +2
```

Primena funkcije na argument

```
Klasičan oblik  f (2)
Lambda račun    f 2
```

Kao što se u aritmetici pojam *račun* odnosi na pojednostavljenje aritmetičkih izraza uz pomoć aritmetičkih pravila, tako je λ račun u suštini proces pojednostavljenja λ izraza pomoću određenih pravila.

Skup lambda izraza `Λ` je najmanji skup za koji važi:

+ Promenljive `x`, `y`, `z`... pripadaju skupu `Λ`.
+ Ako je `x` promenljiva i `M` pripada `Λ`, tada i `(λx.M)` pripada skupu `Λ`.
+ Ako `M` i `N` pripadaju skupu `Λ`, tada `(M N)` pripada skupu `Λ`.

Izraz `(λx. M)` nazivamo *apstrakcijom* izraza `M`, a izraz `(M N)` nazivamo *aplikacijom* (ili *primenom*) izraza `M` na izraz `N`.

### Interpretacija lambda izraza

Lambda izrazi se mogu shvatiti kao uopštenja definicija i primene funkcija:

+ Aplikacija `M N` se može intrpretirati kao primena "funkcije" `M` na vrednost `N`, tj. `M(N)`.
+ Apstrakcija `λx.M` se može interpretirati kao definicija "funkcije" čija vrednost za argument `N` se dobija zamenom svih pojavljanja pomenljive `x` u `M` sa `N`.

Na primer, lambda izraz `λx.x` se može shvatiti kao identička funkcija `f(x) = x`, dok se lambda izraz `λx.y` može shvatiti kao konstantna "funkcija" `f(x) = y`.

### Zagrade u lambda izrazima

Kao što pri radu sa aritmetičkim izrazima možemo izostaviti neke zagrade, tako i u lambda računu postoje pravila koja pojednostavljuju zapis lambda izraza:

1. **Spoljne zagrade ne zapisujemo**: umesto `(M)` pišemo `M`.
2. **Aplikacija lambda izraza je levo-asocijativna**: umesto `((M N) P)` pišemo `(M N P)`
3. **Apstrakcija je desno asocijativna**: umesto `λx.(λy.M)` pišemo `λx.λy.M`
4. **Aplikacija ima veći prioritet u odnosu na apstrakciju**: umesto `λx.(M N)` pišemo `λx.M N`.

Osim navedenih pravila sa zagradama, postoji još jedno pravilo koje skraćuje zapis:

5. **Višestruke apstrakcije možemo spojiti pod jednu lambdu**: umesto `λx.λy.M` pišemo `λxy.M`, umesto `λx.λy.λz.M` pišemo `λxyz.M` i sl.

### Sintaksna jednakost lambda izraza

Kada su dva lambda izraza, `M` i `N`, jednaka kao dva niza simbola, tada za njih kažemo da su sintaksno jednaki i pišemo `M ≡ N`. Pri ovom poređenju ignorišemo razlike u zagradama koje se uspostavljaju opisanom konvencijom o pisanju zagrada.

Na primer `λx.(x  y) ≡ λx.x  y /≡ λz.z  y.`

### Vezane i slobodne promenljive

Za razumevanje pojmova koji slede, potrebno je razumeti koncept *slobodne promenljive*.

Skup svih slobodnih promenljivih `FV(M)` lambda izraza `M` definišemo na sledeći način:

+ `FV(M) = {x}` ako je `M ≡ x`.
+ `FV(M N) = FV(M) ∪ FV(N)`.
+ `FV(λx.M) = FV(M) \ {x}`.

Za promenljivu `x` koja se nalazi u izrazu `M` a ne pripada `FV(M)` kažemo da je *vezana*. Po trećoj tački gornje definicje, takva promenljiva mora biti *vezana* barem jednom *lambdom*.

### Zamena promenljiva

Lambda izrazi `λx.x` i `λy.y` *nisu* sintaksno jednaki. Ipak, interpretirani kao funkcije, ovi izrazi predstavljaju istu funkciju, odnosno *identičku* funkciju `f(a) = a`.

U matematici je jasno da zamena imena promenljive (uz određenu opreznost) suštinski ne menja funkciju. Stoga je korisno, zapravo neophodno, uvesti sličnu vrstu ekvivalencije u lambda račun.

Neka su `x`, `y` i `z` različite promenljive. Supstiticiju (zamenu) izraza `N` u slobodna ponavljanja promenljive `x` u izrazu `M` označavamo sa `M [N/x]`. Preciznije:

+ `x [N/x] ≡ N`.
+ `y [N/x] ≡ y` za svako `y ≠ x`.
+ `(P  Q) [N/x] ≡(P [N/x]) (Q [N/x])`.
+ `(λx.P) [N/x] ≡ λx.P`.
+ `(λy.P) [N/x] ≡ λx.(P [N/x])` ako `y ∉ FV(N)`.
+ `(λy.{P}) [N/x] ≡ λz.(P [z/y][N/x])` ako `y ∈ FV(N)`.

### Alfa konverzija

Neka je lambda izraz `M` sadrži izraz oblika `λx.P` pri čemu `y ∉ FV(P)`. *Alfa konverzijom* nazivamo postupak zamene izraza `λx.P` u `λy.(P [y/x])`.

Ako se izraz `P` može transformisati u izraz `Q` konačnom primenom alfa konverzija, tada kažemo da su `P` i `Q` *alfa ekvivalentni* i pišemo `P = Q`.

Relacija `=` jeste relacije ekvivlencije, odnosno važi:

+ `M = M` (refleksivnost)
+ Ako `M = N` tada i `N = M` (simetričnost)
+ Ako `M = M` i `N = P` tada i `M = P` (tranzitivnost)

### Beta redukcija

Svaki izraz oblika `(λx.M) N` nazivamo *redeks*. Proces zamene redeksa `(λx.M) N` s izrazom `M [N/x]` nazivamo *kontrakcija*.

Ako izraz `P` sadrži redeks `(λx.M) N`, tada kontrakcijom redeksa `(λx.M) N` dobijamo novi lambda izraz `P'`. Ovaj postupak nazivamo *beta redukcija*.

Ako se od `P` u konačno mnogo redukcija može dobiti `P'` tada pišemo `P → P'`.

Dokle možemo da vršimo beta redukciju izraza?  Dokle god imamo redeks u izrazu!

Redukcijom "uprošćavamo" lambda izraze. Lambda izraz koji ne sadrži redeks ne možemo da dalje da redukujemo i za taj izraz kažemo da je u *normalnoj formi*. Ako se lambda izraz `M` može svesti u normalnu formu u konačno mnogo redukcija, tada za `M` kažemo da poseduje normalnu formu.

Na primer, izraz `(λx.λy.x y) u v` nije u normalnoj formi, ali poseduje normalnu formu jer se u dve beta redukcije svodi na `u v`.

Nema svaki lambda izraz normalnu formu!

```
(λx.x x) (λx.x x) → (λx.x x) (λx.x x) → (λx.x x) (λx.x x) → ...
```

Kao što vidimo, postupak beta redukcije izraza `(λx.x x) (λx.x x)` se nikad ne završava. Štaviše, naredni primer pokazuje da proces beta redukcije može neograničeno uvećavati složenost izraza

```
(λx.x x y) (λx.x x y) → (λx.x x y) (λx.x x y) y → (λx.x x y) (λx.x x y) y y → ...
```

Naredno pitanje koje možemo postaviti o beta redukciji tiče se poretka redukovanja redeksa u izrazima: da li će nas svaki redosled redukcija dovesti do istog rešenja?

**Prva Čerč-Roserova teorema** Ako `M → N₁` i `M → N₂` tada postoji lambda izraz `T` takav da `N₁ → T` i `N₂ → T`

Čerč-Roserova teorema nam kaže da poredak vršenja beta redukcija nije bitan.

### Funkcije više promenljiva

Funkcije više promenljiva su izuzetno važne i za matematiku i za programiranje. Međutim, `λ` račun dozvoljava definisanje samo funkcija jedne promenljive (pravilom apstrakcije), što na prvi pogled deluje kao ograničenje.

Pre nego što pokažemo da je lamda račun dovoljno ekspresivan da opiše funkcije više promenljiva  pogledajmo jedan primer.  

Operacija sabiranja brojeva (npr. celih), nije ništa drugo nego funkcija dve promenljive:

```
S(m,n) = m + n.
```

Osim funkcije `S`, možemo posmatrati i funkcije `Sₘ` definisane sa:

```
Sₘ(n)= m + n.
```

Definišimo funkciju `Σ` koja celom broju `m` dodeljuje *funkciju* `Sₘ`:

```
Σ(m) = Sₘ.
```

Sada sabiranje brojeva, funkciju od dva argumenta, možemo predstaviti uz pomoć dve funkcije jedne promenljive:

```
m + n = Sₘ(n) = (Σ(m))(n)
```

Dakle, da bismo sabrali brojeve `m` i `n`, prvo smo funkciju `Σ` primenili na broj `m`, a zatim smo rezultat te primene primenili na broj `n`.

Opisana tehnika predstavljanja funkcija više promenljiva pomoću funkcija jedne promenljive naziva se *karijevanje* (eng. currying, po logičaru Haskell Curry-ju).

Tehnika karijevanja nam daje interpretaciju višestruke apstrakcije. Od sada, lambda izraz oblika `λx₁.λx₂...λxₙ.N` možemo shvatiti kao funkciju `n` promenljiva.

### Kombinatori

*Kombinatori* su lambda izrazi u kojima ne pojavljuju slobodne promenljive.

Redukcija kombinatora primenjenog na druge lambda izraza ne zavisi od konteksta, zbog čega se kombinatori mogu smatrati "bližim" matematičkom pojmu funkcije nego ostali lambda izrazi.

Na primer, za kombinator `K ≡ λxy.y x` uvek će važiti da se izraz `K u v` redukuje u normalnu formu `v u`. S druge strane, za lambda izraz `S ≡ λx.y x` važi da njegova redukcija zavisi od konteksta. Na primer, `S u` ima normalnu formu `y u`, ali normalna forma izraza `(λy.S x) (λz.s)` ne sadrži `x` niti je 'konstantna'!

Sledeći kombinatori su imaju posebna imena (još neke ćemo kasnije navesti):

+ `I ≡ λx.x`,
+ `K ≡ λxy.x`,
+ `S ≡ λxyz.x z (y z)`

Zbog svoje 'funkcionalnosti', kombinatori se mogu definisati jednakostima. Na primer, sledeće jednakosti kompletno definišu gorepomenute kombinatore:

```
IX = X
KXY = X
SXYZ = XZ(YZ).
```

### Kombinatorni račun

Naravno i sa kombinatorima možemo da računamo kao i sa lambbda izrazima. Štaviše, u slučaju kominatora, račun je mnogo jednostavniji.

```
SKI(KIS) → SKII → KI(II) → KII → I
```

```
SKIK → KK(IK) → KKK → K
```

Upravo je ovakav *kombinatorni račun* definisao ruski matematičar Moses Šonfinkel 1920. godine, 15 godina pre Čerčovog lambda računa. Nakon otkrića lambda računa, ispostavilo se da je kombinatorni račun sa `S`, `K`, `I` kombinatorima ekvivalentan lambda računu!

Ipak SKI račun nije najmanji Tjuring kompletan sistem! Čitav SKI račun je moguće svesti na račun sa jednim jedinim kombinatorom! To je takozvani *jota* kombinator:

```
ι ≡ λf.((f S) K)
```

Da jota račun sadrži SKI račun sledi iz jednakosti

```
I = (ιι)   K = (ι(ι(ιι)))    S =(ι(ι(ι(ιι))))
```

## Logika

### Grananje

Na početku prezentacije smo rekli da je lambda račun jedan model koncepta izračunljivosti. Danas kada razmišljamo o izračunljivosti i algoritmima, obično razmišljamo o programskim (imperativnim) jezicima. Jednа od karakterističnih konstrukcija takvih jezika su i naredbe grananja kojima se kontorliše tok programa.

Sada ćemo prikazati kako se u lambda računu može implementirati iskazna logika i naredba grananja.

### if-then-else

Iako moderni jezici sadrže mnoge naredbe grananja (`if-else`, `if-elseif-else`, `switch`), sve te naredbe se mogu svesti na izraze poput narednog:

```
if A then X else Y
```

Postavlja se pitanje, kako u terminima lambda računa formulisati pojmove tačnog i netačnog? Na prvi pogled ne možemo mnogo iskazati na jeziku lambda izraza.

Odgovor leži u izrazu `if A then X else Y.` Kao što smo rekli, za ovakav izraz važi:W

```
if ⊤ then X else Y = X
if ⊥ then X else Y = Y
```

Ovo bi nas moglo navesti da same logičke vrednosti `⊤` i `⊥` shvatimo kao funkcije od dva argumenta za koje važi

```
T (X, Y) = X
F (X, Y) = Y
```

Sada je lako definisati odgovarajuće lambda izraze:

```
T ≡ λx.λy.x 
F ≡ λx.λy.y
```

Ovako definisani kombinatori zaista oponašaju *if-then-else* konstrukciju jer:

```
T X Y → (λx.λy.x) X Y → (λy.X) Y → X
F X Y → (λx.λy.y) X Y → (λy.y) Y → Y
```

### Logički veznici

Logičke veznike takođe definišemo kao kombinatore:

```
¬ &≡ λx.x F T
∧ &≡ λx.λy.x y F
∨ &≡ λx.λy.x T y
```

Lako se proverava da za ovako definisane kombinatore važe odgovarajuće relacije:

```
¬ T → F
¬ F → T
```

```
∧ T T → T
∧ T F → F
∧ F T → F
∧ T F → F
```

```
∨ T T → T 
∨ T F → T
∨ F T → T 
∨ T F → F
```

## Zadaci

U narednim primerima postaviti zagrade na odgovarajuće mesto na osnovu pravila s prethodnog slajda:

+ `x y z (y x)`
+ `λx.u x y`
+ `λu.u (λx.y)`
+ `(λu.v u u) z y`
+ `u x (y z) (λv.v y)`
+ `(λxyz.x z (y z)) u v w`

Izvršiti navedene substitucije

+ `(λy.x (λw.v w x)) [(u v)/x]`
+ `(λy.x (λx.x)) [(λy.{x y})/x]`
+ `(y (λv.x v)) [(λy.v y)/x]`
+ `(λx.z y) [(u v)/x]`

Svesti naredne izraze na normalnu formu:

+ `(λx.x y) (λu.v u u)`
+ `λxy.y x u v}`
+ `(λx.x (x (y z)) x)) (λu.{u v})`
+ `(λx.x x y)(λy.y z)`
+ `(λxy.x y y) (λu.u y x)`
+ `(λxyz.x z (y z)) ((λxy.y x) u) ((λxy.y x) v) w`

Navesti jedan lambda izraz `M` koji nema normalnu formu. Da li izraz `(λx.c) M` ima normalnu formu?
