module Parse exposing (..)

import List.Extra as List

import Model.Card exposing (Card(..))
import Model.Icon as Icon exposing (Icon)
import Model.Servant exposing (Servant)
import Model.Skill exposing (Skill)
import Model.Skill.BonusEffect exposing (BonusEffect(..))
import Model.Skill.BuffEffect exposing (BuffEffect(..))
import Model.Skill.DebuffEffect exposing (DebuffEffect(..))
import Model.Skill.InstantEffect exposing (InstantEffect(..))
import Model.Skill.SkillEffect exposing (SkillEffect(..))
import Model.Skill.Target exposing (Target(..))
import MaybeRank exposing (MaybeRank(..))
import Print

import Database.CraftEssences as CraftEssences


upgradeNP : List String
upgradeNP =
    [ "Orion"
    , "Asterios"
    , "Sasaki Kojirou"
    , "Arjuna"
    , "Paracelsus von Hohenheim"
    , "Nikola Tesla"
    , "Mordred"
    , "Fergus mac Roich"
    , "Iskandar"
    ]


uniqueNP : List String
uniqueNP =
    [ "Mash Kyrielight"
    , "Frankenstein"
    , "EMIYA"
    , "EMIYA (Alter)"
    ]


upgradeSkill : List (String, String)
upgradeSkill =
    [ ("Tamamo-no-Mae", "Fox's Wedding") ]


uniqueSkill : List (String, String)
uniqueSkill =
    [ ("Brynhild", "Primordial Rune")
    , ("Scathach", "Primordial Rune")
    , ("Euryale",  "Whim of the Goddess")
    , ("Stheno",   "Whim of the Goddess")
    , ("Henry Jekyll & Hyde", "Monstrous Strength")
    ]


npRank : Servant -> MaybeRank
npRank s =
    if List.member s.name upgradeNP then
        Upgrade s.phantasm.rank
    else if List.member s.name uniqueNP then
        Unique s s.phantasm.rank
    else
        Pure s.phantasm.rank


ceNames : List String
ceNames =
    List.map .name CraftEssences.db


skillNames : Servant -> List Skill
skillNames s =
    List.map (skillRank s >> Tuple.first) s.skills


skillRank : Servant -> Skill -> (Skill, MaybeRank)
skillRank s x =
    let
        flagged =
            List.member (s.name, x.name)
    in
    if List.member x.name ceNames then
        ({ x | name = x.name ++ " (Skill)" }, Pure x.rank)
    else if flagged upgradeSkill then
        (x, Upgrade x.rank)
    else if flagged uniqueSkill then
        (x, Unique s x.rank)
    else
        (x, Pure x.rank)


