module Database.Servant.Berserker exposing (berserkers)

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

berserkers : List Servant
berserkers =
  [ { name      = "Heracles"
    , spoiler   = Nothing
    , id        = 47
    , rarity    = 4
    , class     = Berserker
    , attr      = Sky
    , deck      = Deck Quick Arts Buster Buster Buster
    , curve     = 9
    , stats     = { base  = { atk = 1775,  hp = 1652 }
                  , max   = { atk = 10655, hp = 10327 }
                  , grail = { atk = 12901, hp = 12521 }
                  }
    , skills    = [ { name   = "Valor"
                    , rank   = APlus
                    , icon   = Icon.SwordUp
                    , cd     = 7
                    , effect = [ Grant Self 3 AttackUp <| Range 10.5 31
                               , Grant Self 3 MentalResist <| Range 21 42
                               ]
                    }
                  , { name   = "Mind's Eye (Fake)"
                    , rank   = B
                    , icon   = Icon.Dodge
                    , cd     = 8
                    , effect = [ Grant Self 1 Evasion Full
                              , Grant Self 3 CritUp <| Range 18 36
                              ]
                    }
                  , { name   = "Battle Continuation"
                    , rank   = A
                    , icon   = Icon.Kneel
                    , cd     = 9
                    , effect = [ Times 1 << Grant Self 5 Guts <| Range 1000 2500 ]
                    }
                  ]
    , passives  = [madness B, divinity A]
    , phantasm  = { name   = "Nine Lives"
                  , rank   = APlus
                  , card   = Buster
                  , kind   = "Unknown"
                  , hits   = 15
                  , effect = [ To Enemy Damage <| Range 600 1000 ]
                  , over   = [ Debuff Enemy 3 DefenseDown <| Range 10 30 ]
                  , first  = False
                  }
    , gen       = { starWeight = 10, starRate = 5, npAtk = 1.07, npDef = 5 }
    , hits      = { quick = 2, arts = 2, buster = 1, ex = 3 }
    , gender    = Male
    , traits    = [Argonaut, Humanoid, Divine, EnumaElish, GreekMythMale]
    , death     = 39
    , align     = [Chaotic, Mad]
    , limited   = False
    , free      = False
    , ascendUp  = Ascension
                  [(Piece Berserker, 4)]
                  [(Piece Berserker, 10), (OctupletCrystals, 6)]
                  [(Monument Berserker, 4), (ClawOfChaos, 3), (HeartOfTheForeignGod, 4)]
                  [(Monument Berserker, 10), (ClawOfChaos, 5), (DragonsReverseScale, 4)]
    , skillUp   = Reinforcement
                  [(GemOf Berserker, 4)]
                  [(GemOf Berserker, 10)]
                  [(MagicGemOf Berserker, 4)]
                  [(MagicGemOf Berserker, 10), (HeartOfTheForeignGod, 2)]
                  [(SecretGemOf Berserker, 4), (HeartOfTheForeignGod, 4)]
                  [(SecretGemOf Berserker, 10), (OctupletCrystals, 4)]
                  [(ProofOfHero, 15), (OctupletCrystals, 8)]
                  [(ProofOfHero, 45), (DragonsReverseScale, 8)]
    }
  , { name      = "Lancelot"
    , spoiler   = Nothing
    , id        = 48
    , rarity    = 4
    , class     = Berserker
    , attr      = Earth
    , deck      = Deck Quick Arts Buster Buster Buster
    , curve     = 14
    , stats     = { base  = { atk = 1746,  hp = 1652 }
                  , max   = { atk = 10477, hp = 10327 }
                  , grail = { atk = 12685, hp = 12521 }
                  }
    , skills    = [ { name   = "Eternal Arms Mastery"
                    , rank   = APlus
                    , icon   = Icon.StarUp
                    , cd     = 7
                    , effect = [ Grant Self 3 GatherUp <| Range 3000 6000 ]
                    }
                  , { name   = "Protection of the Spirits"
                    , rank   = A
                    , icon   = Icon.StarHaloUp
                    , cd     = 7
                    , effect = [ Grant Self 3 StarUp <| Range 10 30 ]
                    }
                  , { name   = "Mana Reversal"
                    , rank   = A
                    , icon   = Icon.NobleUp
                    , cd     = 7
                    , effect = [ Grant Self 1 NPGen <| Range 50 100
                               , Grant Self 3 CritUp <| Range 30 50
                               ]
                    }
                  ]
    , passives  = [magicResistance E, madness C]
    , phantasm  = { name   = "Knight of Owner"
                  , rank   = APlusPlus
                  , card   = Quick
                  , kind   = "Anti-Personnel"
                  , hits   = 10
                  , effect = [ To Enemies Damage <| Range 600 1000 ]
                  , over   = [ Grant Self 3 AttackUp <| Range 10 30 ]
                  , first  = True
                  }
    , gen       = { starWeight = 10, starRate = 5, npAtk = 0.5, npDef = 5 }
    , hits      = { quick = 2, arts = 2, buster = 1, ex = 3 }
    , gender    = Male
    , traits    = [Humanoid, EnumaElish]
    , death     = 52
    , align     = [Lawful, Mad]
    , limited   = False
    , free      = False
    , ascendUp  = Ascension
                  [(Piece Berserker, 4)]
                  [(Piece Berserker, 10), (DragonsReverseScale, 3)]
                  [(Monument Berserker, 4), (ClawOfChaos, 5), (VoidsDust, 8)]
                  [(Monument Berserker, 10), (DragonFang, 24), (VoidsDust, 16)]
    , skillUp   = Reinforcement
                  [(GemOf Berserker, 4)]
                  [(GemOf Berserker, 10)]
                  [(MagicGemOf Berserker, 4)]
                  [(MagicGemOf Berserker, 10), (ClawOfChaos, 3)]
                  [(SecretGemOf Berserker, 4), (ClawOfChaos, 5)]
                  [(SecretGemOf Berserker, 10), (DragonsReverseScale, 2)]
                  [(MeteorHorseshoe, 5), (DragonsReverseScale, 4)]
                  [(MeteorHorseshoe, 15), (DragonFang, 48)]
    }
  , { name      = "Lu Bu Fengxian"
    , spoiler   = Nothing
    , id        = 49
    , rarity    = 3
    , class     = Berserker
    , attr      = Human
    , deck      = Deck Quick Arts Buster Buster Buster
    , curve     = 8
    , stats     = { base  = { atk = 1507,  hp = 1494 }
                  , max   = { atk = 8119,  hp = 8302 }
                  , grail = { atk = 10988, hp = 11256 }
                  }
    , skills    = [ { name   = "Valor"
                    , rank   = B
                    , icon   = Icon.SwordUp
                    , cd     = 7
                    , effect = [ Grant Self 3 AttackUp <| Range 9 27
                               , Grant Self 3 MentalResist <| Range 18 36
                               ]
                    }
                  , { name   = "Defiant"
                    , rank   = B
                    , icon   = Icon.SwordUp
                    , cd     = 7
                    , effect = [ Grant Self 3 DefenseUp <| Range 15 25
                               , Debuff Self 3 AttackBuffDown <| Flat 50
                               ]
                    }
                  , { name   = "Chaotic Villain"
                    , rank   = A
                    , icon   = Icon.BeamUp
                    , cd     = 8
                    , effect = [ Grant Self 1 NPUp <| Range 20 30
                               , Grant Self 1 GatherUp <| Flat 3000
                               , Debuff Others 1 DefenseDown <| Flat 20
                               ]
                    }
                  ]
    , passives  = [madness A]
    , phantasm  = { name   = "God Force"
                  , rank   = A
                  , card   = Buster
                  , kind   = "Anti-Personnel/Anti-Army/Anti-Fortress"
                  , hits   = 1
                  , effect = [ To Enemy DamageThruDef <| Range 600 1000 ]
                  , over   = [ Chances 30 70 <| Debuff Enemy 1 Stun Full ]
                  , first  = False
                  }
    , gen       = { starWeight = 9, starRate = 5, npAtk = 1.04, npDef = 5 }
    , hits      = { quick = 2, arts = 2, buster = 1, ex = 3 }
    , gender    = Male
    , traits    = [Humanoid, EnumaElish]
    , death     = 50.3
    , align     = [Chaotic, Evil]
    , limited   = False
    , free      = True
    , ascendUp  = Ascension
                  [(Piece Berserker, 4)]
                  [(Piece Berserker, 8), (MeteorHorseshoe, 5)]
                  [(Monument Berserker, 4), (ClawOfChaos, 2), (EvilBone, 20)]
                  [(Monument Berserker, 8), (ClawOfChaos, 4), (VoidsDust, 16)]
    , skillUp   = Reinforcement
                  [(GemOf Berserker, 4)]
                  [(GemOf Berserker, 8)]
                  [(MagicGemOf Berserker, 4)]
                  [(MagicGemOf Berserker, 8), (EvilBone, 10)]
                  [(SecretGemOf Berserker, 4), (EvilBone, 20)]
                  [(SecretGemOf Berserker, 8), (MeteorHorseshoe, 4)]
                  [(OctupletCrystals, 4), (MeteorHorseshoe, 7)]
                  [(OctupletCrystals, 12), (VoidsDust, 32)]
    }
  , { name      = "Spartacus"
    , spoiler   = Nothing
    , id        = 50
    , rarity    = 1
    , class     = Berserker
    , attr      = Human
    , deck      = Deck Quick Arts Buster Buster Buster
    , curve     = 6
    , stats     = { base  = { atk = 922,  hp = 1544 }
                  , max   = { atk = 5073, hp = 7722 }
                  , grail = { atk = 7883, hp = 11904 }
                  }
    , skills    = [ { name   = "Honor of Suffering"
                    , rank   = BPlus
                    , icon   = Icon.HealTurn
                    , cd     = 9
                    , effect = [ Grant Self 5 HealPerTurn <| Range 500 1500 ]
                    }
                  , { name   = "Unyielding Will"
                    , rank   = A
                    , icon   = Icon.Kneel
                    , cd     = 7
                    , effect = [ Times 1 << Grant Self 5 Guts <| Flat 1
                               , To Self GaugeUp <| Range 10 30
                               ]
                    }
                  , { name   = "Triumphant Return of the Sword"
                    , rank   = B
                    , icon   = Icon.BusterUp
                    , cd     = 8
                    , effect = [ Grant Self 1 (CardUp Buster) <| Range 20 40
                               , To Self Heal <| Range 1000 2000
                               ]
                    }
                  ]
    , passives  = [madness EX]
    , phantasm  = { name   = "Crying Warmonger"
                  , rank   = APlus
                  , card   = Buster
                  , kind   = "Anti-Personnel"
                  , hits   = 1
                  , effect = [ To Enemies DamageThruDef <| Range 400 600 ]
                  , over   = [ To Self Heal <| Range 4000 8000 ]
                  , first  = False
                  }
    , gen       = { starWeight = 9, starRate = 4.9, npAtk = 1.01, npDef = 5 }
    , hits      = { quick = 2, arts = 2, buster = 1, ex = 3 }
    , gender    = Male
    , traits    = [Humanoid, Roman, EnumaElish]
    , death     = 65
    , align     = [Neutral, Balanced]
    , limited   = False
    , free      = True
    , ascendUp  = Ascension
                  [(Piece Berserker, 2)]
                  [(Piece Berserker, 4), (OctupletCrystals, 3)]
                  [(Monument Berserker, 2), (HomunculusBaby, 2), (ProofOfHero, 10)]
                  [(Monument Berserker, 4), (HomunculusBaby, 4), (EvilBone, 12)]
    , skillUp   = Reinforcement
                  [(GemOf Berserker, 2)]
                  [(GemOf Berserker, 4)]
                  [(MagicGemOf Berserker, 2)]
                  [(MagicGemOf Berserker, 4), (ProofOfHero, 5)]
                  [(SecretGemOf Berserker, 2), (ProofOfHero, 10)]
                  [(SecretGemOf Berserker, 4), (OctupletCrystals, 2)]
                  [(SeedOfYggdrasil, 3), (OctupletCrystals, 4)]
                  [(SeedOfYggdrasil, 8), (EvilBone, 24)]
    }
  , { name      = "Sakata Kintoki"
    , spoiler   = Nothing
    , id        = 51
    , rarity    = 5
    , class     = Berserker
    , attr      = Human
    , deck      = Deck Quick Arts Buster Buster Buster
    , curve     = 9
    , stats     = { base  = { atk = 1964,  hp = 1782 }
                  , max   = { atk = 12712, hp = 12150 }
                  , grail = { atk = 13915, hp = 13311 }
                  }
    , skills    = [ { name   = "Monstrous Strength"
                    , rank   = APlus
                    , icon   = Icon.SwordUp
                    , cd     = 7
                    , effect = [ Grant Self 1 AttackUp <| Range 30 50 ]
                    }
                  , { name   = "Animal Communication"
                    , rank   = C
                    , icon   = Icon.Noble
                    , cd     = 8
                    , effect = [ To Self GaugeUp <| Range 30 50 ]
                    }
                  , { name   = "Natural Body"
                    , rank   = A
                    , icon   = Icon.HoodUp
                    , cd     = 7
                    , effect = [ Grant Self 3 OffensiveResist <| Range 60 120
                               , To Self Heal <| Range 1000 3000
                               ]
                    }
                  ]
    , passives  = [madness E, divinity D]
    , phantasm  = { name   = "Golden Spark"
                  , rank   = CMinus
                  , card   = Buster
                  , kind   = "Anti-Personnel"
                  , hits   = 1
                  , effect = [ To Enemy DamageThruDef <| Range 600 1000 ]
                  , over   = [ Chances 50 100 <| Debuff Enemy 1 Stun Full ]
                  , first  = False
                  }
    , gen       = { starWeight = 9, starRate = 5, npAtk = 1.03, npDef = 5 }
    , hits      = { quick = 2, arts = 2, buster = 1, ex = 3 }
    , gender    = Male
    , traits    = [Humanoid, Divine, LovedOne, EnumaElish]
    , death     = 52
    , align     = [Lawful, Good]
    , limited   = True
    , free      = False
    , ascendUp  = Ascension
                  [(Piece Berserker, 5)]
                  [(Piece Berserker, 12), (ProofOfHero, 22)]
                  [(Monument Berserker, 5), (OctupletCrystals, 10), (SeedOfYggdrasil, 6)]
                  [( Monument Berserker, 12), (SeedOfYggdrasil, 12), (HeartOfTheForeignGod, 5)]
    , skillUp   = Reinforcement
                  [(GemOf Berserker, 5)]
                  [(GemOf Berserker, 12)]
                  [(MagicGemOf Berserker, 5)]
                  [(MagicGemOf Berserker, 12), (OctupletCrystals, 5)]
                  [(SecretGemOf Berserker, 5), (OctupletCrystals, 10)]
                  [(SecretGemOf Berserker, 12), (ProofOfHero, 15)]
                  [(ProofOfHero, 29), (VoidsDust, 12)]
                  [(VoidsDust, 36), (HeartOfTheForeignGod, 10)]
    }
  , { name      = "Vlad III"
    , spoiler   = Nothing
    , id        = 52
    , rarity    = 5
    , class     = Berserker
    , attr      = Earth
    , deck      = Deck Quick Arts Arts Buster Buster
    , curve     = 15
    , stats     = { base  = { atk = 1777,  hp = 2019 }
                  , max   = { atk = 11499, hp = 13770 }
                  , grail = { atk = 12587, hp = 15086 }
                  }
    , skills    = [ { name   = "Vampirism"
                    , rank   = A
                    , icon   = Icon.MagicDark
                    , cd     = 8
                    , effect = [ Chances 80 100 << To Enemy GaugeDown <| Flat 1
                               , To Self GaugeUp <| Range 20 30
                               ]
                    }
                  , { name   = "Legend of Dracula"
                    , rank   = APlus
                    , icon   = Icon.ShieldUp
                    , cd     = 7
                    , effect = [ Grant Self 3 DefenseUp <| Range 20 30
                               , Grant Self 3 AttackUp <| Range 20 30
                               ]
                    }
                  , { name   = "Battle Continuation"
                    , rank   = A
                    , icon   = Icon.Kneel
                    , cd     = 9
                    , effect = [ Times 1 << Grant Self 5 Guts <| Range 1000 2500 ]
                    }
                  ]
    , passives  = [madness EX]
    , phantasm  = { name   = "Kazikli Bey"
                  , rank   = CPlus
                  , card   = Arts
                  , kind   = "Anti-Personnel"
                  , hits   = 10
                  , effect = [ To Enemy Damage <| Range 900 1500 ]
                  , over   = [ To Party GainStars <| Range 20 40 ]
                  , first  = False
                  }
    , gen       = { starWeight = 9, starRate = 4.9, npAtk = 0.5, npDef = 5 }
    , hits      = { quick = 2, arts = 2, buster = 1, ex = 3 }
    , gender    = Male
    , traits    = [Humanoid, EnumaElish, LovedOne, King]
    , death     = 45.5
    , align     = [Chaotic, Evil]
    , limited   = False
    , free      = False
    , ascendUp  = Ascension
                  [(Piece Berserker, 5)]
                  [(Piece Berserker, 12), (DragonsReverseScale, 3)]
                  [(Monument Berserker, 5), (ClawOfChaos, 6), (ForbiddenPage, 5)]
                  [(Monument Berserker, 12), (VoidsDust, 24), (ForbiddenPage, 10)]
    , skillUp   = Reinforcement
                  [(GemOf Berserker, 5)]
                  [(GemOf Berserker, 12)]
                  [(MagicGemOf Berserker, 5)]
                  [(MagicGemOf Berserker, 12), (ClawOfChaos, 3)]
                  [(SecretGemOf Berserker, 5), (ClawOfChaos, 6)]
                  [(SecretGemOf Berserker, 12), (DragonsReverseScale, 2)]
                  [(DragonsReverseScale, 4), (EvilBone, 18)]
                  [(VoidsDust, 48), (EvilBone, 54)]
    }
  , { name      = "Asterios"
    , spoiler   = Nothing
    , id        = 53
    , rarity    = 1
    , class     = Berserker
    , attr      = Earth
    , deck      = Deck Quick Arts Buster Buster Buster
    , curve     = 1
    , stats     = { base  = { atk = 1097, hp = 1320 }
                  , max   = { atk = 6037, hp = 6604 }
                  , grail = { atk = 9381, hp = 10181 }
                  }
    , skills    = [ { name   = "Monstrous Strength"
                    , rank   = A
                    , icon   = Icon.SwordUp
                    , cd     = 7
                    , effect = [ Grant Self 3 AttackUp <| Range 10 30 ]
                    }
                  , { name   = "Natural Demon"
                    , rank   = APlusPlus
                    , icon   = Icon.HoodUp
                    , cd     = 7
                    , effect = [ Grant Self 3 OffensiveResist <| Range 50 100
                               , Grant Self 3 DefenseUp <| Range 20 40
                               ]
                    }
                  , { name   = "Labrys of the Abyss"
                    , rank   = C
                    , icon   = Icon.StarUp
                    , cd     = 7
                    , effect = [ Grant Self 1 GatherUp <| Range 3000 6000
                               , Grant Self 1 (CardUp Buster) <| Range 20 30
                               ]
                    }
                  ]
    , passives  = [madness B]
    , phantasm  = { name   = "Chaos Labyrinth"
                  , rank   = EX
                  , card   = Arts
                  , kind   = "Maze"
                  , hits   = 0
                  , effect = [ Debuff Enemies 6 AttackDown <| Range 10 20
                             , Debuff Enemies 1 AttackDown <| Flat 40
                             , Debuff Enemies 1 DefenseDown <| Flat 40
                             ]
                  , over   = [ Debuff Enemies 6 DefenseDown <| Range 10 30 ]
                  , first  = False
                  }
    , gen       = { starWeight = 9, starRate = 4.9, npAtk = 0.68, npDef = 5 }
    , hits      = { quick = 2, arts = 3, buster = 1, ex = 3 }
    , gender    = Male
    , traits    = [Humanoid, EnumaElish, GreekMythMale]
    , death     = 58.5
    , align     = [Chaotic, Evil]
    , limited   = False
    , free      = True
    , ascendUp  = Ascension
                  [(Piece Berserker, 2)]
                  [(OctupletCrystals, 3), (Piece Berserker, 4)]
                  [(MeteorHorseshoe, 2), (ProofOfHero, 10), (Monument Berserker, 2)]
                  [(MeteorHorseshoe, 4), (SeedOfYggdrasil, 5), (Monument Berserker, 4)]
    , skillUp   = Reinforcement
                  [(GemOf Berserker, 2)]
                  [(GemOf Berserker, 4)]
                  [(MagicGemOf Berserker, 2)]
                  [(MagicGemOf Berserker, 4), (ProofOfHero, 5)]
                  [(SecretGemOf Berserker, 2), (ProofOfHero, 10)]
                  [(SecretGemOf Berserker, 4), (OctupletCrystals, 2)]
                  [(VoidsDust, 4), (OctupletCrystals, 4)]
                  [(SeedOfYggdrasil, 10), (VoidsDust, 12)]
    }
  , { name      = "Caligula"
    , spoiler   = Nothing
    , id        = 54
    , rarity    = 2
    , class     = Berserker
    , attr      = Human
    , deck      = Deck Quick Arts Buster Buster Buster
    , curve     = 12
    , stats     = { base  = { atk = 1374, hp = 1211 }
                  , max   = { atk = 6831, hp = 7303 }
                  , grail = { atk = 9899, hp = 10540 }
                  }
    , skills    = [ { name   = "Sadistic Streak"
                    , rank   = A
                    , icon   = Icon.SwordUp
                    , cd     = 7
                    , effect = [ Grant Self 3 AttackUp <| Range 10 30
                               , Debuff Self 3 DefenseDown <| Flat 10
                               ]
                    }
                  , { name   = "Imperial Privilege"
                    , rank   = A
                    , icon   = Icon.Heal
                    , cd     = 7
                    , effect = [ To Self Heal <| Range 1000 3000
                               , Chance 60 << Grant Self 3 AttackUp <| Range 20 40
                               , Chance 60 << Grant Self 3 DefenseUp <| Range 20 40
                               ]
                    }
                  , { name   = "Glory of Past Days"
                    , rank   = B
                    , icon   = Icon.BusterUp
                    , cd     = 5
                    , effect = [ Grant Self 1 (CardUp Buster) <| Range 30 50
                               , To Self DemeritHealth <| Flat 500
                               ]
                    }
                  ]
    , passives  = [madness APlus]
    , phantasm  = { name   = "Flucticulus Diana"
                  , rank   = C
                  , card   = Arts
                  , kind   = "Anti-Army"
                  , hits   = 0
                  , effect = [ Chances 100 150 <| Debuff Enemies 3 SealSkills Full ]
                  , over   = [ Chances 70 90 <| Debuff Enemies 3 SealNP Full ]
                  , first  = False
                  }
    , gen       = { starWeight = 9, starRate = 5, npAtk = 0.68, npDef = 5 }
    , hits      = { quick = 2, arts = 3, buster = 1, ex = 3 }
    , gender    = Male
    , traits    = [Humanoid, Roman, EnumaElish, King]
    , death     = 56.8
    , align     = [Chaotic, Evil]
    , limited   = False
    , free      = True
    , ascendUp  = Ascension
                  [(Piece Berserker, 3)]
                  [(Piece Berserker, 6), (OctupletCrystals, 4)]
                  [(Monument Berserker, 3), (GhostLantern, 3), (SerpentJewel, 4)]
                  [(Monument Berserker, 6), (GhostLantern, 5), (ForbiddenPage, 6)]
    , skillUp   = Reinforcement
                  [(GemOf Berserker, 3)]
                  [(GemOf Berserker, 6)]
                  [(MagicGemOf Berserker, 3)]
                  [(MagicGemOf Berserker, 6), (SerpentJewel, 2)]
                  [(SecretGemOf Berserker, 3), (SerpentJewel, 4)]
                  [(SecretGemOf Berserker, 6), (OctupletCrystals, 3)]
                  [(MeteorHorseshoe, 3), (OctupletCrystals, 5)]
                  [(MeteorHorseshoe, 9), (ForbiddenPage, 12)]
    }
  , { name      = "Darius III"
    , spoiler   = Nothing
    , id        = 55
    , rarity    = 3
    , class     = Berserker
    , attr      = Human
    , deck      = Deck Quick Arts Buster Buster Buster
    , curve     = 3
    , stats     = { base  = { atk = 1412,  hp = 1577 }
                  , max   = { atk = 7608,  hp = 8763 }
                  , grail = { atk = 10297, hp = 11881 }
                  }
    , skills    = [ { name  = "Golden Rule"
                    , rank   = B
                    , icon    = Icon.NobleUp
                    , cd      = 8
                    , effect = [ Grant Self 3 NPGen <| Range 18 45 ]
                    }
                  , { name    = "Disengage"
                    , rank   = A
                    , icon    = Icon.Heal
                    , cd      = 7
                    , effect = [ To Self RemoveDebuffs Full
                              , To Self Heal <| Range 1000 2500
                              ]
                    }
                  , { name    = "Battle Continuation"
                    , rank   = A
                    , icon    = Icon.Kneel
                    , cd      = 9
                    , effect = [ Times 1 << Grant Self 5 Guts <| Range 1000 2500 ]
                    }
                  ]
    , passives  = [madness B]
    , phantasm  = { name   = "Athanaton Ten Thousand"
                  , rank   = APlus
                  , card   = Buster
                  , kind   = "Anti-Army"
                  , hits   = 10
                  , effect = [ To Enemies Damage <| Range 400 600 ]
                  , over   = [ Debuff Enemies 3 AttackDown <| Range 10 30
                             , Debuff Enemies 3 DefenseDown <| Range 10 30
                             ]
                  , first  = False
                  }
    , gen       = { starWeight = 9, starRate = 5, npAtk = 0.67, npDef = 5 }
    , hits      = { quick = 2, arts = 3, buster = 1, ex = 3 }
    , gender    = Male
    , traits    = [Humanoid, EnumaElish, King]
    , death     = 65
    , align     = [Lawful, Balanced]
    , limited   = False
    , free      = True
    , ascendUp  = Ascension
                  [(Piece Berserker, 4)]
                  [(Piece Berserker, 8), (OctupletCrystals, 5)]
                  [(Monument Berserker, 4), (EvilBone, 10), (PhoenixFeather, 6)]
                  [(Monument Berserker, 8), (EvilBone, 20), (MeteorHorseshoe, 8)]
    , skillUp   = Reinforcement
                  [(GemOf Berserker, 4)]
                  [(GemOf Berserker, 8)]
                  [(MagicGemOf Berserker, 4)]
                  [(MagicGemOf Berserker, 8), (PhoenixFeather, 3)]
                  [(SecretGemOf Berserker, 4), (PhoenixFeather, 6)]
                  [(SecretGemOf Berserker, 8), (OctupletCrystals, 4)]
                  [(VoidsDust, 8), (OctupletCrystals, 7)]
                  [(VoidsDust, 24), (MeteorHorseshoe, 16)]
    }
  , { name      = "Kiyohime"
    , spoiler   = Nothing
    , id        = 56
    , rarity    = 3
    , class     = Berserker
    , attr      = Earth
    , deck      = Deck Quick Arts Buster Buster Buster
    , curve     = 3
    , stats     = { base  = { atk = 1233, hp = 1649 }
                  , max   = { atk = 6644, hp = 9166 }
                  , grail = { atk = 8992, hp = 12428 }
                  }
    , skills    = [ { name   = "Morph"
                    , rank   = C
                    , icon   = Icon.ShieldUp
                    , cd     = 7
                    , effect = [ Grant Self 3 DefenseUp <| Range 16 24 ]
                    }
                  , { name   = "Stalking"
                    , rank   = B
                    , icon   = Icon.ShieldDown
                    , cd     = 7
                    , effect = [ Debuff Enemy 4 DefenseDown <| Range 12 24
                               , Grant Enemy 3 AttackUp <| Flat 20
                               ]
                    }
                  , { name   = "Flame-Coloured Kiss"
                    , rank   = A
                    , icon   = Icon.BusterUp
                    , cd     = 7
                    , effect = [ Grant Self 1 (CardUp Buster) <| Range 20 30
                               , To Self RemoveDebuffs Full
                               ]
                    }
                  ]
    , passives  = [madness EX]
    , phantasm  = { name   = "Transforming, Flame-Emitting Meditation"
                  , rank   = EX
                  , card   = Buster
                  , kind   = "Anti-Personnel"
                  , hits   = 3
                  , effect = [ To Enemies Damage <| Range 300 500 ]
                  , over   = [ Chances 50 80 <| Debuff Enemies 1 Stun Full
                             , Debuff Enemies 10 Burn <| Range 500 900
                             ]
                  , first  = False
                  }
    , gen       = { starWeight = 9, starRate = 4.9, npAtk = 2.03, npDef = 5 }
    , hits      = { quick = 2, arts = 1, buster = 1, ex = 3 }
    , gender    = Female
    , traits    = [Humanoid, Dragon, EnumaElish]
    , death     = 65
    , align     = [Chaotic, Evil]
    , limited   = False
    , free      = True
    , ascendUp  = Ascension
                  [(Piece Berserker, 4)]
                  [(Piece Berserker, 8), (GhostLantern, 5)]
                  [(Monument Berserker, 4), (EvilBone, 20), (DragonFang, 8)]
                  [(Monument Berserker, 8), (DragonsReverseScale, 4), (DragonFang, 16)]
    , skillUp   = Reinforcement
                  [(GemOf Berserker, 4)]
                  [(GemOf Berserker, 8)]
                  [(MagicGemOf Berserker, 4)]
                  [(MagicGemOf Berserker, 8), (EvilBone, 10)]
                  [(SecretGemOf Berserker, 4), (EvilBone, 20)]
                  [(SecretGemOf Berserker, 8), (GhostLantern, 4)]
                  [(SeedOfYggdrasil, 5), (GhostLantern, 7)]
                  [(SeedOfYggdrasil, 15), (DragonsReverseScale, 7)]
    }
  , { name      = "Eric Bloodaxe"
    , spoiler   = Nothing
    , id        = 57
    , rarity    = 2
    , class     = Berserker
    , attr      = Human
    , deck      = Deck Quick Arts Buster Buster Buster
    , curve     = 2
    , stats     = { base  = { atk = 1116, hp = 1447 }
                  , max   = { atk = 6290, hp = 7688 }
                  , grail = { atk = 9115, hp = 11095 }
                  }
    , skills    = [ { name   = "Supporting Curse"
                    , rank   = CPlus
                    , icon   = Icon.SwordDown
                    , cd     = 7
                    , effect = [ Debuff Enemy 2 AttackDown <| Range 5 15
                               , Debuff Enemy 2 DefenseDown <| Range 10 30
                               ]
                    }
                  , { name   = "Battle Continuation"
                    , rank   = B
                    , icon   = Icon.Kneel
                    , cd     = 9
                    , effect = [ Times 1 << Grant Self 4 Guts <| Range 750 2000 ]
                    }
                  , { name   = "Half-Dead Bloodaxe"
                    , rank   = APlus
                    , icon   = Icon.Bubbles
                    , cd     = 8
                    , effect = [ To Self RemoveDebuffs Full
                               , Grant Self 3 HPUp <| Range 1000 3000
                               ]
                  }
                  ]
    , passives  = [madness B]
    , phantasm  = { name   = "Bloodbath Crown"
                  , rank   = B
                  , card   = Buster
                  , kind   = "Anti-Personnel"
                  , hits   = 5
                  , effect = [ To Enemies Damage <| Range 300 500
                             , To Self DemeritDamage <| Flat 1000
                             ]
                  , over   = [ Grant Self 1 AttackUp <| Range 30 50 ]
                  , first  = True
                  }
    , gen       = { starWeight = 9, starRate = 4.9, npAtk = 1.02, npDef = 5 }
    , hits      = { quick = 2, arts = 2, buster = 1, ex = 3 }
    , gender    = Male
    , traits    = [Humanoid, EnumaElish, King]
    , death     = 58.5
    , align     = [Chaotic, Balanced]
    , limited   = False
    , free      = True
    , ascendUp  = Ascension
                  [(Piece Berserker, 3)]
                  [(Piece Berserker, 6), (EvilBone, 11)]
                  [(Monument Berserker, 3), (SerpentJewel, 2), (HomunculusBaby, 5)]
                  [(Monument Berserker, 6), (SerpentJewel, 4), (VoidsDust, 12)]
    , skillUp   = Reinforcement
                  [(GemOf Berserker, 3)]
                  [(GemOf Berserker, 6)]
                  [(MagicGemOf Berserker, 3)]
                  [(MagicGemOf Berserker, 6), (HomunculusBaby, 3)]
                  [(SecretGemOf Berserker, 3), (HomunculusBaby, 5)]
                  [(SecretGemOf Berserker, 6), (EvilBone, 8)]
                  [(ClawOfChaos, 2), (EvilBone, 15)]
                  [(ClawOfChaos, 6), (VoidsDust, 24)]
    }
  , { name      = "Tamamo Cat"
    , spoiler   = Nothing
    , id        = 58
    , rarity    = 4
    , class     = Berserker
    , attr      = Earth
    , deck      = Deck Quick Arts Buster Buster Buster
    , curve     = 9
    , stats     = { base  = { atk = 1504,  hp = 1833 }
                  , max   = { atk = 9026,  hp = 11458 }
                  , grail = { atk = 10929, hp = 13893 }
                  }
    , skills    = [ { name   = "Monstrous Strength"
                    , rank   = B
                    , icon   = Icon.SwordUp
                    , cd     = 7
                    , effect = [ Grant Self 2 AttackUp <| Range 10 30 ]
                    }
                  , { name   = "Curse"
                    , rank   = E
                    , icon   = Icon.MagicDark
                    , cd     = 7
                    , effect = [ Chances 40 60 << To Enemy GaugeDown <| Flat 1 ]
                    }
                  , { name   = "Morph"
                    , rank   = B
                    , icon   = Icon.ShieldUp
                    , cd     = 7
                    , effect = [ Grant Self 3 DefenseUp <| Range 18 27 ]
                    }
                  ]
    , passives  = [madness C]
    , phantasm  = { name   = "Napping in the Dazzling Sunshine and Feasting"
                  , rank   = DPlus
                  , card   = Quick
                  , kind   = "Anti-Personnel"
                  , hits   = 5
                  , effect = [ To Enemies Damage <| Range 800 1200
                             , Chance 500 <| Debuff Self 2 Stun Full
                             ]
                  , over   = [ Grant Self 3 HealPerTurn <| Range 3000 7000 ]
                  , first  = False
                  }
    , gen       = { starWeight = 10, starRate = 5, npAtk = 0.71, npDef = 5 }
    , hits      = { quick = 2, arts = 3, buster = 2, ex = 3 }
    , gender    = Female
    , traits    = [Humanoid, WildBeast, EnumaElish]
    , death     = 39
    , align     = [Chaotic, Good]
    , limited   = False
    , free      = False
    , ascendUp  = Ascension
                  [(Piece Berserker, 4)]
                  [(Piece Berserker, 10), (GhostLantern, 6)]
                  [(Monument Berserker, 4), (HomunculusBaby, 8), (ClawOfChaos, 3)]
                  [(Monument Berserker, 10), (ClawOfChaos, 5), (HeartOfTheForeignGod, 4)]
    , skillUp   = Reinforcement
                  [(GemOf Berserker, 4)]
                  [(GemOf Berserker, 10)]
                  [(MagicGemOf Berserker, 4)]
                  [(MagicGemOf Berserker, 10), (HomunculusBaby, 4)]
                  [(SecretGemOf Berserker, 4), (HomunculusBaby, 8)]
                  [(SecretGemOf Berserker, 10), (GhostLantern, 4)]
                  [(GhostLantern, 8), (OctupletCrystals, 5)]
                  [(OctupletCrystals, 15), (HeartOfTheForeignGod, 8)]
    }
  , { name      = "Frankenstein"
    , spoiler   = Nothing
    , id        = 82
    , rarity    = 4
    , class     = Berserker
    , attr      = Earth
    , deck      = Deck Quick Arts Buster Buster Buster
    , curve     = 24
    , stats     = { base  = { atk = 1573,  hp = 1710 }
                  , max   = { atk = 9441, hp = 10687 }
                  , grail = { atk = 11431, hp = 12958 }
                  }
    , skills    = [ { name  = "Galvanism"
                    , rank   = B
                    , icon    = Icon.NobleUp
                    , cd      = 7
                    , effect = [ Grant Self 3 NPGen <| Range 25 45 ]
                    }
                  , { name    = "Wail of the Living Dead"
                    , rank   = C
                    , icon    = Icon.Stun
                    , cd      = 8
                    , effect = [ Chance 60 <| Debuff Enemy 1 Stun Full
                              , Debuff Enemy 1 DefenseDown <| Range 20 30
                              ]
                    }
                  , { name    = "Overload"
                    , rank   = C
                    , icon    = Icon.BeamUp
                    , cd      = 7
                    , effect = [ Grant Self 1 NPUp <| Range 20 30
                              , Debuff Self 5 Burn <| Flat 300
                              ]
                    }
                  ]
    , passives  = [madness D]
    , phantasm  = { name   = "Blasted Tree"
                  , rank   = BPlus
                  , card   = Quick
                  , kind   = "Anti-Army"
                  , hits   = 5
                  , effect = [ To Enemies Damage <| Range 900 1300
                             , Chance 500 <| Debuff Self 2 Stun Full
                             ]
                  , over   = [ Debuff Enemies 3 CritChance <| Range 20 40 ]
                  , first  = False
                  }
    , gen       = { starWeight = 10, starRate = 4.9, npAtk = 0.83, npDef = 5 }
    , hits      = { quick = 2, arts = 2, buster = 1, ex = 3 }
    , gender    = Female
    , traits    = [Humanoid, EnumaElish]
    , death     = 58.5
    , align     = [Chaotic, Balanced]
    , limited   = False
    , free      = False
    , ascendUp  = Ascension
                  [(Piece Berserker, 4)]
                  [(Piece Berserker, 10), (HomunculusBaby, 6)]
                  [(Monument Berserker, 4), (GhostLantern, 4), (EvilBone, 24)]
                  [(Monument Berserker, 10), (GhostLantern, 8), (EternalGear, 10)]
    , skillUp   = Reinforcement
                  [(GemOf Berserker, 4)]
                  [(GemOf Berserker, 10)]
                  [(MagicGemOf Berserker, 4)]
                  [(MagicGemOf Berserker, 10), (EvilBone, 12)]
                  [(SecretGemOf Berserker, 4), (EvilBone, 24)]
                  [(SecretGemOf Berserker, 10), (HomunculusBaby, 5)]
                  [(OctupletCrystals, 5), (HomunculusBaby, 8)]
                  [(OctupletCrystals, 15), (EternalGear, 20)]
    }
  , { name      = "Beowulf"
    , spoiler   = Nothing
    , id        = 89
    , rarity    = 4
    , class     = Berserker
    , attr      = Earth
    , deck      = Deck Quick Arts Buster Buster Buster
    , curve     = 4
    , stats     = { base  = { atk = 1707,  hp = 1652 }
                  , max   = { atk = 10247, hp = 10327 }
                  , grail = { atk = 12407, hp = 12521 }
                  }
    , skills    = [ { name  = "Berserk"
                    , rank   = A
                    , icon    = Icon.SwordUp
                    , cd      = 7
                    , effect = [ Grant Self 1 AttackUp <| Range 20 30
                              , Grant Self 1 NPUp <| Range 10 20
                              ]
                    }
                  , { name    = "Intuition"
                    , rank   = B
                    , icon    = Icon.Star
                    , cd      = 7
                    , effect = [ To Party GainStars <| Range 4 14 ]
                    }
                  , { name    = "Battle Continuation"
                    , rank   = B
                    , icon    = Icon.Kneel
                    , cd      = 9
                    , effect = [ Times 1 << Grant Self 4 Guts <| Range 750 2000 ]
                    }
                  ]
    , passives  = [madness EMinus]
    , phantasm  = { name   = "Grendel Buster"
                  , rank   = APlusPlus
                  , card   = Buster
                  , kind   = "Anti-Personnel"
                  , hits   = 12
                  , effect = [ Grant Self 1 SureHit Full
                             , To Enemy Damage <| Range 700 1100
                             ]
                  , over   = [ Debuff Enemy 3 CritChance <| Range 30 50 ]
                  , first  = False
                  }
    , gen       = { starWeight = 10, starRate = 4.9, npAtk = 0.68, npDef = 5 }
    , hits      = { quick = 3, arts = 3, buster = 1, ex = 4 }
    , gender    = Male
    , traits    = [Humanoid, EnumaElish, LovedOne, King]
    , death     = 58.5
    , align     = [Chaotic, Good]
    , limited   = False
    , free      = False
    , ascendUp  = Ascension
                  [(Piece Berserker, 4)]
                  [(Piece Berserker, 10), (ProofOfHero, 18)]
                  [( Monument Berserker, 4), (DragonsReverseScale, 2), (OctupletCrystals, 8)]
                  [(Monument Berserker, 10), (DragonsReverseScale, 4), (EvilBone, 30)]
    , skillUp   = Reinforcement
                  [(GemOf Berserker, 4)]
                  [(GemOf Berserker, 10)]
                  [(MagicGemOf Berserker, 4)]
                  [(MagicGemOf Berserker, 10), (OctupletCrystals, 4)]
                  [(SecretGemOf Berserker, 4), (OctupletCrystals, 8)]
                  [(SecretGemOf Berserker, 10), (ProofOfHero, 12)]
                  [(SeedOfYggdrasil, 6), (ProofOfHero, 24)]
                  [(SeedOfYggdrasil, 18), (DragonFang, 48)]
    }
  , { name      = "Florence Nightingale"
    , spoiler   = Nothing
    , id        = 97
    , rarity    = 5
    , class     = Berserker
    , attr      = Human
    , deck      = Deck Quick Arts Arts Buster Buster
    , curve     = 30
    , stats     = { base  = { atk = 1573,  hp = 2232 }
                  , max   = { atk = 10184, hp = 15221 }
                  , grail = { atk = 11148, hp = 16675 }
                  }
    , skills    = [ { name   = "Nurse of Steel"
                    , rank   = A
                    , icon   = Icon.Heal
                    , cd     = 7
                    , effect = [ To Ally Heal <| Range 2000 4000 ]
                    }
                  , { name   = "Understanding of the Human Body"
                    , rank   = A
                    , icon   = Icon.DamageUp
                    , cd     = 8
                    , effect = [ Grant Self 3 (Special AttackUp <| VsTrait Humanoid) <| Range 30 50
                               , Grant Self 3 (Special DefenseUp <| VsTrait Humanoid) <| Range 15 25
                               ]
                    }
                  , { name   = "Angel's Cry"
                    , rank   = EX
                    , icon   = Icon.BusterUp
                    , cd     = 7
                    , effect = [ Grant Ally 3 (CardUp Buster) <| Range 30 50 ]
                    }
                  ]
    , passives  = [madness EX]
    , phantasm  = { name   = "Nightingale Pledge"
                  , rank   = CPlus
                  , card   = Arts
                  , kind   = "Anti-Army"
                  , hits   = 0
                  , effect = [ Debuff Enemies 1 AttackDown <| Flat 50
                             , To Party RemoveDebuffs Full
                             , To Party Heal <| Range 3000 5000
                             ]
                  , over   = [ Debuff Enemies 1 NPDown <| Range 50 100 ]
                  , first  = False
                  }
    , gen       = { starWeight = 10, starRate = 5, npAtk = 0.77, npDef = 5 }
    , hits      = { quick = 6, arts = 2, buster = 1, ex = 5 }
    , gender    = Female
    , traits    = [Humanoid, EnumaElish]
    , death     = 56.8
    , align     = [Lawful, Good]
    , limited   = False
    , free      = False
    , ascendUp  = Ascension
                  [(Piece Berserker, 5)]
                  [(Piece Berserker, 12), (PhoenixFeather, 6)]
                  [(Monument Berserker, 5), (SeedOfYggdrasil, 12), (ClawOfChaos, 3)]
                  [(Monument Berserker, 12), (ClawOfChaos, 6), (HomunculusBaby, 12)]
    , skillUp   = Reinforcement
                  [(GemOf Berserker, 5)]
                  [(GemOf Berserker, 12)]
                  [(MagicGemOf Berserker, 5)]
                  [(MagicGemOf Berserker, 12), (SeedOfYggdrasil, 6)]
                  [(SecretGemOf Berserker, 5), (SeedOfYggdrasil, 12)]
                  [(SecretGemOf Berserker, 12), (PhoenixFeather, 4)]
                  [(PhoenixFeather, 8), (TearstoneOfBlood, 4)]
                  [(TearstoneOfBlood, 11), (GhostLantern, 24)]
    }
  , { name  =   "Cu Chulainn (Alter)"
    , spoiler   = Nothing
    , id        = 98
    , rarity    = 5
    , class     = Berserker
    , attr      = Earth
    , deck      = Deck Quick Arts Buster Buster Buster
    , curve     = 10
    , stats     = { base  = { atk = 1979,  hp = 1790 }
                  , max   = { atk = 12805, hp = 12210 }
                  , grail = { atk = 14017, hp = 13377 }
                  }
    , skills    = [ { name = "Madness of the Spirits"
                    , rank   = A
                    , icon   = Icon.ExclamationDown
                    , cd     = 8
                    , effect = [ Debuff Enemies 3 AttackDown <| Range 10 20
                               , Debuff Enemies 3 CritChance <| Range 30 50
                               ]
                    }
                  , { name   = "Protection from Arrows"
                    , rank   = C
                    , icon   = Icon.Dodge
                    , cd     = 7
                    , effect = [ Times 2 <| Grant Self 0 Evasion Full
                               , Grant Self 3 DefenseUp <| Range 7 14
                               ]
                    }
                  , { name   = "Battle Continuation"
                    , rank   = A
                    , icon   = Icon.Kneel
                    , cd     = 9
                    , effect = [ Times 1 << Grant Self 5 Guts <| Range 1000 2500 ]
                    }
                  ]
    , passives  = [madness C, divinity C]
    , phantasm  = { name   = "Curruid Coinchenn"
                  , rank   = A
                  , card   = Buster
                  , kind   = "Anti-Personnel"
                  , hits   = 12
                  , effect = [ To Enemy Damage <| Range 600 1000 ]
                  , over   = [ Grant Self 1 AttackUp <| Range 30 70
                             , Grant Self 1 DefenseUp <| Range 30 70
                             ]
                  , first  = True
                  }
    , gen       = { starWeight = 9, starRate = 5.1, npAtk = 0.69, npDef = 5 }
    , hits      = { quick = 4, arts = 3, buster = 3, ex = 5 }
    , gender    = Male
    , traits    = [Humanoid, Divine, LovedOne, EnumaElish]
    , death     = 52
    , align     = [Chaotic, Evil]
    , limited   = False
    , free      = False
    , ascendUp  = Ascension
                  [(Piece Berserker, 5)]
                  [(Piece Berserker, 12), (EvilBone, 22)]
                  [(Monument Berserker, 5), (ClawOfChaos, 6), (HeartOfTheForeignGod, 2)]
                  [( Monument Berserker, 12), (HeartOfTheForeignGod, 4), (TearstoneOfBlood, 8)]
    , skillUp   = Reinforcement
                  [(GemOf Berserker, 5)]
                  [(GemOf Berserker, 12)]
                  [(MagicGemOf Berserker, 5)]
                  [(MagicGemOf Berserker, 12), (ClawOfChaos, 3)]
                  [(SecretGemOf Berserker, 5), (ClawOfChaos, 6)]
                  [(SecretGemOf Berserker, 12), (EvilBone, 15)]
                  [(EvilBone, 29), (SerpentJewel, 5)]
                  [(SerpentJewel, 15), (VoidsDust, 48)]
    }
  , { name      = "Minamoto-no-Raikou"
    , spoiler   = Nothing
    , id        = 114
    , rarity    = 5
    , class     = Berserker
    , attr      = Sky
    , deck      = Deck Quick Arts Arts Buster Buster
    , curve     = 30
    , stats     = { base  = { atk = 1786,  hp = 1980 }
                  , max   = { atk = 11556, hp = 13500 }
                  , grail = { atk = 12650, hp = 14790 }
                  }
    , skills    = [ { name   = "Eternal Arms Mastery"
                    , rank   = APlus
                    , icon   = Icon.StarUp
                    , cd     = 7
                    , effect = [ Grant Self 3 GatherUp <| Range 3000 6000 ]
                    }
                  , { name   = "Mana Burst (Lightning)"
                    , rank   = A
                    , icon   = Icon.BusterUp
                    , cd     = 8
                    , effect = [ Grant Self 1 (CardUp Buster) <| Range 20 30
                               , Grant Self 1 Evasion Full
                               ]
                    }
                  , { name   = "Mystic Slayer"
                    , rank   = A
                    , icon   = Icon.DamageUp
                    , cd     = 8
                    , effect = [ Grant Self 3 (Special AttackUp <| VsTrait Demonic) <| Range 30 50
                               , Grant Self 3 (Special AttackUp <| VsTrait EarthOrSky) <| Range 30 50
                               ]
                    }
                  ]
    , passives  = [magicResistance D, madness EX, riding APlus, divinity C]
    , phantasm  = { name   = "Vengeful Lightning of the Ox-King"
                  , rank   = BPlusPlus
                  , card   = Buster
                  , kind   = "Anti-Army"
                  , hits   = 7
                  , effect = [ To Enemies Damage <| Range 300 500 ]
                  , over   = [ Grant Self 1 StarUp <| Range 100 300 ]
                  , first  = True
                  }
    , gen       = { starWeight = 9, starRate = 4.9, npAtk = 0.46, npDef = 5 }
    , hits      = { quick = 3, arts = 4, buster = 1, ex = 5 }
    , gender    = Female
    , traits    = [Humanoid, Divine, Riding, EnumaElish]
    , death     = 39
    , align     = [Chaotic, Good]
    , limited   = True
    , free      = False
    , ascendUp  = Ascension
                  [(Piece Berserker, 5)]
                  [(Piece Berserker, 12), (ClawOfChaos, 5)]
                  [(Monument Berserker, 5), (EvilBone, 29), (TearstoneOfBlood, 3)]
                  [( Monument Berserker, 12), (TearstoneOfBlood, 6), (DragonsReverseScale, 5)]
    , skillUp   = Reinforcement
                  [(GemOf Berserker, 5)]
                  [(GemOf Berserker, 12)]
                  [(MagicGemOf Berserker, 5)]
                  [(MagicGemOf Berserker, 12), (EvilBone, 15)]
                  [(SecretGemOf Berserker, 5), (EvilBone, 29)]
                  [(SecretGemOf Berserker, 12), (ClawOfChaos, 3)]
                  [(ClawOfChaos, 6), (OctupletCrystals, 6)]
                  [(OctupletCrystals, 18), (SpiritRoot, 10)]
    }
  , { name      = "Ibaraki-Douji"
    , spoiler   = Nothing
    , id        = 116
    , rarity    = 4
    , class     = Berserker
    , attr      = Earth
    , deck      = Deck Quick Arts Buster Buster Buster
    , curve     = 29
    , stats     = { base  = { atk = 1606,  hp = 1752 }
                  , max   = { atk = 9636, hp = 10954 }
                  , grail = { atk = 11667, hp = 13282 }
                  }
    , skills    = [ { name  = "Demonic Nature of Oni"
                    , rank   = A
                    , icon    = Icon.SwordUp
                    , cd      = 7
                    , effect = [ Grant Party 3 AttackUp <| Range 10 20
                              , Grant Self 3 NPUp <| Range 20 30
                              ]
                    }
                  , { name    = "Disengage"
                    , rank   = A
                    , icon    = Icon.Heal
                    , cd      = 7
                    , effect = [ To Self RemoveDebuffs Full
                              , To Self Heal <| Range 1000 2500
                              ]
                    }
                  , { name    = "Morph"
                    , rank   = A
                    , icon    = Icon.ShieldUp
                    , cd      = 7
                    , effect = [ Grant Self 3 DefenseUp <| Range 10 30
                              , Grant Self 1 DefenseUp <| Flat 30
                              ]
                    }
                  ]
    , passives  = [madness B]
    , phantasm  = { name   = "Great Grudge of Rashomon"
                  , rank   = B
                  , card   = Buster
                  , kind   = "Anti-Army"
                  , hits   = 1
                  , effect = [ To Enemy Damage <| Range 600 1000
                             , To Enemy RemoveBuffs Full
                             ]
                  , over   = [ Debuff Enemy 3 DefenseDown <| Range 10 30 ]
                  , first  = False
                  }
    , gen       = { starWeight = 10, starRate = 4.9, npAtk = 1.03, npDef = 5 }
    , hits      = { quick = 4, arts = 2, buster = 1, ex = 5 }
    , gender    = Female
    , traits    = [Humanoid, Demonic, DemonBeast, Oni, EnumaElish]
    , death     = 52
    , align     = [Chaotic, Evil]
    , limited   = False
    , free      = False
    , ascendUp  = Ascension
                  [(Piece Berserker, 4)]
                  [(Piece Berserker, 10), (OctupletCrystals, 6)]
                  [(Monument Berserker, 4), (ClawOfChaos, 5), (PhoenixFeather, 4)]
                  [(Monument Berserker, 10), (PhoenixFeather, 7), (HeartOfTheForeignGod, 4)]
    , skillUp   = Reinforcement
                  [(GemOf Berserker, 4)]
                  [(GemOf Berserker, 10)]
                  [(MagicGemOf Berserker, 4)]
                  [(MagicGemOf Berserker, 10), (ClawOfChaos, 3)]
                  [(SecretGemOf Berserker, 4), (ClawOfChaos, 5)]
                  [(SecretGemOf Berserker, 10), (OctupletCrystals, 4)]
                  [(OctupletCrystals, 8), (VoidsDust, 10)]
                  [(VoidsDust, 30), (TearstoneOfBlood, 12)]
    }
  , { name      = "Mysterious Heroine X (Alter)"
    , spoiler   = Nothing
    , id        = 155
    , rarity    = 5
    , class     = Berserker
    , stats     = { base  = { atk = 1717,  hp = 2079 }
                  , max   = { atk = 11113,  hp = 14175 }
                  , grail = { atk = 12165, hp = 15529 }
                  }
    , gen       = { starWeight = 9, starRate = 5, npAtk = 1.07, npDef = 5 }
    , death     = 37.3
    , curve     = 30
    , attr      = Star
    , align     = [Neutral, Evil]
    , gender    = Female
    , traits    = [Humanoid, Dragon, Arthur, Saberface, King]
    , deck      = Deck Quick Quick Arts Buster Buster
    , hits      = { quick = 3, arts = 2, buster = 4, ex = 5 }
    , skills    = [ { name   = "Chocolate"
                    , rank   = EX
                    , icon   = Icon.Heal
                    , cd     = 7
                    , effect = [ Grant Self 3 HealingReceived <| Range 20 50
                               , To Self Heal <| Range 1000 2000
                               ]
                    }
                  , { name   = "Ephemeral Shadowless Blade"
                    , rank   = EX
                    , icon   = Icon.QuickUp
                    , cd     = 7
                    , effect = [ Grant Self 3 (CardUp Quick) <| Range 20 30
                               , To Party GainStars <| Range 10 20
                               ]
                    }
                  , { name   = "King's Invisible Hand"
                    , rank   = C
                    , icon   = Icon.StarDown
                    , cd     = 7
                    , effect = [ Grant Party 3 AttackUp <| Range 10 20
                               , Grant Ally 1 GatherDown <| Flat 100
                               ]
                    }
                  ]
    , passives  = [madness C, altreactor A]
    , phantasm  = { name   = "Cross-Calibur"
                  , rank   = APlus
                  , card   = Quick
                  , kind   = "Anti-Army"
                  , hits   = 9
                  , effect = [ To Enemy Damage <| Range 1200 2000 ]
                  , over   = [ To Enemy (SpecialDamage <| VsClass Saber) <| Range 150 200 ]
                  , first  = False
                  }
    , limited   = True
    , free      = False
    , ascendUp  = Ascension
                  [(Piece Berserker, 5)]
                  [(Piece Berserker, 12), (DragonFang, 18)]
                  [(Monument Berserker, 5), (GreatKnightMedal, 20), (PrimordialLanugo, 3)]
                  [(Monument Berserker, 12), (PrimordialLanugo, 6), (DragonsReverseScale, 5)]
    , skillUp   = Reinforcement
                  [(GemOf Berserker, 5)]
                  [(GemOf Berserker, 12)]
                  [(MagicGemOf Berserker, 5)]
                  [(MagicGemOf Berserker, 12), (GreatKnightMedal, 10)]
                  [(SecretGemOf Berserker, 5), (GreatKnightMedal, 20)]
                  [(SecretGemOf Berserker, 12), (DragonFang, 12)]
                  [(DragonFang, 24), (BlackBeastGrease, 4)]
                  [(BlackBeastGrease, 11), (CursedBeastGallstone, 10)]
    },
    { name      = "Hijikata Toshizo"
    , spoiler   = Nothing
    , id        = 161
    , rarity    = 5
    , class     = Berserker
    , stats     = { base  = { atk = 1868,  hp = 1764 }
                  , max   = { atk = 12089, hp = 12028 }
                  , grail = { atk = 13234, hp = 13178 }
                  }
    , gen       = { starWeight = 9, starRate = 4.9, npAtk = 1.08, npDef = 5 }
    , death     = 65
    , curve     = 5
    , attr      = Human
    , align     = [Lawful, Evil]
    , gender    = Male
    , traits    = [Humanoid, EnumaElish]
    , deck      = Deck Quick Quick Arts Buster Buster
    , hits      = { quick = 3, arts = 2, buster = 2, ex = 3 }
    , skills    = [ { name   = "Demon of the Battlefield"
                    , rank   = B
                    , icon   = Icon.BusterUp
                    , cd     = 7
                    , effect = [ Grant Party 3 (CardUp Buster) <| Range 10 20
                               , Grant Party 3 StarUp <| Range 10 20
                               ]
                    }
                  , { name   = "Disengage"
                    , rank   = C
                    , icon   = Icon.Heal
                    , cd     = 7
                    , effect = [ To Self Heal <| Range 500 1500
                               , To Self RemoveDebuffs Full
                               ]
                    }
                  , { name   = "Laws of the Shinsengumi"
                    , rank   = EX
                    , icon   = Icon.StarUp
                    , cd     = 7
                    , effect = [ Grant Self 3 GatherUp <| Range 2000 4000
                               , Grant Self 3 CritUp <| Flat 20
                               , Grant Self 3 CritPerHealth <| Flat 80
                               , To Self DemeritDamage <| Flat 1000
                               ]
                    }
                  ]
    , passives  = [madness DPlus]
    , phantasm  = { name   = "Shinsengumi"
                  , rank   = CPlus
                  , card   = Buster
                  , kind   = "Anti-Unit"
                  , hits   = 5
                  , effect = [ To Enemy Damage <| Range 600 1000 ]
                  , over   = [ To Enemy LastStand <| Range 600 1000 ]
                  , first  = False
                  }
    , limited   = True
    , free      = False
    , ascendUp  = Ascension
                  [(Piece Berserker, 5)]
                  [(Piece Berserker, 12), (ProofOfHero, 22)]
                  [(Monument Berserker, 5), (FoolsChain, 29), (TearstoneOfBlood, 3)]
                  [(Monument Berserker, 12), (TearstoneOfBlood, 6), (CursedBeastGallstone, 5)]
    , skillUp   = Reinforcement
                  [(GemOf Berserker, 5)]
                  [(GemOf Berserker, 12)]
                  [(MagicGemOf Berserker, 5)]
                  [(MagicGemOf Berserker, 12), (FoolsChain, 15)]
                  [(SecretGemOf Berserker, 5), (FoolsChain, 29)]
                  [(SecretGemOf Berserker, 12), (ProofOfHero, 15)]
                  [(ProofOfHero, 29), (MysticSpinalFluid, 18)]
                  [(MysticSpinalFluid, 54), (EternalGear, 24)]
    }
  , { name      = "Chacha"
    , spoiler   = Nothing
    , id        = 162
    , rarity    = 4
    , class     = Berserker
    , stats     = { base  = { atk = 1490,  hp = 1764 }
                  , max   = { atk = 8945,  hp = 11025 }
                  , grail = { atk = 10831, hp = 13368 }
                  }
    , gen       = { starWeight = 10, starRate = 4.9, npAtk = 1.03, npDef = 5 }
    , death     = 52
    , curve     = 24
    , attr      = Human
    , align     = [Chaotic, Balanced]
    , gender    = Female
    , traits    = [Humanoid, EnumaElish]
    , deck      = Deck Quick Arts Buster Buster Buster
    , hits      = { quick = 3, arts = 2, buster = 5, ex = 4 }
    , skills    = [ { name   = "Golden Rule (Evil)"
                    , rank   = B
                    , icon   = Icon.NobleTurn
                    , cd     = 8
                    , effect = [ Grant Self 3 GaugePerTurn <| Range 5 10
                               , Grant Self 3 NPGen <| Range 20 50
                               ]
                    }
                  , { name   = "Innocent Monster (Flame)"
                    , rank   = C
                    , icon   = Icon.StarTurn
                    , cd     = 7
                    , effect = [ Grant Self 3 StarsPerTurn <| Range 5 10
                               , Grant Others 3 GatherDown <| Flat 50
                               ]
                    }
                  , { name   = "Consort of the Sun"
                    , rank   = EX
                    , icon   = Icon.ShieldDown
                    , cd     = 7
                    , effect = [ Debuff Enemy 5 DefenseDown <| Flat 10
                               , After 1 << Debuff Enemy 4 DefenseDown <| Range  5 10
                               , After 2 << Debuff Enemy 3 DefenseDown <| Range  5 10
                               , After 3 << Debuff Enemy 2 DefenseDown <| Range  5 10
                               , After 4 << Debuff Enemy 1 DefenseDown <| Range  5 10
                               ]
                    }
                  ]
    , passives  = [madness EPlus]
    , phantasm  = { name   = "Kenran Makai Nichirinjou"
                  , rank   = C
                  , card   = Buster
                  , kind   = "Anti-Fortress"
                  , hits   = 8
                  , effect = [ To Enemies Damage <| Range 300 500
                             , Debuff Enemies 3 CritChance <| Flat 20
                             ]
                  , over   = [ Debuff Enemies 5 Burn <| Range 500 2500 ]
                  , first  = False
                  }
    , limited   = True
    , free      = True
    , ascendUp  = Welfare "Piece of Ranjatai"
    , skillUp   = Reinforcement
                  [(GemOf Berserker, 4)]
                  [(GemOf Berserker, 10)]
                  [(MagicGemOf Berserker, 4)]
                  [(MagicGemOf Berserker, 10), (OctupletCrystals, 4)]
                  [(SecretGemOf Berserker, 4), (OctupletCrystals, 8)]
                  [(SecretGemOf Berserker, 10), (PhoenixFeather, 4)]
                  [(PhoenixFeather, 7), (LampOfEvilSealing, 3)]
                  [(LampOfEvilSealing, 9), (ScarabOfWisdom, 8)]
    }
  , { name      = "Penthesilea"
    , spoiler   = Just "El Dorado"
    , id        = 171
    , rarity    = 4
    , class     = Berserker
    , stats     = { base  = { atk = 1750,  hp = 1628 }
                  , max   = { atk = 10502, hp = 10175 }
                  , grail = { atk = 12716, hp = 12337 }
                  }
    , gen       = { starWeight = 10, starRate = 4.9, npAtk = 1.07, npDef = 5 }
    , death     = 39
    , curve     = 4
    , attr      = Earth
    , align     = [Lawful, Good]
    , gender    = Female
    , traits    = [Humanoid, Divine, EnumaElish, King]
    , deck      = Deck Quick Arts Buster Buster Buster
    , hits      = { quick = 3, arts = 2, buster = 2, ex = 5 }
    , skills    = [ { name   = "Charisma"
                    , rank   = B
                    , icon   = Icon.SwordUp
                    , cd     = 7
                    , effect = [ Grant Party 3 AttackUp <| Range 9 18 ]
                    }
                  , { name   = "Golden Rule (Beauty)"
                    , rank   = A
                    , icon   = Icon.Flex
                    , cd     = 8
                    , effect = [ Grant Self 3 DebuffResist Full
                               , Grant Self 3 GaugePerTurn <| Range 10 20
                               ]
                    }
                  , { name   = "Roar of the God of War"
                    , rank   = APlus
                    , icon   = Icon.BusterUp
                    , cd     = 7
                    , effect = [ Grant Party 3 (CardUp Buster) <| Range 10 20
                               , Grant Self 3 (Special AttackUp <| VsTrait GreekMythMale) <| Range 50 100
                               ]
                    }
                  ]
    , passives  = [madness EX, divinity B]
    , phantasm  = { name   = "Outrage Amazon"
                  , rank   = B
                  , card   = Buster
                  , kind   = "Anti-Unit"
                  , hits   = 8
                  , effect = [ To Enemy Damage <| Range 600 1000 ]
                  , over   = [ Debuff Enemy 3 AttackDown <| Range 10 30 ]
                  , first  = False
                  }
    , limited   = False
    , free      = False
    , ascendUp  = Ascension
                  [(Piece Berserker, 4)]
                  [(Piece Berserker, 10), (OctupletCrystals, 6)]
                  [(Monument Berserker, 4), (MeteorHorseshoe, 8), (TearstoneOfBlood, 3)]
                  [(Monument Berserker, 10), (TearstoneOfBlood, 5), (SpiritRoot, 4)]
    , skillUp   = Reinforcement
                  [(GemOf Berserker, 4)]
                  [(GemOf Berserker, 10)]
                  [(MagicGemOf Berserker, 4)]
                  [(MagicGemOf Berserker, 10), (MeteorHorseshoe, 4)]
                  [(SecretGemOf Berserker, 4), (MeteorHorseshoe, 8)]
                  [(SecretGemOf Berserker, 10), (OctupletCrystals, 4)]
                  [(OctupletCrystals, 8), (CursedBeastGallstone, 2)]
                  [(CursedBeastGallstone, 6), (MysteriousDivineWine, 8)]
    }
  , { name      = "Paul Bunyan"
    , spoiler   = Nothing
    , id        = 174
    , rarity    = 1
    , class     = Berserker
    , stats     = { base  = { atk = 1099, hp = 1239 }
                  , max   = { atk = 6044, hp = 6196 }
                  , grail = { atk = 9391, hp = 9551 }
                  }
    , gen       = { starWeight = 9, starRate = 4.9, npAtk = 0.67, npDef = 5 }
    , death     = 65
    , curve     = 6
    , attr      = Earth
    , align     = [Neutral, Balanced]
    , gender    = Female
    , traits    = [Humanoid, EnumaElish]
    , deck      = Deck Quick Arts Buster Buster Buster
    , hits      = { quick = 3, arts = 3, buster = 3, ex = 4 }
    , skills    = [ { name   = "Delightful Comrades"
                    , rank   = A
                    , icon   = Icon.BusterUp
                    , cd     = 8
                    , effect = [ Grant Party 3 (CardUp Buster) <| Range 10 20
                               , Grant Party 3 CritUp <| Range 10 20
                               ]
                    }
                  , { name   = "Bean Soup Lake"
                    , rank   = A
                    , icon   = Icon.Heal
                    , cd     = 7
                    , effect = [ To Party Heal <| Range 1000 2000 ]
                    }
                  , { name   = "Popcorn Blizzard"
                    , rank   = B
                    , icon   = Icon.ShieldDown
                    , cd     = 8
                    , effect = [ Debuff Enemies 3 DefenseDown <| Range 10 20
                               , Debuff Enemies 5 HealDown <| Range 30 50
                               ]
                    }
                  ]
    , passives  = [madness D]
    , phantasm  = { name   = "Marvelous Exploits"
                  , rank   = A
                  , card   = Buster
                  , kind   = "Anti-Army"
                  , hits   = 2
                  , effect = [ To Enemies Damage <| Range 300 500 ]
                  , over   = [ Debuff Enemies 5 DefenseDown <| Range 10 30 ]
                  , first  = False
                  }
    , limited   = True
    , free      = True
    , ascendUp  = Ascension
                  [(Piece Berserker, 2)]
                  [(Piece Berserker, 4), (SeedOfYggdrasil, 3)]
                  [(Monument Berserker, 2), (OctupletCrystals, 4), (SpiritRoot, 1)]
                  [(Monument Berserker, 4), (SpiritRoot, 2), (VoidsDust, 8)]
    , skillUp   = Reinforcement
                  [(GemOf Berserker, 2)]
                  [(GemOf Berserker, 4)]
                  [(MagicGemOf Berserker, 2)]
                  [(MagicGemOf Berserker, 4), (OctupletCrystals, 2)]
                  [(SecretGemOf Berserker, 2), (OctupletCrystals, 4)]
                  [(SecretGemOf Berserker, 4), (SeedOfYggdrasil, 2)]
                  [(SeedOfYggdrasil, 4), (FoolsChain, 6)]
                  [(FoolsChain, 18), (HomunculusBaby, 8)]
    }
  , { name      = "Oda Nobunaga (Berserker)"
    , spoiler   = Nothing
    , id        = 178
    , rarity    = 4
    , class     = Berserker
    , stats     = { base  = { atk = 1691,  hp = 1603 }
                  , max   = { atk = 10146, hp = 10023 }
                  , grail = { atk = 12285, hp = 12153 }
                  }
    , gen       = { starWeight = 10, starRate = 5, npAtk = 0.93, npDef = 5 }
    , death     = 52
    , curve     = 14
    , attr      = Human
    , align     = [Chaotic, Summer]
    , gender    = Female
    , traits    = [Humanoid, EnumaElish, King]
    , deck      = Deck Quick Arts Buster Buster Buster
    , hits      = { quick = 3, arts = 2, buster = 6, ex = 5 }
    , skills    = [ { name   = "Fool's Tactic"
                    , rank   = A
                    , icon   = Icon.Dodge
                    , cd     = 8
                    , effect = [ Grant Self 3 (CardUp Buster) <| Range 10 20
                               , Grant Self 1 Evasion Full
                               ]
                    }
                  , { name   = "Atsumori Beat"
                    , rank   = B
                    , icon   = Icon.StarTurn
                    , cd     = 10
                    , effect = [ Grant Self 5 StarsPerTurn <| Range 5 10
                               , Grant Party 5 HealPerTurn <| Range 300 500
                               , Grant Party 5 GaugePerTurn <| Flat 3
                               ]
                    }
                  , { name   = "Demon King on the Beach"
                    , rank   = AMinus
                    , icon   = Icon.StarUp
                    , cd     = 6
                    , effect = [ Grant Self 1 GatherUp <| Range 1000 3000
                               , Grant Self 1 SureHit Full
                               , When "on Burning field" << Grant Self 3 AttackUp <| Range 10 20
                               ]
                    }
                  ]
    , passives  = [madness C]
    , phantasm  = { name   = "Nobunaga THE Rock 'n Roll"
                  , rank   = EX
                  , card   = Buster
                  , kind   = "Anti-God"
                  , hits   = 12
                  , effect = [ To Enemy Damage <| Range 600 100 ]
                  , over   = [ To Enemy (SpecialDamage <| VsTrait Divine) <| Range 150 20 ]
                  , first  = False
                  }
    , limited   = True
    , free      = False
    , ascendUp  = Ascension
                  [(Piece Berserker, 4)]
                  [(Piece Berserker, 10), (MysticSpinalFluid, 18)]
                  [(Monument Berserker, 4), (MysteriousDivineWine, 4), (DeadlyPoisonousNeedle, 10)]
                  [(Monument Berserker, 10), (DeadlyPoisonousNeedle, 20), (ClawOfChaos, 6)]
    , skillUp   = Reinforcement
                  [(GemOf Berserker, 4)]
                  [(GemOf Berserker, 10)]
                  [(MagicGemOf Berserker, 4)]
                  [(MagicGemOf Berserker, 10), (MysteriousDivineWine, 2)]
                  [(SecretGemOf Berserker, 4), (MysteriousDivineWine, 4)]
                  [(SecretGemOf Berserker, 10), (MysticSpinalFluid, 12)]
                  [(MysticSpinalFluid, 24), (ShellOfReminiscence, 5)]
                  [(ShellOfReminiscence, 15), (CursedBeastGallstone, 8)]
    }
  , { name      = "Atalante (Alter)"
    , spoiler   = Nothing
    , id        = 202
    , rarity    = 4
    , class     = Berserker
    , stats     = { base  = { atk = 1634,  hp = 1701 }
                  , max   = { atk = 9806,  hp = 10634 }
                  , grail = { atk = 11873, hp = 12894 }
                  }
    , gen       = { starWeight = 9, starRate = 5.1, npAtk = 1.05, npDef = 5 }
    , death     = 45.5
    , curve     = 4
    , attr      = Human
    , align     = [Chaotic, Evil]
    , gender    = Female
    , traits    = [Humanoid, EnumaElish]
    , deck      = Deck Quick Quick Arts Buster Buster
    , hits      = { quick = 3, arts = 2, buster = 3, ex = 5 }
    , skills    = [ { name   = "Self Evolution"
                    , rank   = EX
                    , icon   = Icon.StarUp
                    , cd     = 7
                    , effect = [ Grant Self 1 GatherUp <| Range 3000 6000
                               , To Party GainStars <| Range 5 10
                               ]
                    }
                  , { name   = "Beyond Arcadia"
                    , rank   = A
                    , icon   = Icon.QuickUp
                    , cd     = 7
                    , effect = [ Grant Party 1 (CardUp Quick) <| Range 30 50 ]
                    }
                  , { name   = "Feral Logic"
                    , rank   = B
                    , icon   = Icon.Dodge
                    , cd     = 8
                    , effect = [ Grant Self 3 CritUp <| Range 30 50
                               , Grant Self 1 Evasion Full
                               ]
                    }
                  ]
    , passives  = [beastification B, independentAction A]
    , phantasm  = { name   = "Tauropolos Skia Thermokrasía"
                  , rank   = A
                  , card   = Quick
                  , kind   = "Anti-Personnel"
                  , hits   = 5
                  , effect = [ To Enemy Damage <| Range 1200 2000
                             , Debuff Enemy 1 SealNP Full
                             ]
                  , over   = [ Debuff Enemy 5 Curse <| Range 500 2500 ]
                  , first  = False
                  }
    , limited   = False
    , free      = False
    , ascendUp  = Ascension
                  [(Piece Berserker, 4)]
                  [(Piece Berserker, 10), (SeedOfYggdrasil, 8)]
                  [(Monument Berserker, 4), (BlackBeastGrease, 5), (SpiritRoot, 2)]
                  [(Monument Berserker, 10), (SpiritRoot, 4), (PrimordialLanugo, 6)]
    , skillUp   = Reinforcement
                  [(GemOf Berserker, 4)]
                  [(GemOf Berserker, 10)]
                  [(MagicGemOf Berserker, 4)]
                  [(MagicGemOf Berserker, 10), (BlackBeastGrease, 3)]
                  [(SecretGemOf Berserker, 4), (BlackBeastGrease, 5)]
                  [(SecretGemOf Berserker, 10), (SeedOfYggdrasil, 5)]
                  [(SeedOfYggdrasil, 10), (MysticGunpowder, 15)]
                  [(MysticGunpowder, 45), (ClawOfChaos, 12)]
    }
  ]
