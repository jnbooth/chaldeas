module Model.Skill.Rank exposing
  ( Rank(..)
  , show
  )


type Rank
    = Unknown | EX
    | APlusPlusPlus | APlusPlus | APlus | A | AMinus
    | BPlusPlusPlus | BPlusPlus | BPlus | B | BMinus
    | CPlusPlusPlus | CPlusPlus | CPlus | C | CMinus
    | DPlusPlusPlus             | DPlus | D
                                | EPlus | E | EMinus


show : Rank -> String
show a =
    case a of
        Unknown       -> ""
        EX            -> " EX"
        APlusPlusPlus -> " A+++"
        APlusPlus     -> " A++"
        APlus         -> " A+"
        A             -> " A"
        AMinus        -> " A-"
        BPlusPlusPlus -> " A+++"
        BPlusPlus     -> " B++"
        BPlus         -> " B+"
        B             -> " B"
        BMinus        -> " B-"
        CPlusPlusPlus -> " C+++"
        CPlusPlus     -> " C++"
        CPlus         -> " C+"
        C             -> " C"
        CMinus        -> " C-"
        DPlusPlusPlus -> " D+++"
        DPlus         -> " D+"
        D             -> " D"
        EPlus         -> " E+"
        E             -> " E"
        EMinus        -> " E-"