translate : String -> String
translate a =
    case a of
        "Andreias Amarantos" ->
            "Amaranth of the Brave"

        "Armor of Lamentation" ->
            "Wailing Armor"

        "Artificial Hero (Fake)" ->
            "Artificial Hero (False)"

        "Attila the San(ta)" ->
            "Altera the San(ta)"

        "Beautiful Princess (Sea)" ->
            "Princess of Loveliness (Ocean)"

        "Blessing of a Goddess" ->
            "Blessing of the Goddess"

        "Blessing of Kur" ->
            "Protection of the Underworld"

        "Dead-Count Shapeshifter" ->
            "Dragon Revelation Command Spell"

        "Diatrekhon Aster Lonkhe" ->
            "Spear-tip of the Star Traversing the Skies"

        "Frigid Charisma" ->
            "Freezing Charisma"

        "Cheerful-Type Mystic Code" ->
            "Cheerful Model Mystic Code"

        "Clairvoyance (Archer)" ->
            "Clairvoyance (Shooter)"

        "Crest of the Shiny Star" ->
            "Emblem of the Glittering Stars"

        "Eternal Dedication" ->
            "Immortal Dedication"

        "Distant Thoughts" ->
            "Affection Towards The Beyond"

        "Divine Wine—Shinpen Kidoku" ->
            "Divine Wine - Shinpen Kidoku"

        "Drómos Komḗtēs" ->
            "Comet Running Form"

        "Emergency Prerogative" ->
            "Supreme Authority"

        "Eternal Ice" ->
            "Permafrost"

        "Feral Logic" ->
            "Wild Beast's Logic"

        "\"First Hassan\"" ->
            "First Hassan"

        "Flames of Wildfire" ->
            "Wildfire"

        "Fuuma \"Evil-wind\" Kotarou" ->
            "Fuuma Kotarou"

        "Galactic Meteor Sword XEX" ->
            "Galactic Meteor Sword"

        "Innocent Monster (Foreign)" ->
            "Innocent Monster (Strange)"

        "Ivan the Terrible" ->
            "Ivan the Thunder Emperor"

        "Jack-o'-lantern" ->
            "Jack-o'-Lantern"

        "Katou Danzo" ->
            "Kato Danzou"

        "Lamenting Exterior" ->
            "Wailing Armor"

        "Leonardo da Vinci" ->
            "Leonardo Da Vinci"

        "Logic of Wild Beasts" ->
            "Wild Beast's Logic"

        "Mental Schism" ->
            "Contradictory Spirit"

        "Mystic Eyes of Penetration" ->
            "Clairvoyant Mystic Eyes"

        "Mystic Eyes of Distortion (Skill)" ->
            "Mystic Eyes of distortion"

        "Mystic Gunpowder" ->
            "Volatile Gunpowder"

        "Numeral of the Saint" ->
            "Numeral of The Saint"

        "NYARF! (Skill)" ->
            "NYARF!"

        "Nyafu!" ->
            "NYARF!"

        "Poisoned Blade" ->
            "Poison Blade"

        "Pseudonym \"Iseidako\"" ->
            "Pseudonym - Alien Octopus"

        "Queen's Discipline" ->
            "Discipline of the Queen"

        "Rainbow Candy" ->
            "Rainbow Syrup"

        "Self Evolution" ->
            "Self-Evolution"

        "Schwipsig" ->
            "Shvibzik"

        "The End of Four Nights" ->
            "End of the Four Nights"

        "Tranquil Fig" ->
            "Fig Tree of Tranquility"

        "Yagyu Munenori" ->
            "Munenori Yagyu"

        "A Wish Spanning 3 Generations" ->
            "A Thought of Crossing Through 3 Generations"

        "Blooming Flowers in Kur" ->
            "Flowers Blooming in the Underworld"

        "Currently in the Middle of a Shower" ->
            "Currently In The Middle Of A Shower"

        "Door to the Ocean" ->
            "Door To The Ocean"

        "Dream from the Cradle" ->
            "Dream From The Cradle"

        "Extolling the Revolver" ->
            "Extolling The Revolver"

        "Falcon Witch's Banquet" ->
            "Falcon Witch's Feast"

        "Getsurin Kuyou" ->
            "Purnima Navagraha (Getsurin Kuyou)"

        "Guardian Gigantic" ->
            "Gigantic Guardian"

        "Haori of the Oath" ->
            "Chikai no Haori"

        "King Shahryay's Bedchamber" ->
            "King Shahryar's Chambers"

        "Library of Ivan the Terrible" ->
            "Archive of Ivan the Thunder Emperor"

        "Manifestation of the Golden Rule" ->
            "Manifestation of The Golden Rule"

        "Mask of a Demon" ->
            "Mask of A Demon"

        "Mugashiki—Shinkuu Myou" ->
            "Mugashiki - Shinkuu Myōu"

        "Nameless Death" ->
            "The Death Without a Name"

        "Nina" ->
            "La Niña"

        "Otherworldly Mystical Horse" ->
            "Otherworldly Phantom Horse"

        "Painting of a Dragon Passing Over Mount Fuji" ->
            "Dragon of Smoke Escaping from Mt Fuji"

        "Perfect Form" ->
            "Consummated Shape"

        "Piedra del Sol" ->
            "Piedra Del Sol"

        "Princess' Origami" ->
            "Origami of a Princess"

        "Rosarium de Clavis Argenteus" ->
            "Rosary of the Silver Key"

        "Sovereign of Magical Staffs" ->
            "Sovereign of Magic Wands"

        "Sikera Ušum" ->
            "Arrogant King's Alchohol"

        "Spirit of the Vast Land" ->
            "Spirit of The Vast Land"

        "Tenka Fubu -2017 Summer.ver-" ->
            "Tenka Fubu ~2017 Summer.ver~"

        "The Object That Can Hold a Universe" ->
            "The Thing That Contains the World"

        "The Palace of Luoyang" ->
            "Palace of Luoyang"

        "The Purpose of Learning and Teaching" ->
            "To Teach and Learn"

        "The Rainbow Soaring Under the Night Sky" ->
            "Rainbow Running Through the Night Sky"

        "Tributes to King Solomon" ->
            "King Solomon's Tribute"

        "Uncertainty About the Future" ->
            "Uncertainty About The Future"

        "Urvara Nandi" ->
            "Fertile Bull"

        "[Heaven's Feel]" ->
            "\"Heaven's Feel\""

        _ ->
            Print.pretty a


