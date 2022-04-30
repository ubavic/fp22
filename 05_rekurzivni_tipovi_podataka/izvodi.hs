
data Fun = Exp | Log | Sin | Cos 

data Izraz = Broj Float 
    | X 
    | Izraz :+: Izraz 
    | Izraz :*: Izraz 
    | Izraz :-: Izraz
    | Izraz :/: Izraz
    | Izraz :^: Izraz
    | Fun ::: Izraz


instance Show Fun where
    show Exp = "exp"
    show Log = "ln"
    show Sin = "sin"
    show Cos = "cos"


zagrade :: Bool -> String -> String
zagrade z x = if z then "(" ++ x ++ ")" else x

instance Show Izraz where
    show x = prikazi False x
        where
        prikazi _ X = "X"
        prikazi _ (Broj n) = show n
        prikazi z (a@(_ :+: _) :+: b@(_ :+: _)) = zagrade z (prikazi False a ++ " + " ++ prikazi False b)
        prikazi z (a :+: b@(_ :+: _)) = zagrade z (prikazi True a ++ " + " ++ prikazi False b)
        prikazi z (a@(_ :+: _) :+: b) = zagrade z (prikazi False a ++ " + " ++ prikazi True b)
        prikazi z (a :+: b) = zagrade z (prikazi True a ++ " + " ++ prikazi True b)
        prikazi z (a@(_ :*: _) :*: b@(_ :*: _)) = zagrade z (prikazi False a ++ " * " ++ prikazi False b)
        prikazi z (a :*: b@(_ :*: _)) = zagrade z (prikazi True a ++ " * " ++ prikazi False b)
        prikazi z (a@(_ :*: _) :*: b) = zagrade z (prikazi False a ++ " * " ++ prikazi True b)
        prikazi z (a :*: b) = zagrade z (prikazi True a ++ " * " ++ prikazi True b)
        prikazi z (a :-: b) = zagrade z (prikazi True a ++ " - " ++ prikazi True b)
        prikazi z (a :/: b) = zagrade z (prikazi True a ++ " / " ++ prikazi True b)
        prikazi _ (a :^: b) = prikazi True a ++ "^" ++ prikazi True b
        prikazi _ (f ::: a) = show f ++ zagrade True (prikazi False a)


primeniFunkciju :: Fun -> Float -> Float
primeniFunkciju Exp = exp
primeniFunkciju Log = log
primeniFunkciju Sin = sin
primeniFunkciju Cos = cos


izracunaj :: Izraz -> Float -> Float
izracunaj X x = x
izracunaj (Broj s) x = s
izracunaj (a :+: b) x = izracunaj a x + izracunaj b x
izracunaj (a :*: b) x = izracunaj a x * izracunaj b x
izracunaj (a :-: b) x = izracunaj a x - izracunaj b x
izracunaj (a :/: b) x = izracunaj a x / izracunaj b x
izracunaj (a :^: b) x = izracunaj a x ** izracunaj b x
izracunaj (f ::: a) x = primeniFunkciju f (izracunaj a x) 


izvod :: Izraz -> Izraz 
izvod X = Broj 1 
izvod (Broj _) = Broj 0
izvod (a :+: b) = izvod a :+: izvod b
izvod (a :-: b) = izvod a :-: izvod b
izvod (a :*: b) = (izvod a :*: b) :+: (a :*: izvod b)
izvod (a :/: b) = (izvod a :*: b) :+: (a :*: izvod b)
izvod (a :^: b) = (a :^: b) :*: (((Log ::: a) :*: b) :+: (izvod b :/: a)) 
izvod (Sin ::: a) = (Cos ::: a) :*: izvod a
izvod (Cos ::: a) = Broj 1 :*: (Sin ::: a) :*: izvod a
izvod (Exp ::: a) = (Exp ::: a) :*: izvod a
izvod (Log ::: a) = (Broj 1 :/: a) :*: izvod a


simplify :: Izraz -> Izraz
simplify (Broj a :+: Broj b) = Broj (a + b)
simplify (a :+: Broj 0) = simplify a
simplify (Broj 0 :+: a) = simplify a
simplify (a :+: b) = simplify a :+: simplify b
simplify (Broj a :-: Broj b) = Broj (a - b)
simplify (a :-: Broj 0) = simplify a
simplify (a :-: b) = simplify a :-: simplify b
simplify (a :*: Broj 0) = Broj 0
simplify (Broj 0 :*: a) = Broj 0
simplify (a :*: Broj 1) = simplify a
simplify (Broj 1 :*: a) = simplify a
simplify (Broj a :*: Broj b) = Broj (a * b)
simplify (a :*: b) = simplify a :*: simplify b
simplify (Broj a :/: Broj b) = Broj (a / b)
simplify (Broj 0 :/: b) = Broj 0
simplify (a :/: b) = simplify a :/: simplify b
simplify (f ::: a) = f ::: simplify a 
simplify x = x


s1 :: Izraz
s1 = (Exp ::: (X :^: Broj 2)) :*: (X :+: Broj 19)


s2 :: Izraz
s2 = (Cos ::: X) :^: (Sin ::: X)
