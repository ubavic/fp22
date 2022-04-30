# Rekurzivni tipovi podataka

## Lista

## Binarno stablo



## Zadaci

1. Napraviti tip `AritmetickiIzraz` koji predstavlja aritmetičke izraze sačinjenje od celobrojnih vrednosti i operacija sabiranja i množenja. Uvesti tip `AritmetickiIzraz` u `Show` klasu tipova tj. implementirati `show :: AritmetickiIzraz -> String`. Implementirati funkciju `izracunajAritmeticki :: AritmetickiIzraz -> Int` koja izračunava zadati aritmetički izraz. [*Rešenje*](./aritmeticki_izrazi.hs)
2. Analogno prethodnom zadatku kreirati program koji izračunava logičke izraze. Preciznije: Napraviti tip `LogickiIzraz` koji predstavlja aritmetičke izraze sačinjenje od logičkih vrednosti i operacija konjunkcije i disjunkcije. Uvesti tip `LogickiIzraz` u `Show` klasu tipova tj. implementirati `show :: LogickiIzraz -> String`. Implementirati funkciju `izracunajLogicki :: LogickiIzraz -> Bool` koja izračunava zadati aritmetički izraz. [*Rešenje*](./logički_izrazi.hs)
3. *Za ovaj zadatak je neophodno uraditi oba prethodna zadatka.* Neka je data funkicja `f :: Int -> Bool` sa `f x = if x \=0 then True else False`. Konstruistai funkciju `konvertuj :: AritmetickiIzraz -> LogickiIzraz` koja logički izraz prevodi u aritmetički izraz tako što sabiranje prevodi u disjunkciju, množenje u konjunkciju a brojeve u skladu sa datom funkcijom `f`. Na primer izraz `2 * (7 + 0)` se konvertuje u `⊤ ∧ (⊤ ∨ ⊥)`, a izraz `(-2) * 3 + 2 * 0` u `⊤ ∧ ⊤ ∨ ⊤ ∧ ⊥`. Da li važi `f . izracunajAritmeticki = izracunajLogicki . konvertuj`?
4. Napraviti tip `Izraz` koji prezentuje izraz sačinjen od ralnih brojeva, nepoznate `x`, sabiranja, oduzimanja, množenja, deljenja, stepenovanja, sinusa, kosinusa, eksponencijalne i logaritamske funkcije. Konstruistai funkciju `izvod :: Izraz -> Izraz` koja pronalazi izvod izraza. Konstruistai funkciju `simplify` koja pojednostavljuje izraz koristeći razne matematičke identitete (npr. `a + 0 = a` za svaki izraz `a`). [*Rešenje*](./izvodi.hs)