printIcon : Icon -> String
printIcon a =
    case a of
        Icon.BusterArtsUp ->
            "ArtsBuster Up"

        Icon.SwordUp ->
            "Attack Up"

        Icon.SwordShieldUp ->
            "Dual Up"

        Icon.Rainbow ->
            "Bond Up"

        Icon.BusterUp ->
            "Buster Up"

        Icon.QuickBusterUp ->
            "BusterQuick Up"

        Icon.Star ->
            "CStar Gain"

        Icon.StarHaloUp ->
            "CStar Drop Up"

        Icon.StarUp ->
            "CStar Gather Up"

        Icon.StarTurn ->
            "CStar Turn"

        Icon.Heart ->
            "Charm"

        Icon.ExclamationUp ->
            "Crit Up"

        Icon.Fire ->
            "Death Res Up"

        Icon.FireUp ->
            "Death Res Up"

        Icon.ReaperUp ->
            "Death Up"

        Icon.HoodUp ->
            "Debuff Res Up"

        Icon.StaffUp ->
            "Debuff Up"

        Icon.ShieldUp ->
            "Defense Up"

        Icon.Dodge ->
            "Evade"

        Icon.Kneel ->
            "Guts"

        Icon.ShieldBreak ->
            "Invul Pierce"

        Icon.Shield ->
            "Invul"

        Icon.Road ->
            "Journey"

        Icon.HPUp ->
            "Max HP Up"

        Icon.Noble ->
            "NP Charge"

        Icon.NobleUp ->
            "NP Generation"

        Icon.NobleRedUp ->
            "NP Generation2"

        Icon.NobleTurn ->
            "NP Turn"

        Icon.BeamUp ->
            "NP Up"

        Icon.Crystal ->
            "QP Up"

        Icon.ArtsQuickUp ->
            "QuickArts Up"

        Icon.Circuits ->
            "Skill Seal"

        Icon.CrosshairUp ->
            "Taunt"

        Icon.SunUp ->
            "Overcharge Up"

        _ ->
            a
                |> Icon.show
                >> Print.unCamel


effects : List SkillEffect -> List String
effects =
    let
        showEffect a =
            case a of
                To _ (ApplyTrait _) _ ->
                    "Apply Trait"

                To _ (SpecialDamage _) _ ->
                    "Extra Damage"

                Grant _ _ (Special ef _) _ ->
                    "Special " ++ Debug.toString ef

                {-
                 Grant _ _ (Success _) _ ->
                    Debug.toString DebuffUp

                Grant _ _ (Resist _) _ ->
                    Debug.toString DebuffResist
                -}

                To _ ef _ ->
                    Debug.toString ef

                Grant _ _ ef _ ->
                    Debug.toString ef

                Debuff _ _ ef _ ->
                    Debug.toString ef

                Bonus ef _ _ ->
                    Debug.toString ef

                Chances _ _ ef ->
                    showEffect ef

                Chance _ ef ->
                    showEffect ef

                Times _ ef ->
                    showEffect ef

                When _ ef ->
                    showEffect ef

                ToMax _ ef ->
                    showEffect ef

                After _ ef ->
                    showEffect ef
    in
    List.map showEffect

