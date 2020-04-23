module Database.Servant.Extra exposing (extras)

import Model.Attribute exposing (Attribute(..))
import Model.Card exposing (Card(..))
import Model.Class exposing (Class(..))
import Model.Deck exposing (Deck(..))
import Model.Material exposing (Material(..), pairWith)
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

extras : List Servant
extras =
  [ { name      = "Mash Kyrielight"
    , spoiler   = Nothing
    , id        = 1
    , rarity    = 3
    , class     = Shielder
    , attr      = Earth
    , deck      = Deck Quick Arts Arts Buster Buster
    , curve     = 3
    , stats     = { base  = { atk = 1261,  hp = 1854 }
                  , max   = { atk = 6791,  hp = 10302 }
                  , grail = { atk = 10575, hp = 15619 }
                  }
    , skills    = [ { name   = "Honorable Wall of Snowflakes"
                    , rank   = Unknown
                    , icon   = Icon.ShieldUp
                    , cd     = 7
                    , effect = [ Grant Party 3 DefenseUp <| Range 15 20
                               , Times 1 << Grant Party 0 DamageCut <| Flat 2000
                               ]
                    }
                  , { name   = "Obscurant Wall of Chalk"
                    , rank   = Unknown
                    , icon   = Icon.Shield
                    , cd     = 9
                    , effect = [ Grant Ally 1 Invincibility Full
                               , To Ally GaugeUp <| Range 10 20
                               ]
                    }
                , { name   = "Shield of Rousing Resolution"
                  , rank   = Unknown
                  , icon   = Icon.CrosshairUp
                  , cd     = 8
                  , effect = [ Grant Self 1 Taunt Full
                             , Grant Self 1 NPGen <| Range 200 400
                             ]
                  }
                ]
    , passives  = [magicResistance A, riding C]
    , phantasm  = { name   = "Lord Camelot"
                  , rank   = BPlusPlusPlus
                  , card   = Arts
                  , kind   = "Anti-Evil"
                  , hits   = 0
                  , effect = [ Grant Party 3 DamageCut <| Range 100 1000
                             , Grant Others 3 AttackUp <| Flat 30
                             ]
                  , over   = [ Grant Party 3 DefenseUp <| Range 30 50 ]
                  , first  = False
                  }
    , gen       = { starWeight = 99, starRate = 9.9, npAtk = 0.84, npDef = 3 }
    , hits      = { quick = 2, arts = 2, buster = 1, ex = 3 }
    , gender    = Female
    , traits    = [Humanoid, Riding, EnumaElish, DemiServant]
    , death     = 24.5
    , align     = [Lawful, Good]
    , limited   = False
    , free      = True
    , ascendUp  = Clear
                  "Septem"
                  "London pt. 4, Arrow II"
                  "Camelot pt. 15, Arrow I"
                  "Babylonia"
    , skillUp   = Reinforcement
                  [(ProofOfHero, 5)]
                  [(DragonFang, 5)]
                  [(SeedOfYggdrasil, 5)]
                  [(OctupletCrystals, 5)]
                  [(VoidsDust, 5)]
                  [(EternalGear, 5)]
                  [(PhoenixFeather, 5)]
                  [(DragonsReverseScale, 5)]
    }
  , { name  =   "Jeanne d'Arc"
    , spoiler   = Nothing
    , id        = 59
    , rarity    = 5
    , class     = Ruler
    , attr      = Star
    , deck      = Deck Quick Arts Arts Arts Buster
    , curve     = 10
    , stats     = { base  = { atk = 1482,  hp = 2420 }
                  , max   = { atk = 9593,  hp = 16500 }
                  , grail = { atk = 10501, hp = 18076 }
                  }
    , skills    = [ { name   = "Revelation"
                    , rank   = A
                    , icon   = Icon.StarTurn
                    , cd     = 8
                    , effect = [ Grant Self 3 StarsPerTurn <| Range 3 9 ]
                    }
                  , { name   = "True Name Revelation"
                    , rank   = B
                    , icon   = Icon.BeamDown
                    , cd     = 7
                    , effect = [ Debuff Enemy 1 NPDown <| Range 15 30 ]
                    }
                  , { name   = "Divine Judgement"
                    , rank   = A
                    , icon   = Icon.Stun
                    , cd     = 8
                    , effect = [ Chances 70 120 <| Debuff (EnemyType Model.Trait.Servant) 1 Stun Full ]
                    }
                  ]
    , passives  = [magicResistance EX]
    , phantasm  = { name   = "Luminosité Eternelle"
                  , rank   = A
                  , card   = Arts
                  , kind   = "Barrier"
                  , hits   = 0
                  , effect = [ Grant Party 3 DefenseUp <| Range 5 25
                             , Grant Party 1 Invincibility Full
                             , To Party RemoveDebuffs Full
                             ]
                  , over   = [ Grant Party 2 HealPerTurn <| Range 1000 3000 ]
                  , first  = False
                  }
    , gen       = { starWeight = 99, starRate = 10.1, npAtk = 0.76, npDef = 3 }
    , hits      = { quick = 2, arts = 2, buster = 1, ex = 3 }
    , gender    = Female
    , traits    = [Humanoid, EnumaElish, Saberface]
    , death     = 21
    , align     = [Lawful, Good]
    , limited   = False
    , free      = False
    , ascendUp  = Ascension
                  (pairWith 5 Piece    [Saber, Archer, Lancer])
                  (pairWith 5 Piece    [Rider, Caster, Assassin, Berserker])
                  (pairWith 5 Monument [Saber, Archer, Lancer])
                  (pairWith 5 Monument [Rider, Caster, Assassin, Berserker])
    , skillUp   = Reinforcement
                  (pairWith 5 GemOf       [Saber, Archer, Lancer])
                  (pairWith 5 GemOf       [Rider, Caster, Assassin, Berserker])
                  (pairWith 5 MagicGemOf  [Saber, Archer, Lancer])
                  (pairWith 5 MagicGemOf  [Rider, Caster, Assassin, Berserker])
                  (pairWith 5 SecretGemOf [Saber, Archer, Lancer])
                  (pairWith 5 SecretGemOf [Rider, Caster, Assassin, Berserker])
                  [(HeartOfTheForeignGod, 5)]
                  [(HeartOfTheForeignGod, 15)]
    }
  , { name      = "Amakusa Shirou"
    , spoiler   = Nothing
    , id        = 93
    , rarity    = 5
    , class     = Ruler
    , attr      = Human
    , deck      = Deck Quick Arts Arts Buster Buster
    , curve     = 10
    , stats     = { base  = { atk = 1695,  hp = 2069 }
                  , max   = { atk = 10972, hp = 14107 }
                  , grail = { atk = 12011, hp = 15455 }
                  }
    , skills    = [ { name   = "Revelation"
                    , rank   = A
                    , icon   = Icon.StarTurn
                    , cd     = 8
                    , effect = [ Grant Self 3 StarsPerTurn <| Range 3 9 ]
                    }
                  , { name   = "Baptism Rite"
                    , rank   = BPlus
                    , icon   = Icon.NobleTurn
                    , cd     = 12
                    , effect = [ Grant Self 5 GaugePerTurn <| Range 10 20
                               , To (EnemyType Undead) GaugeDown <| Flat 1
                               , To (EnemyType Daemon) GaugeDown <| Flat 1
                               ]
                    }
                  , { name   = "Divine Judgement (Fake)"
                    , rank   = CPlusPlus
                    , icon   = Icon.Stun
                    , cd     = 8
                    , effect = [ Chances 50 100 <| Debuff (EnemyType Model.Trait.Servant) 1 Stun Full
                               , Grant Self 3 (CardUp Buster) <| Range 20 30
                               ]
                    }
                  ]
    , passives  = [magicResistance A]
    , phantasm  = { name   = "Twin Arm—Big Crunch"
                  , rank   = EX
                  , card   = Buster
                  , kind   = "Anti-Army"
                  , hits   = 1
                  , effect = [ To Enemies RemoveBuffs Full
                             , To Enemies Damage <| Range 400 600
                             ]
                  , over   = [ Debuff Enemies 3 CritChance <| Range 30 70 ]
                  , first  = False
                  }
    , gen       = { starWeight = 100, starRate = 10, npAtk = 0.86, npDef = 3 }
    , hits      = { quick = 3, arts = 2, buster = 1, ex = 7 }
    , gender    = Male
    , traits    = [Humanoid, EnumaElish]
    , death     = 21
    , align     = [Lawful, Good]
    , limited   = True
    , free      = False
    , ascendUp  = Ascension
                  (pairWith 5 Piece    [Lancer, Caster, Assassin])
                  (pairWith 5 Piece    [Saber, Archer, Rider, Berserker])
                  (pairWith 5 Monument [Rider, Caster, Assassin])
                  (pairWith 5 Monument [Saber, Archer, Lancer, Berserker])
    , skillUp   = Reinforcement
                  (pairWith 5 GemOf       [Rider, Caster, Assassin])
                  (pairWith 5 GemOf       [Saber, Lancer, Archer, Berserker])
                  (pairWith 5 MagicGemOf  [Rider, Caster, Assassin])
                  (pairWith 5 MagicGemOf  [Saber, Lancer, Archer, Berserker])
                  (pairWith 5 SecretGemOf [Rider, Caster, Assassin])
                  (pairWith 5 SecretGemOf [Saber, Lancer, Archer, Berserker])
                  [(HeartOfTheForeignGod, 5)]
                  [(HeartOfTheForeignGod, 15)]
    }
  , { name      = "Edmond Dantes"
    , spoiler   = Nothing
    , id        = 96
    , rarity    = 5
    , class     = Avenger
    , attr      = Human
    , deck      = Deck Quick Quick Arts Buster Buster
    , curve     = 15
    , stats     = { base  = { atk = 1953,  hp = 1785 }
                  , max   = { atk = 12641, hp = 12177 }
                  , grail = { atk = 13838, hp = 13340 }
                  }
    , skills    = [ { name   = "Iron Determination"
                    , rank   = EX
                    , icon   = Icon.ShieldBreak
                    , cd     = 8
                    , effect = [ Grant Self 1 IgnoreInvinc Full
                               , Grant Self 1 AttackUp <| Range 30 50
                               , Grant Self 3 DebuffResist <| Range 14 32
                               ]
                    }
                  , { name   = "Golden Rule"
                    , rank   = A
                    , icon   = Icon.NobleUp
                    , cd     = 8
                    , effect = [ Grant Self 3 NPGen <| Range 20 50 ]
                    }
                  , { name   = "Wisdom of Crisis"
                    , rank   = A
                    , icon   = Icon.MagicDark
                    , cd     = 8
                    , effect = [ To Enemy GaugeDown <| Flat 1
                               , To Self RemoveDebuffs Full
                               , To Party GainStars <| Range 10 20
                               ]
                    }
                  ]
    , passives  = [avenger A, oblivionCorrection B, selfRestoreMagic D]
    , phantasm  = { name   = "Enfer Château d'If"
                  , rank   = A
                  , card   = Quick
                  , kind   = "Anti-Army"
                  , hits   = 8
                  , effect = [ To Enemies Damage <| Range 600 1000 ]
                  , over   = [ Debuff Enemies 3 DefenseDown <|  Range 20 40
                             , Debuff Enemies 5 Curse <| Range 500 1500
                             ]
                  , first  = False
                  }
    , gen       = { starWeight = 30, starRate = 5.9, npAtk = 0.62, npDef = 6 }
    , hits      = { quick = 4, arts = 2, buster = 3, ex = 5 }
    , gender    = Male
    , traits    = [Humanoid, EnumaElish]
    , death     = 7
    , align     = [Chaotic, Evil]
    , limited   = True
    , free      = False
    , ascendUp  = Ascension
                  [(EvilBone, 10), (OctupletCrystals, 10)]
                  [(SerpentJewel, 10), (ForbiddenPage, 10)]
                  [(VoidsDust, 10), (EternalGear, 10)]
                  [(PhoenixFeather, 10), (HeartOfTheForeignGod, 10)]
    , skillUp   = Reinforcement
                  [(ProofOfHero, 10)]
                  [(SeedOfYggdrasil, 10)]
                  [(DragonFang, 12)]
                  [(GhostLantern, 12)]
                  [(MeteorHorseshoe, 12)]
                  [(HomunculusBaby, 15)]
                  [(ClawOfChaos, 15)]
                  [(DragonsReverseScale, 15)]
    }
  , { name      = "Jeanne d'Arc (Alter)"
    , spoiler   = Nothing
    , id        = 106
    , rarity    = 5
    , class     = Avenger
    , attr      = Human
    , deck      = Deck Quick Arts Arts Buster Buster
    , curve     = 15
    , stats     = { base  = { atk = 2046,  hp = 1724 }
                  , max   = { atk = 13244, hp = 11761 }
                  , grail = { atk = 14498, hp = 12885 }
                  }
    , skills    = [ { name   = "Self-Modification"
                    , rank   = EX
                    , icon   = Icon.ExclamationUp
                    , cd     = 7
                    , effect = [ Grant Self 3 CritUp <| Range 20 50
                               , Grant Self 3 GatherUp <| Range 400 800
                               ]
                    }
                  , { name   = "Dragon Witch"
                    , rank   = EX
                    , icon   = Icon.SwordUp
                    , cd     = 7
                    , effect = [ Grant Party 3 AttackUp <| Range 10 20
                               , Grant (AlliesType Dragon) 3 AttackUp <| Range 10 20
                               ]
                    }
                  , { name   = "Ephemeral Dream"
                    , rank   = A
                    , icon   = Icon.BusterUp
                    , cd     = 8
                    , effect = [ Grant Self 1 (CardUp Buster) <| Range 30 50
                               , Grant Self 1 Invincibility Full
                               , To Self DemeritHealth <| Flat 1000
                               ]
                    }
                  ]
    , passives  = [avenger B, oblivionCorrection A, selfRestoreMagic APlus]
    , phantasm  = { name   = "La Grondement Du Haine"
                  , rank   = APlus
                  , card   = Buster
                  , kind   = "Anti-Army"
                  , hits   = 10
                  , effect = [ To Enemy Damage <| Range 600 1000
                             , Times 1 <| Debuff Enemy 0 BuffBlock Full
                             ]
                  , over   = [ Debuff Enemy 5 Curse <| Range 500 2500 ]
                  , first  = False
                  }
    , gen       = { starWeight = 29, starRate = 6, npAtk = 0.83, npDef = 5 }
    , hits      = { quick = 3, arts = 2, buster = 4, ex = 7 }
    , gender    = Female
    , traits    = [Humanoid, EnumaElish, Saberface]
    , death     = 5.7
    , align     = [Chaotic, Evil]
    , limited   = True
    , free      = False
    , ascendUp  = Ascension
                  [(ProofOfHero, 10), (VoidsDust, 10)]
                  [(OctupletCrystals, 10), (EternalGear, 10)]
                  [(PhoenixFeather, 10), (ClawOfChaos, 10)]
                  [(TearstoneOfBlood, 10), (HeartOfTheForeignGod, 10)]
    , skillUp   = Reinforcement
                  [(DragonFang, 10)]
                  [(EvilBone, 10)]
                  [(SeedOfYggdrasil, 12)]
                  [(ForbiddenPage, 12)]
                  [(SerpentJewel, 12)]
                  [(GhostLantern, 15)]
                  [(WarhorsesYoungHorn, 15)]
                  [(HeartOfTheForeignGod, 15)]
    }
  , { name      = "Angra Mainyu"
    , spoiler   = Nothing
    , id        = 107
    , rarity    = 0
    , class     = Avenger
    , attr      = Human
    , deck      = Deck Quick Quick Arts Arts Buster
    , curve     = 2
    , stats     = { base  = { atk = 1008, hp = 1502 }
                  , max   = { atk = 5683, hp = 7981 }
                  , grail = { atk = 8235, hp = 11518 }
                  }
    , skills    = [ { name  = "Zarich"
                    , rank   = C
                    , icon    = Icon.ExclamationDown
                    , cd      = 8
                    , effect = [ Debuff Enemy 3 CritChance <| Range 30 50 ]
                    }
                  , { name   = "Tawrich"
                    , rank   = C
                    , icon   = Icon.MagicDark
                    , cd     = 8
                    , effect = [ To Enemy GaugeDown <| Flat 1
                               , Debuff Enemy 3 AttackDown <| Range 10 30
                               ]
                    }
                  , { name   = "The End of Four Nights"
                    , rank   = EX
                    , icon   = Icon.QuickUp
                    , cd     = 9
                    , effect = [ Times 1 << Grant Self 6 GutsPercent <| Flat 50
                               , Grant Self 1 (CardUp Quick) <| Range 20 40
                               , After 1 <| Grant Self 1 (CardUp Quick) <| Range 40 80
                               , After 2 <| Grant Self 1 (CardUp Quick) <| Range 60 120
                               , After 3 <| Grant Self 1 (CardUp Quick) <| Range 80 160
                               , After 4 <| Grant Self 1 (CardUp Quick) <| Range 100 200
                               , After 5 <| To Self DemeritKill Full
                               ]
                    }
                  ]
    , passives  = [avenger A, oblivionCorrection A, selfRestoreMagic E]
    , phantasm  = { name   = "Verg Avesta"
                  , rank   = CMinus
                  , card   = Arts
                  , kind   = "Anti-Unit"
                  , hits   = 1
                  , effect = [ Debuff Self 0 Stun Full
                             , To Enemy Avenge <| Range 200 300
                             ]
                  , over   = [ To Self Heal <| Range 1000 5000 ]
                  , first  = False
                  }
    , gen       = { starWeight = 29, starRate = 6, npAtk = 0.79, npDef = 5 }
    , hits      = { quick = 3, arts = 2, buster = 1, ex = 4 }
    , gender    = Male
    , traits    = [Humanoid, EnumaElish]
    , death     = 9
    , align     = [Chaotic, Evil]
    , limited   = False
    , free      = False
    , ascendUp  = Ascension
                  [(ProofOfHero, 10), (EvilBone, 10)]
                  [(VoidsDust, 10), (BlackBeastGrease, 10)]
                  [(EternalGear, 10), (TearstoneOfBlood, 10)]
                  [(SpiritRoot, 10), (DragonsReverseScale, 10)]
    , skillUp   = Reinforcement
                  [(ProofOfHero, 10)]
                  [(VoidsDust, 10)]
                  [(EvilBone, 12)]
                  [(HomunculusBaby, 12)]
                  [(GhostLantern, 12)]
                  [(EternalGear, 15)]
                  [(TearstoneOfBlood, 15)]
                  [(SpiritRoot, 15)]
    }
  , { name      = "Martha (Ruler)"
    , spoiler   = Nothing
    , id        = 135
    , rarity    = 4
    , class     = Ruler
    , attr      = Human
    , deck      = Deck Quick Arts Buster Buster Buster
    , curve     = 4
    , stats     = { base  = { atk = 1591,  hp = 1800 }
                  , max   = { atk = 9546,  hp = 11250 }
                  , grail = { atk = 11558, hp = 13640 }
                  }
    , skills    = [ { name   = "Saint of the Shore"
                    , rank   = BPlus
                    , icon   = Icon.Noble
                    , cd     = 8
                    , effect = [ To Self GaugeUp <| Range 20 30
                               , When "on Waterside or Beach field" << Grant Self 3 AttackUp <| Range 10 20
                               ]
                    }
                  , { name   = "Natural Body (Sea)"
                    , rank   = A
                    , icon   = Icon.Flex
                    , cd     = 7
                    , effect = [ Grant Self 0 DebuffResist Full
                               , To Self Heal <| Range 1000 3000
                               ]
                    }
                , { name   = "Jacob's Limbs"
                  , rank   = B
                  , icon   = Icon.DamageUp
                  , cd     = 7
                  , effect = [ Grant Self 1 (Special AttackUp <| VsTrait Daemon) <| Range 50 100
                             , Grant Self 1 (Special AttackUp <| VsTrait Divine) <| Range 50 100
                             , Grant Self 1 (Special AttackUp <| VsTrait Undead) <| Range 50 100
                             ]
                  }
                  ]
    , passives  = [magicResistance EX]
    , phantasm  = { name   = "Tarasque"
                  , rank   = A
                  , card   = Buster
                  , kind   = "Anti-Unit/Anti-Dragon"
                  , hits   = 10
                  , effect = [ To Enemy Damage <| Range 600 1000 ]
                  , over   = [ Debuff Enemy 1 DefenseDown <| Range 10 50 ]
                  , first  = True
                  }
    , gen       = { starWeight = 102, starRate = 10, npAtk = 0.76, npDef = 3 }
    , hits      = { quick = 4, arts = 3, buster = 1, ex = 5 }
    , gender    = Female
    , traits    = [Humanoid, EnumaElish]
    , death     = 21
    , align     = [Lawful, Good]
    , limited   = True
    , free      = False
    , ascendUp  = Ascension
                  (pairWith 4 Piece [Saber, Rider, Berserker])
                  (pairWith 4 Piece [Archer, Lancer, Caster, Assassin])
                  (pairWith 4 Monument [Saber, Rider, Berserker])
                  (pairWith 4 Monument [Archer, Lancer, Caster, Assassin])
    , skillUp   = Reinforcement
                  (pairWith 4 GemOf [Saber, Rider, Berserker])
                  (pairWith 4 GemOf [Archer, Lancer, Caster, Assassin])
                  (pairWith 4 MagicGemOf [Saber, Rider, Berserker])
                  (pairWith 4 MagicGemOf [Archer, Lancer, Caster, Assassin])
                  (pairWith 4 SecretGemOf [Saber, Rider, Berserker])
                  (pairWith 4 SecretGemOf [Archer, Lancer, Caster, Assassin])
                  [(TearstoneOfBlood, 6)]
                  [(DragonsReverseScale, 12)]
    }
  , { name      = "Gorgon"
    , spoiler   = Nothing
    , id        = 147
    , rarity    = 4
    , class     = Avenger
    , stats     = { base  = { atk = 1784,  hp = 1631 }
                  , max   = { atk = 10706, hp = 10197 }
                  , grail = { atk = 12963, hp = 12364 }
                  }
    , gen       = { starWeight = 29, starRate = 6, npAtk = 0.37, npDef = 5 }
    , death     = 7
    , curve     = 14
    , attr      = Earth
    , align     = [Chaotic, Evil]
    , gender    = Female
    , traits    = [Humanoid, EnumaElish]
    , deck      = Deck Quick Arts Arts Buster Buster
    , hits      = { quick = 3, arts = 5, buster = 3, ex = 5 }
    , skills    = [ { name   = "Monstrous Strength"
                    , rank   = APlus
                    , icon   = Icon.SwordUp
                    , cd     = 7
                    , effect = [ Grant Self 1 AttackUp <| Range 30 50 ]
                    }
                  , { name   = "Demonic Mutation"
                    , rank   = B
                    , icon   = Icon.Kneel
                    , cd     = 9
                    , effect = [ Times 1 << Grant Self 5 Guts <| Range 1000 3000
                               , Grant Self 3 CritUp <| Range 20 50
                               ]
                    }
                  , { name   = "Mystic Eyes"
                    , rank   = APlusPlus
                    , icon   = Icon.Stun
                    , cd     = 8
                    , effect = [ Chances 55 105 <| Debuff Enemy 1 Stun Full ]
                    }
                  ]
    , passives  = [ avenger B, oblivionCorrection C, selfRestoreMagic A ]
    , phantasm  = { name   = "Pandemonium Cetus"
                  , rank   = APlus
                  , card   = Buster
                  , kind   = "Anti-Army"
                  , hits   = 3
                  , effect = [ To Enemies Damage <| Range 400 600
                             , To Party GaugeUp <| Flat 15
                             ]
                  , over   = [ Debuff Enemies 3 Curse <| Range 1000 3000 ]
                  , first  = False
                  }
    , limited   = False
    , free      = False
    , ascendUp  = Ascension
                  [(SerpentJewel, 8), (EvilBone, 8)]
                  [(DeadlyPoisonousNeedle, 8), (FoolsChain, 8)]
                  [(PrimordialLanugo, 8), (VoidsDust, 8)]
                  [(CursedBeastGallstone, 8), (ClawOfChaos, 8)]
    , skillUp   = Reinforcement
                  [(EvilBone, 8)]
                  [(FoolsChain, 8)]
                  [(SerpentJewel, 10)]
                  [(DeadlyPoisonousNeedle, 10)]
                  [(TearstoneOfBlood, 10)]
                  [(PrimordialLanugo, 12)]
                  [(HeartOfTheForeignGod, 12)]
                  [(CursedBeastGallstone, 12)]
    }
  , { name      = "Hessian Lobo"
    , spoiler   = Just "Shinjuku"
    , id        = 158
    , rarity    = 4
    , class     = Avenger
    , stats     = { base  = { atk = 1771,  hp = 1591 }
                  , max   = { atk = 10628, hp = 9949 }
                  , grail = { atk = 12868, hp = 12063 }
                  }
    , gen       = { starWeight = 29, starRate = 6, npAtk = 0.79, npDef = 5 }
    , death     = 10
    , curve     = 14
    , attr      = Earth
    , align     = [Chaotic, Evil]
    , gender    = Male
    , traits    = [Humanoid, EnumaElish, WildBeast]
    , deck      = Deck Quick Quick Arts Arts Buster
    , hits      = { quick = 3, arts = 2, buster = 2, ex = 5 }
    , skills    = [ { name   = "Fallen Demon"
                    , rank   = APlus
                    , icon   = Icon.StarUp
                    , cd     = 7
                    , effect = [ Grant Self 1 GatherUp <| Range 600 1200
                               , Grant Self 1 DefenseUp <| Range 20 40
                               ]
                    }
                  , { name   = "Monstrous Strength"
                    , rank   = B
                    , icon   = Icon.SwordUp
                    , cd     = 7
                    , effect = [ Grant Self 2 AttackUp <| Range 10 30 ]
                    }
                  , { name   = "One Cloaked in Death"
                    , rank   = A
                    , icon   = Icon.FireDown
                    , cd     = 7
                    , effect = [ Debuff Enemy 1 DeathVuln <| Range 30 50
                               , Debuff Enemy 1 AttackDown <| Range 10 30
                               , To Enemy RemoveBuffs Full
                               ]
                    }
                  ]
    , passives  = [avenger A, oblivionCorrection B, selfRestoreMagic B]
    , phantasm  = { name   = "Frieren Scharfrichter"
                  , rank   = C
                  , card   = Quick
                  , kind   = "Anti-Personnel"
                  , hits   = 8
                  , effect = [ Grant Self 1 SureHit Full
                             , To Enemy Damage <| Range 1200 2000
                             ]
                  , over   = [ To Enemy Death <| Range 60 100 ]
                  , first  = True
                  }
    , limited   = False
    , free      = False
    , ascendUp  = Ascension
                  [(EvilBone, 8), (GhostLantern, 8)]
                  [(BlackBeastGrease, 8), (VoidsDust, 8)]
                  [(TearstoneOfBlood, 8), (MysticSpinalFluid, 8)]
                  [(CursedBeastGallstone, 8), (PrimordialLanugo, 8)]
    , skillUp   = Reinforcement
                  [(EvilBone, 8)]
                  [(VoidsDust, 8)]
                  [(GhostLantern, 10)]
                  [(ShellOfReminiscence, 10)]
                  [(ClawOfChaos, 10)]
                  [(BlackBeastGrease, 12)]
                  [(TearstoneOfBlood, 12)]
                  [(CursedBeastGallstone, 12)]
    }
  , { name      = "Meltryllis"
    , spoiler   = Nothing
    , id        = 163
    , rarity    = 5
    , class     = AlterEgo
    , stats     = { base  = { atk = 1807,  hp = 1965 }
                  , max   = { atk = 11692, hp = 13402 }
                  , grail = { atk = 12799, hp = 14682 }
                  }
    , gen       = { starWeight = 100, starRate = 10.2, npAtk = 0.92, npDef = 4 }
    , death     = 30
    , curve     = 5
    , attr      = Earth
    , align     = [Lawful, Good]
    , gender    = Female
    , traits    = [Humanoid, Divine, Riding]
    , deck      = Deck Quick Quick Arts Buster Buster
    , hits      = { quick = 4, arts = 2, buster = 1, ex = 6 }
    , skills    = [ { name   = "Crime Ballet"
                    , rank   = A
                    , icon   = Icon.Dodge
                    , cd     = 7
                    , effect = [ To Party GainStars <| Range 5 15
                               , Times 2 <| Grant Self 3 Evasion Full
                               ]
                    }
                  , { name   = "Sadistic Streak"
                    , rank   = A
                    , icon   = Icon.SwordUp
                    , cd     = 7
                    , effect = [ Grant Self 3 AttackUp <| Range 10 30
                               , Debuff Self 3 DefenseDown <| Flat 10
                               ]
                    }
                  , { name   = "Melt Virus"
                    , rank   = EX
                    , icon   = Icon.BeamDown
                    , cd     = 8
                    , effect = [ Debuff Enemies 1 NPDown <| Range 20 50
                               , Grant Self 2 NPUp <| Range 20 30
                               , Debuff Others 1 NPDown <| Flat 50
                               ]
                    }
                  ]
    , passives  = [magicResistance B, riding B, independentAction A, coreOfGoddess B, highServant A ]
    , phantasm  = { name   = "Saraswati Meltout"
                  , rank   = EX
                  , card   = Quick
                  , kind   = "Anti-Personnel"
                  , hits   = 8
                  , effect = [ To Enemy Damage <| Range 1200 2000
                             , To Enemy RemoveBuffs Full
                             ]
                  , over   = [ Grant Self 3 (CardUp Quick) <| Range 10 30 ]
                  , first  = False
                  }
    , limited   = False
    , free      = False
    , ascendUp  = Ascension
                  [(Piece Lancer, 5), (Piece Assassin, 5)]
                  [(Piece Lancer, 12), (Piece Assassin, 12)]
                  [(Monument Lancer, 5), (Monument Assassin, 5)]
                  [(Monument Lancer, 12), (Monument Assassin, 12)]
    , skillUp   = Reinforcement
                  [(GemOf Lancer, 5), (GemOf Assassin, 5)]
                  [(GemOf Lancer, 12), (GemOf Assassin, 12)]
                  [(MagicGemOf Lancer, 5), (MagicGemOf Assassin, 5)]
                  [(MagicGemOf Lancer, 12), (MagicGemOf Assassin, 12)]
                  [(SecretGemOf Lancer, 5), (SecretGemOf Assassin, 5)]
                  [(SecretGemOf Lancer, 12), (SecretGemOf Assassin, 12)]
                  [(WarhorsesYoungHorn, 5), (PrimordialLanugo, 5)]
                  [(DragonsReverseScale, 9), (ScarabOfWisdom, 9)]
    }
  , { name      = "Passionlip"
    , spoiler   = Nothing
    , id        = 164
    , rarity    = 4
    , class     = AlterEgo
    , stats     = { base  = { atk = 1716,  hp = 1744 }
                  , max   = { atk = 10299, hp = 10901 }
                  , grail = { atk = 12470, hp = 13217 }
                  }
    , gen       = { starWeight = 97, starRate = 9.9, npAtk = 0.77, npDef = 4 }
    , death     = 35
    , curve     = 24
    , attr      = Earth
    , align     = [Lawful, Balanced]
    , gender    = Female
    , traits    = [Humanoid, Divine, EnumaElish]
    , deck      = Deck Quick Arts Buster Buster Buster
    , hits      = { quick = 4, arts = 3, buster = 1, ex = 5 }
    , skills    = [ { name   = "Breast Valley"
                    , rank   = A
                    , icon   = Icon.ShieldUp
                    , cd     = 7
                    , effect = [ Times 3 << Grant Self 5 DamageCut <| Range 500 1000
                               , Times 3 <| Grant Self 5 DebuffResist Full
                               ]
                    }
                  , { name   = "Masochistic Constitution"
                    , rank   = A
                    , icon   = Icon.CrosshairUp
                    , cd     = 6
                    , effect = [ Grant Self 1 DefenseUp <| Range 10 30
                               , Chance 30 <| Grant Self 1 Taunt Full
                               ]
                    }
                  , { name   = "Trash and Crush"
                    , rank   = EX
                    , icon   = Icon.SwordShieldUp
                    , cd     = 8
                    , effect = [ Grant Self 3 AttackUp <| Range 10 30
                               , Grant Self 1 DefenseUp <| Range 10 30
                               , Grant Self 3 IgnoreInvinc Full
                               , When "attacking" << To Enemy Death <| Flat 10
                               ]
                    }
                  ]
    , passives  = [magicResistance C, independentAction C, presenceConcealment APlus, coreOfGoddess C, highServant A]
    , phantasm  = { name   = "Brynhild Romantia"
                  , rank   = C
                  , card   = Buster
                  , kind   = "Anti-Unit"
                  , hits   = 12
                  , effect = [ To Enemies Damage <| Range 300 500 ]
                  , over   = [ To Party Heal <| Range 2000 4000 ]
                  , first  = False
                  }
    , limited   = True
    , free      = False
    , ascendUp  = Ascension
                  [(Piece Archer, 4), (Piece Berserker, 4)]
                  [(Piece Archer, 10), (Piece Berserker, 10)]
                  [(Monument Archer, 4), (Monument Berserker, 4)]
                  [(Monument Archer, 10), (Monument Berserker, 10)]
    , skillUp   = Reinforcement
                  [(GemOf Archer, 4), (GemOf Berserker, 4)]
                  [(GemOf Archer, 10), (GemOf Berserker, 10)]
                  [(MagicGemOf Archer, 4), (MagicGemOf Berserker, 4)]
                  [(MagicGemOf Archer, 10), (MagicGemOf Berserker, 10)]
                  [(SecretGemOf Archer, 4), (SecretGemOf Berserker, 4)]
                  [(SecretGemOf Archer, 10), (SecretGemOf Berserker, 10)]
                  [(TearstoneOfBlood, 4), (ClawOfChaos, 4)]
                  [(SpiritRoot, 7), (CursedBeastGallstone, 7)]
    }
  , { name      = "BB"
    , spoiler   = Nothing
    , id        = 166
    , rarity    = 4
    , class     = MoonCancer
    , stats     = { base  = { atk = 1366, hp = 2182 }
                  , max   = { atk = 8197, hp = 13643 }
                  , grail = { atk = 9925, hp = 16542 }
                  }
    , gen       = { starWeight = 52, starRate = 14.7, npAtk = 0.61, npDef = 3 }
    , death     = 0.6
    , curve     = 4
    , attr      = Human
    , align     = [Chaotic, Good]
    , gender    = Female
    , traits    = [Humanoid, EnumaElish]
    , deck      = Deck Quick Quick Arts Arts Buster
    , hits      = { quick = 4, arts = 3, buster = 1, ex = 4 }
    , skills    = [ { name   = "Domina Cornam"
                    , rank   = D
                    , icon   = Icon.Heal
                    , cd     = 6
                    , effect = [ To Ally RemoveDebuffs Full
                               , To Ally Heal <| Range 1000 3000
                               , Times 1 <| Grant Ally 3 DebuffResist Full
                               ]
                    }
                  , { name   = "Aurea Poculum"
                    , rank   = C
                    , icon   = Icon.Stun
                    , cd     = 8
                    , effect = [ Chances 50 100 <| Debuff Enemy 1 Stun Full
                               , To Enemy (Remove Invincibility) Full
                               , To Enemy (Remove Evasion) Full
                              ]
                    }
                  , { name   = "Self-Modification"
                    , rank   = EX
                    , icon   = Icon.ExclamationUp
                    , cd     = 7
                    , effect = [ Grant Self 3 CritUp <| Range 20 50
                               , Grant Self 3 GatherUp <| Range 400 800
                               ]
                    }
                  ]
    , passives  = [magicResistance B, itemConstruction A, territoryCreation A]
    , phantasm  = { name   = "Cursed Cupid Cleanser"
                  , rank   = A
                  , card   = Arts
                  , kind   = "Anti-Personnel"
                  , hits   = 5
                  , effect = [ To Enemy Damage <| Range 900 1500
                             , To Party GaugeUp <| Flat 20
                             ]
                  , over   = [ Debuff Enemy 3 DebuffVuln <| Range 10 50 ]
                  , first  = False
                  }
    , limited   = True
    , free      = True
    , ascendUp  = Welfare "Nostalgic Ribbon"
    , skillUp   = Reinforcement
                  [(GemOf Caster, 4), (GemOf Rider, 4)]
                  [(GemOf Caster, 10), (GemOf Rider, 10)]
                  [(MagicGemOf Caster, 4), (MagicGemOf Rider, 4)]
                  [(MagicGemOf Caster, 10), (MagicGemOf Rider, 10)]
                  [(SecretGemOf Caster, 4), (SecretGemOf Rider, 4)]
                  [(SecretGemOf Caster, 10), (SecretGemOf Rider, 10)]
                  [(PrimordialLanugo, 4), (LampOfEvilSealing, 4)]
                  [(SpiritRoot, 7), (ScarabOfWisdom, 7)]
    }
  , { name      = "Sessyoin Kiara"
    , spoiler   = Nothing
    , id        = 167
    , rarity    = 5
    , class     = AlterEgo
    , stats     = { base  = { atk = 1803,  hp = 2142 }
                  , max   = { atk = 11668, hp = 14606 }
                  , grail = { atk = 12772, hp = 16001 }
                  }
    , gen       = { starWeight = 97, starRate = 10, npAtk = 0.55, npDef = 4 }
    , death     = 25
    , curve     = 15
    , attr      = Beast
    , align     = [Chaotic, Evil]
    , gender    = Female
    , traits    = [Humanoid]
    , deck      = Deck Quick Arts Arts Buster Buster
    , hits      = { quick = 3, arts = 3, buster = 1, ex = 5 }
    , skills    = [ { name   = "Clairvoyance (Beast)"
                    , rank   = DPlusPlusPlus
                    , icon   = Icon.HoodDown
                    , cd     = 8
                    , effect = [ Debuff Enemy 1 DebuffVuln <| Range 50 100
                               , Debuff Enemy 1 (CardVuln Arts) <| Range 20 30
                               , To Self GaugeUp <| Range 30 50
                               ]
                    }
                  , { name   = "Five Approaches to Meditation"
                    , rank   = A
                    , icon   = Icon.MagicDark
                    , cd     = 9
                    , effect = [ Debuff Enemies 3 DefenseDown <| Range 10 30
                               , To Enemies GaugeDown <| Flat 1
                               ]
                    }
                  , { name   = "Goddess Morph"
                    , rank   = EX
                    , icon   = Icon.Shield
                    , cd     = 8
                    , effect = [ Grant Self 1 NPGen <| Range 30 50
                               , Grant Self 1 CritUp <| Range 30 50
                               , Grant Self 1 HealingReceived <| Range 30 50
                               , Grant Self 1 DebuffResist <| Range 30 50
                               , Grant Self 1 Invincibility Full
                               , To Self DemeritHealth <| Flat 3000
                               ]
                    }
                  ]
    , passives  = [authorityOfBeasts D, independentManifestation E, logosEater C, negaSaver A]
    , phantasm  = { name   = "Amitābha Amidala・Heaven's Hole"
                  , rank   = EX
                  , card   = Arts
                  , kind   = "Anti-Personnel"
                  , hits   = 3
                  , effect = [ Grant Self 1 IgnoreInvinc Full
                             , To Enemies DamageThruDef <| Range 450 750
                             ]
                  , over   = [ To Self Heal <| Range 2000 6000 ]
                  , first  = False
                  }
    , limited   = True
    , free      = False
    , ascendUp  = Ascension
                  [(Piece Saber, 5), (Piece Caster, 5)]
                  [(Piece Saber, 12), (Piece Caster, 12)]
                  [(Monument Saber, 5), (Monument Caster, 5)]
                  [(Monument Saber, 12), (Monument Caster, 12)]
    , skillUp   = Reinforcement
                  [(GemOf Saber, 5), (GemOf Caster, 5)]
                  [(GemOf Saber, 12), (GemOf Caster, 12)]
                  [(MagicGemOf Saber, 5), (MagicGemOf Caster, 5)]
                  [(MagicGemOf Saber, 12), (MagicGemOf Caster, 12)]
                  [(SecretGemOf Saber, 5), (SecretGemOf Caster, 5)]
                  [(SecretGemOf Saber, 12), (SecretGemOf Caster, 12)]
                  [(BlackBeastGrease, 5), (LampOfEvilSealing, 5)]
                  [(CursedBeastGallstone, 9), (HeartOfTheForeignGod, 9)]
    }
  , { name      = "Sherlock Holmes"
    , spoiler   = Nothing
    , id        = 173
    , rarity    = 5
    , class     = Ruler
    , stats     = { base  = { atk = 1776,  hp = 1960 }
                  , max   = { atk = 11495, hp = 13365 }
                  , grail = { atk = 12583, hp = 14642 }
                  }
    , gen       = { starWeight = 100, starRate = 10, npAtk = 0.76, npDef = 3 }
    , death     = 24.5
    , curve     = 5
    , attr      = Star
    , align     = [Neutral, Good]
    , gender    = Male
    , traits    = [Humanoid]
    , deck      = Deck Quick Quick Arts Arts Buster
    , hits      = { quick = 3, arts = 3, buster = 4, ex = 5 }
    , skills    = [ { name   = "Gift of Insight"
                    , rank   = APlusPlus
                    , icon   = Icon.Circuits
                    , cd     = 7
                    , effect = [ To Party GainStars <| Range 10 20
                               , Debuff Enemy 1 SealNP Full
                               ]
                    }
                  , { name   = "Hypothetical Reasoning"
                    , rank   = APlus
                    , icon   = Icon.StarUp
                    , cd     = 7
                    , effect = [ Grant Self 1 GatherUp <| Range 300 600
                               , Grant Self 3 DebuffResist Full
                               ]
                    }
                  , { name   = "Baritsu"
                    , rank   = BPlusPlus
                    , icon   = Icon.ArtsUp
                    , cd     = 7
                    , effect = [ Grant Self 1 (CardUp Arts) <| Range 30 50
                               , Grant Self 1 Evasion Full
                               ]
                    }
                  ]
    , passives  = [territoryCreation EX]
    , phantasm  = { name   = "Elementary, My Dear"
                  , rank   = B
                  , card   = Arts
                  , kind   = "Anti-Personnel/Anti-World"
                  , hits   = 0
                  , effect = [ Debuff Enemies 3 DefenseDown <| Flat 500
                             , Grant Party 3 IgnoreDef Full
                             , Grant Party 3 IgnoreInvinc Full
                             ]
                  , over   = [ Grant Party 3 CritUp <| Range 50 100 ]
                  , first  = False
                  }
    , limited   = True
    , free      = False
    , ascendUp  = Ascension
                  [(Piece Archer, 5), (Piece Caster, 5), (Piece Assassin, 5)]
                  [(Piece Saber, 5), (Piece Lancer, 5), (Piece Rider, 5), (Piece Berserker, 5)]
                  [(Monument Archer, 5), (Monument Caster, 5), (Monument Assassin, 5)]
                  [(Monument Saber, 5), (Monument Lancer, 5), (Monument Rider, 5), (Monument Berserker, 5)]
    , skillUp   = Reinforcement
                  [(GemOf Archer, 5), (GemOf Caster, 5), (GemOf Assassin, 5)]
                  [(GemOf Saber, 5), (GemOf Lancer, 5), (GemOf Rider, 5), (GemOf Berserker, 5)]
                  [(MagicGemOf Archer, 5), (MagicGemOf Caster, 5), (MagicGemOf Assassin, 5)]
                  [(MagicGemOf Saber, 5), (MagicGemOf Lancer, 5), (MagicGemOf Rider, 5), (MagicGemOf Berserker, 5)]
                  [(SecretGemOf Archer, 5), (SecretGemOf Caster, 5), (SecretGemOf Assassin, 5)]
                  [(SecretGemOf Saber, 5), (SecretGemOf Lancer, 5), (SecretGemOf Rider, 5), (SecretGemOf Berserker, 5)]
                  [(ForbiddenPage, 12)]
                  [(ScarabOfWisdom, 15)]
    }
  , { name      = "Mecha Eli-chan"
    , spoiler   = Nothing
    , id        = 190
    , rarity    = 4
    , class     = AlterEgo
    , stats     = { base  = { atk = 1666,  hp = 1744 }
                  , max   = { atk = 9997,  hp = 10901 }
                  , grail = { atk = 12104, hp = 13217 }
                  }
    , gen       = { starWeight = 97, starRate = 9.7, npAtk = 0.9, npDef = 4 }
    , death     = 50
    , curve     = 4
    , attr      = Human
    , align     = [Lawful, Good]
    , gender    = Female
    , traits    = [Humanoid, EnumaElish, ThreatToHumanity]
    , deck      = Deck Quick Arts Buster Buster Buster
    , hits      = { quick = 4, arts = 3, buster = 2, ex = 4 }
    , skills    = [ { name   = "Innocent Monstrosity"
                    , rank   = EX
                    , icon   = Icon.StarTurn
                    , cd     = 7
                    , effect = [ Grant Self 3 StarsPerTurn <| Range 5 10
                               , Grant Self 3 DefenseUp <| Range 20 30
                               ]
                    }
                  , { name   = "Overload MkII"
                    , rank   = C
                    , icon   = Icon.Noble
                    , cd     = 7
                    , effect = [ To Self GaugeUp <| Range 10 20
                               , To Self DemeritHealth <| Flat 500
                               ]
                    }
                  , { name   = "Final Eli-chan"
                    , rank   = C
                    , icon   = Icon.BeamUp
                    , cd     = 7
                    , effect = [ Grant Self 1 NPUp <| Range 40 60
                               , Grant Self 1 CritUp <| Range 40 60
                               , To Self (Remove DefenseUp) Full
                               , To Self (Remove Evasion) Full
                               , To Self (Remove Invincibility) Full
                               ]
                    }
                  ]
    , passives  = [magicResistance B, itemConstruction B]
    , phantasm  = { name   = "Breast Zero Erzsébet"
                  , rank   = B
                  , card   = Buster
                  , kind   = "Anti-Army"
                  , hits   = 8
                  , effect = [ To Enemy Damage <| Range 600 1000
                             , To Enemy (Remove DefenseUp) Full
                             , To Enemy (Remove DeathResist) Full
                             ]
                  , over   = [ Debuff Enemy 3 DefenseDown <| Range 20 40 ]
                  , first  = False
                  }
    , limited   = True
    , free      = True
    , ascendUp  = Welfare "B Pellets"
    , skillUp   = Reinforcement
                  [(GemOf Rider, 4), (GemOf Berserker, 4)]
                  [(GemOf Rider, 10), (GemOf Berserker, 10)]
                  [(MagicGemOf Rider, 4), (MagicGemOf Berserker, 4)]
                  [(MagicGemOf Rider, 10), (MagicGemOf Berserker, 10)]
                  [(SecretGemOf Rider, 4), (SecretGemOf Berserker, 4)]
                  [(SecretGemOf Rider, 10), (SecretGemOf Berserker, 10)]
                  [(TearstoneOfBlood, 4), (BlackBeastGrease, 4)]
                  [(DragonsReverseScale, 7), (MysteriousDivineWine, 7)]
    }
  , { name      = "Mecha Eli-chan MkII"
    , spoiler   = Nothing
    , id        = 191
    , rarity    = 4
    , class     = AlterEgo
    , stats     = { base  = { atk = 1666,  hp = 1744 }
                  , max   = { atk = 9997,  hp = 10901 }
                  , grail = { atk = 12104, hp = 13217 }
                  }
    , gen       = { starWeight = 97, starRate = 9.7, npAtk = 0.9, npDef = 4 }
    , death     = 50
    , curve     = 4
    , attr      = Human
    , align     = [Lawful, Good]
    , gender    = Female
    , traits    = [Humanoid, EnumaElish, ThreatToHumanity]
    , deck      = Deck Quick Arts Buster Buster Buster
    , hits      = { quick = 4, arts = 3, buster = 2, ex = 4 }
    , skills    = [ { name   = "Innocent Monstrosity"
                    , rank   = EX
                    , icon   = Icon.StarTurn
                    , cd     = 7
                    , effect = [ Grant Self 3 StarsPerTurn <| Range 5 10
                               , Grant Self 3 DefenseUp <| Range 20 30
                               ]
                    }
                  , { name   = "Overload MkII"
                    , rank   = C
                    , icon   = Icon.Noble
                    , cd     = 7
                    , effect = [ To Self GaugeUp <| Range 10 20
                               , To Self DemeritHealth <| Flat 500
                               ]
                    }
                  , { name   = "Final Eli-chan"
                    , rank   = C
                    , icon   = Icon.BeamUp
                    , cd     = 7
                    , effect = [ Grant Self 1 NPUp <| Range 40 60
                               , Grant Self 1 CritUp <| Range 40 60
                               , To Self (Remove DefenseUp) Full
                               , To Self (Remove Evasion) Full
                               , To Self (Remove Invincibility) Full
                               ]
                    }
                  ]
    , passives  = [magicResistance B, itemConstruction B]
    , phantasm  = { name   = "Breast Zero Erzsébet"
                  , rank   = B
                  , card   = Buster
                  , kind   = "Anti-Army"
                  , hits   = 8
                  , effect = [ To Enemy Damage <| Range 600 1000
                             , To Enemy (Remove DefenseUp) Full
                             , To Enemy (Remove DeathResist) Full
                             ]
                  , over   = [ Debuff Enemy 3 DefenseDown <| Range 20 40 ]
                  , first  = False
                  }
    , limited   = True
    , free      = True
    , ascendUp  = Welfare "B Pellets"
    , skillUp   = Reinforcement
                  [(GemOf Rider, 4), (GemOf Berserker, 4)]
                  [(GemOf Rider, 10), (GemOf Berserker, 10)]
                  [(MagicGemOf Rider, 4), (MagicGemOf Berserker, 4)]
                  [(MagicGemOf Rider, 10), (MagicGemOf Berserker, 10)]
                  [(SecretGemOf Rider, 4), (SecretGemOf Berserker, 4)]
                  [(SecretGemOf Rider, 10), (SecretGemOf Berserker, 10)]
                  [(TearstoneOfBlood, 4), (BlackBeastGrease, 4)]
                  [(DragonsReverseScale, 7), (MysteriousDivineWine, 7)]
    }
  , { name      = "Abigail Williams"
    , spoiler   = Nothing
    , id        = 195
    , rarity    = 5
    , class     = Foreigner
    , stats     = { base  = { atk = 1870,  hp = 2019 }
                  , max   = { atk = 12100, hp = 13770 }
                  , grail = { atk = 13245, hp = 15086 }
                  }
    , gen       = { starWeight = 148, starRate = 14.8, npAtk = 0.25, npDef = 3 }
    , death     = 7
    , curve     = 30
    , attr      = Earth
    , align     = [Chaotic, Evil]
    , gender    = Female
    , traits    = [Humanoid, Divine, ThreatToHumanity]
    , deck      = Deck Quick Arts Arts Arts Buster
    , hits      = { quick = 4, arts = 6, buster = 4, ex = 5 }
    , skills    = [ { name   = "Prayer of Faith"
                    , rank   = C
                    , icon   = Icon.NobleTurn
                    , cd     = 9
                    , effect = [ Grant Party 3 NPUp <| Range 20 30
                               , Grant Party 3 GaugePerTurn <| Flat 10
                               ]
                    }
                  , { name   = "Loss of Sanity"
                    , rank   = B
                    , icon   = Icon.Stun
                    , cd     = 9
                    , effect = [ Debuff Enemies 3 Fear <| Range 30 50
                               , Debuff Enemies 3 DefenseDown <| Range 10 20
                               ]
                    }
                  , { name   = "Witch's Trial"
                    , rank   = APlus
                    , icon   = Icon.MagicDark
                    , cd     = 9
                    , effect = [ Debuff Enemy 3 AttackDown <| Range 10 20
                               , To Enemy GaugeDown <| Flat 1
                               ]
                    }
                  ]
    , passives  = [entityOfTheOuterRealms EX, insanity B, divinity B]
    , phantasm  = { name   = "Qliphoth Rhizome"
                  , rank   = EX
                  , card   = Buster
                  , kind   = "Anti-Personnel"
                  , hits   = 4
                  , effect = [ To Enemy RemoveBuffs Full
                             , To Enemy Damage <| Range 600 1000
                             ]
                  , over   = [ Debuff Enemy 1 CritChance <| Range 30 70 ]
                  , first  = False
                  }
    , limited   = True
    , free      = False
    , ascendUp  = Ascension
                  [(VoidsDust, 10), (ForbiddenPage, 10)]
                  [(SerpentJewel, 10), (ClawOfChaos, 10)]
                  [(BlackBeastGrease, 10), (TearstoneOfBlood, 10)]
                  [(StakeOfWailingNight, 10), (CursedBeastGallstone, 10)]
    , skillUp   = Reinforcement
                  [(SeedOfYggdrasil, 10)]
                  [(FoolsChain, 10)]
                  [(MysticSpinalFluid, 12)]
                  [(HomunculusBaby, 12)]
                  [(PhoenixFeather, 12)]
                  [(LampOfEvilSealing, 15)]
                  [(SpiritRoot, 15)]
                  [(HeartOfTheForeignGod, 15)]
    }
  , { name      = "Katsushika Hokusai"
    , spoiler   = Nothing
    , id        = 198
    , rarity    = 5
    , class     = Foreigner
    , stats     = { base  = { atk = 1870,  hp = 1940 }
                  , max   = { atk = 12100, hp = 13230 }
                  , grail = { atk = 13245, hp = 14494 }
                  }
    , gen       = { starWeight = 153, starRate = 7, npAtk = 0.33, npDef = 3 }
    , death     = 15
    , curve     = 15
    , attr      = Human
    , align     = [Chaotic, Balanced]
    , gender    = Female
    , traits    = [Humanoid, Divine, EnumaElish, ThreatToHumanity]
    , deck      = Deck Quick Arts Arts Buster Buster
    , hits      = { quick = 4, arts = 6, buster = 4, ex = 4 }
    , skills    = [ { name   = "All of Creation"
                    , rank   = APlus
                    , icon   = Icon.Dodge
                    , cd     = 7
                    , effect = [ To Self GaugeUp <| Range 20 30
                               , Grant Self 1 Evasion Full
                               ]
                    }
                  , { name   = "The Bond Between Father and Daughter"
                    , rank   = A
                    , icon   = Icon.ArtsUp
                    , cd     = 7
                    , effect = [ Grant Self 3 (CardUp Arts) <| Range 20 30
                               , Grant Self 3 BuffRemoveResist <| Range 50 100
                               , Grant Self 1 DebuffResist <| Range 50 100
                               ]
                    }
                  , { name   = "Pseudonym \"Iseidako\""
                    , rank   = B
                    , icon   = Icon.Wave
                    , cd     = 8
                    , effect = [ When "attacking with an Arts Card for 3 turns" << Debuff Enemy 3 DefenseDown <| Range 10 20 ]
                    }
                  ]
    , passives  = [entityOfTheOuterRealms EX, itemConstruction B, territoryCreation D, divinity B]
    , phantasm  = { name   = "Thirty-Six Views of Mount Fuji"
                  , rank   = A
                  , card   = Arts
                  , kind   = "Anti-Army"
                  , hits   = 5
                  , effect = [ To Enemies Damage <| Range 450 750 ]
                  , over   = [ To Enemies (SpecialDamage <| VsAttribute Human) <| Range 150 200 ]
                  , first  = False
                  }
    , limited   = True
    , free      = False
    , ascendUp  = Ascension
                  [(DragonFang, 10), (SeedOfYggdrasil, 10)]
                  [(PhoenixFeather, 10), (MeteorHorseshoe, 10)]
                  [(PrimordialLanugo, 10), (SpiritRoot, 10)]
                  [(RefinedMagatama, 10), (ScarabOfWisdom, 10)]
    , skillUp   = Reinforcement
                  [(EvilBone, 10)]
                  [(VoidsDust, 10)]
                  [(ForbiddenPage, 12)]
                  [(OctupletCrystals, 12)]
                  [(GhostLantern, 12)]
                  [(BlackBeastGrease, 15)]
                  [(DragonsReverseScale, 15)]
                  [(CursedBeastGallstone, 15)]
    }
  , { name      = "Antonio Salieri"
    , spoiler   = Nothing
    , id        = 204
    , rarity    = 3
    , class     = Avenger
    , stats     = { base  = { atk = 1509,  hp = 1411 }
                  , max   = { atk = 8125,  hp = 7840 }
                  , grail = { atk = 10996, hp = 10630 }
                  }
    , gen       = { starWeight = 30, starRate = 6.1, npAtk = 0.7, npDef = 5 }
    , death     = 8
    , curve     = 3
    , attr      = Human
    , align     = [Chaotic, Evil]
    , gender    = Male
    , traits    = [Humanoid, EnumaElish]
    , deck      = Deck Quick Arts Arts Buster Buster
    , hits      = { quick = 3, arts = 2, buster = 2, ex = 5 }
    , skills    = [ { name   = "Innocent Monster"
                    , rank   = EX
                    , icon   = Icon.StarTurn
                    , cd     = 7
                    , effect = [ Grant Self 3 StarsPerTurn <| Range 6 12
                               , Times 3 << Grant Self 5 CritUp <| Range 20 30
                               ]
                    }
                  , { name   = "Lamenting Exterior"
                    , rank   = A
                    , icon   = Icon.ArtsUp
                    , cd     = 7
                    , effect = [ Times 3 << Grant Self 5 (CardUp Arts) <| Range 20 30 ]
                    }
                  , { name   = "Wildfire"
                    , rank   = B
                    , icon   = Icon.ShieldDown
                    , cd     = 7
                    , effect = [ Times 3 << Debuff Enemies 5 DefenseDown <| Range 20 30 ]
                    }
                  ]
    , passives  = [avenger C, oblivionCorrection B, selfRestoreMagic C]
    , phantasm  = { name   = "Dio Santissimo Misericordia de Mi"
                  , rank   = C
                  , card   = Arts
                  , kind   = "Anti-Army"
                  , hits   = 3
                  , effect = [ To Enemies Damage <| Range 450 750
                             , Debuff Party 3 StarDown <| Flat 20
                             ]
                  , over   = [ Debuff Enemies 3 (CardVuln Arts) <| Range 10 30 ]
                  , first  = False
                  }
    , limited   = False
    , free      = False
    , ascendUp  = Ascension
                  [(VoidsDust, 8), (EvilBone, 8)]
                  [(ForbiddenPage, 8), (EternalGear, 8)]
                  [(GhostLantern, 8), (LampOfEvilSealing, 8)]
                  [(HeartOfTheForeignGod, 8), (TearstoneOfBlood, 8)]
    , skillUp   = Reinforcement
                  [(FoolsChain, 8)]
                  [(DeadlyPoisonousNeedle, 8)]
                  [(MysticSpinalFluid, 10)]
                  [(PhoenixFeather, 10)]
                  [(StakeOfWailingNight, 10)]
                  [(MysticGunpowder, 12)]
                  [(EternalIce, 12)]
                  [(ScarabOfWisdom, 12)]
    }
  ]
