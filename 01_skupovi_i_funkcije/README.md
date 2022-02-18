# Skupovi i funkcije

Svakom programeru je jasna povezanost matematike i programiranja. U funkcionalnom ta veza je mnogo dublja nego što je to slučaj kod imperativne ili objektno orijentisane paradigme. Zbog toga, pre nego što započnemo sa funkcionalnim programiranjem, moramo se podsetiti nekih matematičkih osnova.

## Skupovi

Pojam *skupa* je jedan od najsnovnijih pojmova matematike. Štaviše, ovaj pojam je prisutan i u svakdnevnom životu i njime označavamo kolekciju objekata. Ipak, *teorija skupova*, matematička oblast koja se bavi skupovima, je mlada oblast matematike. Može se reći da ova teorija nastala krajem XIX veka u radovima [Georga Kantora](https://en.wikipedia.org/wiki/Georg_Cantor) i [Johana Dirihlea](https://en.wikipedia.org/wiki/Peter_Gustav_Lejeune_Dirichlet). Kantorova teorija skupova, kako je danas nazivamo, je brzo našla primenu u oblasti matematičke analize. Uz pomoć teorije skupova, opisana su neka fundamentalna svojstva skupa realnih brojeva, i uspostavljena je hijerarhija između razlčičitih beskonačnosti.

U tadašnjoj teoriji skupova, moge stvari su uzimane zdravo-za-gotovo. Tako je, na primer, Kantorova teorija, dozvoljavala definisanje skupova iskazima poput sledećeg *`x` pripada skupu `S` ako i samo ako važi `P(x)`.*

Iako na prvi pogled ovakva definicija (određenog) skupa deluje logično, ona može dovesti do paradoksa. Jedan takav paradoks je otkrio [Bertrand Rasel](https://en.wikipedia.org/wiki/Bertrand_Russell) 1901. godine kada je definisao skup `S` kao skup svih skupova koji ne sadrže sami sebe, odnosno važi *`x` pripada skupu `S` ako i samo ako `x` ne pripada `x`*. Ako se zapitamo da li skup `S` pripada sam sebi, doćićemo do kontradiktornih odgovora: po definiciji skupa `S` važi da `S` pripada skupu `S`, ako i samo ako skup `S` ne pripada skupu `S`.

Da bi prevazišli ovakve probleme, matematičari su predložili formalizovanje teorije skupova. Sam Rasel je predložio *teoriju tipova* dok je [Ernst Zermalo](https://en.wikipedia.org/wiki/Ernst_Zermelo) predložio aksiomatizaciju teorije skupova. Zermalova teorija se ubrzo razvila u takozvanu Zermalo-Frenkelovu teoriju skupova,  koja je postala opšteprihvaćena u matematičkoj zajednici do danas.

Za naše potrebe, dovoljno je poznavanje teorije skupova na nivou *naivne*, odnosno Kantorove, teorije skupova. Ipak, potrebno je biti svestan da nas nepažljivo baratanje s skupovima može dovesti do logičkih problema.

Dakle, za nas *skup* predstavlja nekakvu kolekciju elemenata. Činjencu da element `x` pripada skupu `S` obeležavamo sa `x ∈ S`.

U matematici, često se sreću sledeći skupovi: skup prirodnih brojeva `ℕ`, skup celih brojeva `ℤ`, skup racionalnih brojeva `ℚ`, skup realnih brojeva `ℝ`, skup kompleksnih brojeva `ℂ`, itd...

Između dva skupa mogu se uspostaviti nekakve relacije. Ako su su svi elementi skupa `A` ujedno i elementi skupa `B`, tada kažemo da je skup `A` *podskup* skupa `B`, i to označavamo sa `A ⊆ B`. Ako istovremeno važi da je `A ⊆ B` i `B ⊆ A` tada za skupove `A` i `B` kažemo da su *jednaki* i to označavamo sa `A = B`. Dakle, skupovi su jednaki ako i samo ako imaju iste elemente. Ako skupovi `A` i `B` nemaju nijedan zajednički element, tada za te skupove kažemo da su *disjunktni*.

Kao što nad brojevima možemo vršiti aritmetičke operacije, nad logičkim vrednostima logičke operacije, itd. tako i nad skupovima možemo vršiti neke operacije:

+ *Unija* skupova `A` i `B`, u oznaci `A ∪ B`, je skup koji sadrži sve elemente skupa `A` i sve elemente skupa `B` i drugih elemenata nema. 
+ *Presek* skupova `A` i `B`, u oznaci `A ∩ B`, je skup koji sadrži samo elemente koji pripadaju i skupu `A` i skupu `B`.
+ *Razlika* skupova `A` i `B`, u oznaci `A \ B`, je skup koji sadrži samo elemente skupa `A` koji ne pripadju skupu `B`.
+ *Dekartov proizvod* skupova `A` i `B`, u oznaci `A ⨯ B`,  je skup svih uređenih parova, čija prva kordinata pripada skupu `A` a druga koordinata pripada skupu `B`.

Ako je skup `X` ima konačno mnogo elemenata, tada sa `|X|` označavamo broj elemenata skupa `X`.

## Funkcije

Funkcija je jedan od najosnovnijih pojmova matematike, a kao što ćemo i videti, i funkcionalnog programiranja.

Formalno, pojam funkcije u matematici se definiše preko pojma relacije, koji se definiše preko pojma Dekartovog proizvoda skupova. Ovakav pristup preko teorije skupova za nas nije od velike važnosti, te ćemo dati naivnu ali pragamtičnu definciju: *Funkcija je pravilo po kom se svakom elementu jednog skupa (kog nazivamo domen funkcije), pridružuje jedinstven element drugog skupa (kog nazivamo kodomen funkcije)*.

Dakle, funkcija je zapravo pridruživanje elemenata domena elementima kodomena. Činjenicu da je neka funkcija `f` ima domen `X` i kodomen `Y` zapisujemo kao `f: X → Y` i za samu funkciju `f` kažemo da je *`f` funkcija iz `X` u `Y`*. Izraz  `X → Y` nazivamo *tip* funkcije. Činjenicu da funkcija `f` pridržužuje element `y` elementu `x` zapsiujemo kao `f(x) = y`.

**Primeri**:

+ funkcija `f: ℝ → ℝ` definisana sa `f(x) = 2*x` pridružuje svakom realnom broju njeguvo dvostruku vrednost.
+ na svakom skupu `X` moguće je definisati *identičku funkciju* `idX: X → X` za koju važi `idX(x) = x`.
+ ako je `X` proizvoljan skup, `Y` neprazan skup, i `c` proizvoljan element skupa `Y`, tada možemo definisati *konstantnu funkciju* `f(x) = c`. Ova funkcija svim elementima skupa `X` pridružuje element `c`.
+ ako je `X` prazan skup tada postoji jedinstvena funkcija iz `X` u proizvoljan skup `Y`. Ovu funkciju nazivamo *prazna funkcija*. Ona ne uzima argumente, niti daje vrednosti.
+ ako `X` nije prazan skup, a `Y` jeste prazan skup, tada ne postoji funkcija tipa `X → Y`. Jer u suprotnom, nekom elementu `x` iz `X` bi mora biti pridružen element `y` iz `Y` što je nemoguće.

Funkcije između skupova brojeva najčešće zadajemo analitičkim izrazima. Ponekad funkciju i zadajemo razdvajanjem na slučajeve u zavisnosti od argumenta. Na primer, funkcija `abs: ℝ → ℝ` može se definisati:

```
        ⎧  x, ako je x ≥ 0 
asb x = ⎨
        ⎩ -x, ako je x < 0
```

Kad god imamo funkcije `f: X → Y` i `g: Y → Z`, tada možemo kontstrusati novu funkciju `h: X → Z` *kompozicijom* funkcija `f` i `g` sledećim izrazom `h(x) = g(f(x))`. Činjenicu da je `h` kompozicija funkcija `f` i `g` označavamo sa `h = g ∘ f`.

Kompozicija `g ∘ f` ima smisla samo ako je kodomen funkcije `f` jednak domenu funkcije `g`. Ali čak i kada `g ∘ f` ima smisla ne mora važiti `g ∘ f = f ∘ g`. Ipak, za identičku funkciju `id` važi `id ∘ f = f = f ∘ id`.

Kompozicija funkcija je asocijativna operacija, odnosno važi `(h ∘ g) ∘ f = h ∘ (g ∘ f)` kad god navedene kompozicije imaju smisla.

Ako je `f: X → Y` tada za `f` kažemo da je:

+ **surjekcija** ako za svako `y ∈ Y` postoji `x ∈ X` takvo da je `f(x) = y`.
+ **injekcija** ako iz `f(x₁) = f(x₂)` sledi `x₁ = x₂`
+ **bijekcija** ako je surjekcija i injekcija

Ako je funckija `f: X → Y` bijekcija, tada postoji funkcija `F: Y → X` za koju važi da je `F ∘ f = idX` i `f ∘ F = idY`. Funkciju `F` nazivamo inverznom funkcijom funkcije `f`.

Zanimljivo je primetiti sledeće, ako je `f` surjektivna funkcija, tada iz `g₁ ∘ f = g₂ ∘ f` sled i `g₁ = g₂`. Slično, ako je `f` injekcija tada iz `f ∘ g₁ = f ∘ g₂` sledi da je `g₁ = g₂`.

**Primeri**:

+ funkcija `pow2: ℕ → ℕ` definisana sa `pow2(n) = 2ⁿ` jeste injekcija ali nije surjekcija, jer ne postoji prirodan broj `n` broj za koji važi `2ⁿ = 3`.
+ funkcija korenovanja `sqrt: ℝ+ → ℝ` definisana sa `sqrt(x) = √x` jeste injekcija ali nije surjekcija.
+ funkcija `sin: ℝ → ℝ` nije ni injekcija ni surjekcija.

## Funkcije u matematici i u programiranju

U mnogim programskim jezicima susrećemo se s pojmom funkcije. Iako su te funkcije bliske "matematičkom" pojmu funkcije, ipak postoje neke suptilne razlike.

Na primer, pandan "matematičkoj" funkciji sabiraranja `+: ℤ × ℤ → ℤ` u imperativnom programiranju bi bila funkcija poput sledeće

```C
int sum (int a, int b) {
    return a + b;
}
```

Iako na prvi pogled jednake, funkcija napisana u `C` jeziku neće vratiti uvek sumu svojih argumenata. Njena preciznost je ograničena dužinom procesorske reči računara na kom se izvršava, i za dovoljno velike vrednosti argumenta, može doći do ograničenja. Slično navedenom harderverskom ograničenju, neke funkcije su ograničene nedostatkom radne memorije. Naravno, kada govorimo o matematičoj definiciji funkicija, ovakva ograničenja nas mnogo ne interesuju.

Međutim, moderni računari su izuzetno moćni, pa često možemo u praksi da zanemarimo hardverska ograničenja. Pogledajmo zato drugu razliku.

Za razliku od "matematičkih" funkcija, koje su definisane na svakom elementu domena, funkcije u računarstvu to ne moraju biti. Na primer, posmatrajući samo potpis naredne C funkcije, mogli bismo da zaključimo da je ona tipa `ℤ → ℤ`.

```C
int f (int a) {
    int j = 0;
    for (int i = 100; i > 1; i = i / a) {
        j++
    }
    return j;
}
```

Ipak, navedena funkcija nije definisana za `a = 1`, jer će u tom slučaju program ući u beskonačnu petlju.

U računarstvu, funkcije koje su definisane za svaki argument domena, nazivamo *totalnim*. Nažalost, u opštem slučaju je nemoguće reći da li je neka funkcija totalna. Ovo ograničenje leži u samim osnovama teorijskog računarstva i ne možemo mnogo učiniti za njegovo rešavanje.

Postoji još jedna aspekt po kom se matematički i programerski pojam funkcije razlikuju. Za razliku od "matematičkih" funkcija koje za isti argument uvek daju istu vrednost, mnoge funkcije u programiranju nemaju ovu osobinu. Na primer, C funkcija `scanf` (ili `gets`, `getline`, itd...) koja učitava nisku iz korisničkog intervala će uvek vratiti neku novu vrednost. Isto važi i za `random` funkciju koja vraća nasumičnu vrednost.

## Zadaci

1. Neka su `X` i `Y` konačni skupovi, i neka važi `|X|=n` i `|Y|=m`. Koliko je `|X ⊔ Y|`, a koliko `|X × Y|`?
1. Ako je `X = {1, 2, 3, 4, 5, 6, 7, 8}` a `Y = {a, b, c, d, e, f}`, naći `(X × Y) ∩ (Y × X)`.
1. Naći skup `A` takav da važi `A ∩ ℕ = ∅` i `A ∪ ℕ = ℕ`
1. Naći primer funkcija `f` i `g` takvih da je `f ∘ g = g ∘ f`.
1. Naći primer funkcije `f` takve da je `f = f ∘ f = f ∘ f ∘ f = ...`