synonym : List (List String)
synonym =
    [ ["special","against"]
    , ["increase", "increasing"]
    , ["reduce", "decrease", "down"]
    , ["attack", "atk"]
    , ["defense", "def"]
    , ["prevent", "seal", "lock"]
    , ["per", "each", "every"]
    , ["additional", "extra"]
    , ["effectiveness", "performance"]
    , ["maximum", "max"]
    , ["np", "phantasm"]
    , ["self", "yourself"]
    , ["restore", "recover", "regenerate", "restore's"]
    , ["invincible", "invincibility"]
    , ["rate", "chance"]
    , ["resist", "resistance"]
    , ["immune", "immunity"]
    ]

effectMap : List (List String, List String)
effectMap =
    let
        show =
            List.map Debug.toString
    in
    [ (["formula"], [])
    , (["bonus","increase"], [])
    , (["end","of","turn"], [])
    , (["can","only","be","used"], [])

    , (["increase","card","effectiveness","drop","gather","gain","strength",
    "mental","debuff","rate","resist"], show [CardUp Quick, CardUp Arts, CardUp Buster, StarUp, GatherUp, NPGen, NPUp, DebuffUp, MentalResist])
    , (["increase","card","effectiveness","drop","gather","gain","strength","debuff","rate","resist"], show [CardUp Quick, CardUp Arts, CardUp Buster, StarUp, GatherUp, NPGen, NPUp, DebuffUp, DebuffResist])
    , (["reduce","attack","defense","critical","chance","debuff","resist","np","strength"], show [AttackDown, DefenseDown, CritChance, DebuffVuln, NPDown])
    , (["reduce","critical","chance","debuff","resist"], show [CritChance, DebuffVuln])
    , (["reduce","defense","critical","chance"], show [DefenseDown, CritChance])
    , (["reduce","attack","defense"], show [AttackDown, DefenseDown])
    , (["increase","gain","critical","strength","drop","recovery","debuff","resist"], show [NPGen, CritUp, HealingReceived, StarUp, DebuffResist])
    , (["increase","attack","defense","star"], show [AttackUp, DefenseUp, StarUp])
    , (["reduce","np","strength","critical","strength"], show [NPDown, CritDown])
    , (["increase","attack","defense"], show [AttackUp, DefenseUp])
    , (["remove","debuffs","restore","hp"], show [RemoveDebuffs, Heal])
    , (["debuff","resist","down","defense","down"], show [DebuffVuln, DefenseDown])
    , (["additional","damage","turn"], ["Special AttackUp"])
    , (["decrease","1000hp","yourself"], show [DemeritDamage])
    , (["damage","previous","hp"], show [Avenge])
    , (["hp","fall"], show [DemeritHealth])
    , (["additional","damage","all","enemies"], show [Damage])
    , (["confusion"], show [Confusion])
    , (["current","hp"], show [LastStand])
    , (["extra","own","hp"], show [LastStand])
    , (["based","low","hp"], show [LastStand])
    , (["against","drop"], ["Special StarUp"])
    , (["apply","trait"], ["Apply Trait"])
    , (["extra","damage"], ["Extra Damage"])
    , (["deal","special","damage"], ["Extra Damage"])
    , (["special","attack"], ["Special AttackUp"])
    , (["special","damage"], ["Special AttackUp"])
    , (["special","defense"], ["Special DefenseUp"])
    , (["transform","hyde"], show [BecomeHyde])
    , (["increase","bond","points"], show [Bond])
    , (["nullify"], show [BuffBlock])
    , (["prevent","buff"], show [BuffBlock])
    , (["decrease","attack","success","yourself"], show [AttackBuffDown])
    , (["decrease","buff","success"], show [AttackBuffDown])
    , (["increase","buff","success"], show [BuffUp])
    , (["burn"], show [Burn])
    , (["increase","charm","resist"], show [Resist Charm])
    , (["charm","resist"], show [CharmVuln])
    , (["charm","success"], show [Success Charm])
    , (["charm"], show [Charm])
    , (["cooldowns"], show [ReduceCooldowns])
    , (["decrease","critical","chance"], show [CritChance])
    , (["critical","damage","down"], show [CritDown])
    , (["critical","damage","up"], show [CritDown])
    , (["increase","critical","damage"], show [CritUp])
    , (["increase","critical","strength"], show [CritUp])
    , (["remove","poison"], show [Cure])
    , (["curse"], show [Curse])
    , (["additional","damage","all","enemies"], show [Damage])
    , (["damage","cut"], show [DamageCut])
    , (["reduce","incoming","damage"], show [DamageCut])
    , (["reduce","damage","taken"], show [DamageCut])
    , (["deal","damage","defense"], show [DamageThruDef])
    , (["deal","damage","def-ignoring"], show [DamageThruDef])
    , (["increase","incoming","damage"], show [DamageVuln])
    , (["reduce","death","resist"], show [DeathVuln])
    , (["debuff","immunity"], show [DebuffResist])
    , (["reduce","defense"], show [DefenseDown])
    , (["increase","defense"], show [DefenseUp])
    , (["remove","buffs","self"], show [RemoveBuffs])
    , (["charge","enemy","gauge"], show [GaugeUp])
    , (["decrease","hp","fall"], show [DemeritHealth])
    , (["reduce","hp","turn"], show [HealthLoss])
    , (["deal","damage","yourself"], show [DemeritDamage])
    , (["reduce","hp"], show [DemeritDamage])
    , (["reduce","enemy","np","gauge","by"], show [GaugeDown])
    , (["deplete","gauge","on","use"], show [GaugeSpend])
    , (["reduce","own","gauge"], show [DemeritGauge])
    , (["drain","own","gauge"], show [DemeritGauge])
    , (["death","trigger"], show [DemeritKill])
    , (["sacrifice"], show [DemeritKill])
    , (["evade"], show [Evasion])
    , (["increase","master","exp"], show [EXP])
    , (["fear"], show [Fear])
    , (["friend","points"], show [FriendPoints])
    , (["gain","star","turn"], show [StarsPerTurn])
    , (["gain","stars"], show [GainStars])
    , (["decrease","charge"], show [GaugeDown])
    , (["decrease","gauge"], show [GaugeDown])
    , (["gauge","turn"], show [GaugePerTurn])
    , (["restore","gauge"], show [GaugeUp])
    , (["increase","gauge"], show [GaugeUp])
    , (["charge","gauge"], show [GaugeUp])
    , (["begin","np","charged"], show [GaugeUp])
    , (["np","charged","by"], show [GaugeUp])
    , (["gain","np","charge"], show [GaugeUp])
    , (["reduce","np","gauge","by"], show [DemeritGauge])
    , (["guts"], show [Guts])
    , (["increase","healing","effectiveness"], show [HealUp])
    , (["hp","recovery","turns"], show [HealPerTurn])
    , (["hp","recovery","per","turn"], show [HealPerTurn])
    , (["restore","turn"], show [HealPerTurn])
    , (["hp","recovery"], show [HealingReceived])
    , (["recover"], show [Heal])
    , (["heal"], show [Heal])
    , (["ignore","invincibility"], show [IgnoreInvinc])
    , (["invincible"], show [Invincibility])
    , (["death","immunity"], show [DeathResist])
    , (["death","resist"], show [DeathResist])
    , (["death","success"], show [DeathUp])
    , (["increase","death","rate"], show [DeathUp])
    , (["instantly", "kill"], show [Death])
    , (["death"], show [Death])
    , (["maximum","hp"], show [HPUp])
    , (["increase","mental","success"], show [MentalSuccess])
    , (["decrease","mental","resist"], show [MentalVuln])
    , (["mental","resist"], show [MentalResist])
    , (["increase","mystic","code"], show [MysticCode])
    , (["decrease","np","strength"], show [NPDown])
    , (["increase","np","gain"], show [NPGen])
    , (["increase","np","strength"], show [NPUp])
    , (["increase","np","damage"], show [NPUp])
    , (["np","damage","up"], show [NPUp])
    , (["increase","atk","debuff","resist"], show [Resist AttackDown])
    , (["increase","def","debuff","resist"], show [Resist DefenseDown])
    , (["increase","attack","resist"], show [OffensiveResist])
    , (["chance","apply","each"], show [OverChance])
    , (["increase","overcharge"], show [Overcharge])
    , (["quick","performance"], show [CardUp Quick])
    , (["arts","performance"], show [CardUp Arts])
    , (["buster","performance"], show [CardUp Buster])
    , (["increase","qp","drop"], show [QPDrop])
    , (["increase","qp","quest"], show [QPQuest])
    , (["remove","mental"], show [RemoveMental])
    , (["remove","mental_debuff"], show [RemoveMental])
    , (["remove","buff"], show [RemoveBuffs])
    , (["remove","debuff"], show [RemoveDebuffs])
    , (["poison","resist"], show [Resist Poison])
    , (["poison"], show [Poison])
    , (["star","gather"], show [GatherUp])
    , (["seal","np"], show [SealNP])
    , (["seal","skill"], show [SealSkills])
    , (["increase","star","generation"], show [StarUp])
    , (["increase","star","drop"], show [StarUp])
    , (["immobilize"], show [Stun])
    , (["increase","stun","success"], show [Success Stun])
    , (["increase","stun","resist"], show [Resist Stun])
    , (["sure-hit"], show [SureHit])
    , (["sure","hit"], show [SureHit])
    , (["target","focus"], show [Taunt])

    , (["increase","status","effects"], show [MentalResist])
    , (["damage","plus"], show [DamageUp])
    , (["increase","damage"], show [DamageUp])
    , (["increase","debuff","resist"], show [DebuffResist])
    , (["debuff","rate"], show [DebuffUp])
    , (["increase","debuff","success"], show [DebuffUp])
    , (["increase","stun","success"], show [DebuffUp])
    , (["reduce","debuff","resist"], show [DebuffVuln])
    , (["decrease","np"], show [GaugeDown])
    , (["decrease","attack"], show [AttackDown])
    , (["increase","attack"], show [AttackUp])
    , (["severe","damage"], show [Damage])
    , (["strong","attack"], show [Damage])
    , (["deal","damage"], show [Damage])
    , (["damage","all", "enemies"], show [Damage])
    , (["stun"], show [Stun])
    , (["high","chance","status"], show [Charm])

    , (["against","buster"], [])
    , (["effect","activates"], [])
    , (["depends"], [])
    , (["when","defeated","by"], [])
    , (["when","equipped"], [])
    ]


readEffect : String -> List String
readEffect s =
    if String.startsWith "<!--" s && String.endsWith "-->" s then
        []
    else
        let
            words =
                s
                    |> String.toLower
                    >> Print.filterOut ".|[]#,'"
                    >> String.trim
                    >> String.split " "

            inWords x =
                List.member x words || List.member (x ++ "s") words

            synonyms x =
                List.find (List.member x) synonym
                    |> Maybe.withDefault [x]

            match =
                Tuple.first
                    >> List.all (synonyms >> List.any inWords)
        in
        List.find match effectMap
            |> Maybe.map Tuple.second
            >> Maybe.withDefault words
