module Database.Servant.Caster exposing (casters)

import Model.Attribute exposing (Attribute(..))
import Model.Card exposing (Card(..))
import Model.Class exposing (Class(..))
import Model.Deck exposing (Deck(..))
import Model.Material exposing (Material(..))
import Model.Trait exposing (Trait(..))
import Database.Passives exposing (..)
import Model.Servant exposing (Servant, Ascension(..), Reinforcement(..))
import Model.Skill.Amount exposing (Amount(..))
import Model.Skill.BuffEffect exposing (BuffEffect(..))
import Model.Skill.DebuffEffect exposing (DebuffEffect(..))
import Model.Skill.InstantEffect exposing (InstantEffect(..))
import Model.Skill.Rank exposing (Rank(..))
import Model.Skill.SkillEffect exposing (SkillEffect(..))
import Model.Skill.Special exposing (Special(..))
import Model.Skill.Target exposing (Target(..))

import Model.Icon as Icon

casters : List Servant
casters =
  [ { name      = "Medea"
    , spoiler   = Nothing
    , id        = 31
    , rarity    = 3
    , class     = Caster
    , attr      = Earth
    , deck      = Deck Quick Arts Arts Arts Buster
    , curve     = 13
    , stats     = { base  = { atk = 1377,  hp = 1555 }
                  , max   = { atk = 7418,  hp = 8643 }
                  , grail = { atk = 10039, hp = 11719 }
                  }
    , skills    = [ { name   = "Rapid Words of Divine"
                    , rank   = A
                    , icon   = Icon.Noble
                    , cd     = 9
                    , effect = [ To Self GaugeUp <| Range 80 150 ]
                    }
                  , { name    = "Argon Coin"
                    , rank   = Unknown
                    , icon    = Icon.Heal
                    , cd      = 6
                    , effect = [ To Self Heal <| Range 500 2500 ]
                    }
                  , { name   = "Circe's Teaching"
                    , rank   = A
                    , icon   = Icon.Bubbles
                    , cd     = 8
                    , effect = [ To Ally RemoveDebuffs Full
                               , Grant Ally 1 NPGen <| Range 30 50
                               ]
                    }
                  ]
    , passives  = [territoryCreation A, itemConstruction A]
    , phantasm  = { name   = "Rule Breaker"
                  , rank   = CPlus
                  , card   = Arts
                  , kind   = "Anti-Thaumaturgy"
                  , hits   = 1
                  , effect = [ To Enemy Damage <| Range 600 900
                             , To Enemy RemoveBuffs Full
                             ]
                  , over   = [ To Self GaugeUp <| Range 20 100 ]
                  , first  = False
                  }
    , gen       = { starWeight = 50, starRate = 10.9, npAtk = 1.64, npDef = 3 }
    , hits      = { quick = 2, arts = 1, buster = 1, ex = 3 }
    , gender    = Female
    , traits    = [Argonaut, Humanoid, EnumaElish]
    , death     = 34.5
    , align     = [Neutral, Evil]
    , limited   = False
    , free      = True
    , ascendUp  = Ascension
                  [(Piece Caster, 4)]
                  [(Piece Caster, 8), (DragonFang, 12)]
                  [(Monument Caster, 4), (HeartOfTheForeignGod, 2), (VoidsDust, 13)]
                  [(Monument Caster, 8), (HeartOfTheForeignGod, 3), (ForbiddenPage, 8)]
    , skillUp   = Reinforcement
                  [(GemOf Caster, 4)]
                  [(GemOf Caster, 8)]
                  [(MagicGemOf Caster, 4)]
                  [(MagicGemOf Caster, 8), (VoidsDust, 7)]
                  [(SecretGemOf Caster, 4), (VoidsDust, 13)]
                  [(SecretGemOf Caster, 8), (DragonFang, 8)]
                  [(GhostLantern, 4), (DragonFang, 16)]
                  [(GhostLantern, 12), (ForbiddenPage, 16)]
    }
  , { name      = "Gilles de Rais (Caster)"
    , spoiler   = Nothing
    , id        = 32
    , rarity    = 3
    , class     = Caster
    , attr      = Human
    , deck      = Deck Quick Arts Arts Arts Buster
    , curve     = 13
    , stats     = { base  = { atk = 1209, hp = 1711 }
                  , max   = { atk = 6514, hp = 9506 }
                  , grail = { atk = 8816, hp = 12889 }
                  }
    , skills    = [ { name   = "Mental Corruption"
                    , rank   = A
                    , icon   = Icon.StaffUp
                    , cd     = 7
                    , effect = [ Grant Self 3 MentalSuccess <| Range 5 25
                               , Grant Self 3 MentalResist <| Range 50 100
                               ]
                    }
                  , { name   = "Aesthetic Appreciation"
                    , rank   = EMinus
                    , icon   = Icon.BeamDown
                    , cd     = 7
                    , effect = [ Debuff Enemy 1 NPDown <| Range 5.5 11 ]
                    }
                  , { name   = "Evil Eye of the Abyss"
                    , rank   = C
                    , icon   = Icon.Stun
                    , cd     = 10
                    , effect = [ Debuff Enemies 5 Fear <| Range 30 40 ]
                    }
                  ]
    , passives  = [territoryCreation B]
    , phantasm  = { name   = "Prelati's Spellbook"
                  , rank   = APlus
                  , card   = Buster
                  , kind   = "Anti-Army"
                  , hits   = 3
                  , effect = [ To Enemies Damage <| Range 300 500 ]
                  , over   = [ Debuff Enemies 3 AttackDown <| Range 20 40 ]
                  , first  = False
                  }
    , gen       = { starWeight = 48, starRate = 10.8, npAtk = 1.58, npDef = 3 }
    , hits      = { quick = 2, arts = 1, buster = 1, ex = 3 }
    , gender    = Male
    , traits    = [Humanoid, EnumaElish]
    , death     = 48
    , align     = [Chaotic, Evil]
    , limited   = False
    , free      = False
    , ascendUp  = Ascension
                  [(Piece Caster, 4)]
                  [(Piece Caster, 8), (GhostLantern, 5)]
                  [(Monument Caster, 4), (ForbiddenPage, 4), (HomunculusBaby, 7)]
                  [(Monument Caster, 8), (ForbiddenPage, 7), (HeartOfTheForeignGod, 4)]
    , skillUp   = Reinforcement
                  [(GemOf Caster, 4)]
                  [(GemOf Caster, 8)]
                  [(MagicGemOf Caster, 4)]
                  [(MagicGemOf Caster, 8), (HomunculusBaby, 4)]
                  [(SecretGemOf Caster, 4), (HomunculusBaby, 7)]
                  [(SecretGemOf Caster, 8), (GhostLantern, 4)]
                  [(VoidsDust, 8), (GhostLantern, 7)]
                  [(VoidsDust, 24), (HeartOfTheForeignGod, 7)]
    }
  , { name      = "Hans Christian Andersen"
    , spoiler   = Nothing
    , id        = 33
    , rarity    = 2
    , class     = Caster
    , attr      = Human
    , deck      = Deck Quick Arts Arts Arts Buster
    , curve     = 12
    , stats     = { base  = { atk = 1021, hp = 1597 }
                  , max   = { atk = 5758, hp = 8484 }
                  , grail = { atk = 8344, hp = 12244 }
                  }
    , skills    = [ { name   = "Human Observation"
                    , rank   = A
                    , icon   = Icon.ExclamationUp
                    , cd     = 7
                    , effect = [ Grant Party 3 CritUp <| Range 10 40 ]
                    }
                  , { name   = "Rapid Casting"
                    , rank   = E
                    , icon   = Icon.Noble
                    , cd     = 8
                    , effect = [ To Self GaugeUp <| Range 50 75 ]
                    }
                  , { name   = "Innocent Monster"
                    , rank   = D
                    , icon   = Icon.StarTurn
                    , cd     = 7
                    , effect = [ Grant Self 3 StarsPerTurn <| Range 3 9
                               , Debuff Self 3 DefenseDown <| Flat 14
                               ]
                    }
                  ]
    , passives  = [territoryCreation D, itemConstruction C]
    , phantasm  = { name   = "Märchen Meines Lebens"
                  , rank   = CPlus
                  , card   = Arts
                  , kind   = "Anti-Personnel"
                  , hits   = 0
                  , effect = [ To Self OverChance <| Range 60 80 ]
                  , over   = [ Chance 0 << Grant Party 3 AttackUp <| Range 20 40
                             , Chance 0 << Grant Party 3 DefenseUp <| Range 20 40
                             , Chance 0 << Grant Party 3 StarUp <| Range 20 40
                             , Grant Party 3 HealPerTurn <| Range 1000 3000
                             ]
                  , first  = False
                  }
    , gen       = { starWeight = 48, starRate = 10.8, npAtk = 1.66, npDef = 3 }
    , hits      = { quick = 2, arts = 1, buster = 1, ex = 3 }
    , gender    = Male
    , traits    = [Humanoid, EnumaElish]
    , death     = 30
    , align     = [Lawful, Balanced]
    , limited   = False
    , free      = True
    , ascendUp  = Ascension
                  [(Piece Caster, 3)]
                  [(Piece Caster, 6), (ForbiddenPage, 4)]
                  [(Monument Caster, 3), (EternalGear, 3), (HomunculusBaby, 5)]
                  [(Monument Caster, 6), (EternalGear, 5), (MeteorHorseshoe, 6)]
    , skillUp   = Reinforcement
                  [(GemOf Caster, 3)]
                  [(GemOf Caster, 6)]
                  [(MagicGemOf Caster, 3)]
                  [(MagicGemOf Caster, 6), (HomunculusBaby, 3)]
                  [(SecretGemOf Caster, 3), (HomunculusBaby, 5)]
                  [(SecretGemOf Caster, 6), (ForbiddenPage, 3)]
                  [(VoidsDust, 6), (ForbiddenPage, 5)]
                  [(VoidsDust, 18), (MeteorHorseshoe, 12)]
    }
  , { name      = "William Shakespeare"
    , spoiler   = Nothing
    , id        = 34
    , rarity    = 2
    , class     = Caster
    , attr      = Human
    , deck      = Deck Quick Arts Arts Arts Buster
    , curve     = 12
    , stats     = { base  = { atk = 1028, hp = 1520 }
                  , max   = { atk = 5798, hp = 8080 }
                  , grail = { atk = 8402, hp = 11661 }
                  }
    , skills    = [ { name   = "Enchant"
                    , rank   = A
                    , icon   = Icon.BusterUp
                    , cd     = 7
                    , effect = [ Grant Party 1 (CardUp Buster) <| Range 20 40 ]
                    }
                  , { name   = "Self-Preservation"
                    , rank   = B
                    , icon   = Icon.Shield
                    , cd     = 8
                    , effect = [ Grant Self 1 Invincibility Full
                               , To Self Heal <| Range 500 1500
                               ]
                    }
                  , { name   = "King's Men"
                    , rank   = C
                    , icon   = Icon.Noble
                    , cd     = 8
                    , effect = [ To Ally GaugeUp <| Flat 20
                               , Grant Ally 1 StarUp <| Range 50 100
                               ]
                    }
                  ]
    , passives  = [territoryCreation C]
    , phantasm  = { name   = "First Folio"
                  , rank   = BPlus
                  , card   = Buster
                  , kind   = "Anti-Personnel"
                  , hits   = 4
                  , effect = [ To Enemies Damage <| Range 400 600 ]
                  , over   = [ Chances 40 80 <| Debuff Enemies 1 Stun Full ]
                  , first  = False
                  }
    , gen       = { starWeight = 50, starRate = 10.8, npAtk = 1.59, npDef = 3 }
    , hits      = { quick = 2, arts = 1, buster = 1, ex = 3 }
    , gender    = Male
    , traits    = [Humanoid, EnumaElish]
    , death     = 45
    , align     = [Neutral, Balanced]
    , limited   = False
    , free      = True
    , ascendUp  = Ascension
                  [(Piece Caster, 3)]
                  [(Piece Caster, 6), (GhostLantern, 4)]
                  [(Monument Caster, 3), (ForbiddenPage, 5), (HomunculusBaby, 3)]
                  [(Monument Caster, 6), (SerpentJewel, 5), (HomunculusBaby, 3)]
    , skillUp   = Reinforcement
                  [(GemOf Caster, 3)]
                  [(GemOf Caster, 6)]
                  [(MagicGemOf Caster, 3)]
                  [(MagicGemOf Caster, 6), (ForbiddenPage, 3)]
                  [(SecretGemOf Caster, 3), (ForbiddenPage, 5)]
                  [(SecretGemOf Caster, 6), (GhostLantern, 3)]
                  [(VoidsDust, 6), (GhostLantern, 5)]
                  [(VoidsDust, 18), (SerpentJewel, 10)]
    }
  , { name      = "Mephistopheles"
    , spoiler   = Nothing
    , id        = 35
    , rarity    = 3
    , class     = Caster
    , attr      = Earth
    , deck      = Deck Quick Arts Arts Arts Buster
    , curve     = 8
    , stats     = { base  = { atk = 1270, hp = 1659 }
                  , max   = { atk = 6839, hp = 9216 }
                  , grail = { atk = 9255, hp = 12495 }
                  }
    , skills    = [ { name  = "Curse"
                  , rank   = A
                  , icon    = Icon.MagicDark
                  , cd      = 7
                  , effect = [ Chances 60 80 << To Enemy GaugeDown <| Flat 1 ]
                  }
                , { name   = "Innocent Monster"
                  , rank   = B
                  , icon   = Icon.StarTurn
                  , cd     = 7
                  , effect = [ Grant Self 3 StarsPerTurn <| Range 3 9
                             , Debuff Self 3 DefenseDown <| Flat 18
                             ]
                  }
                , { name   = "Clown's Laughter"
                  , rank   = APlus
                  , icon   = Icon.HoodX
                  , cd     = 8
                  , effect = [ Times 3 <| Debuff Enemy 0 BuffBlock Full
                             , Debuff Enemy 5 Curse <| Range 500 1000
                             ]
                  }
                  ]
    , passives  = [territoryCreation CPlus, itemConstruction B]
    , phantasm  = { name   = "Ticktock Bomb"
                  , rank   = APlus
                  , card   = Buster
                  , kind   = "Anti-Army"
                  , hits   = 1
                  , effect = [ To Enemies DamageThruDef <| Range 400 600 ]
                  , over   = [ Debuff Enemies 3 Curse <| Range 500 2500 ]
                  , first  = False
                  }
    , gen       = { starWeight = 50, starRate = 11, npAtk = 0.81, npDef = 3 }
    , hits      = { quick = 2, arts = 2, buster = 1, ex = 3 }
    , gender    = Male
    , traits    = [Humanoid, EnumaElish]
    , death     = 36
    , align     = [Chaotic, Evil]
    , limited   = False
    , free      = True
    , ascendUp  = Ascension
                  [(Piece Caster, 4)]
                  [(Piece Caster, 8), (VoidsDust, 10)]
                  [(Monument Caster, 4), (HomunculusBaby, 7), (HeartOfTheForeignGod, 2)]
                  [(Monument Caster, 8), (HeartOfTheForeignGod, 3), (GhostLantern, 8)]
    , skillUp   = Reinforcement
                  [(GemOf Caster, 4)]
                  [(GemOf Caster, 8)]
                  [(MagicGemOf Caster, 4)]
                  [(MagicGemOf Caster, 8), (HomunculusBaby, 4)]
                  [(SecretGemOf Caster, 4), (HomunculusBaby, 7)]
                  [(SecretGemOf Caster, 8), (VoidsDust, 7)]
                  [(VoidsDust, 13), (EternalGear, 4)]
                  [(EternalGear, 12), (GhostLantern, 16)]
    }
  , { name      = "Wolfgang Amadeus Mozart"
    , spoiler   = Nothing
    , id        = 36
    , rarity    = 1
    , class     = Caster
    , attr      = Star
    , deck      = Deck Quick Arts Arts Arts Buster
    , curve     = 1
    , stats     = { base  = { atk = 944,  hp = 1425 }
                  , max   = { atk = 5195, hp = 7129 }
                  , grail = { atk = 8072, hp = 10990 }
                  }
    , skills    = [ { name   = "Protection of Muse (Fake)"
                    , rank   = EX
                    , icon   = Icon.ArtsUp
                    , cd     = 7
                    , effect = [ Grant Party 1 (CardUp Arts) <| Range 22 44 ]
                    }
                  , { name   = "Aesthetic Appreciation"
                    , rank   = B
                    , icon   = Icon.BeamDown
                    , cd     = 7
                    , effect = [ Debuff Enemy 1 NPDown <| Range 9 18 ]
                    }
                  , { name   = "Eine kleine Nachtmusik"
                    , rank   = EX
                    , icon   = Icon.Star
                    , cd     = 8
                    , effect = [ To Party GainStars <| Range 20 50 ]
                    }
                  ]
    , passives  = [territoryCreation B]
    , phantasm  = { name   = "Requiem for Death"
                  , rank   = B
                  , card   = Arts
                  , kind   = "Anti-Army"
                  , hits   = 0
                  , effect = [ To Self OverChance <| Range 60 80 ]
                  , over   = [ Chance 0 << Debuff Enemies 3 AttackDown <| Range 20 40
                             , Chance 0 << Debuff Enemies 3 DefenseDown <| Range 20 40
                             , Debuff Enemies 3 Curse <| Range 500 2500
                             ]
                  , first  = False
                  }
    , gen       = { starWeight = 49, starRate = 11, npAtk = 1.6, npDef = 3 }
    , hits      = { quick = 2, arts = 1, buster = 1, ex = 3 }
    , gender    = Male
    , traits    = [Humanoid, LovedOne]
    , death     = 40.5
    , align     = [Neutral, Good]
    , limited   = False
    , free      = True
    , ascendUp  = Ascension
                  [(Piece Caster, 2)]
                  [(Piece Caster, 4), (EvilBone, 8)]
                  [(Monument Caster, 2), (EternalGear, 4), (ForbiddenPage, 2)]
                  [(Monument Caster, 4), (ForbiddenPage, 4), (HeartOfTheForeignGod, 2)]
    , skillUp   = Reinforcement
                  [(GemOf Caster, 2)]
                  [(GemOf Caster, 4)]
                  [(MagicGemOf Caster, 2)]
                  [(MagicGemOf Caster, 4), (EternalGear, 2)]
                  [(SecretGemOf Caster, 2), (EternalGear, 4)]
                  [(SecretGemOf Caster, 4), (EvilBone, 5)]
                  [(EvilBone, 10), (PhoenixFeather, 2)]
                  [(PhoenixFeather, 5), (HeartOfTheForeignGod, 4)]
    }
  , { name  =   "Zhuge Liang (Lord El-Melloi II)"
    , spoiler   = Nothing
    , id        = 37
    , rarity    = 5
    , class     = Caster
    , attr      = Human
    , deck      = Deck Quick Arts Arts Arts Buster
    , curve     = 15
    , stats     = { base  = { atk = 1637,  hp = 2091 }
                  , max   = { atk = 10598, hp = 14259 }
                  , grail = { atk = 11601, hp = 15621 }
                  }
    , skills    = [ { name   = "Discerning Eye"
                    , rank   = A
                    , icon   = Icon.ExclamationUp
                    , cd     = 7
                    , effect = [ Grant Ally 3 CritUp <| Range 20 50
                               , To Ally GaugeUp <| Flat 30
                               ]
                    }
                  , { name   = "Tactician's Advice"
                    , rank   = APlus
                    , icon   = Icon.ShieldUp
                    , cd     = 8
                    , effect = [ Grant Party 3 DefenseUp <| Range 20 30
                               , Grant Party 3 DamageCut <| Range 200 500
                               , To Party GaugeUp <| Flat 10
                               ]
                    }
                  , { name   = "Tactician's Command"
                    , rank   = APlus
                    , icon   = Icon.SwordUp
                    , cd     = 8
                    , effect = [ Grant Party 3 AttackUp <| Range 20 30
                               , Grant Party 3 DamageUp <| Range 200 500
                               , To Party GaugeUp <| Flat 10
                               ]
                    }
                  ]
    , passives  = [itemConstruction B, territoryCreation A]
    , phantasm  = { name   = "Unreturning Formation"
                  , rank   = C
                  , card   = Arts
                  , kind   = "Anti-Army"
                  , hits   = 0
                  , effect = [ Chance 150 << Debuff Enemies 3 DefenseDown <| Range 30 50
                             , Chance 150 << Debuff Enemies 3 Curse <| Flat 1000
                             , To Enemies GaugeDown <| Flat 1
                             ]
                  , over   = [ Chances 50 80 <| Debuff Enemies 1 Stun Full ]
                  , first  = False
                  }
    , gen       = { starWeight = 50, starRate = 10.8, npAtk = 1.64, npDef = 3 }
    , hits      = { quick = 2, arts = 1, buster = 1, ex = 3 }
    , gender    = Male
    , traits    = [Humanoid, EnumaElish, LovedOne, PseudoServant]
    , death     = 34.5
    , align     = [Neutral, Good]
    , limited   = False
    , free      = False
    , ascendUp  = Ascension
                  [(Piece Caster, 5)]
                  [(Piece Caster, 12), (VoidsDust, 15)]
                  [(Monument Caster, 5), (ForbiddenPage, 10), (EternalGear, 5)]
                  [(Monument Caster, 12), (EternalGear, 10), (PhoenixFeather, 10)]
    , skillUp   = Reinforcement
                  [(GemOf Caster, 5)]
                  [(GemOf Caster, 12)]
                  [(MagicGemOf Caster, 5)]
                  [(MagicGemOf Caster, 12), (ForbiddenPage, 5)]
                  [(SecretGemOf Caster, 5), (ForbiddenPage, 10)]
                  [(SecretGemOf Caster, 12), (VoidsDust, 10)]
                  [(VoidsDust, 20), (HeartOfTheForeignGod, 3)]
                  [(HeartOfTheForeignGod, 8), (PhoenixFeather, 20)]
    }
  , { name      = "Cu Chulainn (Caster)"
    , spoiler   = Nothing
    , id        = 38
    , rarity    = 3
    , class     = Caster
    , attr      = Sky
    , deck      = Deck Quick Arts Arts Arts Buster
    , curve     = 8
    , stats     = { base  = { atk = 1222,  hp = 1728 }
                  , max   = { atk = 6580, hp = 9604 }
                  , grail = { atk = 8905, hp = 13022 }
                  }
    , skills    = [ { name   = "Primordial Rune"
                    , rank   = Unknown
                    , icon   = Icon.ExclamationUp
                    , cd     = 7
                    , effect = [ Grant Self 3 CritUp <| Range 20 50
                               , Grant Self 3 DebuffResist <| Range 20 50
                               , To Self GaugeUp <| Range 20 30
                               ]
                    }
                  , { name   = "Divine Protection from Arrows"
                    , rank   = A
                    , icon   = Icon.Dodge
                    , cd     = 7
                    , effect = [ Times 3 <| Grant Self 0 Evasion Full
                               , Grant Self 3 DefenseUp <| Range 9 18
                               ]
                    }
                  , { name   = "Disengage"
                    , rank   = C
                    , icon   = Icon.Bubbles
                    , cd     = 7
                    , effect = [ To Self RemoveDebuffs Full
                               , To Self Heal <| Range 500 1500
                               ]
                    }
                  ]
    , passives  = [territoryCreation B, divinity B]
    , phantasm  = { name   = "Wicker Man"
                  , rank   = B
                  , card   = Buster
                  , kind   = "Anti-Army"
                  , hits   = 1
                  , effect = [ To Enemies Damage <| Range 300 500 ]
                  , over   = [ Debuff Enemies 3 DefenseDown <| Range 10 30
                             , Debuff Enemies 10 Burn <| Range 300 1500
                             ]
                  , first  = False
                  }
    , gen       = { starWeight = 49, starRate = 10.9, npAtk = 1.6, npDef = 3 }
    , hits      = { quick = 2, arts = 1, buster = 1, ex = 3 }
    , gender    = Male
    , traits    = [Humanoid, Divine, LovedOne, EnumaElish]
    , death     = 42
    , align     = [Lawful, Balanced]
    , limited   = False
    , free      = False
    , ascendUp  = Ascension
                  [(Piece Caster, 4)]
                  [(Piece Caster, 8), (SeedOfYggdrasil, 6)]
                  [(Monument Caster, 4), (ClawOfChaos, 2), (ForbiddenPage, 7)]
                  [(Monument Caster, 8), (ClawOfChaos, 4), (EternalGear, 8)]
    , skillUp   = Reinforcement
                  [(GemOf Caster, 4)]
                  [(GemOf Caster, 8)]
                  [(MagicGemOf Caster, 4)]
                  [(MagicGemOf Caster, 8), (ForbiddenPage, 4)]
                  [(SecretGemOf Caster, 4), (ForbiddenPage, 7)]
                  [(SecretGemOf Caster, 8), (SeedOfYggdrasil, 4)]
                  [(PhoenixFeather, 4), (SeedOfYggdrasil, 8)]
                  [(PhoenixFeather, 10), (EternalGear, 16)]
    }
  , { name      = "Elisabeth Bathory (Halloween)"
    , spoiler   = Nothing
    , id        = 61
    , rarity    = 4
    , class     = Caster
    , attr      = Human
    , deck      = Deck Quick Arts Arts Arts Buster
    , curve     = 4
    , stats     = { base  = { atk = 1436,  hp = 1824 }
                  , max   = { atk = 8616,  hp = 11404 }
                  , grail = { atk = 10432, hp = 13827 }
                  }
    , skills    = [ { name  = "Innocent Monster"
                  , rank   = EX
                  , icon    = Icon.StarTurn
                  , cd      = 7
                  , effect = [ Grant Self 3 StarsPerTurn <| Range 6 12
                             , To Self Heal <| Range 1000 2000
                             ]
                  }
                , { name   = "Mana Burst (Pumpkin)"
                  , rank   = A
                  , icon   = Icon.BusterUp
                  , cd     = 7
                  , effect = [ Grant Self 1 (CardUp Buster) <| Range 25 45
                             , Debuff Enemies 10 Burn <| Flat 300
                             ]
                  }
                , { name   = "Performance Continuation"
                  , rank   = A
                  , icon   = Icon.Kneel
                  , cd     = 9
                  , effect = [ Times 1 << Grant Self 5 Guts <| Range 1000 2500
                             , To Party GainStars <| Flat 8
                             ]
                  }
                  ]
    , passives  = [territoryCreation B, itemConstruction A]
    , phantasm  = { name   = "Báthory Halloween Erzsébet"
                  , rank   = EMinus
                  , card   = Buster
                  , kind   = "Anti-Army"
                  , hits   = 5
                  , effect = [ To Enemies DamageThruDef <| Range 300 500 ]
                  , over   = [ Debuff Enemies 3 Curse <| Range 500 2500 ]
                  , first  = False
                  }
    , gen       = { starWeight = 49, starRate = 10.8, npAtk = 1.6, npDef = 3 }
    , hits      = { quick = 2, arts = 1, buster = 1, ex = 4 }
    , gender    = Female
    , traits    = [Humanoid, Dragon, EnumaElish]
    , death     = 42
    , align     = [Chaotic, Evil]
    , limited   = True
    , free      = True
    , ascendUp  = Welfare "Twinkle Candy"
    , skillUp   = Reinforcement
                  [(GemOf Caster, 4)]
                  [(GemOf Caster, 10)]
                  [(MagicGemOf Caster, 4)]
                  [(MagicGemOf Caster, 10), (GhostLantern, 4)]
                  [(SecretGemOf Caster, 4), (GhostLantern, 8)]
                  [(SecretGemOf Caster, 10), (EvilBone, 12)]
                  [(DragonFang, 12), (EvilBone, 24)]
                  [(DragonFang, 36), (DragonsReverseScale, 8)]
    }
  , { name      = "Tamamo-no-Mae"
    , spoiler   = Nothing
    , id        = 62
    , rarity    = 5
    , class     = Caster
    , attr      = Sky
    , deck      = Deck Quick Arts Arts Arts Buster
    , curve     = 5
    , stats     = { base  = { atk = 1629,  hp = 2091 }
                  , max   = { atk = 10546, hp = 14259 }
                  , grail = { atk = 11544, hp = 15621 }
                  }
    , skills    = [ { name  = "Curse"
                    , rank   = EX
                    , icon    = Icon.MagicDark
                    , cd      = 7
                    , effect = [ Chances 80 100 << To Enemy GaugeDown <| Flat 1 ]
                    }
                  , { name    = "Morph"
                    , rank   = A
                    , icon    = Icon.ShieldUp
                    , cd      = 7
                    , effect = [ Grant Self 3 DefenseUp <| Range 10 30
                               , Grant Self 1 DefenseUp <| Flat 30
                               ]
                    }
                  , { name    = "Fox's Wedding"
                    , rank   = EX
                    , icon    = Icon.ArtsUp
                    , cd      = 7
                    , effect = [ Grant Ally 3 (CardUp Arts) <| Range 30 50
                               , To Ally Heal <| Range 1000 2500
                               ]
                    }
                  ]
    , passives  = [territoryCreation C, divinity A]
    , phantasm  = { name   = "Eightfold Blessings of Amaterasu"
                  , rank   = D
                  , card   = Arts
                  , kind   = "Anti-Army"
                  , hits   = 0
                  , effect = [ To Party ReduceCooldowns <| Flat 1
                             , To Party Heal <| Range 2000 3000
                             ]
                  , over   = [ To Party GaugeUp <| Range 25 50 ]
                  , first  = False
                  }
    , gen       = { starWeight = 49, starRate = 11, npAtk = 0.32, npDef = 3 }
    , hits      = { quick = 3, arts = 5, buster = 1, ex = 4 }
    , gender    = Female
    , traits    = [Humanoid, Divine, EnumaElish]
    , death     = 36
    , align     = [Neutral, Evil]
    , limited   = False
    , free      = False
    , ascendUp  = Ascension
                  [(Piece Caster, 5)]
                  [(Piece Caster, 12), (GhostLantern, 8)]
                  [(Monument Caster, 5), (EvilBone, 29), (HeartOfTheForeignGod, 2)]
                  [(Monument Caster, 12), (HeartOfTheForeignGod, 4), (ForbiddenPage, 12)]
    , skillUp   = Reinforcement
                  [(GemOf Caster, 5)]
                  [(GemOf Caster, 12)]
                  [(MagicGemOf Caster, 5)]
                  [(MagicGemOf Caster, 12), (EvilBone, 15)]
                  [(SecretGemOf Caster, 5), (EvilBone, 29)]
                  [(SecretGemOf Caster, 12), (GhostLantern, 5)]
                  [(GhostLantern, 10), (SeedOfYggdrasil, 8)]
                  [(SeedOfYggdrasil, 22), (ForbiddenPage, 24)]
    }
  , { name      = "Medea (Lily)"
    , spoiler   = Nothing
    , id        = 67
    , rarity    = 4
    , class     = Caster
    , attr      = Earth
    , deck      = Deck Quick Arts Arts Arts Buster
    , curve     = 9
    , stats     = { base  = { atk = 1294, hp = 2091 }
                  , max   = { atk = 7766, hp = 13070 }
                  , grail = { atk = 9403, hp = 15847 }
                  }
    , skills    = [ { name   = "Rapid Words of Divine"
                    , rank   = A
                    , icon   = Icon.Noble
                    , cd     = 9
                    , effect = [ To Self GaugeUp <| Range 80 150 ]
                    }
                  , { name   = "Poison Resistance"
                    , rank   = APlusPlus
                    , icon   = Icon.Bubbles
                    , cd     = 7
                    , effect = [ To Party Cure Full
                               , To Party Heal <| Range 2000 3000
                               ]
                    }
                  , { name   = "Ephemeral Love"
                    , rank   = B
                    , icon   = Icon.Heal
                    , cd     = 10
                    , effect = [ Grant Ally 1 HealingReceived <| Range 50 100 ]
                    }
                  ]
    , passives  = [territoryCreation B, itemConstruction B]
    , phantasm  = { name   = "Pain Breaker"
                  , rank   = C
                  , card   = Arts
                  , kind   = "Anti-Magic"
                  , hits   = 0
                  , effect = [ To Party RemoveDebuffs Full
                             , To Party Heal <| Range 4000 6000
                             ]
                  , over   = [ Grant Party 3 DebuffResist <| Range 40 120 ]
                  , first  = False
                  }
    , gen       = { starWeight = 51, starRate = 10.7, npAtk = 0.4, npDef = 3 }
    , hits      = { quick = 4, arts = 4, buster = 3, ex = 5 }
    , gender    = Female
    , traits    = [Argonaut, Humanoid, EnumaElish]
    , death     = 36
    , align     = [Lawful, Good]
    , limited   = False
    , free      = False
    , ascendUp  = Ascension
                  [(Piece Caster, 4)]
                  [(Piece Caster, 10), (VoidsDust, 12)]
                  [(Monument Caster, 4), (GhostLantern, 8), (PhoenixFeather, 4)]
                  [(Monument Caster, 10), (PhoenixFeather, 7), (ForbiddenPage, 10)]
    , skillUp   = Reinforcement
                  [(GemOf Caster, 4)]
                  [(GemOf Caster, 10)]
                  [(MagicGemOf Caster, 4)]
                  [(MagicGemOf Caster, 10), (GhostLantern, 4)]
                  [(SecretGemOf Caster, 4), (GhostLantern, 8)]
                  [(SecretGemOf Caster, 10), (VoidsDust, 8)]
                  [(VoidsDust, 16), (HeartOfTheForeignGod, 2)]
                  [(HeartOfTheForeignGod, 6), (ForbiddenPage, 20)]
    }
  , { name      = "Paracelsus von Hohenheim"
    , spoiler   = Nothing
    , id        = 79
    , rarity    = 3
    , class     = Caster
    , attr      = Human
    , deck      = Deck Quick Arts Arts Arts Buster
    , curve     = 3
    , stats     = { base  = { atk = 1246, hp = 1711 }
                  , max   = { atk = 6711, hp = 9506 }
                  , grail = { atk = 9082, hp = 12889 }
                  }
    , skills    = [ { name   = "Rapid Casting"
                    , rank   = A
                    , icon   = Icon.Noble
                    , cd     = 10
                    , effect = [ To Self GaugeUp <| Range 55 80 ]
                    }
                  , { name   = "Elemental"
                    , rank   = APlus
                    , icon   = Icon.ArtsUp
                    , cd     = 9
                    , effect = [ Grant Party 3 (CardUp Arts) <| Range 10 20 ]
                    }
                  , { name   = "Philosopher's Stone"
                    , rank   = A
                    , icon   = Icon.Kneel
                    , cd     = 10
                    , effect = [ Times 1 << Grant Ally 3 Guts <| Range 1000 3000 ]
                    }
                  ]
    , passives  = [territoryCreation A, itemConstruction EX]
    , phantasm  = { name   = "Sword of Paracelsus"
                  , rank   = APlus
                  , card   = Arts
                  , kind   = "Anti-Army"
                  , hits   = 3
                  , effect = [ To Enemies Damage <| Range 400 600 ]
                  , over   = [ Debuff Enemies 3 AttackDown <| Range 10 30 ]
                  , first  = False
                  }
    , gen       = { starWeight = 50, starRate = 10.8, npAtk = 0.55, npDef = 3 }
    , hits      = { quick = 2, arts = 2, buster = 1, ex = 3 }
    , gender    = Male
    , traits    = [Humanoid, EnumaElish, LovedOne]
    , death     = 36
    , align     = [Chaotic, Good]
    , limited   = False
    , free      = True
    , ascendUp  = Ascension
                  [(Piece Caster, 4)]
                  [(Piece Caster, 8), (ForbiddenPage, 5)]
                  [(Monument Caster, 4), (HomunculusBaby, 4), (EternalGear, 7)]
                  [(Monument Caster, 8), (HomunculusBaby, 7), (EvilBone, 24)]
    , skillUp   = Reinforcement
                  [(GemOf Caster, 4)]
                  [(GemOf Caster, 8)]
                  [(MagicGemOf Caster, 4)]
                  [(MagicGemOf Caster, 8), (EternalGear, 4)]
                  [(SecretGemOf Caster, 4), (EternalGear, 7)]
                  [(SecretGemOf Caster, 8), (ForbiddenPage, 4)]
                  [(VoidsDust, 8), (ForbiddenPage, 7)]
                  [(VoidsDust, 24), (EvilBone, 48)]
    }
  , { name      = "Nursery Rhyme"
    , spoiler   = Nothing
    , id        = 74
    , rarity    = 4
    , class     = Caster
    , attr      = Human
    , deck      = Deck Quick Arts Arts Arts Buster
    , curve     = 4
    , stats     = { base  = { atk = 1438,  hp = 1901 }
                  , max   = { atk = 8629,  hp = 11882 }
                  , grail = { atk = 10448, hp = 14407 }
                  }
    , skills    = [ { name  = "Self-Modification"
                    , rank   = A
                    , icon    = Icon.ExclamationUp
                    , cd      = 7
                    , effect = [ Grant Self 3 CritUp <| Range 20 50
                               , Grant Self 3 GatherUp <| Range 300 600
                               ]
                    }
                  , { name   = "Morph"
                    , rank   = APlus
                    , icon   = Icon.ShieldUp
                    , cd     = 7
                    , effect = [ Grant Self 3 DefenseUp <| Range 10 30
                               , Grant Self 1 DefenseUp <| Flat 30
                              , Grant Self 3 DebuffResist <| Range 20 40
                               ]
                    }
                  , { name   = "Meanwhile"
                    , rank   = A
                    , icon   = Icon.Noble
                    , cd     = 8
                    , effect = [ To Self GaugeUp <| Range 20 40
                               , To Self Heal <| Range 1000 2000
                               , To Self RemoveDebuffs Full
                               ]
                    }
                  ]
    , passives  = [territoryCreation A]
    , phantasm  = { name   = "Nursery Rhyme"
                  , rank   = C
                  , card   = Arts
                  , kind   = "Anti-Personnel"
                  , hits   = 3
                  , effect = [ To Enemies Damage <| Range 600 900
                             , Debuff Enemies 3 DefenseDown <| Flat 20
                             ]
                  , over   = [ Chances 60 100 << To Enemies GaugeDown <| Flat 1 ]
                  , first  = False
                  }
    , gen       = { starWeight = 50, starRate = 10.8, npAtk = 0.54, npDef = 3 }
    , hits      = { quick = 3, arts = 3, buster = 1, ex = 3 }
    , gender    = Female
    , traits    = [Humanoid, EnumaElish]
    , death     = 36
    , align     = [Neutral, Balanced]
    , limited   = False
    , free      = False
    , ascendUp  = Ascension
                  [(Piece Caster, 4)]
                  [(Piece Caster, 10), (SeedOfYggdrasil, 8)]
                  [(Monument Caster, 4), (ForbiddenPage, 4), (GhostLantern, 8)]
                  [(Monument Caster, 10), (ForbiddenPage, 8), (PhoenixFeather, 8)]
    , skillUp   = Reinforcement
                  [(GemOf Caster, 4)]
                  [(GemOf Caster, 10)]
                  [(MagicGemOf Caster, 4)]
                  [(MagicGemOf Caster, 10), (GhostLantern, 4)]
                  [(SecretGemOf Caster, 4), (GhostLantern, 8)]
                  [(SecretGemOf Caster, 10), (SeedOfYggdrasil, 5)]
                  [(SeedOfYggdrasil, 10), (HomunculusBaby, 5)]
                  [(HomunculusBaby, 15), (PhoenixFeather, 16)]
    }
  , { name      = "Charles Babbage"
    , spoiler   = Nothing
    , id        = 80
    , rarity    = 3
    , class     = Caster
    , attr      = Human
    , deck      = Deck Quick Arts Arts Buster Buster
    , curve     = 13
    , stats     = { base  = { atk = 1113, hp = 1959 }
                  , max   = { atk = 5996, hp = 10887 }
                  , grail = { atk = 8115, hp = 14761 }
                  }
    , skills    = [ { name   = "Concentration"
                    , rank   = C
                    , icon   = Icon.NobleUp
                    , cd     = 8
                    , effect = [ Grant Self 3 NPGen <| Range 20 30
                               , Grant Self 1 GatherUp <| Range 500 1000
                               ]
                    }
                  , { name   = "Mechanized Armor"
                    , rank   = EX
                    , icon   = Icon.SwordUp
                    , cd     = 7
                    , effect = [ Grant Self 1 AttackUp <| Range 20 40
                               , Grant Self 1 Invincibility Full
                               ]
                    }
                  , { name   = "Overload"
                    , rank   = D
                    , icon   = Icon.BeamUp
                    , cd     = 7
                    , effect = [ Grant Self 1 NPUp <| Range 15 25
                               , Debuff Self 5 Burn <| Flat 300
                               ]
                    }
                  ]
    , passives  = [itemConstructionFake A]
    , phantasm  = { name   = "Dimension of Steam"
                  , rank   = EX
                  , card   = Buster
                  , kind   = "Anti-Army"
                  , hits   = 4
                  , effect = [ To Enemies Damage <| Range 400 600 ]
                  , over   = [ Debuff Enemies 3 DefenseDown <| Range 10 20 ]
                  , first  = False
                  }
    , gen       = { starWeight = 48, starRate = 10.8, npAtk = 0.91, npDef = 3 }
    , hits      = { quick = 2, arts = 2, buster = 1, ex = 3 }
    , gender    = Male
    , traits    = [Humanoid, EnumaElish]
    , death     = 36
    , align     = [Chaotic, Balanced]
    , limited   = False
    , free      = True
    , ascendUp  = Ascension
                  [(Piece Caster, 4)]
                  [(Piece Caster, 8), (EternalGear, 5)]
                  [(Monument Caster, 4), (ForbiddenPage, 4), (OctupletCrystals, 7)]
                  [(Monument Caster, 8), (ForbiddenPage, 7), (VoidsDust, 16)]
    , skillUp   = Reinforcement
                  [(GemOf Caster, 4)]
                  [(GemOf Caster, 8)]
                  [(MagicGemOf Caster, 4)]
                  [(MagicGemOf Caster, 8), (OctupletCrystals, 4)]
                  [(SecretGemOf Caster, 4), (OctupletCrystals, 7)]
                  [(SecretGemOf Caster, 8), (EternalGear, 4)]
                  [(GhostLantern, 4), (EternalGear, 7)]
                  [(VoidsDust, 32), (GhostLantern, 12)]
    }
  , { name      = "Helena Blavatsky"
    , spoiler   = Nothing
    , id        = 100
    , rarity    = 4
    , class     = Caster
    , attr      = Human
    , deck      = Deck Quick Arts Arts Arts Buster
    , curve     = 4
    , stats     = { base  = { atk = 1438,  hp = 1901 }
                  , max   = { atk = 8629,  hp = 11882 }
                  , grail = { atk = 10448, hp = 14407 }
                  }
    , skills    = [ { name   = "Mana Tuning"
                    , rank   = C
                    , icon   = Icon.Noble
                    , cd     = 9
                    , effect = [ To Party GaugeUp <| Range 10 20 ]
                    }
                  , { name   = "Mahatma"
                    , rank   = A
                    , icon   = Icon.StarTurn
                    , cd     = 10
                    , effect = [ Grant Self 5 StarsPerTurn <| Flat 5
                               , Chances 60 80 << Grant Self 1 NPUp <| Flat 50
                               ]
                    }
                  , { name    = "Search for the Unknown"
                    , rank   = B
                    , icon   = Icon.AllUp
                    , cd     = 9
                    , effect = [ Grant Party 3 (CardUp Quick) <| Range 15 20
                              , Grant Party 3 (CardUp Arts) <| Range 15 20
                              , Grant Party 3 (CardUp Buster) <| Range 15 20
                              ]
                    }
                  ]
    , passives  = [territoryCreation A, itemConstruction B]
    , phantasm  = { name   = "Sanat Kumara"
                  , rank   = APlus
                  , card   = Arts
                  , kind   = "Anti-Army"
                  , hits   = 3
                  , effect = [ To Enemies DamageThruDef <| Range 600 900 ]
                  , over   = [ Debuff Enemies 3 DefenseDown <| Range 10 50
                             , Debuff Enemies 3 CritChance <| Range 10 50
                             , Debuff Enemies 3 DebuffVuln <| Range 10 50
                             ]
                  , first  = False
                  }
    , gen       = { starWeight = 51, starRate = 10.7, npAtk = 0.45, npDef = 3 }
    , hits      = { quick = 6, arts = 3, buster = 1, ex = 3 }
    , gender    = Female
    , traits    = [Humanoid, EnumaElish]
    , death     = 36
    , align     = [Chaotic, Good]
    , limited   = False
    , free      = False
    , ascendUp  = Ascension
                  [(Piece Caster, 4)]
                  [(Piece Caster, 10), (VoidsDust, 12)]
                  [(Monument Caster, 4), (GhostLantern, 8), (HomunculusBaby, 4)]
                  [(Monument Caster, 10), (HomunculusBaby, 8), (ForbiddenPage, 10)]
    , skillUp   = Reinforcement
                  [(GemOf Caster, 4)]
                  [(GemOf Caster, 10)]
                  [(MagicGemOf Caster, 4)]
                  [(MagicGemOf Caster, 10), (GhostLantern, 4)]
                  [(SecretGemOf Caster, 4), (GhostLantern, 8)]
                  [(SecretGemOf Caster, 10), (VoidsDust, 8)]
                  [(VoidsDust, 16), (BlackBeastGrease, 3)]
                  [(BlackBeastGrease, 9), (PhoenixFeather, 16)]
    }
  , { name      = "Thomas Edison"
    , spoiler   = Nothing
    , id        = 103
    , rarity    = 4
    , class     = Caster
    , attr      = Human
    , deck      = Deck Quick Arts Arts Arts Buster
    , curve     = 24
    , stats     = { base  = { atk = 1325, hp = 1901 }
                  , max   = { atk = 7952, hp = 11882 }
                  , grail = { atk = 9628, hp = 14407 }
                  }
    , skills    = [ { name   = "Morph"
                    , rank   = C
                    , icon   = Icon.ShieldUp
                    , cd     = 7
                    , effect = [ Grant Self 3 DefenseUp <| Range 16 24 ]
                    }
                  , { name   = "Mass Production"
                    , rank   = A
                    , icon   = Icon.StarTurn
                    , cd     = 12
                    , effect = [ Grant Self 5 StarsPerTurn <| Range 5 10
                               , Grant Self 5 GaugePerTurn <| Range 5 10
                               ]
                    }
                  , { name   = "Concept Improvement"
                    , rank   = APlus
                    , icon   = Icon.SunUp
                    , cd     = 8
                    , effect = [ Grant Ally 1 Overcharge <| Flat 2
                               , Grant Ally 1 StarUp <| Range 10 30
                               ]
                    }
                  ]
    , passives  = [territoryCreation D, itemConstruction D]
    , phantasm  = { name   = "World Faith Domination"
                  , rank   = EX
                  , card   = Arts
                  , kind   = "Anti-Populace"
                  , hits   = 1
                  , effect = [ To Enemies Damage <| Range 600 900
                             , Debuff Enemies 1 SealSkills Full
                             , Debuff Enemies 1 SealNP Full
                             ]
                  , over   = [ Debuff Enemies 3 CritChance <| Range 10 50
                             , Debuff Enemies 3 AttackDown <| Range 10 50
                             ]
                  , first  = False
                  }
    , gen       = { starWeight = 51, starRate = 10.6, npAtk = 0.51, npDef = 3 }
    , hits      = { quick = 3, arts = 3, buster = 3, ex = 5 }
    , gender    = Male
    , traits    = [Humanoid, EnumaElish]
    , death     = 60
    , align     = [Lawful, Balanced]
    , limited   = False
    , free      = False
    , ascendUp  = Ascension
                  [(Piece Caster, 4)]
                  [(Piece Caster, 10), (ForbiddenPage, 6)]
                  [(Monument Caster, 4), (ProofOfHero, 24), (EternalGear, 4)]
                  [(Monument Caster, 10), (EternalGear, 8), (BlackBeastGrease, 6)]
    , skillUp   = Reinforcement
                  [(GemOf Caster, 4)]
                  [(GemOf Caster, 10)]
                  [(MagicGemOf Caster, 4)]
                  [(MagicGemOf Caster, 10), (ProofOfHero, 12)]
                  [(SecretGemOf Caster, 4), (ProofOfHero, 24)]
                  [(SecretGemOf Caster, 10), (ForbiddenPage, 4)]
                  [(ForbiddenPage, 8), (HeartOfTheForeignGod, 2)]
                  [(HeartOfTheForeignGod, 6), (ClawOfChaos, 12)]
    }
  , { name      = "Geronimo"
    , spoiler   = Nothing
    , id        = 104
    , rarity    = 3
    , class     = Caster
    , attr      = Human
    , deck      = Deck Quick Arts Arts Buster Buster
    , curve     = 3
    , stats     = { base  = { atk = 1273, hp = 1642 }
                  , max   = { atk = 6857, hp = 9123 }
                  , grail = { atk = 9280, hp = 12369 }
                  }
    , skills    = [ { name   = "Bloody Devil"
                    , rank   = B
                    , icon   = Icon.BusterUp
                    , cd     = 7
                    , effect = [ Grant Self 1 (CardUp Buster) <| Range 30 50 ]
                    }
                  , { name   = "Shamanism"
                    , rank   = B
                    , icon   = Icon.ArtsUp
                    , cd     = 7
                    , effect = [ Grant Self 1 (CardUp Arts) <| Range 30 50 ]
                    }
                  , { name   = "Guardian Beast"
                    , rank   = B
                    , icon   = Icon.QuickUp
                    , cd     = 7
                    , effect = [ Grant Self 1 (CardUp Quick) <| Range 30 50 ]
                    }
                  ]
    , passives  = [territoryCreation B, itemConstruction C]
    , phantasm  = { name   = "Tsago Degi Naleya"
                  , rank   = BPlus
                  , card   = Arts
                  , kind   = "Anti-Army"
                  , hits   = 1
                  , effect = [ To Enemies Damage <| Range 600 900
                             , Debuff Enemies 3 CritChance <| Flat 20
                             ]
                  , over   = [ To Party Heal <| Range 1000 2000
                             , Grant Party 3 DebuffResist <| Range 20 60
                             ]
                  , first  = False
                  }
    , gen       = { starWeight = 49, starRate = 11, npAtk = 0.9, npDef = 3 }
    , hits      = { quick = 2, arts = 2, buster = 1, ex = 4 }
    , gender    = Male
    , traits    = [Humanoid, EnumaElish, LovedOne]
    , death     = 40.5
    , align     = [Neutral, Good]
    , limited   = False
    , free      = True
    , ascendUp  = Ascension
                  [(Piece Caster, 4)]
                  [(Piece Caster, 8), (ProofOfHero, 15)]
                  [(Monument Caster, 4), (SeedOfYggdrasil, 8), (GhostLantern, 4)]
                  [(Monument Caster, 8), (GhostLantern, 7), (OctupletCrystals, 8)]
    , skillUp   = Reinforcement
                  [(GemOf Caster, 4)]
                  [(GemOf Caster, 8)]
                  [(MagicGemOf Caster, 4)]
                  [(MagicGemOf Caster, 8), (SeedOfYggdrasil, 4)]
                  [(SecretGemOf Caster, 4), (SeedOfYggdrasil, 8)]
                  [(SecretGemOf Caster, 8), (ProofOfHero, 10)]
                  [(ProofOfHero, 20), (EvilBone, 12)]
                  [(EvilBone, 36), (SpiritRoot, 7)]
    }
  , { name      = "Irisviel (Holy Grail)"
    , spoiler   = Nothing
    , id        = 111
    , rarity    = 4
    , class     = Caster
    , attr      = Sky
    , deck      = Deck Quick Arts Arts Arts Buster
    , curve     = 24
    , stats     = { base  = { atk = 1372, hp = 1996 }
                  , max   = { atk = 8237, hp = 12476 }
                  , grail = { atk = 9973, hp = 15127 }
                  }
    , skills    = [ { name  = "Sacrificial Resolve"
                    , rank   = A
                    , icon    = Icon.HealUp
                    , cd      = 9
                    , effect = [ Grant Self 1 HealUp<| Range 30 50 ]
                    }
                  , { name    = "Child of Nature"
                    , rank   = A
                    , icon    = Icon.Shield
                    , cd      = 8
                    , effect = [ Grant Self 1 Invincibility Full
                              , Grant Self 3 NPGen <| Range 20 30
                              ]
                    }
                  , { name    = "Magical Healing"
                    , rank   = A
                    , icon    = Icon.Heal
                    , cd      = 7
                    , effect = [ To Ally Heal <| Range 2000 3000 ]
                    }
                  ]
    , passives  = [territoryCreation B, coreOfGoddess C]
    , phantasm  = { name   = "Song of Grail"
                  , rank   = B
                  , card   = Arts
                  , kind   = "Magecraft"
                  , hits   = 0
                  , effect = [ To Party Heal <| Range 2000 3000 ]
                  , over   = [ Times 1 << Grant Party 3 Guts <| Range 1000 3000 ]
                  , first  = False
                  }
    , gen       = { starWeight = 50, starRate = 10.8, npAtk = 0.42, npDef = 3 }
    , hits      = { quick = 3, arts = 3, buster = 3, ex = 4 }
    , gender    = Female
    , traits    = [Humanoid, Divine, EnumaElish]
    , death     = 34.5
    , align     = [Chaotic, Good]
    , limited   = True
    , free      = True
    , ascendUp  = Welfare "Crystal Ball"
    , skillUp   = Reinforcement
                  [(GemOf Caster, 4)]
                  [(GemOf Caster, 10)]
                  [(MagicGemOf Caster, 4)]
                  [(MagicGemOf Caster, 10), (SeedOfYggdrasil, 5)]
                  [(SecretGemOf Caster, 4), (SeedOfYggdrasil, 10)]
                  [(SecretGemOf Caster, 10), (HomunculusBaby, 4)]
                  [(HomunculusBaby, 8), (PhoenixFeather, 4)]
                  [(PhoenixFeather, 12), (SpiritRoot, 8)]
    }
  , { name      = "Xuanzang Sanzang"
    , spoiler   = Nothing
    , id        = 113
    , rarity    = 5
    , class     = Caster
    , attr      = Human
    , deck      = Deck Quick Arts Arts Arts Buster
    , curve     = 15
    , stats     = { base  = { atk = 1801,  hp = 1901 }
                  , max   = { atk = 11658, hp = 12965 }
                  , grail = { atk = 12761, hp = 14204 }
                  }
    , skills    = [ { name   = "Rapid Sutra Chanting"
                    , rank   = A
                    , icon   = Icon.Noble
                    , cd     = 9
                    , effect = [ To Self GaugeUp <| Range 50 80
                               , Grant Self 1 NPUp <| Range 10 20
                               ]
                    }
                  , { name   = "Captivating Rosy Cheeks"
                    , rank   = A
                    , icon   = Icon.CrosshairUp
                    , cd     = 8
                    , effect = [ Grant Self 1 Taunt Full
                               , Grant Self 1 DamageCut <| Range 500 1500
                               ]
                    }
                  , { name   = "Sanzang's Teachings"
                    , rank   = A
                    , icon   = Icon.NobleUp
                    , cd     = 7
                    , effect = [ Grant Party 3 NPGen <| Range 10 30
                               , Grant Party 3 StarUp <| Range 10 30
                               , Grant Party 1 DebuffResist Full
                               ]
                    }
                  ]
    , passives  = [territoryCreation APlus, divinity D]
    , phantasm  = { name   = "Five Elements Mountain Buddha Palm"
                  , rank   = BPlus
                  , card   = Buster
                  , kind   = "Anti-Army"
                  , hits   = 12
                  , effect = [ To Enemy DamageThruDef <| Range 800 1200 ]
                  , over   = [ Debuff Enemy 1 CritChance <| Range 80 120 ]
                  , first  = False
                  }
    , gen       = { starWeight = 52, starRate = 11, npAtk = 0.82, npDef = 3 }
    , hits      = { quick = 3, arts = 2, buster = 1, ex = 6 }
    , gender    = Female
    , traits    = [Humanoid, Divine, EnumaElish]
    , death     = 34.5
    , align     = [Lawful, Good]
    , limited   = False
    , free      = False
    , ascendUp  = Ascension
                  [(Piece Caster, 5)]
                  [(Piece Caster, 12), (SeedOfYggdrasil, 9)]
                  [(Monument Caster, 5), (OctupletCrystals, 10), (PhoenixFeather, 4)]
                  [(Monument Caster, 12), (PhoenixFeather, 8), (SpiritRoot, 5)]
    , skillUp   = Reinforcement
                  [(GemOf Caster, 5)]
                  [(GemOf Caster, 12)]
                  [(MagicGemOf Caster, 5)]
                  [(MagicGemOf Caster, 12), (OctupletCrystals, 5)]
                  [(SecretGemOf Caster, 5), (OctupletCrystals, 10)]
                  [(SecretGemOf Caster, 12), (SeedOfYggdrasil, 6)]
                  [(SeedOfYggdrasil, 12), (MeteorHorseshoe, 6)]
                  [(MeteorHorseshoe, 18), (ForbiddenPage, 24)]
    }
  , { name      = "Nitocris"
    , spoiler   = Nothing
    , id        = 120
    , rarity    = 4
    , class     = Caster
    , attr      = Earth
    , deck      = Deck Quick Arts Arts Arts Buster
    , curve     = 9
    , stats     = { base  = { atk = 1510,  hp = 1806 }
                  , max   = { atk = 9060,  hp = 11288 }
                  , grail = { atk = 10970, hp = 13686 }
                  }
    , skills    = [ { name   = "Egyptian Magecraft"
                    , rank   = A
                    , icon   = Icon.ReaperUp
                    , cd     = 7
                    , effect = [ Grant Self 3 DeathUp <| Range 50 100
                               , To Self Heal <| Range 1000 3000
                               ]
                    }
                  , { name   = "Rapid Words of Divine"
                    , rank   = B
                    , icon   = Icon.Noble
                    , cd     = 9
                    , effect = [ To Self GaugeUp <| Range 60 120 ]
                    }
                  , { name   = "Affection of the Sky God"
                    , rank   = B
                    , icon   = Icon.Kneel
                    , cd     = 7
                    , effect = [ Times 1 << Grant Self 3 Guts <| Range 1000 2000
                               , To Self RemoveDebuffs Full
                               ]
                    }
                  ]
    , passives  = [territoryCreation A, itemConstruction BPlus, divinity B]
    , phantasm  = { name   = "Anpu Neb Ta Djeser"
                  , rank   = BPlusPlus
                  , card   = Arts
                  , kind   = "Anti-Army"
                  , hits   = 3
                  , effect = [ To Enemies Damage <| Range 600 900
                             , Debuff Enemies 3 CritChance <| Flat 20
                             ]
                  , over   = [ To Enemies Death <| Range 50 100 ]
                  , first  = True
                  }
    , gen       = { starWeight = 50, starRate = 10.8, npAtk = 0.54, npDef = 3 }
    , hits      = { quick = 4, arts = 3, buster = 3, ex = 5 }
    , gender    = Female
    , traits    = [Humanoid, Divine, King, EnumaElish]
    , death     = 36
    , align     = [Lawful, Good]
    , limited   = False
    , free      = False
    , ascendUp  = Ascension
                  [(Piece Caster, 4)]
                  [(Piece Caster, 10), (ForbiddenPage, 6)]
                  [(Monument Caster, 4), (FoolsChain, 24), (ScarabOfWisdom, 2)]
                  [(Monument Caster, 10), (ScarabOfWisdom, 4), (LampOfEvilSealing, 6)]
    , skillUp   = Reinforcement
                  [(GemOf Caster, 4)]
                  [(GemOf Caster, 10)]
                  [(MagicGemOf Caster, 4)]
                  [(MagicGemOf Caster, 10), (FoolsChain, 12)]
                  [(SecretGemOf Caster, 4), (FoolsChain, 24)]
                  [(SecretGemOf Caster, 10), (ForbiddenPage, 4)]
                  [(ForbiddenPage, 8), (HeartOfTheForeignGod, 2)]
                  [(HeartOfTheForeignGod, 6), (EvilBone, 60)]
    }
  , { name      = "Leonardo da Vinci"
    , spoiler   = Nothing
    , id        = 127
    , rarity    = 5
    , class     = Caster
    , attr      = Star
    , deck      = Deck Quick Arts Arts Arts Buster
    , curve     = 30
    , stats     = { base  = { atk = 1637,  hp = 2091 }
                  , max   = { atk = 10598, hp = 14259 }
                  , grail = { atk = 11601, hp = 15621 }
                  }
    , skills    = [ { name   = "Inherent Wisdom"
                    , rank   = EX
                    , icon   = Icon.Kneel
                    , cd     = 7
                    , effect = [ Times 1 << Grant Self 3 Guts <| Range 1000 3000
                               , Chance 85 << Grant Self 3 DefenseUp <| Range 20 30
                               , Chance 85 << Grant Self 3 NPUp <| Range 20 30
                               ]
                    }
                  , { name   = "Golden Rule (Body)"
                    , rank   = B
                    , icon   = Icon.HealTurn
                    , cd     = 8
                    , effect = [ Grant Self 2 DebuffResist Full
                               , Grant Self 3 HealPerTurn <| Range 500 1000
                               , Grant Self 3 GaugePerTurn <| Flat 10
                               ]
                    }
                  , { name   = "Pioneer of the Stars"
                    , rank   = EX
                    , icon   = Icon.Noble
                    , cd     = 8
                    , effect = [ To Self GaugeUp <| Range 30 50
                               , Grant Self 3 IgnoreInvinc Full
                               , To Party GainStars <| Flat 10
                               ]
                    }
                  ]
    , passives  = [territoryCreation A, itemConstruction A]
    , phantasm  = { name   = "Uomo Universale"
                  , rank   = EX
                  , card   = Arts
                  , kind   = "Anti-Unit/Anti-Army"
                  , hits   = 1
                  , effect = [ To Enemies DamageThruDef <| Range 450 750
                             , Debuff Enemies 3 CritChance <| Flat 10
                             ]
                  , over   = [ Grant Self 1 NPUp <| Range 30 70 ]
                  , first  = True
                  }
    , gen       = { starWeight = 50, starRate = 10.8, npAtk = 0.54, npDef = 3 }
    , hits      = { quick = 4, arts = 3, buster = 1, ex = 4 }
    , gender    = Female
    , traits    = [Humanoid, EnumaElish]
    , death     = 34.5
    , align     = [Chaotic, Good]
    , limited   = True
    , free      = False
    , ascendUp  = Ascension
                  [(Piece Caster, 5)]
                  [(Piece Caster, 12), (EternalGear, 8)]
                  [(Monument Caster, 5), (PhoenixFeather, 8), (SpiritRoot, 2)]
                  [(Monument Caster, 12), (SpiritRoot, 4), (ScarabOfWisdom, 5)]
    , skillUp   = Reinforcement
                  [(GemOf Caster, 5)]
                  [(GemOf Caster, 12)]
                  [(MagicGemOf Caster, 5)]
                  [(MagicGemOf Caster, 12), (PhoenixFeather, 4)]
                  [(SecretGemOf Caster, 5), (PhoenixFeather, 8)]
                  [(SecretGemOf Caster, 12), (EternalGear, 5)]
                  [(EternalGear, 10), (ForbiddenPage, 6)]
                  [(ForbiddenPage, 18), (BlackBeastGrease, 15)]
    }
  , { name      = "Marie Antoinette (Caster)"
    , spoiler   = Nothing
    , id        = 130
    , rarity    = 4
    , class     = Caster
    , attr      = Human
    , deck      = Deck Quick Arts Arts Arts Buster
    , curve     = 9
    , stats     = { base  = { atk = 1510,  hp = 1824 }
                  , max   = { atk = 9060,  hp = 11404 }
                  , grail = { atk = 10970, hp = 13827 }
                  }
    , skills    = [ { name   = "Beach Flower"
                    , rank   = APlus
                    , icon   = Icon.SwordUp
                    , cd     = 7
                    , effect = [ Grant Party 3 AttackUp <| Range 9.5 19.5
                               , Grant (AlliesType Male) 3 StarUp <| Range 21 41
                               ]
                    }
                  , { name   = "Sparkling Sunflower"
                    , rank   = A
                    , icon   = Icon.StarTurn
                    , cd     = 9
                    , effect = [ Grant Self 3 StarsPerTurn <| Range 5 10
                               , Grant Self 3 HealPerTurn <| Range 500 1000
                               ]
                    }
                  , { name   = "Beautiful Princess (Sea)"
                    , rank   = A
                    , icon   = Icon.Shield
                    , cd     = 8
                    , effect = [ Times 3 <| Grant Self 0 Invincibility Full
                               , Grant Self 3 DebuffResist <| Range 30 50
                               ]
                    }
                  ]
    , passives  = [territoryCreation A, itemConstruction D]
    , phantasm  = { name   = "Crystal Dress"
                  , rank   = A
                  , card   = Arts
                  , kind   = "Anti-Army/Anti-Populace"
                  , hits   = 3
                  , effect = [ To Enemies Damage <| Range 450 750
                             , Debuff Enemies 3 CritChance <| Flat 20
                             ]
                  , over   = [ Grant Party 3 CritUp <| Range 20 40 ]
                  , first  = False
                  }
    , gen       = { starWeight = 50, starRate = 10.9, npAtk = 0.32, npDef = 3 }
    , hits      = { quick = 3, arts = 5, buster = 1, ex = 4 }
    , gender    = Female
    , traits    = [Humanoid, EnumaElish, King]
    , death     = 36
    , align     = [Lawful, Good]
    , limited   = True
    , free      = False
    , ascendUp  = Ascension
                  [(Piece Caster, 4)]
                  [(Piece Caster, 10), (SeedOfYggdrasil, 8)]
                  [(Monument Caster, 4), (PhoenixFeather, 4), (ShellOfReminiscence, 8)]
                  [(Monument Caster, 10), (PhoenixFeather, 7), (ScarabOfWisdom, 4)]
    , skillUp   = Reinforcement
                  [(GemOf Caster, 4)]
                  [(GemOf Caster, 10)]
                  [(MagicGemOf Caster, 4)]
                  [(MagicGemOf Caster, 10), (ShellOfReminiscence, 4)]
                  [(SecretGemOf Caster, 4), (ShellOfReminiscence, 8)]
                  [(SecretGemOf Caster, 10), (SeedOfYggdrasil, 5)]
                  [(SerpentJewel, 4), (SeedOfYggdrasil, 10)]
                  [(SerpentJewel, 12), (EternalGear, 20)]
    }
  , { name      = "Illyasviel von Einzbern"
    , spoiler   = Nothing
    , id        = 136
    , rarity    = 5
    , class     = Caster
    , attr      = Human
    , deck      = Deck Quick Arts Arts Arts Buster
    , curve     = 10
    , stats     = { base  = { atk = 1677,  hp = 2027 }
                  , max   = { atk = 10857, hp = 13825 }
                  , grail = { atk = 11885, hp = 15146 }
                  }
    , skills    = [ { name   = "Cheerful-Type Mystic Code"
                    , rank   = A
                    , icon   = Icon.BusterUp
                    , cd     = 7
                    , effect = [ Grant Self 1 (CardUp Buster) <| Range 30 50 ]
                    }
                  , { name   = "Child of Nature"
                    , rank   = B
                    , icon   = Icon.Shield
                    , cd     = 8
                    , effect = [ Grant Self 1 Invincibility Full
                               , Grant Self 3 NPGen <| Range 18 28
                               ]
                    }
                  , { name   = "Suspicious Medicine"
                    , rank   = A
                    , icon   = Icon.Heal
                    , cd     = 8
                    , effect = [ To Ally Heal <| Range 1000 3000
                               , Chance 70 <| Grant Self 1 DebuffResist Full
                               , Chance 70 << Times 1 << Grant Self 3 Guts <| Flat 1000
                               ]
                    }
                  ]
    , passives  = [magicResistance B, unlimitedManaSupply C]
    , phantasm  = { name   = "Quintett Feuer"
                  , rank   = EX
                  , card   = Buster
                  , kind   = "Anti-Unit"
                  , hits   = 4
                  , effect = [ To Enemy Damage <| Range 800 1200
                             , Grant Self 3 NPGen <| Flat 20
                             , Grant Self 3 StarUp <| Flat 20
                             , Debuff Self 3 AttackDown <| Flat 10
                             , Debuff Self 3 DefenseDown <| Flat 10
                             ]
                  , over   = [ Grant Self 1 (CardUp Buster) <| Range 20 80 ]
                  , first  = True
                  }
    , gen       = { starWeight = 51, starRate = 10.7, npAtk = 0.32, npDef = 3 }
    , hits      = { quick = 3, arts = 5, buster = 1, ex = 5 }
    , gender    = Female
    , traits    = [Humanoid, PseudoServant, Illya, EnumaElish]
    , death     = 42
    , align     = [Neutral, Good]
    , limited   = True
    , free      = False
    , ascendUp  = Ascension
                  [(Piece Caster, 5)]
                  [(Piece Caster, 12), (SeedOfYggdrasil, 9)]
                  [(Monument Caster, 5), (ForbiddenPage, 10), (PhoenixFeather, 4)]
                  [(Monument Caster, 12), (PhoenixFeather, 8), (ScarabOfWisdom, 5)]
    , skillUp   = Reinforcement
                  [(GemOf Caster, 5)]
                  [(GemOf Caster, 12)]
                  [(MagicGemOf Caster, 5)]
                  [(MagicGemOf Caster, 12), (ForbiddenPage, 5)]
                  [(SecretGemOf Caster, 5), (ForbiddenPage, 10)]
                  [(SecretGemOf Caster, 12), (SeedOfYggdrasil, 6)]
                  [(SeedOfYggdrasil, 12), (HomunculusBaby, 6)]
                  [(HomunculusBaby, 18), (SpiritRoot, 10)]
    }
  , { name      = "Gilgamesh (Caster)"
    , spoiler   = Nothing
    , id        = 145
    , rarity    = 4
    , class     = Caster
    , stats     = { base  = { atk = 1410,  hp = 1920 }
                  , max   = { atk = 8460,  hp = 12005 }
                  , grail = { atk = 10243, hp = 14556 }
                  }
    , gen       = { starWeight = 51, starRate = 10.9, npAtk = 0.32, npDef = 3 }
    , death     = 42
    , curve     = 29
    , attr      = Human
    , align     = [Lawful, Good]
    , gender    = Male
    , traits    = [Humanoid, Divine, LovedOne, King]
    , deck      = Deck Quick Arts Arts Arts Buster
    , hits      = { quick = 2, arts = 5, buster = 6, ex = 5 }
    , skills    = [ { name   = "King's Return"
                    , rank   = A
                    , icon   = Icon.StarHaloUp
                    , cd     = 9
                    , effect = [ Grant Party 3 StarUp <| Range 50 100 ]
                    }
                  , { name   = "Charisma"
                    , rank   = APlus
                    , icon   = Icon.SwordUp
                    , cd     = 7
                    , effect = [ Grant Party 3 AttackUp <| Range 10.5 21 ]
                    }
                  , { name   = "Sovereign of Magical Staffs"
                    , rank   = EX
                    , icon   = Icon.ArtsUp
                    , cd     = 8
                    , effect = [ Grant Party 3 (CardUp Arts) <| Range 20 30
                               , Grant Party 3 DebuffUp <| Range 20 30
                               ]
                    }
                  ]
    , passives  = [itemConstructionFake A, territoryCreation A, divinity B]
    , phantasm  = { name   = "Melammu Dingir"
                  , rank   = B
                  , card   = Arts
                  , kind   = "Anti-Army/Anti-Fortress"
                  , hits   = 10
                  , effect = [ To Enemies Damage <| Range 450 750
                             , Grant Party 3 DefenseUp <| Flat 20
                             ]
                  , over   = [ Debuff Enemies 3 DefenseDown <| Range 20 40 ]
                  , first  = False
                  }
    , limited   = False
    , free      = False
    , ascendUp  = Ascension
                  [(Piece Caster, 4)]
                  [(Piece Caster, 10), (ProofOfHero, 18)]
                  [(Monument Caster, 4), (ForbiddenPage, 8), (PrimordialLanugo, 3)]
                  [(Monument Caster, 10), (PrimordialLanugo, 5), (ScarabOfWisdom, 4)]
    , skillUp   = Reinforcement
                  [(GemOf Caster, 4)]
                  [(GemOf Caster, 10)]
                  [(MagicGemOf Caster, 4)]
                  [(MagicGemOf Caster, 10), (ForbiddenPage, 4)]
                  [(SecretGemOf Caster, 4), (ForbiddenPage, 8)]
                  [(SecretGemOf Caster, 10), (ProofOfHero, 12)]
                  [(ProofOfHero, 24), (GhostLantern, 5)]
                  [(GhostLantern, 15), (DeadlyPoisonousNeedle, 48)]
    }
  , { name      = "Merlin"
    , spoiler   = Nothing
    , id        = 150
    , rarity    = 5
    , class     = Caster
    , stats     = { base  = { atk = 1692,  hp = 2091 }
                  , max   = { atk = 10546, hp = 14259 }
                  , grail = { atk = 11544, hp = 15621 }
                  }
    , gen       = { starWeight = 49, starRate = 10.8, npAtk = 0.81, npDef = 3 }
    , death     = 36
    , curve     = 30
    , attr      = Earth
    , align     = [Lawful, Good]
    , gender    = Male
    , traits    = [Humanoid, EnumaElish]
    , deck      = Deck Quick Arts Arts Arts Buster
    , hits      = { quick = 3, arts = 2, buster = 5, ex = 6 }
    , skills    = [ { name   = "Dreamlike Charisma"
                    , rank   = A
                    , icon   = Icon.SwordUp
                    , cd     = 7
                    , effect = [ Grant Party 3 AttackUp <| Range 10 20
                               , To Party GaugeUp <| Flat 20
                               ]
                    }
                  , { name   = "Illusion"
                    , rank   = A
                    , icon   = Icon.Shield
                    , cd     = 9
                    , effect = [ Grant Party 1 StarUp <| Range 30 50
                               , Grant Party 1 Invincibility Full
                               , Debuff Enemies 3 CritChance <| Range 10 20
                               ]
                    }
                  , { name   = "Hero Creation"
                    , rank   = EX
                    , icon   = Icon.BusterUp
                    , cd     = 8
                    , effect = [ Grant Ally 3 (CardUp Buster) <| Range 30 50
                               , Grant Ally 3 HPUp <| Range 2000 3000
                               , Grant Ally 1 CritUp <| Range 50 100
                               ]
                    }
                  ]
    , passives  = [territoryCreation C, itemConstruction C, mixedBlood EX]
    , phantasm  = { name   = "Garden of Avalon"
                  , rank   = C
                  , card   = Arts
                  , kind   = "Anti-Unit"
                  , hits   = 0
                  , effect = [ Grant Party 5 HealPerTurn <| Range 1000 2000
                             , Grant Party 5 GaugePerTurn <| Flat 5
                             ]
                  , over   = [ Grant Self 5 StarsPerTurn <| Range 5 25 ]
                  , first  = False
                  }
    , limited   = True
    , free      = False
    , ascendUp  = Ascension
                  [(Piece Caster, 5)]
                  [(Piece Caster, 12), (EternalGear, 8)]
                  [(Monument Caster, 5), (ForbiddenPage, 10), (ScarabOfWisdom, 2)]
                  [(Monument Caster, 12), (ScarabOfWisdom, 4), (DragonsReverseScale, 5)]
    , skillUp   = Reinforcement
                  [(GemOf Caster, 5)]
                  [(GemOf Caster, 12)]
                  [(MagicGemOf Caster, 5)]
                  [(MagicGemOf Caster, 12), (ForbiddenPage, 5)]
                  [(SecretGemOf Caster, 5), (ForbiddenPage, 10)]
                  [(SecretGemOf Caster, 12), (EternalGear, 5)]
                  [(EternalGear, 10), (SpiritRoot, 3)]
                  [(SpiritRoot, 8), (HeartOfTheForeignGod, 10)]
    }
  , { name      = "Scheherazade"
    , spoiler   = Just "the Nightless City"
    , id        = 169
    , rarity    = 5
    , class     = Caster
    , stats     = { base  = { atk = 1423,  hp = 2324 }
                  , max   = { atk = 9212,  hp = 15846 }
                  , grail = { atk = 10084, hp = 17360 }
                  }
    , gen       = { starWeight = 52, starRate = 10.8, npAtk = 0.51, npDef = 3 }
    , death     = 48
    , curve     = 30
    , attr      = Human
    , align     = [Lawful, Balanced]
    , gender    = Female
    , traits    = [Humanoid, EnumaElish]
    , deck      = Deck Quick Arts Arts Arts Buster
    , hits      = { quick = 4, arts = 3, buster = 4, ex = 4 }
    , skills    = [ { name   = "Storyteller"
                    , rank   = EX
                    , icon   = Icon.MagicDark
                    , cd     = 8
                    , effect = [ Chances 80 100 << To Enemy GaugeDown <| Flat 1
                               , Grant Self 1 (CardUp Arts) <| Range 10 30
                               ]
                    }
                  , { name   = "Bedchamber of Survival"
                    , rank   = APlus
                    , icon   = Icon.Heart
                    , cd     = 8
                    , effect = [ Chances 30 60 <| Debuff Enemies 1 Charm Full ]
                    }
                  , { name   = "Counter-Hero"
                    , rank   = A
                    , icon   = Icon.Kneel
                    , cd     = 8
                    , effect = [ Times 1 << Grant Self 5 Guts <| Range 1000 3000
                               , Debuff (EnemyType King) 1 AttackDown <| Range 30 50 ]
                    }
                  ]
    , passives  = [territoryCreation APlusPlus]
    , phantasm  = { name   = "Alfu Laylatin wa-Laylah"
                  , rank   = EX
                  , card   = Arts
                  , kind   = "Anti-King"
                  , hits   = 5
                  , effect = [ Grant Self 1 NPUp <| Flat 20
                             , To Enemies Damage <| Range 600 900
                             , Chance 500 << Times 1 << Debuff Enemies 3 DebuffVuln <| Flat 50
                             ]
                  , over   = [ To Enemies (SpecialDamage <| VsTrait King) <| Range 200 300 ]
                  , first  = False
                  }
    , limited   = False
    , free      = False
    , ascendUp  = Ascension
                  [(Piece Caster, 5)]
                  [(Piece Caster, 12), (PhoenixFeather, 6)]
                  [(Monument Caster, 5), (SerpentJewel, 8), (LampOfEvilSealing, 3)]
                  [(Monument Caster, 12), (LampOfEvilSealing, 6), (MysteriousDivineWine, 5)]
    , skillUp   = Reinforcement
                  [(GemOf Caster, 5)]
                  [(GemOf Caster, 12)]
                  [(MagicGemOf Caster, 5)]
                  [(MagicGemOf Caster, 12), (SerpentJewel, 4)]
                  [(SecretGemOf Caster, 5), (SerpentJewel, 8)]
                  [(SecretGemOf Caster, 12), (PhoenixFeather, 4)]
                  [(PhoenixFeather, 8), (ShellOfReminiscence, 6)]
                  [(ShellOfReminiscence, 18), (ScarabOfWisdom, 10)]
    }
  , { name      = "Nero Claudius (Caster)"
    , spoiler   = Nothing
    , id        = 175
    , rarity    = 5
    , class     = Caster
    , stats     = { base  = { atk = 1677,  hp = 2007 }
                  , max   = { atk = 10857, hp = 13685 }
                  , grail = { atk = 11885, hp = 14992 }
                  }
    , gen       = { starWeight = 51, starRate = 11.1, npAtk = 0.4, npDef = 3 }
    , death     = 42
    , curve     = 15
    , attr      = Human
    , align     = [Chaotic, Summer]
    , gender    = Female
    , traits    = [Humanoid, Riding, Saberface, EnumaElish, King]
    , deck      = Deck Quick Arts Arts Buster Buster
    , hits      = { quick = 4, arts = 6, buster = 2, ex = 6 }
    , skills    = [ { name   = "Rampaging Privilege"
                    , rank   = EX
                    , icon   = Icon.Noble
                    , cd     = 8
                    , effect = [ To Self GaugeUp <| Range 30 50
                               , When "HP is less than 50%" << Grant Self 3 NPGen <| Range 30 50
                               ]
                    }
                  , { name   = "Seven Crowns"
                    , rank   = C
                    , icon   = Icon.SwordShieldUp
                    , cd     = 7
                    , effect = [ Grant Self 3 AttackUp <| Range 20 30
                               , Grant Self 3 DefenseUp <| Range 20 30
                               , Grant Self 3 NoDisadvantage Full
                               ]
                    }
                  , { name   = "Undying Magus"
                    , rank   = A
                    , icon   = Icon.Kneel
                    , cd     = 9
                    , effect = [ Times 1 << Grant Ally 3 Guts <| Flat 1
                               , Grant Ally 3 AttackUp <| Range 30 50
                               ]
                    }
                  ]
    , passives  = [riding B, territoryCreation APlus, itemConstructionStrange EX]
    , phantasm  = { name   = "Laudatum Domus Illustris"
                  , rank   = A
                  , card   = Buster
                  , kind   = "Anti-Army"
                  , hits   = 5
                  , effect = [ Grant Self 1 IgnoreInvinc Full
                             , To Enemies Damage <| Range 300 500
                             ]
                  , over   = [ Grant Self 1 NPUp <| Range 20 60 ]
                  , first  = True
                  }
    , limited   = True
    , free      = False
    , ascendUp  = Ascension
                  [(Piece Caster, 5)]
                  [(Piece Caster, 12), (ForbiddenPage, 8)]
                  [(Monument Caster, 5), (PhoenixFeather, 8), (ScarabOfWisdom, 2)]
                  [(Monument Caster, 12), (ScarabOfWisdom, 4), (MysteriousDivineWine, 5)]
    , skillUp   = Reinforcement
                  [(GemOf Caster, 5)]
                  [(GemOf Caster, 12)]
                  [(MagicGemOf Caster, 5)]
                  [(MagicGemOf Caster, 12), (PhoenixFeather, 4)]
                  [(SecretGemOf Caster, 5), (PhoenixFeather, 8)]
                  [(SecretGemOf Caster, 12), (ForbiddenPage, 5)]
                  [(ForbiddenPage, 10), (ShellOfReminiscence, 6)]
                  [(ShellOfReminiscence, 18), (PrimordialLanugo, 15)]
    }
  , { name      = "Circe"
    , spoiler   = Just "Okeanos"
    , id        = 192
    , rarity    = 4
    , class     = Caster
    , stats     = { base  = { atk = 1445,  hp = 1960 }
                  , max   = { atk = 8671,  hp = 12250 }
                  , grail = { atk = 10499, hp = 14853 }
                  }
    , gen       = { starWeight = 51, starRate = 10.8, npAtk = 0.39, npDef = 3 }
    , death     = 34.5
    , curve     = 9
    , attr      = Sky
    , align     = [Chaotic, Balanced]
    , gender    = Female
    , traits    = [Humanoid, EnumaElish]
    , deck      = Deck Quick Arts Arts Arts Buster
    , hits      = { quick = 3, arts = 3, buster = 2, ex = 4 }
    , skills    = [ { name   = "Rapid Words of Divine"
                    , rank   = B
                    , icon   = Icon.Noble
                    , cd     = 9
                    , effect = [ To Self GaugeUp <| Range 60 120 ]
                    }
                  , { name   = "Poisonous Feast"
                    , rank   = A
                    , icon   = Icon.Poison
                    , cd     = 7
                    , effect = [ Debuff Enemies 3 Poison <| Range 500 1000
                               , Debuff Enemies 3 DefenseDown <| Range 10 20
                               ]
                    }
                  , { name   = "Sailing Advice"
                    , rank   = A
                    , icon   = Icon.StarHaloUp
                    , cd     = 8
                    , effect = [ Grant Party 3 StarUp <| Range 30 50
                               , To Party RemoveDebuffs Full
                               ]
                    }
                  ]
    , passives  = [territoryCreation B, itemConstruction A]
    , phantasm  = { name   = "Fat Piglets"
                  , rank   = C
                  , card   = Buster
                  , kind   = "Anti-Unit"
                  , hits   = 5
                  , effect = [ To Enemy Damage <| Range 600 1000
                             , Debuff Enemy 1 Pig Full
                             ]
                  , over   = [ Debuff Enemy 1 CritChance <| Range 10 50 ]
                  , first  = False
                  }
    , limited   = False
    , free      = False
    , ascendUp  = Ascension
                  [(Piece Caster, 4)]
                  [(Piece Caster, 10), (ForbiddenPage, 6)]
                  [(Monument Caster, 4), (PrimordialLanugo, 5), (PhoenixFeather, 4)]
                  [(Monument Caster, 10), (PhoenixFeather, 7), (ScarabOfWisdom, 4)]
    , skillUp   = Reinforcement
                  [(GemOf Caster, 4)]
                  [(GemOf Caster, 10)]
                  [(MagicGemOf Caster, 4)]
                  [(MagicGemOf Caster, 10), (PrimordialLanugo, 3)]
                  [(SecretGemOf Caster, 4), (PrimordialLanugo, 5)]
                  [(SecretGemOf Caster, 10), (ForbiddenPage, 4)]
                  [(ForbiddenPage, 8), (StakeOfWailingNight, 15)]
                  [(StakeOfWailingNight, 45), (HeartOfTheForeignGod, 8)]
    }
  , { name      = "Queen of Sheba"
    , spoiler   = Just "Midrash"
    , id        = 194
    , rarity    = 4
    , class     = Caster
    , stats     = { base  = { atk = 1438,  hp = 1940 }
                  , max   = { atk = 8629,  hp = 12127 }
                  , grail = { atk = 10448, hp = 14704 }
                  }
    , gen       = { starWeight = 51, starRate = 10.8, npAtk = 0.81, npDef = 3 }
    , death     = 36
    , curve     = 24
    , attr      = Human
    , align     = [Neutral, Good]
    , gender    = Female
    , traits    = [Humanoid, King, EnumaElish]
    , deck      = Deck Quick Arts Arts Buster Buster
    , hits      = { quick = 4, arts = 3, buster = 4, ex = 5 }
    , skills    = [ { name   = "Charisma"
                    , rank   = BMinus
                    , icon   = Icon.SwordUp
                    , cd     = 7
                    , effect = [ Grant Party 3 AttackUp <| Range 8.9 17.8 ]
                    }
                  , { name   = "Eye of the Spirit"
                    , rank   = A
                    , icon   = Icon.ExclamationUp
                    , cd     = 7
                    , effect = [ Grant Self 1 CritUp <| Range 50 100
                               , Grant Self 1 IgnoreInvinc Full
                               ]
                    }
                  , { name   = "Wisdom of the Demon God"
                    , rank   = A
                    , icon   = Icon.BusterArtsUp
                    , cd     = 8
                    , effect = [ Grant Self 3 (CardUp Arts) <| Range 10 20
                               , Grant Self 3 (CardUp Buster) <| Range 10 20
                               , To Party GainStars <| Flat 10
                               ]
                    }
                  ]
    , passives  = [territoryCreation C, magicResistance A]
    , phantasm  = { name   = "Three Enigmas"
                  , rank   = B
                  , card   = Arts
                  , kind   = "Anti-Personnel"
                  , hits   = 5
                  , effect = [ To Enemy Damage <| Range 900 1500 ]
                  , over   = [ Debuff Enemy 3 AttackDown <| Range 10 30
                             , Debuff Enemy 3 DefenseDown <| Range 10 30
                             , Debuff Enemy 3 HealDown <| Range 30 70
                             ]
                  , first  = False
                  }
    , limited   = True
    , free      = False
    , ascendUp  = Ascension
                  [(Piece Caster, 4)]
                  [(Piece Caster, 10), (PhoenixFeather, 5)]
                  [(Monument Caster, 4), (StakeOfWailingNight, 24), (SerpentJewel, 4)]
                  [(Monument Caster, 10), (SerpentJewel, 7), (LampOfEvilSealing, 6)]
    , skillUp   = Reinforcement
                  [(GemOf Caster, 4)]
                  [(GemOf Caster, 10)]
                  [(MagicGemOf Caster, 4)]
                  [(MagicGemOf Caster, 10), (StakeOfWailingNight, 12)]
                  [(SecretGemOf Caster, 4), (StakeOfWailingNight, 24)]
                  [(SecretGemOf Caster, 10), (PhoenixFeather, 4)]
                  [(PhoenixFeather, 7), (FoolsChain, 15)]
                  [(FoolsChain, 45), (ScarabOfWisdom, 8)]
    }
  , { name      = "Anastasia Nikolaevna Romanova"
    , spoiler   = Nothing
    , id        = 201
    , rarity    = 5
    , class     = Caster
    , stats     = { base  = { atk = 2091,  hp = 1629 }
                  , max   = { atk = 10546, hp = 14259 }
                  , grail = { atk = 11544, hp = 15621 }
                  }
    , gen       = { starWeight = 49, starRate = 10.8, npAtk = 0.51, npDef = 3 }
    , death     = 36
    , curve     = 15
    , attr      = Human
    , align     = [Neutral, Balanced]
    , gender    = Female
    , traits    = [Humanoid, EnumaElish]
    , deck      = Deck Quick Arts Arts Arts Buster
    , hits      = { quick = 4, arts = 3, buster = 3, ex = 5 }
    , skills    = [ { name   = "Mystic Eyes of Penetration"
                    , rank   = D
                    , icon   = Icon.ShieldBreak
                    , cd     = 7
                    , effect = [ Grant Self 1 IgnoreInvinc Full
                               , Grant Self 1 (CardUp Arts) <| Range 30 50
                               , Debuff Enemy 1 DebuffVuln <| Range 50 100
                               ]
                    }
                  , { name   = "Frigid Charisma"
                    , rank   = B
                    , icon   = Icon.SwordUp
                    , cd     = 7
                    , effect = [ Grant Party 3 AttackUp <| Range 10 20
                               , Debuff Enemies 3 AttackDown <| Range 10 20
                               ]
                    }
                  , { name   = "Schwipsig"
                    , rank   = B
                    , icon   = Icon.Noble
                    , cd     = 9
                    , effect = [ To Self GaugeUp <| Range 30 50
                               , Chances 40 60 <| Debuff Enemy 1 Stun Full
                               ]
                    }
                  ]
    , passives  = [territoryCreation A, fairyContract A]
    , phantasm  = { name   = "Viy Viy Viy"
                  , rank   = EX
                  , card   = Arts
                  , kind   = "Spiritual"
                  , hits   = 4
                  , effect = [ To Enemies Damage <| Range 450 750
                             , Debuff Enemies 1 SealSkills Full
                             ]
                  , over   = [ Debuff Enemies 3 DefenseDown <| Range 20 40 ]
                  , first  = False
                  }
    , limited   = False
    , free      = False
    , ascendUp  = Ascension
                  [(Piece Caster, 5)]
                  [(Piece Caster, 12), (VoidsDust, 15)]
                  [(Monument Caster, 5), (ShellOfReminiscence, 10), (TearstoneOfBlood, 3)]
                  [(Monument Caster, 12), (TearstoneOfBlood, 6), (EternalIce, 12)]
    , skillUp   = Reinforcement
                  [(GemOf Caster, 5)]
                  [(GemOf Caster, 12)]
                  [(MagicGemOf Caster, 5)]
                  [(MagicGemOf Caster, 12), (ShellOfReminiscence, 5)]
                  [(SecretGemOf Caster, 5), (ShellOfReminiscence, 10)]
                  [(SecretGemOf Caster, 12), (VoidsDust, 10)]
                  [(VoidsDust, 20), (ForbiddenPage, 6)]
                  [(ForbiddenPage, 18), (MysticGunpowder, 72)]
    }
  , { name      = "Avicebron"
    , spoiler   = Nothing
    , id        = 203
    , rarity    = 3
    , class     = Caster
    , stats     = { base  = { atk = 1184,  hp = 1795 }
                  , max   = { atk = 6376,  hp = 9981 }
                  , grail = { atk = 10629, hp = 15533 }
                  }
    , gen       = { starWeight = 50, starRate = 10.7, npAtk = 0.61, npDef = 3 }
    , death     = 36
    , curve     = 13
    , attr      = Human
    , align     = [Neutral, Balanced]
    , gender    = Male
    , traits    = [Humanoid, EnumaElish]
    , deck      = Deck Quick Arts Arts Arts Buster
    , hits      = { quick = 4, arts = 2, buster = 4, ex = 5 }
    , skills    = [ { name   = "Numerology"
                    , rank   = B
                    , icon   = Icon.BusterArtsUp
                    , cd     = 8
                    , effect = [ Grant Self 3 (CardUp Arts) <| Range 20 30
                               , Grant Self 3 (CardUp Buster) <| Range 20 30
                               ]
                    }
                  , { name   = "Rapid Casting"
                    , rank   = BPlus
                    , icon   = Icon.Noble
                    , cd     = 10
                    , effect = [ To Self GaugeUp <| Range 54.5 79.5 ]
                    }
                  , { name   = "Tranquil Fig"
                    , rank   = EX
                    , icon   = Icon.ClockSkull
                    , cd     = 10
                    , effect = [ When "defeated within 5 turns" << To Others Heal <| Range 1000 2000
                               , When "level 1-9" << Times 2 <| Grant Party 3 Invincibility Full
                               , When "level 10" << Times 3 <| Grant Party 3 Invincibility Full
                               ]
                    }
                  ]
    , passives  = [territoryCreation B, itemConstruction BPlus]
    , phantasm  = { name   = "Golem Keter Malkuth"
                  , rank   = APlus
                  , card   = Buster
                  , kind   = "Anti-Army"
                  , hits   = 3
                  , effect = [ To Enemies Damage <| Range 300 500 ]
                  , over   = [ Grant Party 3 NPGen <| Range 10 30 ]
                  , first  = False
                  }
    , limited   = False
    , free      = True
    , ascendUp  = Ascension
                  [(Piece Caster, 4)]
                  [(Piece Caster, 8), (OctupletCrystals, 5)]
                  [(Monument Caster, 4), (HomunculusBaby, 7), (LampOfEvilSealing, 2)]
                  [(Monument Caster, 8), (LampOfEvilSealing, 4), (ScarabOfWisdom, 4)]
    , skillUp   = Reinforcement
                  [(GemOf Caster, 4)]
                  [(GemOf Caster, 8)]
                  [(MagicGemOf Caster, 4)]
                  [(MagicGemOf Caster, 8), (HomunculusBaby, 4)]
                  [(SecretGemOf Caster, 4), (HomunculusBaby, 7)]
                  [(SecretGemOf Caster, 8), (OctupletCrystals, 4)]
                  [(OctupletCrystals, 7), (EternalIce, 4)]
                  [(EternalIce, 12), (MysticGunpowder, 48)]
    }
  ]
