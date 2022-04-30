
data AritmetickiIzraz = Broj Int
    | Zbir AritmetickiIzraz AritmetickiIzraz
    | Proizvod AritmetickiIzraz AritmetickiIzraz
        deriving Eq

-- 2 * 3 + 20 * (-30)
izraz :: AritmetickiIzraz
izraz = Zbir (Proizvod (Broj 2) (Broj 3)) (Proizvod (Broj 20) (Broj (-30)))

instance Show AritmetickiIzraz where
    show (Broj n) = show n
    show (Zbir a b) = "(" ++ show a ++ " + " ++ show b ++ ")"
    show (Proizvod a b) = "(" ++ show a ++ " * " ++ show b ++ ")"

izracunajAritmeticki :: AritmetickiIzraz -> Int
izracunajAritmeticki (Broj n) = n
izracunajAritmeticki (Zbir a b) = izracunajAritmeticki a + izracunajAritmeticki b
izracunajAritmeticki (Proizvod a b) = izracunajAritmeticki a * izracunajAritmeticki b
