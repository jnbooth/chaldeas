module Class.ToJSON exposing (craftEssence, servant)

{-| Exports internal data to JSON values. -}

import Json.Encode as E exposing (Value)
import List.Extra as List

import StandardLibrary exposing (flip)

import Model.Attribute as Attribute
import Model.Card as Card
import Model.Class as Class
import Model.CraftEssence exposing (CraftEssence)
import Model.Deck as Deck
import Model.Stat exposing (Stat)
import Model.Trait as Trait
import Model.Icon as Icon
import Model.Servant exposing (Hits, NoblePhantasm, Servant)
import Model.Skill exposing (Skill)
import Model.Skill.Amount as Amount exposing (Amount(..))
import Model.Skill.BonusEffect as BonusEffect
import Model.Skill.BuffEffect as BuffEffect
import Model.Skill.DebuffEffect as DebuffEffect
import Model.Skill.InstantEffect as InstantEffect
import Model.Skill.Rank as Rank
import Model.Skill.SkillEffect exposing (SkillEffect(..))
import Model.Skill.Target as Target exposing (Target(..))

import Database.CraftEssences as CraftEssences


nullable : (a -> Value) -> Maybe a -> Value
nullable f a =
    case a of
        Just x  -> f x
        Nothing -> E.null


withAmount : Amount -> List (String, Value) -> List (String, Value)
withAmount a els =
    case a of
        Placeholder ->
            els

        Full ->
            els

        Flat x ->
            ("amount", E.float x)
                :: els

        Range x y ->
            ("amount", E.object [("from", E.float x), ("to", E.float y)])
                :: els


stat : Stat -> Value
stat x =
    E.object
    [ ("atk", E.int x.atk)
    , ("hp",  E.int x.hp)
    ]


target : Target -> Value
target =
    Target.possessiveAndSubject
        >> .s
        >> String.trim
        >> E.string


skillEffect : SkillEffect -> Value
skillEffect =
    let
        modEffect f fields =
            case List.find (Tuple.first >> (==) "effect") fields of
                Just (_, effect) ->
                    let
                        modded =
                            effect
                                |> E.encode 0
                                >> String.dropLeft 1
                                >> String.dropRight 1
                                >> f
                                >> E.string
                    in
                    fields ++ [("effect", modded)]

                Nothing ->
                    fields

        go a = case a of
            Grant targ duration effect amount ->
                withAmount amount <|
                [ ("target",   target targ)
                , ("duration", E.int duration)
                , ("effect"
                  , E.string <| BuffEffect.show Someone Placeholder effect
                  )
                ]

            Debuff targ duration effect amount ->
                withAmount amount <|
                [ ("target",   target targ)
                , ("duration", E.int duration)
                , ("effect"
                  , E.string <| DebuffEffect.show Someone Placeholder effect
                  )
                ]

            To targ effect amount ->
                withAmount amount <|
                [ ("target",   target targ)
                , ("effect"
                  , E.string <| InstantEffect.show Someone Placeholder effect
                  )
                ]

            Bonus effect isPerc amount ->
                withAmount amount <|
                [ ("effect"
                  , E.string <| BonusEffect.show isPerc Placeholder effect
                  )
                ]

            Chance x effect ->
                go effect ++ [("chance", E.int x)]

            Chances x y effect ->
                go effect
                    ++ [ ("chance"
                         , E.object [("from", E.int x), ("to", E.int y)]
                         )
                       ]

            ToMax x effect ->
                go effect
                    |> modEffect
                       (flip (++) <| " every turn up to " ++ Amount.show x)

            When x effect ->
                go effect ++ [("condition", E.string x)]

            Times x effect ->
                go effect ++ [("times", E.int x)]

            After x effect ->
                go effect
                    |> modEffect
                       ((++) <| "After " ++ String.fromInt x ++ " turns: ")
    in
    go
        >> E.object


skill : Skill -> Value
skill x =
    E.object
    [ ("name",   E.string x.name)
    , ("icon",   E.string <| Icon.show x.icon)
    , ("cd",     E.int x.cd)
    , ("effect", E.list skillEffect x.effect)
    ]


noblePhantasm : NoblePhantasm -> Value
noblePhantasm x =
    E.object
    [ ("name",           E.string x.name)
    , ("rank",           E.string <| Rank.show x.rank)
    , ("card",           E.string <| Card.show x.card)
    , ("classification", E.string x.kind)
    , ("hits",           E.int x.hits)
    , ("effect",         E.list skillEffect x.effect)
    , ("over",           E.list skillEffect x.over)
    , ("activatesFirst", E.bool x.first)
    ]


hits : Hits -> Value
hits x =
    E.object
    [ ("quick",  E.int x.quick)
    , ("arts",   E.int x.arts)
    , ("buster", E.int x.buster)
    , ("extra",  E.int x.ex)
    ]


craftEssence : CraftEssence -> Value
craftEssence ce =
    let
        stats x =
            E.object
            [ ("base",  stat x.base)
            , ("max",   stat x.max)
            ]
    in
    E.object
    [ ("name",    E.string ce.name)
    , ("id",      E.int ce.id)
    , ("rarity",  E.int ce.rarity)
    , ("icon",    E.string <| Icon.show ce.icon)
    , ("stats",   stats ce.stats)
    , ("effect",  E.list skillEffect ce.effect)
    , ("limited", E.bool ce.limited)
    , ("bond",    nullable E.string ce.bond)
    ]


servant : Servant -> Value
servant s =
    let
        stats x =
            E.object
            [ ("base",  stat x.base)
            , ("max",   stat x.max)
            , ("grail", stat x.grail)
            ]
    in
    E.object
    [ ("name",          E.string s.name)
    , ("id",            E.int s.id)
    , ("rarity",        E.int s.rarity)
    , ("class",         E.string <| Class.show s.class)
    , ("attribute",     E.string <| Attribute.show s.attr)
    , ("deck",          E.list (E.string << Card.show) <| Deck.toList s.deck)
    , ("curve",         E.int s.curve)
    , ("stats",         stats s.stats)
    , ("skills",        E.list skill s.skills)
    , ("passives",      E.list skill s.passives)
    , ("noblePhantasm", noblePhantasm s.phantasm)
    , ("starWeight",    E.int s.gen.starWeight)
    , ("starRate",      E.float s.gen.starRate)
    , ("npAtk",         E.float s.gen.npAtk)
    , ("npDef",         E.int s.gen.npDef)
    , ("hits",          hits s.hits)
    , ("traits",        E.list (Trait.show >> E.string) s.traits)
    , ("deathRate",     E.float s.death)
    , ("gender",        E.string <| Trait.show s.gender)
    , ("alignment",     E.list (Trait.show >> E.string) s.align)
    , ("limited",       E.bool s.limited)
    , ("free",          E.bool s.free)
    , ("bond",          nullable craftEssence <| CraftEssences.getBond s)
    ]
