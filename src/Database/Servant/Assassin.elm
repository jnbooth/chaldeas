module Database.Servant.Assassin exposing (assassins)

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

assassins : List Servant
assassins =
  [ { name      = "Sasaki Kojirou"
    , spoiler   = Nothing
    , id        = 39
    , rarity    = 1
    , class     = Assassin
    , attr      = Human
    , deck      = Deck Quick Quick Quick Arts Buster
    , curve     = 6
    , stats     = { base  = { atk = 1042, hp = 1244 }
                  , max   = { atk = 5735, hp = 6220 }
                  , grail = { atk = 8912, hp = 9588 }
                  }
    , skills    = [ { name   = "Mind's Eye (Fake)"
                    , rank   = A
                    , icon   = Icon.Dodge
                    , cd     = 8
                    , effect = [ Grant Self 1 Evasion Full
                               , Grant Self 3 CritUp <| Range 20 40
                               ]
                    }
                  , { name   = "Vitrify"
                    , rank   = BPlus
                    , icon   = Icon.Bubbles
                    , cd     = 6
                    , effect = [ To Self RemoveMental Full
                               , To Party GainStars <| Range 5 15
                               ]
                    }
                  , { name   = "Knowledge of the Sowa"
                    , rank   = BPlusPlus
                    , icon   = Icon.Bullseye
                    , cd     = 7
                    , effect = [ Grant Self 3 SureHit Full
                               , Grant Self 3 StarUp <| Range 30 90
                               , Grant Self 3 GatherUp <| Range 200 500
                               ]
                    }
                  ]
    , passives  = [presenceConcealment D]
    , phantasm  = { name   = "Swallow Reversal"
                  , desc   = "Hiken—Tsubame Gaeshi"
                  , rank   = Unknown
                  , card   = Quick
                  , kind   = "Anti-Personnel"
                  , hits   = 3
                  , effect = [ To Enemy Damage <| Range 1200 2000 ]
                  , over   = [ To Party GainStars <| Range 15 35 ]
                  , first  = False
                  }
    , gen       = { starWeight = 102, starRate = 25.3, npAtk = 1.05, npDef = 4 }
    , hits      = { quick = 2, arts = 2, buster = 1, ex = 3 }
    , gender    = Male
    , traits    = [Humanoid, EnumaElish]
    , death     = 55
    , align     = [Neutral, Evil]
    , limited   = False
    , free      = True
    , ascendUp  = Ascension
                  [(Piece Assassin, 2)]
                  [(Piece Assassin, 4), (ProofOfHero, 8)]
                  [(Monument Assassin, 2), (EternalGear, 2), (VoidsDust, 7)]
                  [(Monument Assassin, 4), (EternalGear, 4), (OctupletCrystals, 4)]
    , skillUp   = Reinforcement
                  [(GemOf Assassin, 2)]
                  [(GemOf Assassin, 4)]
                  [(MagicGemOf Assassin, 2)]
                  [(MagicGemOf Assassin, 4), (VoidsDust, 4)]
                  [(SecretGemOf Assassin, 2), (VoidsDust, 7)]
                  [(SecretGemOf Assassin, 4), (ProofOfHero, 5)]
                  [(ProofOfHero, 10), (EvilBone, 6)]
                  [(OctupletCrystals, 8), (EvilBone, 18)]
    }
  , { name      = "Hassan of the Cursed Arm"
    , spoiler   = Nothing
    , id        = 40
    , rarity    = 2
    , class     = Assassin
    , attr      = Human
    , deck      = Deck Quick Quick Quick Arts Buster
    , curve     = 2
    , stats     = { base  = { atk = 1114, hp = 1429 }
                  , max   = { atk = 6280, hp = 7594 }
                  , grail = { atk = 9100, hp = 10960 }
                  }
    , skills    = [ { name   = "Throw (Dagger)"
                    , rank   = B
                    , icon   = Icon.Star
                    , cd     = 6
                    , effect = [ To Party GainStars <| Range 3 12 ]
                    }
                  , { name   = "Self-Modification"
                    , rank   = C
                    , icon   = Icon.ExclamationUp
                    , cd     = 7
                    , effect = [ Grant Self 3 CritUp <| Range 20 50 ]
                    }
                  , { name   = "Protection Against the Wind"
                    , rank   = A
                    , icon   = Icon.Dodge
                    , cd     = 7
                    , effect = [ Times 3 <| Grant Self 0 Evasion Full
                               , Grant Self 3 StarUp <| Range 10 30
                               ]
                    }
                  ]
    , passives  = [presenceConcealment APlus]
    , phantasm  = { name   = "Zabaniya"
                  , desc   = "Delusional Heartbeat"
                  , rank   = C
                  , card   = Quick
                  , kind   = "Anti-Personnel"
                  , hits   = 1
                  , effect = [ To Enemy Damage <| Range 1200 2000 ]
                  , over   = [ To Enemy Death <| Range 80 120 ]
                  , first  = True
                  }
    , gen       = { starWeight = 97, starRate = 25.2, npAtk = 1.07, npDef = 4 }
    , hits      = { quick = 3, arts = 2, buster = 1, ex = 3 }
    , gender    = Male
    , traits    = [Humanoid, EnumaElish]
    , death     = 44
    , align     = [Lawful, Evil]
    , limited   = False
    , free      = True
    , ascendUp  = Ascension
                  [(Piece Assassin, 3)]
                  [(Piece Assassin, 6), (EvilBone, 11)]
                  [(Monument Assassin, 3), (EternalGear, 5), (VoidsDust, 5)]
                  [(Monument Assassin, 6), (HomunculusBaby, 6), (VoidsDust, 10)]
    , skillUp   = Reinforcement
                  [(GemOf Assassin, 3)]
                  [(GemOf Assassin, 6)]
                  [(MagicGemOf Assassin, 3)]
                  [(MagicGemOf Assassin, 6), (EternalGear, 3)]
                  [(SecretGemOf Assassin, 3), (EternalGear, 5)]
                  [(SecretGemOf Assassin, 6), (EvilBone, 8)]
                  [(GhostLantern, 3), (EvilBone, 15)]
                  [(GhostLantern, 9), (HomunculusBaby, 12)]
    }
  , { name      = "Stheno"
    , spoiler   = Nothing
    , id        = 41
    , rarity    = 4
    , class     = Assassin
    , attr      = Sky
    , deck      = Deck Quick Quick Quick Arts Buster
    , curve     = 4
    , stats     = { base  = { atk = 1497,  hp = 1843 }
                  , max   = { atk = 8985,  hp = 11518 }
                  , grail = { atk = 10879, hp = 13965 }
                  }
    , skills    = [ { name   = "Vampirism"
                    , rank   = C
                    , icon   = Icon.MagicDark
                    , cd     = 8
                    , effect = [ Chances 60 80 << To Enemy GaugeDown <| Flat 1
                               , To Self GaugeUp <| Range 18 27
                               ]
                    }
                  , { name   = "Siren Song"
                    , rank   = A
                    , icon   = Icon.Heart
                    , cd     = 9
                    , effect = [ Chances 70 100 <| Debuff (EnemyType Male) 1 Charm Full ]
                    }
                  , { name   = "Whim of the Goddess"
                    , rank   = A
                    , icon   = Icon.SwordUp
                    , cd     = 7
                    , effect = [ Grant Party 3 AttackUp <| Range 10 20
                               , Grant (AlliesType Divine) 3 AttackUp <| Range 10 20
                               ]
                    }
                  ]
    , passives  = [magicResistance A, presenceConcealment APlus, coreOfGoddess EX]
    , phantasm  = { name   = "Smile of the Stheno"
                  , desc   = "Goddess' Smile"
                  , rank   = B
                  , card   = Buster
                  , kind   = "Anti-Personnel"
                  , hits   = 0
                  , effect = [ To (EnemyType Male) Death <| Range 100 150
                             , Chance 150 << Debuff Enemy 3 DefenseDown <| Flat 20
                             ]
                  , over   = [ Chances 100 200 <| Debuff (EnemyType Male) 1 Charm Full ]
                  , first  = False
                  }
    , gen       = { starWeight = 104, starRate = 25, npAtk = 2.26, npDef = 4 }
    , hits      = { quick = 2, arts = 1, buster = 1, ex = 3 }
    , gender    = Female
    , traits    = [Humanoid, Divine, EnumaElish]
    , death     = 27.5
    , align     = [Chaotic, Good]
    , limited   = False
    , free      = False
    , ascendUp  = Ascension
                  [(Piece Assassin, 4)]
                  [(Piece Assassin, 10), (SerpentJewel, 5)]
                  [(Monument Assassin, 4), (HeartOfTheForeignGod, 4), (VoidsDust, 8)]
                  [(Monument Assassin, 10), (VoidsDust, 16), (DragonsReverseScale, 4)]
    , skillUp   = Reinforcement
                  [(GemOf Assassin, 4)]
                  [(GemOf Assassin, 10)]
                  [(MagicGemOf Assassin, 4)]
                  [(MagicGemOf Assassin, 10), (HeartOfTheForeignGod, 2)]
                  [(SecretGemOf Assassin, 4), (HeartOfTheForeignGod, 4)]
                  [(SecretGemOf Assassin, 10), (SerpentJewel, 4)]
                  [(SerpentJewel, 7), (ClawOfChaos, 3)]
                  [(ClawOfChaos, 9), (DragonsReverseScale, 8)]
    }
  , { name      = "Jing Ke"
    , spoiler   = Nothing
    , id        = 42
    , rarity    = 3
    , class     = Assassin
    , attr      = Human
    , deck      = Deck Quick Quick Quick Arts Buster
    , curve     = 8
    , stats     = { base  = { atk = 1338, hp = 1492 }
                  , max   = { atk = 7207, hp = 8293 }
                  , grail = { atk = 9754, hp = 11244 }
                  }
    , skills    = [ { name   = "Restrain"
                    , rank   = A
                    , icon   = Icon.StarUp
                    , cd     = 7
                    , effect = [ Grant Self 3 GatherUp <| Flat 200
                               , To Party GainStars <| Range 5 15
                               ]
                    }
                  , { name   = "Planning"
                    , rank   = B
                    , icon   = Icon.StarHaloUp
                    , cd     = 7
                    , effect = [ Grant Self 3 StarUp <| Range 10 30 ]
                    }
                  , { name   = "Insolent"
                    , rank   = A
                    , icon   = Icon.QuickUp
                    , cd     = 7
                    , effect = [ Grant Self 1 (CardUp Quick) <| Range 20 30
                               , Grant Self 1 CritUp <| Range 30 50
                               ]
                    }
                  ]
    , passives  = [presenceConcealment B]
    , phantasm  = { name   = "All I Do Is Kill"
                  , desc   = "Unreturning Dagger"
                  , rank   = BPlus
                  , card   = Quick
                  , kind   = "Anti-Unit"
                  , hits   = 1
                  , effect = [ To Enemy Damage <| Range 1600 2400
                             , To Self DemeritDamage <| Flat 1000
                             ]
                  , over   = [ To Enemy Death <| Range 50 100
                             , To Party GainStars <| Range 20 40
                             ]
                  , first  = True
                  }
    , gen       = { starWeight = 98, starRate = 25.2, npAtk = 1.05, npDef = 4 }
    , hits      = { quick = 2, arts = 2, buster = 1, ex = 3 }
    , gender    = Female
    , traits    = [Humanoid, EnumaElish]
    , death     = 55
    , align     = [Chaotic, Good]
    , limited   = False
    , free      = True
    , ascendUp  = Ascension
                  [(Piece Assassin, 4)]
                  [(EvilBone, 15), (Piece Assassin, 8)]
                  [(GhostLantern, 4), (OctupletCrystals, 7), (Monument Assassin, 4)]
                  [(GhostLantern, 7), (VoidsDust, 16), (Monument Assassin, 8)]
    , skillUp   = Reinforcement
                  [(GemOf Assassin, 4)]
                  [(GemOf Assassin, 8)]
                  [(MagicGemOf Assassin, 4)]
                  [(MagicGemOf Assassin, 8), (OctupletCrystals, 4)]
                  [(SecretGemOf Assassin, 4), (OctupletCrystals, 7)]
                  [(SecretGemOf Assassin, 8), (EvilBone, 10)]
                  [(PhoenixFeather, 4), (EvilBone, 20)]
                  [(PhoenixFeather, 10), (VoidsDust, 32)]
    }
  , { name      = "Charles-Henri Sanson"
    , spoiler   = Nothing
    , id        = 43
    , rarity    = 2
    , class     = Assassin
    , attr      = Human
    , deck      = Deck Quick Quick Quick Arts Buster
    , curve     = 12
    , stats     = { base  = { atk = 968,  hp = 1568 }
                  , max   = { atk = 5456, hp = 8309 }
                  , grail = { atk = 7906, hp = 11991 }
                  }
    , skills    = [ { name   = "Executioner"
                    , rank   = APlusPlus
                    , icon   = Icon.DamageUp
                    , cd     = 7
                    , effect = [ Grant Self 3 (Special AttackUp <| VsTrait Evil) <| Range 40 60 ]
                    }
                  , { name   = "Medicine"
                    , rank   = APlus
                    , icon   = Icon.Heal
                    , cd     = 7
                    , effect = [ To Ally Heal <| Range 1000 3000
                               , To Ally RemoveDebuffs Full
                               ]
                    }
                  , { name   = "Human Study"
                    , rank   = B
                    , icon   = Icon.DamageUp
                    , cd     = 7
                    , effect = [ Grant Self 3 (Special AttackUp <| VsAttribute Human) <| Range 40 60 ]
                    }
                  ]
    , passives  = [presenceConcealment D]
    , phantasm  = { name   = "La Mort Espoir"
                  , desc   = "Death is Hope For Tomorrow"
                  , rank   = APlus
                  , card   = Buster
                  , kind   = "Anti-Personnel"
                  , hits   = 1
                  , effect = [ To Enemy Damage <| Range 800 1200 ]
                  , over   = [ To Enemy Death <| Range 30 80
                             , Debuff Enemy 3 DefenseDown <| Range 30 50
                             ]
                  , first  = True
                  }
    , gen       = { starWeight = 102, starRate = 24.8, npAtk = 1.06, npDef = 4 }
    , hits      = { quick = 2, arts = 2, buster = 1, ex = 3 }
    , gender    = Male
    , traits    = [Humanoid, EnumaElish]
    , death     = 49.5
    , align     = [Lawful, Evil]
    , limited   = False
    , free      = True
    , ascendUp  = Ascension
                  [(Piece Assassin, 3)]
                  [(Piece Assassin, 6), (EvilBone, 11)]
                  [(Monument Assassin, 3), (HeartOfTheForeignGod, 1), (VoidsDust, 10)]
                  [(Monument Assassin, 6), (HeartOfTheForeignGod, 2), (HomunculusBaby, 6)]
    , skillUp   = Reinforcement
                  [(GemOf Assassin, 3)]
                  [(GemOf Assassin, 6)]
                  [(MagicGemOf Assassin, 3)]
                  [(MagicGemOf Assassin, 6), (VoidsDust, 5)]
                  [(SecretGemOf Assassin, 3), (VoidsDust, 10)]
                  [(SecretGemOf Assassin, 6), (EvilBone, 8)]
                  [(ForbiddenPage, 3), (EvilBone, 15)]
                  [(ForbiddenPage, 9), (HomunculusBaby, 12)]
    }
  , { name      = "Phantom of the Opera"
    , spoiler   = Nothing
    , id        = 44
    , rarity    = 2
    , class     = Assassin
    , attr      = Earth
    , deck      = Deck Quick Quick Quick Arts Buster
    , curve     = 2
    , stats     = { base  = { atk = 1003, hp = 1580 }
                  , max   = { atk = 5654, hp = 8393 }
                  , grail = { atk = 8193, hp = 12112 }
                  }
    , skills    = [ { name  = "Innocent Monster"
                    , rank   = D
                    , icon    = Icon.StarTurn
                    , cd      = 7
                    , effect = [ Grant Self 3 StarsPerTurn <| Range 3 9
                               , Debuff Self 3 DefenseDown <| Flat 14
                               ]
                    }
                  , { name   = "Siren Song"
                    , rank   = B
                    , icon   = Icon.Heart
                    , cd     = 9
                    , effect = [ Chances 60 90 <| Debuff (EnemyType Female) 1 Charm Full ]
                    }
                  , { name   = "Mental Corruption"
                    , rank   = A
                    , icon   = Icon.StaffUp
                    , cd     = 7
                    , effect = [ Grant Self 3 MentalSuccess <| Range 5 25
                               , Grant Self 3 MentalResist <| Range 50 100
                               ]
                    }
                  ]
    , passives  = [presenceConcealment A]
    , phantasm  = { name   = "Christine Christine"
                  , desc   = "Love Song Resounding through Hell"
                  , rank   = BPlus
                  , card   = Arts
                  , kind   = "Anti-Army"
                  , hits   = 1
                  , effect = [ To Enemies DamageThruDef <| Range 600 900 ]
                  , over   = [ Debuff Enemies 6 DebuffVuln <| Range 50 100 ]
                  , first  = False
                  }
    , gen       = { starWeight = 98, starRate = 25.2, npAtk = 0.71, npDef = 4 }
    , hits      = { quick = 2, arts = 3, buster = 2, ex = 3 }
    , gender    = Male
    , traits    = [Humanoid, EnumaElish]
    , death     = 49.5
    , align     = [Chaotic, Evil]
    , limited   = False
    , free      = True
    , ascendUp  = Ascension
                  [(Piece Assassin, 3)]
                  [(Piece Assassin, 6), (GhostLantern, 4)]
                  [(Monument Assassin, 3), (VoidsDust, 10), (EternalGear, 3)]
                  [(Monument Assassin, 6), (EternalGear, 5), (EvilBone, 18)]
    , skillUp   = Reinforcement
                  [(GemOf Assassin, 3)]
                  [(GemOf Assassin, 6)]
                  [(MagicGemOf Assassin, 3)]
                  [(MagicGemOf Assassin, 6), (VoidsDust, 5)]
                  [(SecretGemOf Assassin, 3), (VoidsDust, 10)]
                  [(SecretGemOf Assassin, 6), (GhostLantern, 3)]
                  [(GhostLantern, 5), (HeartOfTheForeignGod, 2)]
                  [(HeartOfTheForeignGod, 4), (EvilBone, 36)]
    }
  , { name      = "Mata Hari"
    , spoiler   = Nothing
    , id        = 45
    , rarity    = 1
    , class     = Assassin
    , attr      = Human
    , deck      = Deck Quick Quick Quick Arts Buster
    , curve     = 6
    , stats     = { base  = { atk = 977,  hp = 1313 }
                  , max   = { atk = 5377, hp = 6565 }
                  , grail = { atk = 8355, hp = 10120 }
                  }
    , skills    = [ { name   = "Espionage"
                    , rank   = APlusPlus
                    , icon   = Icon.StarHaloUp
                    , cd     = 7
                    , effect = [ Grant Self 3 StarUp <| Range 10 30 ]
                    }
                  , { name   = "Pheromone"
                    , rank   = B
                    , icon   = Icon.Heart
                    , cd     = 8
                    , effect = [ Chances 30 60 <| Debuff (EnemiesType Male) 1 Charm Full
                               , Debuff Enemies 3 DefenseDown <| Range 10 20
                               ]
                    }
                  , { name   = "Double-cross"
                    , rank   = B
                    , icon   = Icon.Circuits
                    , cd     = 8
                    , effect = [ Debuff Enemy 1 SealSkills Full
                               , Debuff Enemy 3 DefenseDown <| Range 10 20
                               ]
                    }
                  ]
    , passives  = []
    , phantasm  = { name   = "Mata Hari"
                  , desc   = "The Woman with Sunny Eyes"
                  , rank   = A
                  , card   = Arts
                  , kind   = "Anti-Army"
                  , hits   = 0
                  , effect = [ Chances 40 60 <| Debuff Enemies 1 Charm Full ]
                  , over   = [ Debuff Enemies 1 AttackDown <| Range 20 40
                             , Debuff Enemies 1 DefenseDown <| Range 20 40
                             ]
                  , first  = False
                  }
    , gen       = { starWeight = 98, starRate = 24.6, npAtk = 2.1, npDef = 4 }
    , hits      = { quick = 2, arts = 1, buster = 1, ex = 3 }
    , gender    = Female
    , traits    = [Humanoid, EnumaElish]
    , death     = 55
    , align     = [Chaotic, Balanced]
    , limited   = False
    , free      = True
    , ascendUp  = Ascension
                  [(Piece Assassin, 2)]
                  [(Piece Assassin, 4), (PhoenixFeather, 2)]
                  [(Monument Assassin, 2), (EternalGear, 4), (GhostLantern, 2)]
                  [(Monument Assassin, 4), (SerpentJewel, 4), (GhostLantern, 4)]
    , skillUp   = Reinforcement
                  [(GemOf Assassin, 2)]
                  [(GemOf Assassin, 4)]
                  [(MagicGemOf Assassin, 2)]
                  [(MagicGemOf Assassin, 4), (EternalGear, 2)]
                  [(SecretGemOf Assassin, 2), (EternalGear, 4)]
                  [(SecretGemOf Assassin, 4), (PhoenixFeather, 2)]
                  [(HomunculusBaby, 2), (PhoenixFeather, 3)]
                  [(HomunculusBaby, 6), (SerpentJewel, 7)]
    }
  , { name      = "Carmilla"
    , spoiler   = Nothing
    , id        = 46
    , rarity    = 4
    , class     = Assassin
    , attr      = Earth
    , deck      = Deck Quick Quick Quick Arts Buster
    , curve     = 14
    , stats     = { base  = { atk = 1568,  hp = 1675 }
                  , max   = { atk = 9408,  hp = 10473 }
                  , grail = { atk = 11391, hp = 12698 }
                  }
    , skills    = [ { name   = "Vampirism"
                    , rank   = C
                    , icon   = Icon.MagicDark
                    , cd     = 8
                    , effect = [ Chances 60 80 << To Enemy GaugeDown <| Flat 1
                               , To Self GaugeUp <| Range 18 27
                               ]
                    }
                  , { name   = "Torture Technique"
                    , rank   = A
                    , icon   = Icon.ShieldDown
                    , cd     = 7
                    , effect = [ Debuff Enemy 3 DefenseDown <| Range 10 20 ]
                    }
                  , { name   = "Bath of Fresh Blood"
                    , rank   = A
                    , icon   = Icon.ExclamationDown
                    , cd     = 8
                    , effect = [ Debuff Enemy 3 CritChance <| Range 30 50
                               , Grant Self 3 StarsPerTurn <| Range 5 10
                               ]
                    }
                  ]
    , passives  = [presenceConcealment D]
    , phantasm  = { name   = "Phantom Maiden"
                  , desc   = "Phantasmal Iron Maiden"
                  , rank   = CPlus
                  , card   = Buster
                  , kind   = "Anti-Personnel"
                  , hits   = 1
                  , effect = [ To Enemy Damage <| Range 800 1200
                             , To Self Heal <| Flat 2000
                             , Grant Self 3 AttackUp <| Flat 20
                             ]
                  , over   = [ To Enemy (SpecialDamage <| VsTrait Female) <| Range 150 200 ]
                  , first  = False
                  }
    , gen       = { starWeight = 98, starRate = 25.2, npAtk = 2.15, npDef = 4 }
    , hits      = { quick = 2, arts = 1, buster = 1, ex = 3 }
    , gender    = Female
    , traits    = [Humanoid, EnumaElish]
    , death     = 44
    , align     = [Chaotic, Evil]
    , limited   = False
    , free      = False
    , ascendUp  = Ascension
                  [(Piece Assassin, 4)]
                  [(Piece Assassin, 10), (SerpentJewel, 5)]
                  [(Monument Assassin, 4), (HeartOfTheForeignGod, 2), (HomunculusBaby, 8)]
                  [(Monument Assassin, 10), (HeartOfTheForeignGod, 4), (ClawOfChaos, 6)]
    , skillUp   = Reinforcement
                  [(GemOf Assassin, 4)]
                  [(GemOf Assassin, 10)]
                  [(MagicGemOf Assassin, 4)]
                  [(MagicGemOf Assassin, 10), (HomunculusBaby, 4)]
                  [(SecretGemOf Assassin, 4), (HomunculusBaby, 8)]
                  [(SecretGemOf Assassin, 10), (SerpentJewel, 4)]
                  [(EvilBone, 15), (SerpentJewel, 7)]
                  [(EvilBone, 45), (ClawOfChaos, 12)]
    }
  , { name      = "Jack the Ripper"
    , spoiler   = Nothing
    , id        = 75
    , rarity    = 5
    , class     = Assassin
    , attr      = Earth
    , deck      = Deck Quick Quick Quick Arts Buster
    , curve     = 25
    , stats     = { base  = { atk = 1786,  hp = 1862 }
                  , max   = { atk = 11557, hp = 12696 }
                  , grail = { atk = 12651, hp = 13909 }
                  }
    , skills    = [ { name   = "Murder on a Misty Night"
                    , rank   = A
                    , icon   = Icon.Dodge
                    , cd     = 8
                    , effect = [ Grant Self 1 Evasion Full
                               , Grant Self 1 (CardUp Quick) <| Range 30 50
                               ]
                    }
                  , { name   = "Information Erasure"
                    , rank   = B
                    , icon   = Icon.Circuits
                    , cd     = 7
                    , effect = [ To Enemy RemoveBuffs Full
                               , Debuff Enemy 3 CritChance <| Range 10 30
                               ]
                    }
                  , { name   = "Surgery"
                    , rank   = E
                    , icon   = Icon.Heal
                    , cd     = 6
                    , effect = [ To Ally Heal <| Range 500 2500 ]
                    }
                  ]
    , passives  = [presenceConcealment APlus]
    , phantasm  = { name   = "Maria the Ripper"
                  , desc   = "Holy Mother of Dismemberment"
                  , rank   = DPlus
                  , card   = Quick
                  , kind   = "Anti-Personnel"
                  , hits   = 4
                  , effect = [ To Enemy DamageThruDef <| Range 1400 2200 ]
                  , over   = [ Grant Self 1 (Special AttackUp <| VsTrait Female) <| Range 50 100 ]
                  , first  = True
                  }
    , gen       = { starWeight = 97, starRate = 25.5, npAtk = 1.07, npDef = 4 }
    , hits      = { quick = 5, arts = 2, buster = 2, ex = 4 }
    , gender    = Female
    , traits    = [Humanoid, EnumaElish]
    , death     = 44
    , align     = [Chaotic, Evil]
    , limited   = False
    , free      = False
    , ascendUp  = Ascension
                  [(Piece Assassin, 5)]
                  [(Piece Assassin, 12), (EvilBone, 22)]
                  [(Monument Assassin, 5), (EternalGear, 5), (VoidsDust, 20)]
                  [(Monument Assassin, 12), (ClawOfChaos, 8), (EternalGear, 10)]
    , skillUp   = Reinforcement
                  [(GemOf Assassin, 5)]
                  [(GemOf Assassin, 12)]
                  [(MagicGemOf Assassin, 5)]
                  [(MagicGemOf Assassin, 12), (VoidsDust, 10)]
                  [(SecretGemOf Assassin, 5), (VoidsDust, 20)]
                  [(SecretGemOf Assassin, 12), (EvilBone, 15)]
                  [(HeartOfTheForeignGod, 3), (EvilBone, 29)]
                  [(HeartOfTheForeignGod, 8), (ClawOfChaos, 15)]
    }
  , { name      = "Henry Jekyll & Hyde"
    , spoiler   = Nothing
    , id        = 81
    , rarity    = 3
    , class     = Assassin
    , attr      = Earth
    , deck      = Deck Quick Quick Arts Buster Buster
    , curve     = 23
    , stats     = { base  = { atk = 1173, hp = 1741 }
                  , max   = { atk = 6320, hp = 9675 }
                  , grail = { atk = 8553, hp = 13118 }
                  }
    , skills    = [ { name   = "Monstrous Strength"
                    , rank   = B
                    , icon   = Icon.SwordUp
                    , cd     = 7
                    , effect = [ Grant Self 3 AttackUp <| Range 5 15
                               , When "transformed into Hyde" << Grant Self 3 AttackUp <| Range 25 35
                               ]
                    }
                  , { name   = "Panicky Voice"
                    , rank   = A
                    , icon   = Icon.Stun
                    , cd     = 8
                    , effect = [ Times 1 << Grant Self 0 (Success Stun) <| Range 5 15
                               , When "transformed into Hyde" << Times 1 << Grant Self 0 (Success Stun) <| Range 85 135
                               , Chance 10 <| Debuff Enemy 1 Stun Full
                               ]
                    }
                  , { name   = "Self-Modification"
                    , rank   = D
                    , icon   = Icon.ExclamationUp
                    , cd     = 7
                    , effect = [ Grant Self 3 CritUp <| Range 5 15
                               , When "transformed into Hyde" << Grant Self 3 CritUp <| Range 25 35
                               ]
                    }
                  ]
    , passives  = [presenceConcealment A, madness A]
    , phantasm  = { name   = "Dangerous Game"
                  , desc   = "The Secret Game of Sin"
                  , rank   = CPlus
                  , card   = Buster
                  , kind   = "Anti-Personnel"
                  , hits   = 0
                  , effect = [ To Self BecomeHyde Full
                             , Grant Self 0 HPUp <| Range 3000 6000
                             , To Self Heal Full
                             ]
                  , over   = [ Grant Self 0 (CardUp Buster) <| Range 40 80 ]
                  , first  = False
                  }
    , gen       = { starWeight = 99, starRate = 25.6, npAtk = 1.05, npDef = 4 }
    , hits      = { quick = 2, arts = 2, buster = 1, ex = 3 }
    , gender    = Male
    , traits    = [Humanoid, EnumaElish, LovedOne]
    , death     = 55
    , align     = [Lawful, Good, Chaotic, Evil]
    , limited   = False
    , free      = True
    , ascendUp  = Ascension
                  [(Piece Assassin, 4)]
                  [(EvilBone, 15), (Piece Assassin, 8)]
                  [(VoidsDust, 13), (OctupletCrystals, 4), (Monument Assassin, 4)]
                  [(Monument Assassin, 8), (OctupletCrystals, 7), (HomunculusBaby, 8)]
    , skillUp   = Reinforcement
                  [(GemOf Assassin, 4)]
                  [(GemOf Assassin, 8)]
                  [(MagicGemOf Assassin, 4)]
                  [(MagicGemOf Assassin, 8), (VoidsDust, 7)]
                  [(SecretGemOf Assassin, 4), (VoidsDust, 13)]
                  [(SecretGemOf Assassin, 8), (EvilBone, 10)]
                  [(EvilBone, 20), (HeartOfTheForeignGod, 2)]
                  [(HeartOfTheForeignGod, 5), (HomunculusBaby, 16)]
    }
  , { name      = "Mysterious Heroine X"
    , spoiler   = Nothing
    , id        = 86
    , rarity    = 5
    , class     = Assassin
    , attr      = Star
    , deck      = Deck Quick Quick Arts Arts Buster
    , curve     = 5
    , stats     = { base  = { atk = 1817,  hp = 1862 }
                  , max   = { atk = 11761, hp = 12696 }
                  , grail = { atk = 12874, hp = 13909 }
                  }
    , skills    = [ { name   = "Fire Support"
                    , rank   = EX
                    , icon   = Icon.Stun
                    , cd     = 10
                    , effect = [ After 1 << Chances 60 80 <| Debuff Enemies 1 Stun Full ]
                    }
                , { name     = "Star of Saber"
                    , rank   = CPlusPlus
                    , icon   = Icon.Shield
                    , cd     = 7
                    , effect = [ Grant Self 1 Invincibility Full
                               , To Party GainStars <| Range 10 20
                               ]
                    }
                  , { name   = "Galactic Meteor Sword XEX"
                    , rank   = A
                    , icon   = Icon.StarHaloUp
                    , cd     = 8
                    , effect = [ Grant Self 3 (Special AttackUp <| VsClass Saber) <| Range 30 50
                               , Grant Self 3 (Special StarUp <| VsClass Saber) <| Range 50 100
                               , Grant Self 3 AttackUp <| Range 10 20
                               ]
                    }
                  ]
    , passives  = [riding EX, cosmoReactor A]
    , phantasm  = { name   = "Secret Calibur"
                  , desc   = "Sword of Unnamed Victory"
                  , rank   = EX
                  , card   = Quick
                  , kind   = "Anti-Unit"
                  , hits   = 12
                  , effect = [ To Enemy Damage <| Range 1600 2400 ]
                  , over   = [ To Enemy (SpecialDamage <| VsTrait Saberface) <| Range 150 200 ]
                  , first  = False
                  }
    , gen       = { starWeight = 98, starRate = 25.6, npAtk = 0.81, npDef = 4 }
    , hits      = { quick = 4, arts = 2, buster = 1, ex = 4 }
    , gender    = Female
    , traits    = [Humanoid, Riding, Dragon, Saberface, Arthur, King]
    , death     = 38.5
    , align     = [Chaotic, Good]
    , limited   = True
    , free      = False
    , ascendUp  = Ascension
                  [(Piece Assassin, 5)]
                  [(Piece Assassin, 12), (DragonFang, 18)]
                  [(Monument Assassin, 5), (DragonsReverseScale, 2), (PhoenixFeather, 8)]
                  [(Monument Assassin, 12), (DragonsReverseScale, 4), (ProofOfHero, 36)]
    , skillUp   = Reinforcement
                  [(GemOf Assassin, 5)]
                  [(GemOf Assassin, 12)]
                  [(MagicGemOf Assassin, 5)]
                  [(MagicGemOf Assassin, 12), (PhoenixFeather, 4)]
                  [(SecretGemOf Assassin, 5), (PhoenixFeather, 8)]
                  [(SecretGemOf Assassin, 12), (DragonFang, 12)]
                  [(VoidsDust, 12), (DragonFang, 24)]
                  [(VoidsDust, 36), (OctupletCrystals, 24)]
    }
  , { name      = "Ryougi Shiki (Assassin)"
    , spoiler   = Nothing
    , id        = 92
    , rarity    = 4
    , class     = Assassin
    , attr      = Human
    , deck      = Deck Quick Quick Arts Arts Buster
    , curve     = 4
    , stats     = { base  = { atk = 1477,  hp = 1768 }
                  , max   = { atk = 8867,  hp = 11055 }
                  , grail = { atk = 10736, hp = 13404 }
                  }
    , skills    = [ { name   = "Mystic Eyes of Death Perception"
                    , rank   = A
                    , icon   = Icon.Mystic
                    , cd     = 7
                    , effect = [ Grant Self 1 IgnoreInvinc Full
                               , Grant Self 1 (CardUp Arts) <| Range 30 50
                               , Debuff Enemy 1 DeathVuln <| Range 80 100
                               ]
                    }
                  , { name   = "Mind's Eye (Fake)"
                    , rank   = A
                    , icon   = Icon.Dodge
                    , cd     = 8
                    , effect = [ Grant Self 1 Evasion Full
                               , Grant Self 3 CritUp <| Range 20 40
                               ]
                    }
                  , { name   = "Yin-Yang"
                    , rank   = B
                    , icon   = Icon.YinYang
                    , cd     = 8
                    , effect = [ To Self GaugeUp <| Range 20 30
                               , To Self DemeritDamage <| Flat 1000
                               ]
                    }
                  ]
    , passives  = [presenceConcealment C, independentAction A]
    , phantasm  = { name   = "Vijñāpti-mātratā—Mystic Eyes of Death Perception"
                  , desc   = "Yuishiki・Chokushi no Magan"
                  , rank   = EX
                  , card   = Arts
                  , kind   = "Anti-Unit"
                  , hits   = 3
                  , effect = [ To Enemy DamageThruDef <| Range 900 1500 ]
                  , over   = [ To Enemy Death <| Range 100 140 ]
                  , first  = True
                  }
    , gen       = { starWeight = 102, starRate = 25.6, npAtk = 0.8, npDef = 4 }
    , hits      = { quick = 4, arts = 2, buster = 1, ex = 5 }
    , gender    = Female
    , traits    = [Humanoid, EnumaElish, PseudoServant]
    , death     = 44
    , align     = [Chaotic, Good]
    , limited   = True
    , free      = True
    , ascendUp  = Welfare "Sharp Knife"
    , skillUp   = Reinforcement
                  [(GemOf Assassin, 4)]
                  [(GemOf Assassin, 10)]
                  [(MagicGemOf Assassin, 4)]
                  [(MagicGemOf Assassin, 10), (EvilBone, 12)]
                  [(SecretGemOf Assassin, 4), (EvilBone, 24)]
                  [(SecretGemOf Assassin, 10), (ClawOfChaos, 3)]
                  [(ClawOfChaos, 5), (EternalGear, 5)]
                  [(EternalGear, 15), (HomunculusBaby, 20)]
    }
  , { name      = "Emiya (Assassin)"
    , spoiler   = Nothing
    , id        = 109
    , rarity    = 4
    , class     = Assassin
    , attr      = Human
    , deck      = Deck Quick Quick Arts Arts Buster
    , curve     = 24
    , stats     = { base  = { atk = 1493,  hp = 1786 }
                  , max   = { atk = 8958,  hp = 11168 }
                  , grail = { atk = 10846, hp = 13541 }
                  }
    , skills    = [ { name   = "Magecraft"
                    , rank   = B
                    , icon   = Icon.ArtsUp
                    , cd     = 7
                    , effect = [ Grant Self 1 (CardUp Arts) <| Range 24 40 ]
                    }
                  , { name   = "Affection of the Holy Grail"
                    , rank   = APlus
                    , icon   = Icon.ShieldBreak
                    , cd     = 7
                    , effect = [ Grant Self 3 IgnoreInvinc Full
                               , Grant Self 3 CritUp <| Range 30 50
                               , Debuff Others 3 DebuffVuln <| Flat 20
                               ]
                    }
                  , { name   = "Scapegoat"
                    , rank   = C
                    , icon   = Icon.CrosshairUp
                    , cd     = 7
                    , effect = [ Grant Ally 1 Taunt Full
                               , To Party GainStars <| Range 5 15
                               ]
                    }
                  ]
    , passives  = [presenceConcealment APlus, independentAction A]
    , phantasm  = { name   = "Chronos Rose"
                  , desc   = "Gather Ye Rosebuds While Ye May"
                  , rank   = BPlus
                  , card   = Arts
                  , kind   = "Anti-Unit"
                  , hits   = 15
                  , effect = [ To Enemy DamageThruDef <| Range 1200 1800
                             , To Enemy GaugeDown <| Flat 1
                             ]
                  , over   = [ Debuff Enemy 3 CritChance <| Range 10 50 ]
                  , first  = False
                  }
    , gen       = { starWeight = 97, starRate = 25.6, npAtk = 0.46, npDef = 4 }
    , hits      = { quick = 4, arts = 2, buster = 6, ex = 8 }
    , gender    = Male
    , traits    = [Humanoid, LovedOne, EnumaElish]
    , death     = 44
    , align     = [Chaotic, Evil]
    , limited   = False
    , free      = False
    , ascendUp  = Ascension
                  [(Piece Assassin, 4)]
                  [(Piece Assassin, 10), (ProofOfHero, 18)]
                  [(Monument Assassin, 4), (EvilBone, 24), (VoidsDust, 8)]
                  [(Monument Assassin, 10), (VoidsDust, 16), (TearstoneOfBlood, 6)]
    , skillUp   = Reinforcement
                  [(GemOf Assassin, 4)]
                  [(GemOf Assassin, 10)]
                  [(MagicGemOf Assassin, 4)]
                  [(MagicGemOf Assassin, 10), (EvilBone, 12)]
                  [(SecretGemOf Assassin, 4), (EvilBone, 24)]
                  [(SecretGemOf Assassin, 10), (ProofOfHero, 12)]
                  [(ProofOfHero, 24), (HomunculusBaby, 5)]
                  [(HomunculusBaby, 15), (HeartOfTheForeignGod, 8)]
    }
  , { name      = "Hassan of the Hundred Personas"
    , spoiler   = Nothing
    , id        = 110
    , rarity    = 3
    , class     = Assassin
    , attr      = Human
    , deck      = Deck Quick Quick Arts Arts Buster
    , curve     = 28
    , stats     = { base  = { atk = 1241, hp = 1675 }
                  , max   = { atk = 6686, hp = 9310 }
                  , grail = { atk = 9049, hp = 12623 }
                  }
    , skills    = [ { name   = "Librarian of Knowledge"
                    , rank   = C
                    , icon   = Icon.NobleUp
                    , cd     = 7
                    , effect = [ Grant Self 3 NPGen <| Range 10 20
                               , Grant Self 3 StarUp <| Range 20 40
                               ]
                    }
                  , { name   = "Wide Specialization"
                    , rank   = APlus
                    , icon   = Icon.AllUp
                    , cd     = 7
                    , effect = [ Chances 60 80 << Grant Self 3 (CardUp Buster) <| Flat 30
                               , Chances 60 80 << Grant Self 3 (CardUp Quick) <| Flat 30
                               , Chances 60 80 << Grant Self 3 (CardUp Arts) <| Flat 30
                               , Grant Self 1 Evasion Full
                               ]
                    }
                  , { name   = "Battle Retreat"
                    , rank   = B
                    , icon   = Icon.Heal
                    , cd     = 8
                    , effect = [ To Self Heal <| Range 2000 4000
                               , To Self RemoveBuffs Full
                               ]
                    }
                  ]
    , passives  = [presenceConcealment A]
    , phantasm  = { name   = "Zabaniya"
                  , desc   = "Delusional Illusion"
                  , rank   = BPlusPlus
                  , card   = Arts
                  , kind   = "Anti-Unit"
                  , hits   = 13
                  , effect = [ To Enemy Damage <| Range 1200 1800
                             , Debuff Enemy 3 (CardVuln Arts) <| Flat 20
                             ]
                  , over   = [ Debuff Enemy 3 CritChance <| Range 10 50 ]
                  , first  = False
                  }
    , gen       = { starWeight = 97, starRate = 25.5, npAtk = 0.48, npDef = 4 }
    , hits      = { quick = 3, arts = 3, buster = 1, ex = 6 }
    , gender    = Female
    , traits    = [Humanoid, EnumaElish]
    , death     = 44
    , align     = [Lawful, Evil]
    , limited   = False
    , free      = True
    , ascendUp  = Ascension
                  [(Piece Assassin, 4)]
                  [(Piece Assassin, 8), (VoidsDust, 10)]
                  [(Monument Assassin, 4), (OctupletCrystals, 7), (SerpentJewel, 3)]
                  [(Monument Assassin, 4), (SerpentJewel, 6), (BlackBeastGrease, 5)]
    , skillUp   = Reinforcement
                  [(GemOf Assassin, 4)]
                  [(GemOf Assassin, 8)]
                  [(MagicGemOf Assassin, 4)]
                  [(MagicGemOf Assassin, 8), (OctupletCrystals, 4)]
                  [(SecretGemOf Assassin, 4), (OctupletCrystals, 7)]
                  [(SecretGemOf Assassin, 8), (VoidsDust, 7)]
                  [(VoidsDust, 13), (EvilBone, 12)]
                  [(EvilBone, 36), (ClawOfChaos, 10)]
    }
  , { name      = "Shuten-Douji"
    , spoiler   = Nothing
    , id        = 112
    , rarity    = 5
    , class     = Assassin
    , attr      = Earth
    , deck      = Deck Quick Quick Arts Arts Buster
    , curve     = 25
    , stats     = { base  = { atk = 1853,  hp = 1881 }
                  , max   = { atk = 11993, hp = 12825 }
                  , grail = { atk = 13128, hp = 14050 }
                  }
    , skills    = [ { name   = "Intoxicating Aroma of Fruits"
                    , rank   = A
                    , icon   = Icon.Heart
                    , cd     = 9
                    , effect = [ Chance 60 <| Debuff Enemies 1 Charm Full
                               , Debuff Enemies 3 DefenseDown <| Range 10 20
                               ]
                    }
                  , { name   = "Demonic Nature of Oni"
                    , rank   = A
                    , icon   = Icon.SwordUp
                    , cd     = 7
                    , effect = [ Grant Party 3 AttackUp <| Range 10 20
                               , Grant Self 3 NPUp <| Range 20 30
                               ]
                    }
                  , { name   = "Battle Continuation"
                    , rank   = APlus
                    , icon   = Icon.Kneel
                    , cd     = 9
                    , effect = [ Times 1 << Grant Self 5 Guts <| Range 1200 2700 ]
                    }
                  ]
    , passives  = [presenceConcealment C, divinity C]
    , phantasm  = { name   = "Multicolored Poison—Shinpen Kidoku"
                  , desc   = ""
                  , rank   = B
                  , card   = Arts
                  , kind   = "Anti-Army"
                  , hits   = 1
                  , effect = [ To Enemies Damage <| Range 450 750
                             , Debuff Enemies 3 DebuffVuln <| Flat 10
                             , Debuff Enemies 3 AttackDown <| Flat 10
                             , Debuff Enemies 3 NPDown <| Flat 10
                             , Debuff Enemies 3 CritChance <| Flat 10
                             , Debuff Enemies 3 DefenseDown <| Flat 10
                             , Debuff Enemies 1 SealSkills Full
                             ]
                  , over   = [ Debuff Enemies 5 Poison <| Range 1000 5000 ]
                  , first  = False
                  }
    , gen       = { starWeight = 98, starRate = 25, npAtk = 0.55, npDef = 4 }
    , hits      = { quick = 4, arts = 3, buster = 1, ex = 6 }
    , gender    = Female
    , traits    = [Humanoid, Demonic, DemonBeast, Oni, EnumaElish, Divine, Dragon]
    , death     = 31.6
    , align     = [Chaotic, Evil]
    , limited   = True
    , free      = False
    , ascendUp  = Ascension
                  [(Piece Assassin, 5)]
                  [(Piece Assassin, 12), (EvilBone, 22)]
                  [(Monument Assassin, 5), (SerpentJewel, 8), (GhostLantern, 5)]
                  [(Monument Assassin, 12), (GhostLantern, 10), (HeartOfTheForeignGod, 5)]
    , skillUp   = Reinforcement
                  [(GemOf Assassin, 5)]
                  [(GemOf Assassin, 12)]
                  [(MagicGemOf Assassin, 5)]
                  [(MagicGemOf Assassin, 12), (SerpentJewel, 4)]
                  [(SecretGemOf Assassin, 5), (SerpentJewel, 8)]
                  [(SecretGemOf Assassin, 12), (EvilBone, 15)]
                  [(EvilBone, 29), (ClawOfChaos, 4)]
                  [(ClawOfChaos, 11), (SpiritRoot, 10)]
    }
  , { name      = "Fuuma \"Evil-wind\" Kotarou"
    , spoiler   = Nothing
    , id        = 117
    , rarity    = 3
    , class     = Assassin
    , attr      = Human
    , deck      = Deck Quick Quick Quick Arts Buster
    , curve     = 8
    , stats     = { base  = { atk = 1316,  hp = 1592 }
                  , max   = { atk = 7091, hp = 8844 }
                  , grail = { atk = 9597, hp = 11991 }
                  }
    , skills    = [ { name   = "Sabotage"
                    , rank   = BPlus
                    , icon   = Icon.SwordDown
                    , cd     = 7
                    , effect = [ Debuff Enemies 3 AttackDown <| Flat 10
                               , Debuff Enemies 3 CritChance <| Range 10 20
                               ]
                    }
                  , { name   = "Ninjutsu"
                    , rank   = APlusPlusPlus
                    , icon   = Icon.Dodge
                    , cd     = 8
                    , effect = [ Grant Ally 1 Evasion Full
                               , Grant Ally 1 StarUp <| Range 30 50
                               ]
                    }
                  , { name   = "Suspicious Shadow"
                    , rank   = C
                    , icon   = Icon.HoodDown
                    , cd     = 7
                    , effect = [ Debuff Enemies 1 DebuffVuln <| Range 50 100 ]
                    }
                  ]
    , passives  = [presenceConcealment APlus]
    , phantasm  = { name   = "Immortal Chaos Brigade"
                  , desc   = "Fumetsu no Konton Ryodan"
                  , rank   = BPlus
                  , card   = Quick
                  , kind   = "Anti-Army"
                  , hits   = 5
                  , effect = [ To Enemies Damage <| Range 800 1200
                             , Debuff Enemies 3 DefenseDown <| Flat 20
                             ]
                  , over   = [ Debuff Enemies 5 Confusion <| Range 30 70 ]
                  , first  = False
                  }
    , gen       = { starWeight = 100, starRate = 25.6, npAtk = 0.54, npDef = 4 }
    , hits      = { quick = 4, arts = 4, buster = 1, ex = 4 }
    , gender    = Male
    , traits    = [Humanoid, EnumaElish]
    , death     = 38.5
    , align     = [Chaotic, Evil]
    , limited   = False
    , free      = True
    , ascendUp  = Ascension
                  [(Piece Assassin, 4)]
                  [(Piece Assassin, 8), (EvilBone, 15)]
                  [(Monument Assassin, 4), (VoidsDust, 13), (OctupletCrystals, 4)]
                  [(Monument Assassin, 8), (OctupletCrystals, 7), (BlackBeastGrease, 5)]
    , skillUp   = Reinforcement
                  [(GemOf Assassin, 4)]
                  [(GemOf Assassin, 8)]
                  [(MagicGemOf Assassin, 4)]
                  [(MagicGemOf Assassin, 8), (VoidsDust, 7)]
                  [(SecretGemOf Assassin, 4), (VoidsDust, 13)]
                  [(SecretGemOf Assassin, 8), (EvilBone, 10)]
                  [(EvilBone, 20), (SeedOfYggdrasil, 5)]
                  [(SeedOfYggdrasil, 15), (ClawOfChaos, 10)]
    }
  , { name      = "Hassan of the Serenity"
    , spoiler   = Nothing
    , id        = 124
    , rarity    = 3
    , class     = Assassin
    , attr      = Human
    , deck      = Deck Quick Quick Arts Arts Buster
    , curve     = 23
    , stats     = { base  = { atk = 1232, hp = 1675 }
                  , max   = { atk = 6636, hp = 9310 }
                  , grail = { atk = 8981, hp = 12623 }
                  }
    , skills    = [ { name   = "Morph (Infiltration)"
                    , rank   = C
                    , icon   = Icon.ExclamationDown
                    , cd     = 9
                    , effect = [ Debuff Enemy 3 CritChance <| Range 10 20
                               , To Enemy GaugeDown <| Flat 1
                               ]
                    }
                  , { name   = "Poisoned Blade"
                    , rank   = CPlusPlus
                    , icon   = Icon.Poison
                    , cd     = 6
                    , effect = [ Debuff Enemy 5 Poison <| Flat 500
                               , Debuff Enemy 5 PoisonVuln <| Flat 100
                               , To Party GainStars <| Range 5 15
                               ]
                    }
                  , { name   = "Dance of Silence"
                    , rank   = B
                    , icon   = Icon.ReaperUp
                    , cd     = 8
                    , effect = [ Grant Self 3 DeathUp <| Range 20 50
                               , Grant Self 3 DebuffUp <| Range 20 50
                               ]
                    }
                  ]
    , passives  = [presenceConcealment APlus, independentAction A]
    , phantasm  = { name   = "Zabaniya"
                  , desc   = "Delusional Poison Body"
                  , rank   = CPlus
                  , card   = Arts
                  , kind   = "Anti-Unit"
                  , hits   = 1
                  , effect = [ Debuff Enemy 5 Poison <| Flat 2000
                             , Chance 40 <| Debuff Enemy 1 SealSkills Full
                             , Chance 40 <| Debuff Enemy 1 SealNP Full
                             , To Enemy Damage <| Range 1200 1800
                             ]
                  , over   = [ To Enemy Death <| Range 60 100 ]
                  , first  = True
                  }
    , gen       = { starWeight = 102, starRate = 25.6, npAtk = 0.53, npDef = 4 }
    , hits      = { quick = 3, arts = 3, buster = 4, ex = 5 }
    , gender    = Female
    , traits    = [Humanoid, EnumaElish]
    , death     = 44
    , align     = [Lawful, Evil]
    , limited   = False
    , free      = True
    , ascendUp  = Ascension
                  [(Piece Assassin, 4)]
                  [(Piece Assassin, 8), (EvilBone, 15)]
                  [(Monument Assassin, 4), (FoolsChain, 20), (TearstoneOfBlood, 2)]
                  [(Monument Assassin, 8), (TearstoneOfBlood, 4), (BlackBeastGrease, 5)]
    , skillUp   = Reinforcement
                  [(GemOf Assassin, 4)]
                  [(GemOf Assassin, 8)]
                  [(MagicGemOf Assassin, 4)]
                  [(MagicGemOf Assassin, 8), (FoolsChain, 10)]
                  [(SecretGemOf Assassin, 4), (FoolsChain, 20)]
                  [(SecretGemOf Assassin, 8), (EvilBone, 10)]
                  [(EvilBone, 20), (VoidsDust, 8)]
                  [(VoidsDust, 10), (LampOfEvilSealing, 10)]
    }
  , { name      = "Scathach (Assassin)"
    , spoiler   = Nothing
    , id        = 133
    , rarity    = 4
    , class     = Assassin
    , attr      = Star
    , deck      = Deck Quick Quick Quick Arts Buster
    , curve     = 4
    , stats     = { base  = { atk = 1851,  hp = 1786 }
                  , max   = { atk = 9049,  hp = 11168 }
                  , grail = { atk = 10956, hp = 13541 }
                  }
    , skills    = [ { name   = "Beach Crisis"
                    , rank   = APlus
                    , icon   = Icon.CrosshairUp
                    , cd     = 8
                    , effect = [ Chances 100 300 <| Grant Self 1 Taunt Full
                               , Grant Self 1 CritUp <| Range 30 50
                               ]
                    }
                  , { name   = "Primordial Rune (Sea)"
                    , rank   = A
                    , icon   = Icon.Heal
                    , cd     = 8
                    , effect = [ To Ally Heal <| Range 1000 3000
                               , Grant Ally 1 DamageCut <| Range 500 1000
                               ]
                    }
                  , { name   = "Midsummer Mistake"
                    , rank   = C
                    , icon   = Icon.ShieldBreak
                    , cd     = 8
                    , effect = [ Grant Self 1 IgnoreInvinc Full
                               , Grant Self 1 (CardUp Quick) <| Range 30 50
                               ]
                    }
                  ]
    , passives  = [presenceConcealment E]
    , phantasm  = { name   = "Gáe Bolg Alternative"
                  , desc   = "Soaring Spear of Kicked Piercing Death"
                  , rank   = BPlus
                  , card   = Quick
                  , kind   = "Anti-Army"
                  , hits   = 5
                  , effect = [ To Enemies Damage <| Range 600 1000 ]
                  , over   = [ To Enemies Death <| Range 30 70 ]
                  , first  = True
                  }
    , gen       = { starWeight = 98, starRate = 25.6, npAtk = 0.71, npDef = 4 }
    , hits      = { quick = 3, arts = 3, buster = 3, ex = 5 }
    , gender    = Female
    , traits    = [Humanoid, EnumaElish, King]
    , death     = 44
    , align     = [Neutral, Good]
    , limited   = True
    , free      = True
    , ascendUp  = Welfare "Bell-Ringing Branch"
    , skillUp   = Reinforcement
                  [(GemOf Assassin, 4)]
                  [(GemOf Assassin, 10)]
                  [(MagicGemOf Assassin, 4)]
                  [(MagicGemOf Assassin, 10), (SeedOfYggdrasil, 5)]
                  [(SecretGemOf Assassin, 4), (SeedOfYggdrasil, 10)]
                  [(SecretGemOf Assassin, 10), (ShellOfReminiscence, 4)]
                  [(ShellOfReminiscence, 8), (SpiritRoot, 2)]
                  [(SpiritRoot, 6), (ScarabOfWisdom, 8)]
    }
  , { name      = "Cleopatra"
    , spoiler   = Nothing
    , id        = 139
    , rarity    = 5
    , class     = Assassin
    , attr      = Human
    , deck      = Deck Quick Quick Arts Buster Buster
    , curve     = 5
    , stats     = { base  = { atk = 1713,  hp = 1965 }
                  , max   = { atk = 11088, hp = 13402 }
                  , grail = { atk = 12138, hp = 14682 }
                  }
    , skills    = [ { name   = "Imperial Privilege"
                    , rank   = A
                    , icon   = Icon.Heal
                    , cd     = 7
                    , effect = [ To Self Heal <| Range 1000 3000
                               , Chance 60 << Grant Self 3 AttackUp  <| Range 20 40
                               , Chance 60 << Grant Self 3 DefenseUp <| Range 20 40
                               ]
                    }
                  , { name   = "Golden Rule (Wealth & Body)"
                    , rank   = B
                    , icon   = Icon.NobleTurn
                    , cd     = 8
                    , effect = [ Grant Self 3 NPGen <| Range 20 40
                               , Grant Self 3 GaugePerTurn <| Flat 10
                               , Grant Self 3 HealPerTurn <| Range 500 100
                               ]
                    }
                  , { name   = "Protection of the Goddess"
                    , rank   = C
                    , icon   = Icon.Shield
                    , cd     = 8
                    , effect = [ Grant Self 1 Invincibility Full
                               , To Self RemoveDebuffs Full
                               , To Party GainStars <| Range 10 20
                               ]
                    }
                  ]
    , passives  = [presenceConcealment B, divinity D]
    , phantasm  = { name   = "Uraeus Astrape"
                  , desc   = "Here Stand the Snakes, at the Dawn's End"
                  , rank   = A
                  , card   = Buster
                  , kind   = "Anti-Army"
                  , hits   = 5
                  , effect = [ To Enemies Damage <| Range 300 500
                             , To Self DemeritDamage <| Flat 1000
                             ]
                  , over   = [ Grant Self 1 (CardUp Buster) <| Range 30 70 ]
                  , first  = True
                  }
    , gen       = { starWeight = 98, starRate = 25.5, npAtk = 1.06, npDef = 4 }
    , hits      = { quick = 4, arts = 2, buster = 3, ex = 6 }
    , gender    = Female
    , traits    = [Humanoid, Divine, EnumaElish, King]
    , death     = 49.5
    , align     = [Lawful, Balanced]
    , limited   = True
    , free      = False
    , ascendUp  = Ascension
                  [(Piece Assassin, 5)]
                  [(Piece Assassin, 12), (PhoenixFeather, 6)]
                  [(Monument Assassin, 5), (LampOfEvilSealing, 6), (TearstoneOfBlood, 3)]
                  [(Monument Assassin, 12), (TearstoneOfBlood, 6), (SerpentJewel, 10)]
    , skillUp   = Reinforcement
                  [(GemOf Assassin, 5)]
                  [(GemOf Assassin, 12)]
                  [(MagicGemOf Assassin, 5)]
                  [(MagicGemOf Assassin, 12), (LampOfEvilSealing, 3)]
                  [(SecretGemOf Assassin, 5), (LampOfEvilSealing, 6)]
                  [(SecretGemOf Assassin, 12), (PhoenixFeather, 4)]
                  [(PhoenixFeather, 8), (ShellOfReminiscence, 6)]
                  [(ShellOfReminiscence, 18), (ScarabOfWisdom, 10)]
    }
  , { name      = "\"First Hassan\""
    , spoiler   = Nothing
    , id        = 154
    , rarity    = 5
    , class     = Assassin
    , stats     = { base  = { atk = 1831,  hp = 1956 }
                  , max   = { atk = 11848, hp = 13338 }
                  , grail = { atk = 12969, hp = 14612 }
                  }
    , gen       = { starWeight = 98, starRate = 25.5, npAtk = 1, npDef = 4 }
    , death     = 49.5
    , curve     = 15
    , attr      = Human
    , align     = [Lawful, Evil]
    , gender    = Male
    , traits    = [Humanoid, LovedOne, EnumaElish]
    , deck      = Deck Quick Arts Buster Buster Buster
    , hits      = { quick = 5, arts = 3, buster = 1, ex = 6 }
    , skills    = [ { name   = "Battle Continuation"
                    , rank   = EX
                    , icon   = Icon.Kneel
                    , cd     = 9
                    , effect = [ Times 1 << Grant Self 3 Guts <| Range 3000 5000 ]
                    }
                  , { name   = "Protection of the Faith"
                    , rank   = APlusPlusPlus
                    , icon   = Icon.HoodUp
                    , cd     = 7
                    , effect = [ Grant Self 3 DebuffResist <| Range 50 100
                               , To Self Heal <| Range 1000 2500
                               , Grant Self 1 DefenseUp <| Range 20 40
                               , Grant Self 3 AttackUp <| Range 10 20
                               ]
                    }
                  , { name   = "Evening Bell"
                    , rank   = EX
                    , icon   = Icon.FireDown
                    , cd     = 8
                    , effect = [ Debuff Enemies 3 DeathVuln <| Range 50 100
                               , Grant Self 1 (CardUp Buster) <| Range 30 50
                               ]
                    }
                  ]
    , passives  = [magicResistance B, presenceConcealment A, independentAction B, onTheBoundary A]
    , phantasm  = { name   = "Azrael"
                  , desc   = "The Angel That Announces Death"
                  , rank   = C
                  , card   = Buster
                  , kind   = "Anti-Personnel"
                  , hits   = 1
                  , effect = [ To Enemy Damage <| Range 600 1000 ]
                  , over   = [ To Enemy Death <| Range 100 200 ]
                  , first  = True
                  }
    , limited   = True
    , free      = False
    , ascendUp  = Ascension
                  [(Piece Assassin, 5)]
                  [(Piece Assassin, 12), (EvilBone, 22)]
                  [(Monument Assassin, 5), (FoolsChain, 29), (CursedBeastGallstone, 2)]
                  [(Monument Assassin, 12), (CursedBeastGallstone, 4), (VoidsDust, 24)]
    , skillUp   = Reinforcement
                  [(GemOf Assassin, 5)]
                  [(GemOf Assassin, 12)]
                  [(MagicGemOf Assassin, 5)]
                  [(MagicGemOf Assassin, 12), (FoolsChain, 15)]
                  [(SecretGemOf Assassin, 5), (FoolsChain, 29)]
                  [(SecretGemOf Assassin, 12), (EvilBone, 15)]
                  [(EvilBone, 29), (DeadlyPoisonousNeedle, 15)]
                  [(DeadlyPoisonousNeedle, 44), (GhostLantern, 24)]
    },
    { name      = "Yan Qing"
    , spoiler   = Just "Shinjuku"
    , id        = 159
    , rarity    = 4
    , class     = Assassin
    , stats     = { base  = { atk = 1443,  hp = 1862 }
                  , max   = { atk = 8661,  hp = 11637 }
                  , grail = { atk = 10487, hp = 14110 }
                  }
    , gen       = { starWeight = 100, starRate = 25.6, npAtk = 0.71, npDef = 4 }
    , death     = 49.5
    , curve     = 9
    , attr      = Human
    , align     = [Chaotic, Evil]
    , gender    = Male
    , traits    = [Humanoid, EnumaElish]
    , deck      = Deck Quick Quick Quick Arts Buster
    , hits      = { quick = 3, arts = 3, buster = 1, ex = 5 }
    , skills    = [ { name   = "Chinese Boxing"
                    , rank   = EX
                    , icon   = Icon.StarUp
                    , cd     = 7
                    , effect = [ Grant Self 1 GatherUp <| Range 300 600
                               , Grant Self 1 NPGen <| Range 20 30
                               ]
                    }
                  , { name   = "Espionage"
                    , rank   = A
                    , icon   = Icon.StarHaloUp
                    , cd     = 7
                    , effect = [ Grant Self 3 StarUp <| Range 9 29 ]
                    }
                  , { name   = "Skillful Star"
                    , rank   = APlus
                    , icon   = Icon.StarDown
                    , cd     = 8
                    , effect = [ Grant Self 1 GatherDown <| Flat 100
                               , To Party GainStars <| Range 10 20
                               ]
                    }
                  ]
    , passives  = [presenceConcealment C, ruffian A]
    , phantasm  = { name   = "Juumenmaifuku Muei no Gotoku"
                  , desc   = "Ambushed from Ten Sides, As If There Was No Shadow"
                  , rank   = A
                  , card   = Quick
                  , kind   = "Anti-Unit"
                  , hits   = 11
                  , effect = [ To Enemy Damage <| Range 1200 2000 ]
                  , over   = [ Debuff Enemy 3 CritDown <| Range 20 40 ]
                  , first  = False
                  }
    , limited   = False
    , free      = False
    , ascendUp  = Ascension
                  [(Piece Assassin, 4)]
                  [(Piece Assassin, 10), (VoidsDust, 12)]
                  [(Monument Assassin, 4), (GhostLantern, 8), (OctupletCrystals, 4)]
                  [(Monument Assassin, 10), (OctupletCrystals, 8), (PhoenixFeather, 8)]
    , skillUp   = Reinforcement
                  [(GemOf Assassin, 4)]
                  [(GemOf Assassin, 10)]
                  [(MagicGemOf Assassin, 4)]
                  [(MagicGemOf Assassin, 10), (GhostLantern, 4)]
                  [(SecretGemOf Assassin, 4), (GhostLantern, 8)]
                  [(SecretGemOf Assassin, 10), (VoidsDust, 8)]
                  [(VoidsDust, 16), (MysticSpinalFluid, 15)]
                  [(MysticSpinalFluid, 45), (HomunculusBaby, 20)]
    }
  , { name      = "Wu Zetian"
    , spoiler   = Just "the Nightless City"
    , id        = 170
    , rarity    = 4
    , class     = Assassin
    , stats     = { base  = { atk = 1496,  hp = 1750 }
                  , max   = { atk = 8981,  hp = 10942 }
                  , grail = { atk = 10874, hp = 13267 }
                  }
    , gen       = { starWeight = 102, starRate = 25.5, npAtk = 0.87, npDef = 4 }
    , death     = 38.5
    , curve     = 9
    , attr      = Human
    , align     = [Lawful, Evil]
    , gender    = Female
    , traits    = [Humanoid, EnumaElish, King]
    , deck      = Deck Quick Quick Arts Buster Buster
    , hits      = { quick = 3, arts = 3, buster = 3, ex = 3 }
    , skills    = [ { name   = "Torture Technique"
                    , rank   = A
                    , icon   = Icon.ShieldDown
                    , cd     = 7
                    , effect = [ Debuff Enemy 3 DefenseDown <| Range 10 20 ]
                    }
                  , { name   = "Imperial Privilege"
                    , rank   = B
                    , icon   = Icon.Heal
                    , cd     = 7
                    , effect = [ To Self Heal <| Range 800 2800
                               , Chance 60 << Grant Self 3 AttackUp <| Range 18 38
                               , Chance 60 << Grant Self 3 DefenseUp <| Range 18 38
                               ]
                    }
                  , { name   = "Charisma of the Empress"
                    , rank   = A
                    , icon   = Icon.SwordUp
                    , cd     = 7
                    , effect = [ Grant Party 3 AttackUp <| Range 10 20
                               , Grant Others 3 (CardUp Quick) <| Range 10 20
                               ]
                    }
                  ]
    , passives  = [presenceConcealment D]
    , phantasm  = { name   = "Gào Mì Luó Zhī Jīng"
                  , desc   = "Manual of Accusation"
                  , rank   = B
                  , card   = Quick
                  , kind   = "Anti-Personnel"
                  , hits   = 4
                  , effect = [ To Enemy Damage <| Range 1200 2000
                             , Debuff Enemy 3 Poison <| Flat 1000
                             ]
                  , over   = [ Grant Self 3 CritUp <| Range 50 100 ]
                  , first  = False
                  }
    , limited   = False
    , free      = False
    , ascendUp  = Ascension
                  [(Piece Assassin, 4)]
                  [(Piece Assassin, 10), (DeadlyPoisonousNeedle, 15)]
                  [(Monument Assassin, 4), (FoolsChain, 24), (BlackBeastGrease, 3)]
                  [(Monument Assassin, 10), (BlackBeastGrease, 5), (CursedBeastGallstone, 4)]
    , skillUp   = Reinforcement
                  [(GemOf Assassin, 4)]
                  [(GemOf Assassin, 10)]
                  [(MagicGemOf Assassin, 4)]
                  [(MagicGemOf Assassin, 10), (FoolsChain, 12)]
                  [(SecretGemOf Assassin, 4), (FoolsChain, 24)]
                  [(SecretGemOf Assassin, 10), (DeadlyPoisonousNeedle, 10)]
                  [(DeadlyPoisonousNeedle, 20), (MysteriousDivineWine, 2)]
                  [(MysteriousDivineWine, 6), (MysticSpinalFluid, 60)]
    }
  , { name      = "Nitocris (Assassin)"
    , spoiler   = Nothing
    , id        = 177
    , rarity    = 4
    , class     = Assassin
    , stats     = { base  = { atk = 1468,  hp = 1843 }
                  , max   = { atk = 8812,  hp = 11518 }
                  , grail = { atk = 10670, hp = 13965 }
                  }
    , gen       = { starWeight = 102, starRate = 25, npAtk = 0.78, npDef = 3 }
    , death     = 33
    , curve     = 9
    , attr      = Earth
    , align     = [Lawful, Good]
    , gender    = Female
    , traits    = [Humanoid, Divine, King]
    , deck      = Deck Quick Quick Arts Arts Buster
    , hits      = { quick = 3, arts = 2, buster = 1, ex = 4 }
    , skills    = [ { name   = "White Imperial Garments"
                    , rank   = A
                    , icon   = Icon.ShieldUp
                    , cd     = 7
                    , effect = [ Grant Self 1 DefenseUp <| Flat 30
                               , Grant Self 3 DefenseUp <| Range 10 30
                               , Grant Self 3 DebuffResist <| Flat 30
                               ]
                    }
                  , { name   = "Beach Panic"
                    , rank   = EX
                    , icon   = Icon.CrosshairUp
                    , cd     = 9
                    , effect = [ Times 3 << Grant Self 3 DamageCut <| Range 1000 2000
                               , Chance 300 <| Grant Self 1 Taunt Full
                               ]
                    }
                  , { name   = "High Road of the Hot Sands"
                    , rank   = A
                    , icon   = Icon.SwordUp
                    , cd     = 8
                    , effect = [ Grant Self 3 AttackUp <| Range 20 30
                               , Grant Self 3 NPUp <| Range 10 20
                               , Grant Self 3 NPGen <| Range 20 30
                               ]
                    }
                  ]
    , passives  = [presenceConcealment A, divinity BPlus]
    , phantasm  = { name   = "Sneferu Iteru Nile"
                  , desc   = "Cleanse the Impure, Blue and Beautiful Nile"
                  , rank   = B
                  , card   = Arts
                  , kind   = "Anti-Army"
                  , hits   = 3
                  , effect = [ To Enemies Damage <| Range 450 750
                             , Debuff Enemies 3 DefenseDown <| Flat 20
                             ]
                  , over   = [ To Enemies Death <| Range 30 70 ]
                  , first  = True
                  }
    , limited   = True
    , free      = False
    , ascendUp  = Ascension
                  [(Piece Assassin, 4)]
                  [(Piece Assassin, 10), (GhostLantern, 6)]
                  [(Monument Assassin, 4), (ShellOfReminiscence, 8), (PhoenixFeather, 4)]
                  [(Monument Assassin, 10), (PhoenixFeather, 7), (ScarabOfWisdom, 4)]
    , skillUp   = Reinforcement
                  [(GemOf Assassin, 4)]
                  [(GemOf Assassin, 10)]
                  [(MagicGemOf Assassin, 4)]
                  [(MagicGemOf Assassin, 10), (ShellOfReminiscence, 4)]
                  [(SecretGemOf Assassin, 4), (ShellOfReminiscence, 8)]
                  [(SecretGemOf Assassin, 10), (GhostLantern, 4)]
                  [(GhostLantern, 8), (SpiritRoot, 2)]
                  [(SpiritRoot, 6), (LampOfEvilSealing, 12)]
    }
  , { name      = "Mochizuki Chiyome"
    , spoiler   = Just "Paraiso"
    , id        = 185
    , rarity    = 4
    , class     = Assassin
    , stats     = { base  = { atk = 1418,  hp = 1862 }
                  , max   = { atk = 8510,  hp = 11637 }
                  , grail = { atk = 10304, hp = 14110 }
                  }
    , gen       = { starWeight = 99, starRate = 25.5, npAtk = 0.8, npDef = 4 }
    , death     = 44
    , curve     = 4
    , attr      = Earth
    , align     = [Chaotic, Evil]
    , gender    = Female
    , traits    = [Humanoid, EnumaElish]
    , deck      = Deck Quick Quick Arts Arts Buster
    , hits      = { quick = 3, arts = 2, buster = 3, ex = 4 }
    , skills    = [ { name   = "Curse (Shrine Maiden)"
                    , rank   = C
                    , icon   = Icon.Circuits
                    , cd     = 7
                    , effect = [ Chances 80 100 <| Debuff Enemy 1 SealNP Full ]
                    }
                  , { name   = "Curse of the Orochi"
                    , rank   = B
                    , icon   = Icon.ArtsUp
                    , cd     = 7
                    , effect = [ Grant Self 3 (CardUp Arts) <| Range 10 30
                               , When "attacking for 3 turns" << Chance 200 << Debuff Target 3 Curse <| Flat 500
                               ]
                    }
                  , { name   = "Kougaryu"
                    , rank   = A
                    , icon   = Icon.Dodge
                    , cd     = 8
                    , effect = [ To Self GaugeUp <| Range 20 30
                               , Grant Self 1 Evasion Full
                               ]
                    }
                  ]
    , passives  = [presenceConcealment APlus]
    , phantasm  = { name   = "Kuchiyose, Ibukidaimyoujin-Engi"
                  , desc   = "Summoning the Great Deity of Ibuki Pratītyasamutpāda"
                  , rank   = C
                  , card   = Arts
                  , kind   = "Anti-Personnel"
                  , hits   = 5
                  , effect = [ To Enemy Damage <| Range 900 1500
                             , Debuff Enemy 1 SealSkills Full
                             ]
                  , over   = [ Debuff Enemy 3 CritChance <| Range 10 30 ]
                  , first  = False
                  }
    , limited   = False
    , free      = False
    , ascendUp  = Ascension
                  [(Piece Assassin, 4)]
                  [(Piece Assassin, 10), (DeadlyPoisonousNeedle, 15)]
                  [(Monument Assassin, 4), (RefinedMagatama, 8), (SpiritRoot, 2)]
                  [(Monument Assassin, 10), (SpiritRoot, 4), (CursedBeastGallstone, 4)]
    , skillUp   = Reinforcement
                  [(GemOf Assassin, 4)]
                  [(GemOf Assassin, 10)]
                  [(MagicGemOf Assassin, 4)]
                  [(MagicGemOf Assassin, 10), (RefinedMagatama, 4)]
                  [(SecretGemOf Assassin, 4), (RefinedMagatama, 8)]
                  [(SecretGemOf Assassin, 10), (DeadlyPoisonousNeedle, 10)]
                  [(DeadlyPoisonousNeedle, 20), (ClawOfChaos, 4)]
                  [(ClawOfChaos, 9), (VoidsDust, 40)]
    }
  , { name      = "Katou Danzo"
    , spoiler   = Nothing
    , id        = 188
    , rarity    = 4
    , class     = Assassin
    , stats     = { base  = { atk = 1489,  hp = 1768 }
                  , max   = { atk = 8935,  hp = 11055 }
                  , grail = { atk = 10818, hp = 13404 }
                  }
    , gen       = { starWeight = 100, starRate = 25.5, npAtk = 0.71, npDef = 4 }
    , death     = 44
    , curve     = 24
    , attr      = Earth
    , align     = [Neutral, Balanced]
    , gender    = Female
    , traits    = [Humanoid, EnumaElish]
    , deck      = Deck Quick Quick Arts Buster Buster
    , hits      = { quick = 4, arts = 3, buster = 2, ex = 5 }
    , skills    = [ { name   = "Synthetic Limbs (Mechanical)"
                    , rank   = APlusPlus
                    , icon   = Icon.QuickBusterUp
                    , cd     = 7
                    , effect = [ Grant Self 3 (CardUp Quick) <| Range 20 30
                               , Grant Self 3 (CardUp Buster) <| Range 20 30
                               ]
                    }
                  , { name   = "Ninjutsu"
                    , rank   = A
                    , icon   = Icon.Dodge
                    , cd     = 8
                    , effect = [ Grant Self 1 StarUp <| Range 25 45
                               , Grant Self 1 Evasion Full
                               ]
                    }
                  , { name   = "Mechanical Illusion"
                    , rank   = BPlus
                    , icon   = Icon.Shield
                    , cd     = 8
                    , effect = [ Grant Ally 1 StarUp <| Range 25 45
                               , Grant Ally 1 Invincibility Full
                               ]
                    }
                  ]
    , passives  = [presenceConcealment A]
    , phantasm  = { name   = "Karakuri Genpou - Dongyu"
                  , desc   = "Mechanical Illusion: Bull Engulfing"
                  , rank   = C
                  , card   = Buster
                  , kind   = "Anti-Beast"
                  , hits   = 3
                  , effect = [ To Enemies Damage <| Range 300 500 ]
                  , over   = [ To Enemies (SpecialDamage <| VsTrait Demonic) <| Range 150 200 ]
                  , first  = False
                  }
    , limited   = False
    , free      = False
    , ascendUp  = Ascension
                  [(Piece Assassin, 4)]
                  [(Piece Assassin, 10), (FoolsChain, 18)]
                  [(Monument Assassin, 4), (GhostLantern, 8), (MysticSpinalFluid, 12)]
                  [(Monument Assassin, 10), (MysticSpinalFluid, 24), (EternalGear, 10)]
    , skillUp   = Reinforcement
                  [(GemOf Assassin, 4)]
                  [(GemOf Assassin, 10)]
                  [(MagicGemOf Assassin, 4)]
                  [(MagicGemOf Assassin, 10), (GhostLantern, 4)]
                  [(SecretGemOf Assassin, 4), (GhostLantern, 8)]
                  [(SecretGemOf Assassin, 10), (FoolsChain, 12)]
                  [(FoolsChain, 24), (VoidsDust, 10)]
                  [(VoidsDust, 30), (RefinedMagatama, 20)]
    }
  , { name      = "Osakabehime"
    , spoiler   = Nothing
    , id        = 189
    , rarity    = 5
    , class     = Assassin
    , stats     = { base  = { atk = 1672,  hp = 2027 }
                  , max   = { atk = 10824, hp = 13822 }
                  , grail = { atk = 11849, hp = 15143 }
                  }
    , gen       = { starWeight = 102, starRate = 24.6, npAtk = 0.83, npDef = 4 }
    , death     = 31.6
    , curve     = 5
    , attr      = Earth
    , align     = [Chaotic, Balanced]
    , gender    = Female
    , traits    = [Humanoid, Divine, EnumaElish]
    , deck      = Deck Quick Quick Arts Arts Buster
    , hits      = { quick = 4, arts = 2, buster = 3, ex = 5 }
    , skills    = [ { name   = "Morph"
                    , rank   = APlus
                    , icon   = Icon.ShieldUp
                    , cd     = 7
                    , effect = [ Grant Self 3 DefenseUp <| Range 10 30
                               , Grant Self 3 DebuffResist <| Range 20 40
                               , Grant Self 1 DefenseUp <| Flat 30
                               ]
                    }
                  , { name   = "Thousand Years of Paper Arts"
                    , rank   = EX
                    , icon   = Icon.Noble
                    , cd     = 7
                    , effect = [ To Ally GaugeUp <| Range 10 20
                               , Grant Ally 3 StarUp <| Range 30 50
                               ]
                    }
                  , { name   = "Castle Ghost"
                    , rank   = APlusPlus
                    , icon   = Icon.ShieldDown
                    , cd     = 7
                    , effect = [ Debuff Enemy 1 DefenseDown <| Range 20 40
                               , To Enemy RemoveBuffs Full
                               ]
                    }
                  ]
    , passives  = [territoryCreation A, presenceConcealmentDark B, divinity C]
    , phantasm  = { name   = "The Great Hachitendou of Hakuro Castle"
                  , desc   = "Temple Guardian of The White Egret Castle Pandemonium"
                  , rank   = APlus
                  , card   = Quick
                  , kind   = "Anti-Fortress"
                  , hits   = 0
                  , effect = [ Grant Party 3 HPUp <| Range 1000 2000
                             , Grant Party 3 DefenseUp <| Flat 20
                             ]
                  , over   = [ Grant Party 3 (CardUp Quick) <| Range 30 50 ]
                  , first  = False
                  }
    , limited   = False
    , free      = False
    , ascendUp  = Ascension
                  [(Piece Assassin, 5)]
                  [(Piece Assassin, 12), (SeedOfYggdrasil, 9)]
                  [(Monument Assassin, 5), (VoidsDust, 20), (ForbiddenPage, 5)]
                  [(Monument Assassin, 12), (ForbiddenPage, 10), (SpiritRoot, 5)]
    , skillUp   = Reinforcement
                  [(GemOf Assassin, 5)]
                  [(GemOf Assassin, 12)]
                  [(MagicGemOf Assassin, 5)]
                  [(MagicGemOf Assassin, 12), (VoidsDust, 10)]
                  [(SecretGemOf Assassin, 5), (VoidsDust, 20)]
                  [(SecretGemOf Assassin, 12), (SeedOfYggdrasil, 6)]
                  [(SeedOfYggdrasil, 12), (MysteriousDivineWine, 3)]
                  [(MysteriousDivineWine, 8), (RefinedMagatama, 24)]
    }
  , { name      = "Semiramis"
    , spoiler   = Nothing
    , id        = 199
    , rarity    = 5
    , class     = Assassin
    , stats     = { base  = { atk = 1747,  hp = 1945 }
                  , max   = { atk = 11309, hp = 13266 }
                  , grail = { atk = 12379, hp = 14533 }
                  }
    , gen       = { starWeight = 102, starRate = 24.7, npAtk = 0.39, npDef = 4 }
    , death     = 33
    , curve     = 15
    , attr      = Earth
    , align     = [Lawful, Evil]
    , gender    = Female
    , traits    = [Humanoid, EnumaElish, Divine, King]
    , deck      = Deck Quick Arts Arts Arts Buster
    , hits      = { quick = 4, arts = 4, buster = 4, ex = 5 }
    , skills    = [ { name   = "Familiar (Pigeon)"
                    , rank   = D
                    , icon   = Icon.Noble
                    , cd     = 7
                    , effect = [ To Self GaugeUp <| Range 20 30
                               , Debuff Enemies 1 DebuffVuln <| Range 30 50
                               ]
                    }
                  , { name   = "Double Summon"
                    , rank   = B
                    , icon   = Icon.NobleUp
                    , cd     = 7
                    , effect = [ Grant Self 3 NPGen <| Range 20 40
                               , Grant Self 3 (NoAffinity Caster) Full
                               ]
                    }
                  , { name   = "Sikera Ušum"
                    , rank   = BPlus
                    , icon   = Icon.Poison
                    , cd     = 8
                    , effect = [ To Party DemeritStars <| Flat 8
                               , Debuff Enemies 3 Poison <| Range 500 1000
                               , Debuff Enemies 3 (CardVuln Buster) <| Range 30 50
                               ]
                    }
                  ]
    , passives  = [presenceConcealment CPlus, territoryCreation EX, itemConstruction C, divinity C]
    , phantasm  = { name   = "Hanging Gardens of Babylon"
                  , desc   = "Floating Garden of Vanity"
                  , rank   = EX
                  , card   = Buster
                  , kind   = "Anti-World"
                  , hits   = 5
                  , effect = [ To Enemies Damage <| Range 300 500
                             , Grant Party 3 DefenseUp <| Flat 20
                             ]
                  , over   = [ Grant Self 1 NPUp <| Range 10 50 ]
                  , first  = True
                  }
    , limited   = True
    , free      = False
    , ascendUp  = Ascension
                  [(Piece Assassin, 5)]
                  [(Piece Assassin, 12), (DragonFang, 18)]
                  [(Monument Assassin, 5), (DeadlyPoisonousNeedle, 24), (SerpentJewel, 4)]
                  [(Monument Assassin, 12), (SerpentJewel, 8), (ScarabOfWisdom, 5)]
    , skillUp   = Reinforcement
                  [(GemOf Assassin, 5)]
                  [(GemOf Assassin, 12)]
                  [(MagicGemOf Assassin, 5)]
                  [(MagicGemOf Assassin, 12), (DeadlyPoisonousNeedle, 12)]
                  [(SecretGemOf Assassin, 5), (DeadlyPoisonousNeedle, 24)]
                  [(SecretGemOf Assassin, 12), (DragonFang, 12)]
                  [(DragonFang, 24), (PhoenixFeather, 5)]
                  [(PhoenixFeather, 15), (SpiritRoot, 10)]
    }
  ]
