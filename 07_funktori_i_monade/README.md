# Funktori i monade

Koncepti funktora i monade su izuzetno važni za jezik Haskel. Iako se mnogi Haskel programi (ali ne svi!) mogu zapisati bez korišćenja navedenih koncepata, njihovo korišćenje značajno olakšava pisanje, kao i čitanje, Haskel koda.

Iako su i funktor i monada preuzeti i veoma apstraktne ablasti matematike (teorija kategorija), videćemo da se u Haskelu ovi koncepti svode na klase tipova (a to je nešto sa čim smo se već upoznali). Iako na privi pogled definicje funktora i monade deluju apstraktno, mnogobrojni primeri pokazuju da se ove apstraktne ideje često pojavljuju u programiranju.

## Motivacija

U jednoj od prethodnih lekcija, obradili smo `Maybe` tip. Kao što smo videli, `Maybe a` je tip koji osim vrednosti tipa `a` sadrži i vrednost `Nothing` koja predstavlja odsustvo vrednosti. 

Zamislimo sada da od neke funkcije dobijamo vrednost tipa `Maybe Float` (naveli smo ranije takav primer sa temperaturnim senzorom). Ako želimo dalje da obrađujemo ovu vrednost možemo se osloboditi `Maybe` 'omotača'. Na primer ako želimo da vrednost unutar `Just` konstruktora pomnožimo sa dva, možemo napisati ovakvu funkciju:

```haskell
dupliraj :: Maybe Float -> Float
dupliraj (Just a) = 2 * a
```

Nažalost, funkcija `dupliraj` nije totalna. Ako joj prosledimo vrednost `Nothing` doći će izuzetka i program će biti prekinut. Dakle, moramo vratiti vrednost tipa `Float` i u slučaju kada je prosleđeno `Nothing`. Stoga naša funkcija sada izgleda ovako

```haskell
dupliraj' :: Maybe Float -> Float
dupliraj' (Just a) = 2 * a
dupliraj' Nothing = 0
```

*U gornjem primeru vrednost `0` je proizvoljno odabrana, ilustarcije radi.*

Naša funkcija je sada totalna, ali uočavamo drugi problem: izgubili smo informaciju koju `Maybe` tip nosi u sebi. Od sada više ne možemo da razlikujemo vrednost `0` koja je "došla" iz `Just 0` od one koja je "došla" od `Nothing`. Ponekad je dozvoljeno napraviti takav gubitak informacije, ali često postoje i situacije kada nije. Zbog toga napisaćemo treću verziju funkcije `dupliraj`:

```haskell
dupliraj'' :: Maybe Float -> Maybe Float
dupliraj'' (Just a) = 2 * a
dupliraj'' Nothing = Nothing
```

Sada je naša funkcija toptalna, i ispravno obrađuje vrednost `Nothing` (bolje reći, prosleđuje je). Na prvi pogled sve je u redu. Ali kako budemo razvijali sve više funkcija, primetićemo da pišemo mnogo funkcija iste strukture:

```haskell
g :: a -> b
-- g je neka proizvoljna (i totalna) funkcija

f :: Maybe a -> Maybe b
f (Just a) =  Just (g a)
f Nothing = Nothing
```

*Uvidećmo da često koristimo neku drugu funkciju `g :: a -> b`, da bismo definisali funkciju `f :: Maybe a -> Maybe b`. Gotovo uvek će ta definicija imati strukturu koju smo naveli gore.*

Ponavljanje koda je loše iz mnogih objektivnih razloga. Zbog toga želimo da konstruišemo jednu funkciju višeg reda koja će nas osloboditi zamornog kopiranja koda. Ta funkcija će kao parametre imati funkciju `f :: a -> b` i vrednost tipa `Maybe a`, a vratiće vrednost tipa `Maybe b` u skladu sa prethodno navedenom šemom. Na osnovu ovakvog opisa nije teško napisati definiciju:

```haskell
maybeF :: (a -> b) -> Maybe a -> Maybe b 
maybeF f (Just a) = Just (f a)
maybeF _ Nothing = Nothing
```

Sada se `dupliraj''` od malopre moze elegantnije iskazati

```haskell
dupliraj'' :: Maybe Float -> Maybe Float
dupliraj'' x = maybeF (2*) x
```

Ako posmatramo funckiju `maybeF` kroz tehniku karijevanja, vidimo da ona uzima jednu funkciju tipa `a -> b` i daje funkciju tipa `Maybe a -> Maybe b`. Rečeno žargonom Haskel programera, funkcija `maybeF` *podiže* funkciju tipa `a -> b` u funkciju tipa `Maybe a -> Maybe b`. Međutim, mi smo tako nešto već videli u prošloj sekciji sa funkcijom `map`. Funkcija `map` od podiže funkciju tipa `a -> b` u funkciju tipa `[a] -> [b]` (potpuno analogno funkciji `maybeF`). 

Klasa koju ćemo sada definisati, obuhvata oba ova primera i još mnoge druge.

## Functor

U Haskel jeziku, `Functor` je klasa tipova koja propisuje samo jednu funkciju:

```haskell
class Functor f where  
    fmap :: (a -> b) -> f a -> f b
```

Prvo što bi trebalo da uočimo jeste da konkretni tipovi (tipovi vrste `*`) ne mogu pripadati ovoj klasi! Zaista, iz druge linije definicje vidimo da je `fmap` tipa `(a -> b) -> f a -> f b` iz čeka sledi da `f` mora biti tipska funkcija odnosno posedovati tip `* -> *`.

Drugo što primećujemo je da tip `(a -> b) -> f a -> f b` funkcije `fmap` ima istu strukturu kao tip funkcije `maybeF :: (a -> b) -> Maybe a -> Maybe b` odnosno `map :: (a -> b) -> [a] -> [b]` (setite se da je `[]` tipska funkcija!).

Ono što nismo naveli u kodu su dva pravila koja `fmap` mora da zadovoljava:

1. **Funktor mora da čuva `id` funkciju** tj. mora da važi `fmap id = id`. (primetimo da funkcije `id` sa različitih strana navedene jednakosti imaju različite tipove)
2. **Funktor mora da čuva kompoziciju funkcija** tj. mora da važi `fmap g . fmap h = fmap (g . h)`

Svaku tipsku funkciju koja implementira `fmap` tako da su oba pravila zadovoljena, nazivamo *funktor*.

## Motivacija 2


## Aplicative




## Monad