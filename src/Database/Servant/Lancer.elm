module Database.Servant.Lancer exposing (lancers)

import Database.Base exposing (..)
import Database.Passive exposing (..)
import Database.Servant exposing (..)
import Database.Skill exposing (..)

import Database.Icon as Icon

lancers : List Servant
lancers =
  [ { name      = "Cu Chulainn"
    , spoiler   = Nothing
    , id        = 17
    , rarity    = 3
    , class     = Lancer
    , attr      = Sky
    , deck      = Deck Quick Quick Arts Buster Buster
    , curve     = 8
    , stats     = { base  = { atk = 1334, hp = 1726 }
                  , max   = { atk = 7239, hp = 9593 }
                  , grail = { atk = 9797, hp = 13007 }
                  }
    , skills    = [ { name   = "Battle Continuation"
                    , rank   = A
                    , icon   = Icon.Kneel
                    , cd     = 9
                    , effect = [ Times 1 << Grant Self 5 Guts <| Range 1000 2500 ]
                    }
                  , { name   = "Protection from Arrows"
                    , rank   = B
                    , icon   = Icon.Dodge
                    , cd     = 7
                    , effect = [ Times 3 <| Grant Self 0 Evasion Full
                               , Grant Self 3 DefenseUp <| Range 8 16
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
    , passives  = [magicResistance C, divinity B]
    , phantasm  = { name   = "Gáe Bolg"
                  , desc   = "Barbed Spear that Pierces with Death"
                  , rank   = B
                  , card   = Quick
                  , kind   = "Anti-Personnel"
                  , hits   = 1
                  , effect = [ To Enemy Damage <| Range 1200 2000 ]
                  , over   = [ To Enemy Death <| Range 50 100
                             , Debuff Enemy 3 DefenseDown <| Range 10 30
                             ]
                  , first  = True
                  }
    , gen       = { starWeight = 87, starRate = 12.1, npAtk = 1.07, npDef = 4 }
    , hits      = { quick = 2, arts = 2, buster = 1, ex = 3 }
    , gender    = Male
    , traits    = [Humanoid, Divine, LovedOne, EnumaElish]
    , death     = 32
    , align     = [Lawful, Balanced]
    , limited   = False
    , free      = False
    , ascendUp  = Ascension
                  [(Piece Lancer, 4)]
                  [(Piece Lancer, 8), (ClawOfChaos, 3)]
                  [(Monument Lancer, 4), (SeedOfYggdrasil, 8), (OctupletCrystals, 4)]
                  [(Monument Lancer, 8), (OctupletCrystals, 7), (PhoenixFeather, 7)]
    , skillUp   = Reinforcement
                  [(GemOf Lancer, 4)]
                  [(GemOf Lancer, 8)]
                  [(MagicGemOf Lancer, 4)]
                  [(MagicGemOf Lancer, 8), (SeedOfYggdrasil, 4)]
                  [(SecretGemOf Lancer, 4), (SeedOfYggdrasil, 8)]
                  [(SecretGemOf Lancer, 8), (ClawOfChaos, 2)]
                  [(ClawOfChaos, 4), (ProofOfHero, 12)]
                  [(ProofOfHero, 36), (PhoenixFeather, 13)]
    }
  , { name      = "Elisabeth Bathory"
    , spoiler   = Nothing
    , id        = 18
    , rarity    = 4
    , class     = Lancer
    , attr      = Man
    , deck      = Deck Quick Quick Arts Buster Buster
    , curve     = 4
    , stats     = { base  = { atk = 1520,  hp = 1899 }
                  , max   = { atk = 9122,  hp = 11870 }
                  , grail = { atk = 11045, hp = 14392 }
                  }
    , skills    = [ { name   = "Sadistic Charisma"
                    , rank   = C
                    , icon   = Icon.SwordUp
                    , cd     = 7
                    , effect = [ Grant Party 3 AttackUp <| Range 10 20
                               , Grant (AlliesType Female) 3 AttackUp <| Range 10 20
                               ]
                    }
                  , { name   = "Torture Technique"
                    , rank   = A
                    , icon   = Icon.ShieldDown
                    , cd     = 7
                    , effect = [ Debuff Enemy 3 DefenseDown <| Range 10 20 ]
                    }
                  , { name   = "Battle Continuation"
                    , rank   = B
                    , icon   = Icon.Kneel
                    , cd     = 9
                    , effect = [ Times 1 << Grant Self 4 Guts <| Range 750 2000 ]
                    }
                  ]
    , passives  = [magicResistance A, territoryCreation B]
    , phantasm  = { name   = "Báthory Erzsébet"
                  , desc   = "Fresh Blood Demoness"
                  , rank   = EPlus
                  , card   = Buster
                  , kind   = "Anti-Personnel"
                  , hits   = 5
                  , effect = [ To Enemies DamageThruDef <| Range 400 600
                             , Debuff Enemies 3 DebuffDown <| Flat 20
                             ]
                  , over   = [ Debuff Enemies 3 Curse <| Range 500 2500 ]
                  , first  = False
                  }
    , gen       = { starWeight = 90, starRate = 11.8, npAtk = 1.1, npDef = 4 }
    , hits      = { quick = 2, arts = 2, buster = 1, ex = 3 }
    , gender    = Female
    , traits    = [Humanoid, Dragon, EnumaElish]
    , death     = 24
    , align     = [Chaotic, Evil]
    , limited   = False
    , free      = False
    , ascendUp  = Ascension
                  [(Piece Lancer, 4)]
                  [(Piece Lancer, 10), (DragonFang, 15)]
                  [(Monument Lancer, 4), (DragonsReverseScale, 4), (ClawOfChaos, 3)]
                  [(Monument Lancer, 10), (ClawOfChaos, 5), (PhoenixFeather, 8)]
    , skillUp   = Reinforcement
                  [(GemOf Lancer, 4)]
                  [(GemOf Lancer, 10)]
                  [(MagicGemOf Lancer, 4)]
                  [(MagicGemOf Lancer, 10), (DragonsReverseScale, 2)]
                  [(SecretGemOf Lancer, 4), (DragonsReverseScale, 4)]
                  [(SecretGemOf Lancer, 10), (DragonFang, 10)]
                  [(DragonFang, 20), (ForbiddenPage, 5)]
                  [(ForbiddenPage, 15), (PhoenixFeather, 16)]
    }
  , { name      = "Musashibou Benkei"
    , spoiler   = Nothing
    , id        = 19
    , rarity    = 2
    , class     = Lancer
    , attr      = Man
    , deck      = Deck Quick Quick Arts Arts Buster
    , curve     = 7
    , stats     = { base  = { atk = 1029, hp = 1722 }
                  , max   = { atk = 5801, hp = 9149 }
                  , grail = { atk = 8406, hp = 13204 }
                  }
    , skills    = [ { name   = "Vengeful Spirit Exorcism"
                    , rank   = A
                    , icon   = Icon.Circuits
                    , cd     = 7
                    , effect = [ Chances 50 100 <| Debuff Enemy 1 SealSkills Full ]
                    }
                  , { name   = "Imposing Stance"
                    , rank   = B
                    , icon   = Icon.CrosshairUp
                    , cd     = 7
                    , effect = [ Grant Self 1 Taunt Full
                               , Grant Self 1 DefenseUp <| Range 30 60
                               ]
                    }
                  , { name   = "Blank Subscription List"
                    , rank   = Unknown
                    , icon   = Icon.Circuits
                    , cd     = 10
                    , effect = [ Chances 60 80 <| Debuff Enemies 1 SealNP Full ]
                    }
                  ]
    , passives  = [magicResistance CPlus]
    , phantasm  = { name   = "Pilgrimage of the Five Hundred Arhat"
                  , desc   = ""
                  , rank   = EX
                  , card   = Arts
                  , kind   = "Anti-Army"
                  , hits   = 0
                  , effect = [ Chances 50 80 <| Debuff Enemies 1 Stun Full ]
                  , over   = [ Debuff Enemies 3 Curse <| Range 500 2500 ]
                  , first  = False
                  }
    , gen       = { starWeight = 89, starRate = 11.9, npAtk = 0.79, npDef = 4 }
    , hits      = { quick = 2, arts = 2, buster = 1, ex = 3 }
    , gender    = Male
    , traits    = [Humanoid, EnumaElish, LovedOne]
    , death     = 36
    , align     = [Chaotic, Good]
    , limited   = False
    , free      = False
    , ascendUp  = Ascension
                  [(Piece Lancer, 3)]
                  [(Piece Lancer, 6), (EvilBone, 11)]
                  [(Monument Lancer, 3), (SeedOfYggdrasil, 6), (HomunculusBaby, 3)]
                  [(Monument Lancer, 6), (HomunculusBaby, 5), (VoidsDust, 12)]
    , skillUp   = Reinforcement
                  [(GemOf Lancer, 3)]
                  [(GemOf Lancer, 6)]
                  [(MagicGemOf Lancer, 3)]
                  [(MagicGemOf Lancer, 6), (SeedOfYggdrasil, 3)]
                  [(SecretGemOf Lancer, 3), (SeedOfYggdrasil, 6)]
                  [(SecretGemOf Lancer, 6), (EvilBone, 8)]
                  [(EvilBone, 15), (VoidsDust, 6)]
                  [(VoidsDust, 42)]
    }
  , { name      = "Cu Chulainn (Prototype)"
    , spoiler   = Nothing
    , id        = 20
    , rarity    = 3
    , class     = Lancer
    , attr      = Sky
    , deck      = Deck Quick Quick Arts Buster Buster
    , curve     = 13
    , stats     = { base  = { atk = 1315,  hp = 1817 }
                  , max   = { atk = 7082, hp = 10098 }
                  , grail = { atk = 9584, hp = 13691 }
                  }
    , skills    = [ { name   = "Rune Spell"
                    , rank   = B
                    , icon   = Icon.ExclamationUp
                    , cd     = 7
                    , effect = [ Grant Self 3 CritUp <| Range 18 45
                               , Grant Self 3 DebuffResist <| Range 18 45
                               ]
                    }
                  , { name   = "Protection from Arrows"
                    , rank   = B
                    , icon   = Icon.Dodge
                    , cd     = 7
                    , effect = [ Times 3 <| Grant Self 0 Evasion Full
                               , Grant Self 3 DefenseUp <| Range 8 16
                               ]
                    }
                  , { name   = "Beast-Slayer"
                    , rank   = BPlusPlus
                    , icon   = Icon.DamageUp
                    , cd     = 7
                    , effect = [ Grant Self 3 (Special AttackUp <| VsTrait WildBeast) <| Range 50 100
                               , Grant Self 3 GatherUp <| Range 200 500
                               ]
                    }
                  ]
    , passives  = [magicResistance C, divinity B]
    , phantasm  = { name   = "Gáe Bolg"
                  , desc   = "The Spear which Reverses Causality"
                  , rank   = B
                  , card   = Quick
                  , kind   = "Anti-Personnel"
                  , hits   = 1
                  , effect = [ To Enemy Damage <| Range 1200 2000 ]
                  , over   = [ To Enemy Death <| Range 50 100
                             , Debuff Enemy 3 DefenseDown <| Range 10 30
                             ]
                  , first  = True
                  }
    , gen       = { starWeight = 88, starRate = 12.1, npAtk = 1.08, npDef = 4 }
    , hits      = { quick = 2, arts = 2, buster = 1, ex = 3 }
    , gender    = Male
    , traits    = [Humanoid, Divine, EnumaElish]
    , death     = 28
    , align     = [Lawful, Balanced]
    , limited   = False
    , free      = False
    , ascendUp  = Ascension
                  [(Piece Lancer, 4)]
                  [(Piece Lancer, 8), (VoidsDust, 10)]
                  [(Monument Lancer, 4), (SeedOfYggdrasil, 8), (ClawOfChaos, 2)]
                  [(Monument Lancer, 8), (ClawOfChaos, 4), (OctupletCrystals, 8)]
    , skillUp   = Reinforcement
                  [(GemOf Lancer, 4)]
                  [(GemOf Lancer, 8)]
                  [(MagicGemOf Lancer, 4)]
                  [(MagicGemOf Lancer, 8), (SeedOfYggdrasil, 4)]
                  [(SecretGemOf Lancer, 4), (SeedOfYggdrasil, 8)]
                  [(SecretGemOf Lancer, 8), (VoidsDust, 7)]
                  [(VoidsDust, 13), (ProofOfHero, 12)]
                  [(ProofOfHero, 36), (OctupletCrystals, 16)]
    }
  , { name      = "Leonidas I"
    , spoiler   = Nothing
    , id        = 21
    , rarity    = 2
    , class     = Lancer
    , attr      = Man
    , deck      = Deck Quick Quick Arts Buster Buster
    , curve     = 7
    , stats     = { base  = { atk = 1168, hp = 1498 }
                  , max   = { atk = 6583, hp = 7959 }
                  , grail = { atk = 9539, hp = 11486 }
                  }
    , skills    = [ { name   = "Rear Guard's Pride"
                    , rank   = A
                    , icon   = Icon.CrosshairUp
                    , cd     = 8
                    , effect = [ Grant Self 1 Taunt Full
                               , Grant Self 3 NPGen <| Range 50 100
                               ]
                    }
                  , { name   = "Battle Continuation"
                    , rank   = A
                    , icon   = Icon.Kneel
                    , cd     = 9
                    , effect = [ Times 1 << Grant Self 5 Guts <| Range 1000 2500 ]
                    }
                  , { name   = "Warrior's War Cry"
                    , rank   = B
                    , icon   = Icon.BusterUp
                    , cd     = 7
                    , effect = [ Grant Party 3 (CardUp Buster) <| Range 15 25 ]
                    }
                  ]
    , passives  = [magicResistance C]
    , phantasm  = { name   = "Thermopylae Enomotia"
                  , desc   = "Guardian of the Hot Gates"
                  , rank   = B
                  , card   = Buster
                  , kind   = "Anti-Personnel"
                  , hits   = 0
                  , effect = [ Grant Self 3 Taunt Full
                             , To Party GainStars <| Range 5 25
                             ]
                  , over   = [ Grant Self 3 DefenseUp <| Range 30 50 ]
                  , first  = False
                  }
    , gen       = { starWeight = 89, starRate = 11.8, npAtk = 1.07, npDef = 4 }
    , hits      = { quick = 2, arts = 2, buster = 1, ex = 3 }
    , gender    = Male
    , traits    = [Humanoid, EnumaElish, King]
    , death     = 32
    , align     = [Lawful, Balanced]
    , limited   = False
    , free      = False
    , ascendUp  = Ascension
                  [(Piece Lancer, 3)]
                  [(Piece Lancer, 6), (ClawOfChaos, 3)]
                  [(Monument Lancer, 3), (VoidsDust, 10), (OctupletCrystals, 3)]
                  [(Monument Lancer, 6), (OctupletCrystals, 5), (EvilBone, 18)]
    , skillUp   = Reinforcement
                  [(GemOf Lancer, 3)]
                  [(GemOf Lancer, 6)]
                  [(MagicGemOf Lancer, 3)]
                  [(MagicGemOf Lancer, 6), (VoidsDust, 5)]
                  [(SecretGemOf Lancer, 3), (VoidsDust, 10)]
                  [(SecretGemOf Lancer, 6), (ClawOfChaos, 2)]
                  [(ClawOfChaos, 3), (SerpentJewel, 3)]
                  [(SerpentJewel, 8), (EvilBone, 36)]
    }
  , { name      = "Romulus"
    , spoiler   = Nothing
    , id        = 22
    , rarity    = 3
    , class     = Lancer
    , attr      = Star
    , deck      = Deck Quick Quick Arts Buster Buster
    , curve     = 3
    , stats     = { base  = { atk = 1344, hp = 1779 }
                  , max   = { atk = 7239, hp = 9883 }
                  , grail = { atk = 9797, hp = 13400 }
                  }
    , skills    = [ { name   = "Natural Body"
                    , rank   = C
                    , icon   = Icon.HoodUp
                    , cd     = 7
                    , effect = [ Grant Self 3 OffensiveResist <| Range 50 100
                               , To Self Heal <| Range 1000 2500
                               ]
                    }
                  , { name   = "Imperial Privilege"
                    , rank   = EX
                    , icon   = Icon.Heal
                    , cd     = 7
                    , effect = [ To Self Heal <| Range 1200 3400
                               , Chance 60 << Grant Self 3 AttackUp <| Range 22 44
                               , Chance 60 << Grant Self 3 DefenseUp <| Range 22 44
                               ]
                    }
                  , { name   = "Seven Hills"
                    , rank   = A
                    , icon   = Icon.Kneel
                    , cd     = 9
                    , effect = [ Times 1 << Grant Ally 1 Guts <| Flat 1000
                               , Grant Ally 1 (CardUp Buster) <| Range 10 30
                               ]
                    }
                  ]
    , passives  = [magicResistance B]
    , phantasm  = { name   = "Magna Voluisse Magnum"
                  , desc   = "All Things Lead to My Spear"
                  , rank   = APlusPlus
                  , card   = Buster
                  , kind   = "Anti-Army"
                  , hits   = 7
                  , effect = [ To Enemies Damage <| Range 300 500 ]
                  , over   = [ Grant Party 3 AttackUp <| Range 10 30 ]
                  , first  = False
                  }
    , gen       = { starWeight = 90, starRate = 12.1, npAtk = 1.07, npDef = 4 }
    , hits      = { quick = 2, arts = 2, buster = 1, ex = 3 }
    , gender    = Male
    , traits    = [Humanoid, Roman, King]
    , death     = 32
    , align     = [Chaotic, Balanced]
    , limited   = False
    , free      = False
    , ascendUp  = Ascension
                  [(Piece Lancer, 4)]
                  [(Piece Lancer, 8), (OctupletCrystals, 5)]
                  [(Monument Lancer, 4), (PhoenixFeather, 6), (EvilBone, 10)]
                  [(Monument Lancer, 8), (EvilBone, 20), (VoidsDust, 16)]
    , skillUp   = Reinforcement
                  [(GemOf Lancer, 4)]
                  [(GemOf Lancer, 8)]
                  [(MagicGemOf Lancer, 4)]
                  [(MagicGemOf Lancer, 8), (PhoenixFeather, 3)]
                  [(SecretGemOf Lancer, 4), (PhoenixFeather, 6)]
                  [(SecretGemOf Lancer, 8), (OctupletCrystals, 4)]
                  [(OctupletCrystals, 7), (EternalGear, 4)]
                  [(EternalGear, 12), (VoidsDust, 32)]
    }
  , { name      = "Hektor"
    , spoiler   = Nothing
    , id        = 64
    , rarity    = 3
    , class     = Lancer
    , attr      = Man
    , deck      = Deck Quick Quick Arts Buster Buster
    , curve     = 3
    , stats     = { base  = { atk = 1334, hp = 1726 }
                  , max   = { atk = 6928, hp = 10200 }
                  , grail = { atk = 9376, hp = 13829 }
                  }
    , skills    = [ { name   = "Tactics"
                    , rank   = CPlus
                    , icon   = Icon.BeamUp
                    , cd     = 7
                    , effect = [ Grant Party 1 NPUp <| Range 8.5 17 ]
                    }
                  , { name   = "Proof of Friendship"
                    , rank   = C
                    , icon   = Icon.MagicDark
                    , cd     = 7
                    , effect = [ Chances 60 80 << To Enemy GaugeDown <| Flat 1
                               , Chances 60 80 <| Debuff Enemy 1 Stun Full
                               ]
                    }
                  , { name   = "Disengage"
                    , rank   = B
                    , icon   = Icon.Bubbles
                    , cd     = 7
                    , effect = [ To Self RemoveDebuffs Full
                               , To Self Heal <| Range 800 2000
                               ]
                    }
                  ]
    , passives  = [magicResistance B, riding B]
    , phantasm  = { name   = "Durindana"
                  , desc   = "Ultimate Unbroken Spear"
                  , rank   = A
                  , card   = Buster
                  , kind   = "Anti-Army"
                  , hits   = 1
                  , effect = [ To Enemies DamageThruDef <| Range 400 600 ]
                  , over   = [ Debuff Enemies 3 DefenseDown <| Range 20 40 ]
                  , first  = False
                  }
    , gen       = { starWeight = 90, starRate = 12.2, npAtk = 1.08, npDef = 4 }
    , hits      = { quick = 2, arts = 2, buster = 1, ex = 3 }
    , gender    = Male
    , traits    = [Humanoid, Riding, EnumaElish, GreekMythMale]
    , death     = 28
    , align     = [Lawful, Balanced]
    , limited   = False
    , free      = False
    , ascendUp  = Ascension
                  [(Piece Lancer, 4)]
                  [(Piece Lancer, 8), (MeteorHorseshoe, 5)]
                  [(Monument Lancer, 4), (ProofOfHero, 20), (SeedOfYggdrasil, 4)]
                  [(Monument Lancer, 8), (SeedOfYggdrasil, 8), (PhoenixFeather, 7)]
    , skillUp   = Reinforcement
                  [(GemOf Lancer, 4)]
                  [(GemOf Lancer, 8)]
                  [(MagicGemOf Lancer, 4)]
                  [(MagicGemOf Lancer, 8), (ProofOfHero, 10)]
                  [(SecretGemOf Lancer, 4), (ProofOfHero, 20)]
                  [(SecretGemOf Lancer, 8), (MeteorHorseshoe, 4)]
                  [(MeteorHorseshoe, 7), (OctupletCrystals, 4)]
                  [(OctupletCrystals, 12), (PhoenixFeather, 13)]
    }
  , { name      = "Scathach"
    , spoiler   = Nothing
    , id        = 70
    , rarity    = 5
    , class     = Lancer
    , attr      = Star
    , deck      = Deck Quick Quick Arts Buster Buster
    , curve     = 4
    , stats     = { base  = { atk = 1758,  hp = 2174 }
                  , max   = { atk = 11375, hp = 14825 }
                  , grail = { atk = 12452, hp = 16241 }
                  }
    , skills    = [ { name  = "Wisdom of Dun Scaith"
                    , rank   = APlus
                    , icon    = Icon.Dodge
                    , cd      = 7
                    , effect = [ Grant Self 1 Evasion Full
                              , Chance 80 <<
                              Grant Self 3 CritUp <| Range 30 50
                              , Chance 80 <<
                              Grant Self 3 GatherUp <| Range 300 500
                              ]
                    }
                  , { name    = "Primordial Rune"
                    , rank   = Unknown
                    , icon    = Icon.QuickUp
                    , cd      = 8
                    , effect = [ Grant Ally 1 (CardUp Quick) <| Range 30 50 ]
                    }
                  , { name    = "God-Slayer"
                    , rank   = B
                    , icon    = Icon.DamageUp
                    , cd      = 7
                    , effect = [ Grant Self 1 (Special AttackUp <| VsTrait Divine) <| Range 50 100
                              , Grant Self 1 (Special AttackUp <| VsTrait Undead) <| Range 50 100
                              ]
                    }
                  ]
    , passives  = [magicResistance A]
    , phantasm  = { name   = "Gáe Bolg Alternative"
                  , desc   = "Soaring Spear that Pierces with Death"
                  , rank   = BPlus
                  , card   = Quick
                  , kind   = "Anti-Personnel"
                  , hits   = 1
                  , effect = [ Chance 500 <| Debuff Enemy 1 Stun Full
                             , To Enemy Damage <| Range 1600 2400
                             ]
                  , over   = [ To Enemy Death <| Range 60 100 ]
                  , first  = True
                  }
    , gen       = { starWeight = 88, starRate = 12.2, npAtk = 0.71, npDef = 4 }
    , hits      = { quick = 2, arts = 3, buster = 6, ex = 7 }
    , gender    = Female
    , traits    = [Humanoid, EnumaElish, King]
    , death     = 32
    , align     = [Neutral, Good]
    , limited   = True
    , free      = False
    , ascendUp  = Ascension
                  [(Piece Lancer, 5)]
                  [(Piece Lancer, 12), (EvilBone, 22)]
                  [(Monument Lancer, 5), (VoidsDust, 20), (ClawOfChaos, 3)]
                  [(Monument Lancer, 12), (ClawOfChaos, 6), (HeartOfTheForeignGod, 5)]
    , skillUp   = Reinforcement
                  [(GemOf Lancer, 5)]
                  [(GemOf Lancer, 12)]
                  [(MagicGemOf Lancer, 5)]
                  [(MagicGemOf Lancer, 12), (VoidsDust, 10)]
                  [(SecretGemOf Lancer, 5), (VoidsDust, 20)]
                  [(SecretGemOf Lancer, 12), (EvilBone, 15)]
                  [(EvilBone, 29), (PhoenixFeather, 5)]
                  [(PhoenixFeather, 15), (HeartOfTheForeignGod, 10)]
    }
  , { name      = "Diarmuid Ua Duibhne"
    , spoiler   = Nothing
    , id        = 71
    , rarity    = 3
    , class     = Lancer
    , attr      = Earth
    , deck      = Deck Quick Quick Arts Arts Buster
    , curve     = 8
    , stats     = { base  = { atk = 1277, hp = 1817 }
                  , max   = { atk = 6877, hp = 10098 }
                  , grail = { atk = 9307, hp = 13691 }
                  }
    , skills    = [ { name   = "Mind's Eye (True)"
                    , rank   = B
                    , icon   = Icon.Dodge
                    , cd     = 8
                    , effect = [ Grant Self 1 Evasion Full
                               , Grant Self 3 DefenseUp <| Range 9 18
                               ]
                    }
                  , { name   = "Love Spot"
                    , rank   = C
                    , icon   = Icon.SwordDown
                    , cd     = 7
                    , effect = [ Debuff (EnemiesType Female) 1 AttackDown <| Range 30 50 ]
                    }
                  , { name   = "Knight's Strategy"
                    , rank   = B
                    , icon   = Icon.StarHaloUp
                    , cd     = 7
                    , effect = [ Grant Self 3 StarUp <| Range 30 50 ]
                    }
                  ]
    , passives  = [magicResistance B]
    , phantasm  = { name   = "Gáe Dearg and Gáe Buidhe"
                  , desc   = "Crimson Rose of Exorcism and Yellow Rose of Mortality"
                  , rank   = BPlus
                  , card   = Quick
                  , kind   = "Anti-Personnel"
                  , hits   = 2
                  , effect = [ To Enemy Damage <| Range 1600 2400
                             , To Enemy RemoveBuffs Full
                             ]
                  , over   = [ Debuff Enemy 5 Curse <| Range 500 1500 ]
                  , first  = False
                  }
    , gen       = { starWeight = 87, starRate = 12.3, npAtk = 0.79, npDef = 4 }
    , hits      = { quick = 2, arts = 2, buster = 2, ex = 4 }
    , gender    = Male
    , traits    = [Humanoid, EnumaElish, LovedOne]
    , death     = 36
    , align     = [Lawful, Balanced]
    , limited   = False
    , free      = False
    , ascendUp  = Ascension
                  [(Piece Lancer, 4)]
                  [(Piece Lancer, 10), (SeedOfYggdrasil, 6)]
                  [(Monument Lancer, 4), (PhoenixFeather, 6), (SerpentJewel, 3)]
                  [(Monument Lancer, 8), (SerpentJewel, 6), (VoidsDust, 16)]
    , skillUp   = Reinforcement
                  [(GemOf Lancer, 4)]
                  [(GemOf Lancer, 8)]
                  [(MagicGemOf Lancer, 4)]
                  [(MagicGemOf Lancer, 8), (PhoenixFeather, 3)]
                  [(SecretGemOf Lancer, 4), (PhoenixFeather, 6)]
                  [(SecretGemOf Lancer, 8), (SeedOfYggdrasil, 4)]
                  [(SeedOfYggdrasil, 8), (ProofOfHero, 12)]
                  [(ProofOfHero, 36), (VoidsDust, 32)]
    }
  , { name      = "Altria Pendragon (Lancer Alter)"
    , spoiler   = Nothing
    , id        = 78
    , rarity    = 4
    , class     = Lancer
    , attr      = Sky
    , deck      = Deck Quick Quick Arts Buster Buster
    , curve     = 29
    , stats     = { base  = { atk = 1661,  hp = 1881 }
                  , max   = { atk = 9968,  hp = 11761 }
                  , grail = { atk = 12069, hp = 14260 }
                  }
    , skills    = [ { name  = "Mana Burst"
                    , rank   = APlus
                    , icon    = Icon.BusterUp
                    , cd      = 7
                    , effect = [ Grant Self 1 (CardUp Buster) <| Range 35 55 ]
                    }
                  , { name    = "Protection of World's End"
                    , rank   = A
                    , icon    = Icon.StarUp
                    , cd      = 7
                    , effect = [ Grant Self 1 GatherUp <| Range 500 1000
                              , Grant Self 1 CritUp <| Range 30 50
                              , To Party GainStars <| Range 5 10
                              ]
                    }
                  , { name    = "Charisma"
                    , rank   = E
                    , icon    = Icon.SwordUp
                    , cd      = 7
                    , effect = [ Grant Party 3 AttackUp <| Range 6 12 ]
                    }
                  ]
    , passives  = [magicResistance A, riding A]
    , phantasm  = { name   = "Rhongomyniad"
                  , desc   = "Spear that Shines to the End of the World"
                  , rank   = EX
                  , card   = Buster
                  , kind   = "Anti-Fortress"
                  , hits   = 4
                  , effect = [ To Enemies DamageThruDef <| Range 400 600
                             , Chance 60 <| Debuff Enemies 1 SealNP Full
                             ]
                  , over   = [ Debuff Enemies 5 Curse <| Range 1000 3000 ]
                  , first  = False
                  }
    , gen       = { starWeight = 88, starRate = 11.8, npAtk = 0.74, npDef = 4 }
    , hits      = { quick = 2, arts = 3, buster = 1, ex = 4 }
    , gender    = Female
    , traits    = [Humanoid, Riding, Dragon, Saberface, Arthur, EnumaElish, King]
    , death     = 23
    , align     = [Lawful, Good]
    , limited   = False
    , free      = False
    , ascendUp  = Ascension
                  [(Piece Lancer, 4)]
                  [(Piece Lancer, 10), (MeteorHorseshoe, 6)]
                  [(Monument Lancer, 4), (PhoenixFeather, 7), (DragonsReverseScale, 2)]
                  [( Monument Lancer, 10), (DragonsReverseScale, 4), (HeartOfTheForeignGod, 4)]
    , skillUp   = Reinforcement
                  [(GemOf Lancer, 4)]
                  [(GemOf Lancer, 10)]
                  [(MagicGemOf Lancer, 4)]
                  [(MagicGemOf Lancer, 10), (PhoenixFeather, 4)]
                  [(SecretGemOf Lancer, 4), (PhoenixFeather, 7)]
                  [(SecretGemOf Lancer, 10), (MeteorHorseshoe, 4)]
                  [(MeteorHorseshoe, 8), (DragonFang, 12)]
                  [(DragonFang, 36), (HeartOfTheForeignGod, 8)]
    }
  , { name      = "Karna"
    , spoiler   = Nothing
    , id        = 85
    , rarity    = 5
    , class     = Lancer
    , attr      = Sky
    , deck      = Deck Quick Quick Arts Buster Buster
    , curve     = 10
    , stats     = { base  = { atk = 1850,  hp = 1999 }
                  , max   = { atk = 11976, hp = 13632 }
                  , grail = { atk = 13110, hp = 14934 }
                  }
    , skills    = [ { name  = "Knowledge of the Deprived"
                    , rank   = A
                    , icon    = Icon.Circuits
                    , cd      = 8
                    , effect = [ Debuff Enemy 1 SealNP Full
                              , Debuff Enemy 1 DebuffVuln <| Range 30 50
                              ]
                    }
                  , { name    = "Mana Burst (Flame)"
                    , rank   = A
                    , icon    = Icon.BusterUp
                    , cd      = 7
                    , effect = [ Grant Self 1 (CardUp Buster) <| Range 20 30
                              , Grant Self 1 NPUp <| Range 10 20
                              ]
                    }
                  , { name    = "Uncrowned Arms Mastership"
                    , rank   = Unknown
                    , icon    = Icon.Noble
                    , cd      = 8
                    , effect = [ To Self GaugeUp <| Flat 25
                              , Grant Self 3 StarUp <| Range 30 50
                              , Grant Self 3 CritUp <| Range 20 40
                              ]
                    }
                  ]
    , passives  = [magicResistance C, divinity A, riding A]
    , phantasm  = { name   = "Vasavi Shakti"
                  , desc   = "O Sun, Abide to Death"
                  , rank   = EX
                  , card   = Buster
                  , kind   = "Anti-Divine"
                  , hits   = 5
                  , effect = [ To Enemies Damage <| Range 400 600
                             , Debuff Enemies 3 (CardVuln Buster) <| Flat 20
                             ]
                  , over   = [ To Enemies (SpecialDamage <| VsTrait Divine) <| Range 150 200 ]
                  , first  = False
                  }
    , gen       = { starWeight = 88, starRate = 12.2, npAtk = 0.72, npDef = 4 }
    , hits      = { quick = 3, arts = 3, buster = 1, ex = 4 }
    , gender    = Male
    , traits    = [Humanoid, Riding, LovedOne, Divine, EnumaElish]
    , death     = 28
    , align     = [Lawful, Good]
    , limited   = False
    , free      = False
    , ascendUp  = Ascension
                  [(Piece Lancer, 5)]
                  [(Piece Lancer, 12), (OctupletCrystals, 8)]
                  [(Monument Lancer, 5), (EternalGear, 10), (PhoenixFeather, 4)]
                  [(Monument Lancer, 12), (PhoenixFeather, 8), (HeartOfTheForeignGod, 5)]
    , skillUp   = Reinforcement
                  [(GemOf Lancer, 5)]
                  [(GemOf Lancer, 12)]
                  [(MagicGemOf Lancer, 5)]
                  [(MagicGemOf Lancer, 12), (EternalGear, 5)]
                  [(SecretGemOf Lancer, 5), (EternalGear, 10)]
                  [(SecretGemOf Lancer, 12), (OctupletCrystals, 5)]
                  [(OctupletCrystals, 10), (ProofOfHero, 18)]
                  [(ProofOfHero, 54), (HeartOfTheForeignGod, 10)]
    }
  , { name      = "Fionn mac Cumhaill"
    , spoiler   = Nothing
    , id        = 87
    , rarity    = 4
    , class     = Lancer
    , attr      = Sky
    , deck      = Deck Quick Quick Arts Arts Buster
    , curve     = 9
    , stats     = { base  = { atk = 1488,  hp = 2040 }
                  , max   = { atk = 8930,  hp = 12750 }
                  , grail = { atk = 10812, hp = 15459 }
                  }
    , skills    = [ { name   = "Clairvoyance (Beauty)"
                    , rank   = BPlusPlus
                    , icon   = Icon.StarHaloUp
                    , cd     = 8
                    , effect = [ Grant Party 3 StarUp <| Range 30 50
                              , Grant Party 3 NPGen <| Range 10 30
                              ]
                    }
                  , { name   = "Trouble with Women"
                    , rank   = A
                    , icon   = Icon.Dodge
                    , cd     = 12
                    , effect = [ Chances 60 100 <| Grant Self 1 Evasion Full
                               , Grant Self 1 Taunt Full
                               , Debuff Self 3 CharmVuln <| Flat 80
                               ]
                    }
                  , { name   = "Magecraft"
                    , rank   = B
                    , icon   = Icon.ArtsUp
                    , cd     = 7
                    , effect = [ Grant Self 1 (CardUp Arts) <| Range 24 40 ]
                    }
                  ]
    , passives  = [magicResistance B, divinity D]
    , phantasm  = { name   = "Mac an Luin"
                  , desc   = "Undefeated Violet Flower"
                  , rank   = APlus
                  , card   = Arts
                  , kind   = "Anti-Army"
                  , hits   = 3
                  , effect = [ To Enemies Damage <| Range 600 900
                             , Grant Self 3 DebuffResist Full
                             ]
                  , over   = [ Debuff Enemies 3 AttackDown <| Range 10 30 ]
                  , first  = False
                  }
    , gen       = { starWeight = 89, starRate = 12.3, npAtk = 0.55, npDef = 4 }
    , hits      = { quick = 2, arts = 2, buster = 1, ex = 4 }
    , gender    = Male
    , traits    = [Humanoid, Divine, EnumaElish]
    , death     = 32
    , align     = [Neutral, Balanced]
    , limited   = False
    , free      = False
    , ascendUp  = Ascension
                  [(Piece Lancer, 4)]
                  [(Piece Lancer, 10), (PhoenixFeather, 5)]
                  [(Monument Lancer, 4), (EvilBone, 24), (ClawOfChaos, 3)]
                  [(Monument Lancer, 10), (ClawOfChaos, 5), (VoidsDust, 20)]
    , skillUp   = Reinforcement
                  [(GemOf Lancer, 4)]
                  [(GemOf Lancer, 10)]
                  [(MagicGemOf Lancer, 4)]
                  [(MagicGemOf Lancer, 10), (EvilBone, 12)]
                  [(SecretGemOf Lancer, 4), (EvilBone, 24)]
                  [(SecretGemOf Lancer, 10), (PhoenixFeather, 4)]
                  [(PhoenixFeather, 7), (OctupletCrystals, 5)]
                  [(OctupletCrystals, 15), (SerpentJewel, 16)]
    }
  , { name      = "Brynhild"
    , spoiler   = Nothing
    , id        = 88
    , rarity    = 5
    , class     = Lancer
    , attr      = Sky
    , deck      = Deck Quick Quick Arts Buster Buster
    , curve     = 25
    , stats     = { base  = { atk = 1766,  hp = 2174 }
                  , max   = { atk = 11432, hp = 14825 }
                  , grail = { atk = 12514, hp = 16241 }
                  }
    , skills    = [ { name  = "Mana Burst (Flame)"
                    , rank   = B
                    , icon   = Icon.BusterUp
                    , cd     = 7
                    , effect = [ Grant Self 1 (CardUp Buster) <| Range 15 25
                               , Grant Self 1 NPUp <| Range 8 15
                               ]
                    }
                  , { name    = "Primordial Rune"
                    , rank   = Unknown
                    , icon    = Icon.ExclamationDown
                    , cd      = 8
                    , effect = [ Debuff Enemy 3 CritChance <| Range 30 50
                               , Debuff Enemy 1 NPDown <| Range 15 30
                               ]
                    }
                  , { name   = "Hero's Assistant"
                    , rank   = C
                    , icon   = Icon.StarUp
                    , cd     = 7
                    , effect = [ Grant Ally 3 GatherUp <| Range 300 600
                               , To Ally Heal <| Range 1000 3000
                               ]
                    }
                  ]
    , passives  = [magicResistance B, riding A, divinity E]
    , phantasm  = { name   = "Brynhild Romantia"
                  , desc   = "Till Death Divides the Two"
                  , rank   = BPlus
                  , card   = Buster
                  , kind   = "Anti-Personnel"
                  , hits   = 5
                  , effect = [ To Enemy Damage <| Range 800 1200
                             , Grant Party 3 StarUp <| Flat 50
                             ]
                  , over   = [ To Enemy (SpecialDamage <| VsTrait LovedOne) <| Range 150 200 ]
                  , first  = False
                  }
    , gen       = { starWeight = 87, starRate = 12.2, npAtk = 1.07, npDef = 4 }
    , hits      = { quick = 3, arts = 2, buster = 1, ex = 5 }
    , gender    = Female
    , traits    = [Humanoid, Riding, Divine, EnumaElish]
    , death     = 32
    , align     = [Neutral, Good]
    , limited   = True
    , free      = False
    , ascendUp  = Ascension
                  [(Piece Lancer, 5)]
                  [(Piece Lancer, 12), (HeartOfTheForeignGod, 3)]
                  [(Monument Lancer, 5), (SeedOfYggdrasil, 12), (ProofOfHero, 15)]
                  [(Monument Lancer, 12), (ProofOfHero, 29), (GhostLantern, 12)]
    , skillUp   = Reinforcement
                  [(GemOf Lancer, 5)]
                  [(GemOf Lancer, 12)]
                  [(MagicGemOf Lancer, 5)]
                  [(MagicGemOf Lancer, 12), (SeedOfYggdrasil, 6)]
                  [(SecretGemOf Lancer, 5), (SeedOfYggdrasil, 12)]
                  [(SecretGemOf Lancer, 12), (HeartOfTheForeignGod, 2)]
                  [(HeartOfTheForeignGod, 4), (PhoenixFeather, 5)]
                  [(PhoenixFeather, 15), (ClawOfChaos, 15)]
    }
  , { name      = "Li Shuwen"
    , spoiler   = Nothing
    , id        = 102
    , rarity    = 4
    , class     = Lancer
    , attr      = Man
    , deck      = Deck Quick Quick Arts Arts Buster
    , curve     = 14
    , stats     = { base  = { atk = 1608,  hp = 1817 }
                  , max   = { atk = 9653,  hp = 11360 }
                  , grail = { atk = 11688, hp = 13774 }
                  }
    , skills    = [ { name   = "Chinese Martial Arts (Liu He Da Qiang)"
                    , rank   = APlusPlus
                    , icon   = Icon.Bullseye
                    , cd     = 8
                    , effect = [ Grant Self 1 SureHit Full
                              , Grant Self 1 CritUp <| Range 50 100
                              ]
                    }
                  , { name   = "Sphere Boundary"
                    , rank   = B
                    , icon   = Icon.Dodge
                    , cd     = 8
                    , effect = [ Grant Self 1 Evasion Full
                               , Grant Self 1 GatherUp <| Range 300 500
                               ]
                    }
                  , { name   = "Juezhao"
                    , rank   = B
                    , icon   = Icon.ShieldBreak
                    , cd     = 8
                    , effect = [ Grant Self 1 IgnoreInvinc Full
                               , Grant Self 1 (CardUp Arts) <| Range 30 50
                               ]
                    }
                  ]
    , passives  = [magicResistance D]
    , phantasm  = { name   = "Shen Qiang Wu Er Da"
                  , desc   = "Divine Spear—No Second Strike"
                  , rank   = Unknown
                  , card   = Arts
                  , kind   = "Anti-Unit"
                  , hits   = 3
                  , effect = [ To Enemy DamageThruDef <| Range 900 1500
                             , Debuff Enemy 3 DefenseDown <| Flat 20
                             ]
                  , over   = [ To Enemy Death <| Range 40 80 ]
                  , first  = False
                  }
    , gen       = { starWeight = 87, starRate = 12.2, npAtk = 0.52, npDef = 4 }
    , hits      = { quick = 3, arts = 3, buster = 1, ex = 5 }
    , gender    = Male
    , traits    = [Humanoid, EnumaElish]
    , death     = 40
    , align     = [Neutral, Evil]
    , limited   = False
    , free      = False
    , ascendUp  = Ascension
                  [(Piece Lancer, 4)]
                  [(Piece Lancer, 10), (DragonFang, 15)]
                  [(Monument Lancer, 4), (OctupletCrystals, 8), (ClawOfChaos, 3)]
                  [(Monument Lancer, 10), (ClawOfChaos, 5), (DragonsReverseScale, 4)]
    , skillUp   = Reinforcement
                  [(GemOf Lancer, 4)]
                  [(GemOf Lancer, 10)]
                  [(MagicGemOf Lancer, 4)]
                  [(MagicGemOf Lancer, 10), (OctupletCrystals, 4)]
                  [(SecretGemOf Lancer, 4), (OctupletCrystals, 8)]
                  [(SecretGemOf Lancer, 10), (DragonFang, 10)]
                  [(DragonFang, 20), (VoidsDust, 10)]
                  [(VoidsDust, 30), (WarhorsesYoungHorn, 12)]
    }
  , { name      = "Altria Pendragon (Lancer)"
    , spoiler   = Nothing
    , id        = 119
    , rarity    = 5
    , class     = Lancer
    , attr      = Sky
    , deck      = Deck Quick Quick Arts Buster Buster
    , curve     = 5
    , stats     = { base  = { atk = 1699,  hp = 2288 }
                  , max   = { atk = 10995, hp = 15606 }
                  , grail = { atk = 12036, hp = 17097 }
                  }
    , skills    = [ { name   = "Mana Burst"
                    , rank   = A
                    , icon   = Icon.BusterUp
                    , cd     = 7
                    , effect = [ Grant Self 1 (CardUp Buster) <| Range 30 50 ]
                    }
                  , { name   = "Charisma"
                    , rank   = B
                    , icon   = Icon.SwordUp
                    , cd     = 7
                    , effect = [ Grant Party 3 AttackUp <| Range 9 18 ]
                    }
                  , { name   = "Protection of World's End"
                    , rank   = EX
                    , icon   = Icon.Noble
                    , cd     = 8
                    , effect = [ To Self GaugeUp <| Range 30 50
                               , To Self RemoveDebuffs Full
                               ]
                    }
                  ]
    , passives  = [magicResistance B, riding A]
    , phantasm  = { name   = "Rhongomyniad"
                  , desc   = "Spear Shining at the End of the World"
                  , rank   = APlusPlus
                  , card   = Buster
                  , kind   = "Anti-Fortress"
                  , hits   = 2
                  , effect = [ Grant Self 1 IgnoreInvinc Full
                             , To Enemies Damage <| Range 300 500
                             ]
                  , over   = [ To Self GaugeUp <| Range 20 60 ]
                  , first  = False
                  }
    , gen       = { starWeight = 89, starRate = 12.2, npAtk = 1.1, npDef = 4 }
    , hits      = { quick = 3, arts = 2, buster = 1, ex = 5 }
    , gender    = Female
    , traits    = [Humanoid, Arthur, Dragon, King, Riding, Saberface, EnumaElish]
    , death     = 24
    , align     = [Lawful, Good]
    , limited   = False
    , free      = False
    , ascendUp  = Ascension
                  [(Piece Lancer, 5)]
                  [(Piece Lancer, 12), (DragonFang, 18)]
                  [(Monument Lancer, 5), (GreatKnightMedal, 20), (WarhorsesYoungHorn, 3)]
                  [( Monument Lancer, 12), (WarhorsesYoungHorn, 6), (DragonsReverseScale, 5)]
    , skillUp   = Reinforcement
                  [(GemOf Lancer, 5)]
                  [(GemOf Lancer, 12)]
                  [(MagicGemOf Lancer, 5)]
                  [(MagicGemOf Lancer, 12), (GreatKnightMedal, 10)]
                  [(SecretGemOf Lancer, 5), (GreatKnightMedal, 20)]
                  [(SecretGemOf Lancer, 12), (DragonFang, 12)]
                  [(DragonFang, 24), (MeteorHorseshoe, 6)]
                  [(MeteorHorseshoe, 18), (HeartOfTheForeignGod, 10)]
    }
  , { name      = "Tamamo-no-Mae (Lancer)"
    , spoiler   = Nothing
    , id        = 128
    , rarity    = 5
    , class     = Lancer
    , attr      = Sky
    , deck      = Deck Quick Quick Arts Buster Buster
    , curve     = 5
    , stats     = { base  = { atk = 1657,  hp = 2221 }
                  , max   = { atk = 10726, hp = 15147 }
                  , grail = { atk = 11741, hp = 16594 }
                  }
    , skills    = [ { name   = "Beach Flower"
                    , rank   = EX
                    , icon   = Icon.SwordUp
                    , cd     = 7
                    , effect = [ Grant Party 3 AttackUp <| Range 10 20
                               , Grant (AlliesType Male) 3 StarUp <| Range 22 42
                               ]
                    }
                  , { name   = "Midsummer Curse"
                    , rank   = A
                    , icon   = Icon.Heart
                    , cd     = 9
                    , effect = [ Debuff Enemy 1 Charm Full
                               , Debuff Enemy 3 DefenseDown <| Range 20 30
                               , Debuff Enemy 5 Curse <| Range 500 1000
                               , To Enemy DemeritCharge <| Flat 1
                               ]
                    }
                  , { name   = "Goddess Morph"
                    , rank   = B
                    , icon   = Icon.Shield
                    , cd     = 8
                    , effect = [ Grant Self 1 Invincibility Full
                               , Grant Self 1 CritUp <| Range 30 50
                               , Grant Self 1 StarUp <| Range 30 50
                               , Grant Self 1 NPGen <| Range 30 50
                               , Grant Self 1 DebuffResist <| Range 30 50
                               , Grant Self 1 HealingReceived <| Range 30 50
                               , After 1 <| Debuff Self 1 Stun Full
                               ]
                    }
                  ]
    , passives  = [riding A, territoryCreation A, divinity APlusPlus]
    , phantasm  = { name   = "Tokonatsu Nikkou—Goddess' Love Parasol"
                  , desc   = ""
                  , rank   = C
                  , card   = Buster
                  , kind   = "Anti-Unit"
                  , hits   = 4
                  , effect = [ To Enemy Damage <| Range 600 1000 ]
                  , over   = [ To Enemy (SpecialDamage <| VsTrait Male) <| Range 150 200 ]
                  , first  = False
                  }
    , gen       = { starWeight = 91, starRate = 12.2, npAtk = 1.05, npDef = 4 }
    , hits      = { quick = 4, arts = 2, buster = 3, ex = 4 }
    , gender    = Female
    , traits    = [Humanoid, Divine, Riding, EnumaElish]
    , death     = 40
    , align     = [Neutral, Summer]
    , limited   = True
    , free      = False
    , ascendUp  = Ascension
                  [(Piece Lancer, 5)]
                  [(Piece Lancer, 12), (PhoenixFeather, 6)]
                  [(Monument Lancer, 5), (SeedOfYggdrasil, 12), (WarhorsesYoungHorn, 3)]
                  [( Monument Lancer, 12), (WarhorsesYoungHorn, 6)
                  , (ShellOfReminiscence, 12)
                  ]
    , skillUp   = Reinforcement
                  [(GemOf Lancer, 5)]
                  [(GemOf Lancer, 12)]
                  [(MagicGemOf Lancer, 5)]
                  [(MagicGemOf Lancer, 12), (SeedOfYggdrasil, 6)]
                  [(SecretGemOf Lancer, 5), (SeedOfYggdrasil, 12)]
                  [(SecretGemOf Lancer, 12), (PhoenixFeather, 4)]
                  [(PhoenixFeather, 8), (ClawOfChaos, 4)]
                  [(ClawOfChaos, 11), (HeartOfTheForeignGod, 10)]
    }
  , { name      = "Kiyohime (Lancer)"
    , spoiler   = Nothing
    , id        = 134
    , rarity    = 4
    , class     = Lancer
    , attr      = Earth
    , deck      = Deck Quick Quick Arts Buster Buster
    , curve     = 4
    , stats     = { base  = { atk = 1489,  hp = 1899 }
                  , max   = { atk = 8936,  hp = 11870 }
                  , grail = { atk = 10820, hp = 14392 }
                  }
    , skills    = [ { name   = "Passionate Summer"
                    , rank   = A
                    , icon   = Icon.ExclamationDown
                    , cd     = 7
                    , effect = [ Debuff Enemies 3 CritChance <| Range 20 30 ]
                    }
                  , { name   = "Bath Transformation"
                    , rank   = A
                    , icon   = Icon.BusterUp
                    , cd     = 7
                    , effect = [ Grant Self 3 (CardUp Buster) <| Range 20 30 ]
                    }
                  , { name   = "Stalking"
                    , rank   = A
                    , icon   = Icon.ShieldDown
                    , cd     = 7
                    , effect = [ Chance 500 << Debuff Enemy 3 DefenseDown <| Range 20 30
                               , Grant Enemy 3 AttackUp <| Flat 20
                               ]
                    }
                  ]
    , passives  = [madness EX, magicResistance D]
    , phantasm  = { name   = "Dojo-ji Bell Form 108—Karyu-nagi"
                  , desc   = ""
                  , rank   = A
                  , card   = Buster
                  , kind   = "Anti-Personnel"
                  , hits   = 6
                  , effect = [ To Enemy Damage <| Range 600 1000
                             , Chance 150 <| Debuff Enemy 1 SealSkills Full
                             ]
                  , over   = [ Debuff Enemy 5 Burn <| Range 500 2500 ]
                  , first  = False
                  }
    , gen       = { starWeight = 92, starRate = 12, npAtk = 1.05, npDef = 4 }
    , hits      = { quick = 2, arts = 2, buster = 6, ex = 5 }
    , gender    = Female
    , traits    = [Humanoid, Dragon, EnumaElish]
    , death     = 40
    , align     = [Chaotic, Evil]
    , limited   = True
    , free      = False
    , ascendUp  = Ascension
                  [(Piece Lancer, 4)]
                  [(Piece Lancer, 10), (OctupletCrystals, 6)]
                  [(Monument Lancer, 4), (ShellOfReminiscence, 8), (BlackBeastGrease, 3)]
                  [(Monument Lancer, 10), (BlackBeastGrease, 5), (LampOfEvilSealing, 6)]
    , skillUp   = Reinforcement
                  [(GemOf Lancer, 4)]
                  [(GemOf Lancer, 10)]
                  [(MagicGemOf Lancer, 4)]
                  [(MagicGemOf Lancer, 10), (ShellOfReminiscence, 4)]
                  [(SecretGemOf Lancer, 4), (ShellOfReminiscence, 8)]
                  [(SecretGemOf Lancer, 10), (OctupletCrystals, 4)]
                  [(OctupletCrystals, 8), (DragonFang, 12)]
                  [(DragonFang, 36), (DragonsReverseScale, 8)]
    }
  , { name      = "Vlad III (EXTRA)"
    , spoiler   = Nothing
    , id        = 140
    , rarity    = 4
    , class     = Lancer
    , attr      = Earth
    , deck      = Deck Quick Quick Arts Buster Buster
    , curve     = 14
    , stats     = { base  = { atk = 1462,  hp = 2080 }
                  , max   = { atk = 8775,  hp = 13005 }
                  , grail = { atk = 10625, hp = 15769 }
                  }
    , skills    = [ { name   = "Protection of the Faith"
                    , rank   = APlusPlusPlus
                    , icon   = Icon.HoodUp
                    , cd     = 7
                    , effect = [ Grant Self 3 DebuffResist <| Range 50 100
                               , To Self Heal <| Range 1000 2500
                               , Grant Self 1 DefenseUp <| Range 20 40
                               , Grant Self 3 AttackUp <| Range 10 20
                               ]
                    }
                  , { name   = "Tactics"
                    , rank   = B
                    , icon   = Icon.BeamUp
                    , cd     = 7
                    , effect = [ Grant Party 1 NPUp <| Range 9 18 ]
                    }
                  , { name   = "Innocent Monster"
                    , rank   = A
                    , icon   = Icon.StarTurn
                    , cd     = 7
                    , effect = [ Grant Self 3 StarsPerTurn <| Range 3 9
                               , Chances 100 300 <| Grant Self 1 Taunt Full
                               ]
                    }
                  ]
    , passives  = [magicResistance C]
    , phantasm  = { name   = "Kazikli Bey"
                  , desc   = "Citadel of Impalement"
                  , rank   = C
                  , card   = Buster
                  , kind   = "Anti-Enemy"
                  , hits   = 6
                  , effect = [ Grant Self 1 IgnoreInvinc Full
                             , To Enemy Damage <| Range 600 1000
                             ]
                  , over   = [ To Enemy (SpecialDamage <| VsTrait Evil) <| Range 150 200 ]
                  , first  = False
                  }
    , gen       = { starWeight = 88, starRate = 11.6, npAtk = 1.1, npDef = 4 }
    , hits      = { quick = 3, arts = 2, buster = 3, ex = 5 }
    , gender    = Male
    , traits    = [Humanoid, King]
    , death     = 24
    , align     = [Lawful,Good]
    , limited   = False
    , free      = False
    , ascendUp  = Ascension
                  [(Piece Lancer, 4)]
                  [(Piece Lancer, 10), (ProofOfHero, 18)]
                  [(Monument Lancer, 4), (FoolsChain, 24), (BlackBeastGrease, 3)]
                  [(Monument Lancer, 10), (BlackBeastGrease, 5), (DragonsReverseScale, 4)]
    , skillUp   = Reinforcement
                  [(GemOf Lancer, 4)]
                  [(GemOf Lancer, 10)]
                  [(MagicGemOf Lancer, 4)]
                  [(MagicGemOf Lancer, 10), (FoolsChain, 12)]
                  [(SecretGemOf Lancer, 4), (FoolsChain, 24)]
                  [(SecretGemOf Lancer, 10), (ProofOfHero, 12)]
                  [(ProofOfHero, 24), (OctupletCrystals, 5)]
                  [(OctupletCrystals, 15), (HeartOfTheForeignGod, 8)]
    }
  , { name      = "Jeanne d'Arc Alter Santa Lily"
    , spoiler   = Nothing
    , id        = 141
    , rarity    = 4
    , class     = Lancer
    , attr      = Man
    , deck      = Deck Quick Quick Arts Buster Buster
    , curve     = 9
    , stats     = { base  = { atk = 1543,  hp = 1899 }
                  , max   = { atk = 9261,  hp = 11870 }
                  , grail = { atk = 11213, hp = 14392 }
                  }
    , skills    = [ { name   = "Saint's Gift"
                    , rank   = C
                    , icon   = Icon.Heal
                    , cd     = 7
                    , effect = [ To Ally Heal <| Range 1000 3000
                               , Grant Ally 3 StarUp <| Flat 30
                               ]
                    }
                  , { name   = "Self-Transformation"
                    , rank   = A
                    , icon   = Icon.Noble
                    , cd     = 7
                    , effect = [ Grant Self 3 DebuffResist <| Range 20 50
                               , To Self GaugeUp <| Flat 20
                               ]
                    }
                  , { name   = "Ephemeral Dream"
                    , rank   = EX
                    , icon   = Icon.BusterUp
                    , cd     = 8
                    , effect = [ Grant Self 1 (CardUp Buster) <| Range 35 55
                               , Grant Self 1 Invincibility Full
                               , To Self DemeritHealth <| Flat 1200
                               ]
                    }
                  ]
    , passives  = [magicResistance APlus]
    , phantasm  = { name   = "La Grâce Fille Noël"
                  , desc   = "Sing Elegantly, For the Christmas"
                  , rank   = APlus
                  , card   = Buster
                  , kind   = "Anti-Army"
                  , hits   = 5
                  , effect = [ To Enemies Damage <| Range 300 500
                             , Debuff Enemies 1 DebuffVuln <| Flat 10
                             ]
                  , over   = [ Grant Party 1 AttackUp <| Range 10 30
                             , Grant Party 1 HealingReceived <| Range 20 60
                             ]
                  , first  = False
                  }
    , gen       = { starWeight = 92, starRate = 12.1, npAtk = 0.72, npDef = 4 }
    , hits      = { quick = 3, arts = 3, buster = 1, ex = 5 }
    , gender    = Female
    , traits    = [Humanoid, Saberface, EnumaElish]
    , death     = 28
    , align     = [Chaotic, Good]
    , limited   = True
    , free      = True
    , ascendUp  = Welfare "Gilles de Rais Doll"
    , skillUp   = Reinforcement
                  [(GemOf Lancer, 4)]
                  [(GemOf Lancer, 10)]
                  [(MagicGemOf Lancer, 4)]
                  [(MagicGemOf Lancer, 10), (ShellOfReminiscence, 4)]
                  [(SecretGemOf Lancer, 4), (ShellOfReminiscence, 8)]
                  [(SecretGemOf Lancer, 10), (SeedOfYggdrasil, 5)]
                  [(SeedOfYggdrasil, 10), (WarhorsesYoungHorn, 3)]
                  [(WarhorsesYoungHorn, 9), (SpiritRoot, 8)]
    }
  , { name      = "Enkidu"
    , spoiler   = Nothing
    , id        = 143
    , rarity    = 5
    , class     = Lancer
    , stats     = { base  = { atk = 1666,  hp = 2244 }
                  , max   = { atk = 10780, hp = 15300 }
                  , grail = { atk = 11800, hp = 16762 }
                  }
    , gen       = { starWeight = 90, starRate = 12, npAtk = 0.53, npDef = 4 }
    , death     = 28
    , curve     = 10
    , attr      = Sky
    , align     = [Neutral, Balanced]
    , gender    = Nonbinary
    , traits    = [Humanoid, EnumaElish]
    , deck      = Deck Quick Quick Quick Arts Buster
    , hits      = { quick = 4, arts = 5, buster = 1, ex = 6 }
    , skills    = [ { name   = "Transfiguration"
                    , rank   = A
                    , icon   = Icon.BusterUp
                    , cd     = 7
                    , effect = [ Grant Self 1 (CardUp Buster) <| Range 30 50
                               , To Self ApplyAtRandom Full
                               , Grant Self 1 (CardUp Arts) <| Range 30 50
                               , Grant Self 1 (CardUp Quick) <| Range 30 50
                               ]
                    }
                  , { name   = "Presence Detection"
                    , rank   = APlus
                    , icon   = Icon.ExclamationDown
                    , cd     = 7
                    , effect = [ Debuff Enemy 3 CritChance <| Range 30 50
                               , To Enemy (Remove Evasion) Full
                               , Grant Self 1 Evasion Full
                               ]
                    }
                  , { name   = "Perfect Form"
                    , rank   = A
                    , icon   = Icon.Heal
                    , cd     = 12
                    , effect = [ To Self Heal <| Range 5000 10000
                               , To Self RemoveDebuffs Full
                               ]
                    }
                  ]
    , passives  = [magicResistance A]
    , phantasm  = { name   = "Enuma Elish"
                  , desc   = "O Humans, Let Us Restrain the Gods"
                  , rank   = EX
                  , card   = Buster
                  , kind   = "Anti-Enforcement"
                  , hits   = 5
                  , effect = [ To Enemy Damage <| Range 800 1200
                             , Chance 500 <| Debuff (EnemyType Divine) 1 Stun Full
                             , To Enemy (SpecialDamage <| VsTrait ThreatToHumanity) <| Flat 200
                             ]
                  , over   = [ Debuff Enemy 3 DefenseDown <| Range 30 50 ]
                  , first  = True
                  }
    , limited   = False
    , free      = False
    , ascendUp  = Ascension
                  [(Piece Lancer, 5)]
                  [(Piece Lancer, 12), (FoolsChain, 22)]
                  [(Monument Lancer, 5), (OctupletCrystals, 10), (SpiritRoot, 2)]
                  [(Monument Lancer, 12), (SpiritRoot, 4), (HeartOfTheForeignGod, 5)]
    , skillUp   = Reinforcement
                  [(GemOf Lancer, 5)]
                  [(GemOf Lancer, 12)]
                  [(MagicGemOf Lancer, 5)]
                  [(MagicGemOf Lancer, 12), (OctupletCrystals, 5)]
                  [(SecretGemOf Lancer, 5), (OctupletCrystals, 10)]
                  [(SecretGemOf Lancer, 12), (FoolsChain, 15)]
                  [(FoolsChain, 29), (HomunculusBaby, 6)]
                  [(HomunculusBaby, 18), (PrimordialLanugo, 15)]
    }
  , { name      = "Medusa (Lancer)"
    , spoiler   = Nothing
    , id        = 146
    , rarity    = 4
    , class     = Lancer
    , stats     = { base  = { atk = 1375, hp = 2099 }
                  , max   = { atk = 8253, hp = 13119 }
                  , grail = { atk = 9993, hp = 15907 }
                  }
    , gen       = { starWeight = 89, starRate = 12.2, npAtk = 0.44, npDef = 4 }
    , death     = 40
    , curve     = 3
    , attr      = Earth
    , align     = [Neutral, Good]
    , gender    = Female
    , traits    = [Humanoid, Divine, EnumaElish]
    , deck      = Deck Quick Quick Arts Arts Buster
    , hits      = { quick = 3, arts = 4, buster = 1, ex = 5 }
    , skills    = [ { name   = "Siren Song"
                    , rank   = B
                    , icon   = Icon.Heart
                    , cd     = 9
                    , effect = [ Chances 60 90 <| Debuff (EnemyType Male) 1 Charm Full ]
                    }
                  , { name   = "Monstrous Strength"
                    , rank   = C
                    , icon   = Icon.SwordUp
                    , cd     = 7
                    , effect = [ Grant Self 1 AttackUp <| Range 10 30 ]
                    }
                  , { name   = "Distant Thoughts"
                    , rank   = A
                    , icon   = Icon.Kneel
                    , cd     = 9
                    , effect = [ Times 1 << Grant Self 3 Guts <| Range 1000 3000
                               , Times 1 <| Grant Self 1 Invincibility Full
                               ]
                    }
                  ]
    , passives  = [magicResistance B, coreOfGoddess A]
    , phantasm  = { name   = "Caress of the Medusa"
                  , desc   = "Embrace of the Goddess"
                  , rank   = BPlus
                  , card   = Quick
                  , kind   = "Anti-Unit"
                  , hits   = 8
                  , effect = [ To Enemy Damage <| Range 1600 2400
                             , Debuff Enemy 3 (CardVuln Quick) <| Flat 20
                             ]
                  , over   = [ Chances 80 160 <| Debuff Enemy 1 Stun Full ]
                  , first  = False
                  }
    , limited   = False
    , free      = False
    , ascendUp  = Ascension
                  [(Piece Lancer, 4)]
                  [(Piece Lancer, 10), (ShellOfReminiscence, 6)]
                  [(Monument Lancer, 4), (SeedOfYggdrasil, 10), (PhoenixFeather, 4)]
                  [(Monument Lancer, 10), (PhoenixFeather, 7), (DeadlyPoisonousNeedle, 24)]
    , skillUp   = Reinforcement
                  [(GemOf Lancer, 4)]
                  [(GemOf Lancer, 10)]
                  [(MagicGemOf Lancer, 4)]
                  [(MagicGemOf Lancer, 10), (SeedOfYggdrasil, 5)]
                  [(SecretGemOf Lancer, 4), (SeedOfYggdrasil, 10)]
                  [(SecretGemOf Lancer, 10), (ShellOfReminiscence, 4)]
                  [(ShellOfReminiscence, 8), (PrimordialLanugo, 3)]
                  [(PrimordialLanugo, 9), (SerpentJewel, 16)]
    }
  , { name      = "Jaguar Warrior"
    , spoiler   = Nothing
    , id        = 148
    , rarity    = 3
    , class     = Lancer
    , stats     = { base  = { atk = 1304, hp = 1726 }
                  , max   = { atk = 7022, hp = 9593 }
                  , grail = { atk = 9503, hp = 13007 }
                  }
    , gen       = { starWeight = 90, starRate = 12, npAtk = 1.05, npDef = 4 }
    , death     = 40
    , curve     = 8
    , attr      = Earth
    , align     = [Chaotic, Balanced]
    , gender    = Female
    , traits    = [Humanoid, WildBeast, Divine, PseudoServant, EnumaElish]
    , deck      = Deck Quick Quick Arts Buster Buster
    , hits      = { quick = 2, arts = 2, buster = 4, ex = 6 }
    , skills    = [ { name   = "Jaguar Punch"
                    , rank   = A
                    , icon   = Icon.BusterUp
                    , cd     = 12
                    , effect = [ Grant Self 3 (CardUp Buster) <| Range 10 30
                               , Grant Self 3 DebuffResist <| Range 20 40
                               , Times 2 <| Grant Self 0 Evasion Full
                               , To Party GainStars <| Range 5 15
                               ]
                    }
                  , { name   = "Jaguar Kick"
                    , rank   = B
                    , icon   = Icon.SwordUp
                    , cd     = 7
                    , effect = [ Grant Self 2 AttackUp <| Range 10 30 ]
                    }
                  , { name   = "Jaguar Eye"
                    , rank   = APlus
                    , icon   = Icon.ExclamationUp
                    , cd     = 8
                    , effect = [ Grant Self 3 CritUp <| Range 30 50
                               , When "on Forest field" << Grant Self 3 StarUp <| Range 30 50
                               , When "on Forest field" << Grant Self 3 GatherUp <| Range 300 600
                               ]
                    }
                  ]
    , passives  = [magicResistance A, madness E, divinity A]
    , phantasm  = { name   = "Great Death Claw"
                  , desc   = "The Inescapable Claw of Death"
                  , rank   = B
                  , card   = Buster
                  , kind   = "Anti-Personnel"
                  , hits   = 2
                  , effect = [ Grant Self 1 SureHit Full
                             , To Enemy Damage <| Range 600 1000
                             ]
                  , over   = [ Debuff Enemy 3 DebuffVuln <| Range 10 50 ]
                  , first  = False
                  }
    , limited   = False
    , free      = True
    , ascendUp  = Ascension
                  [(Piece Lancer, 4)]
                  [(Piece Lancer, 8), (SeedOfYggdrasil, 6)]
                  [(Monument Lancer, 4), (ClawOfChaos, 4), (BlackBeastGrease, 2)]
                  [(Monument Lancer, 8), (BlackBeastGrease, 4), (PrimordialLanugo, 5)]
    , skillUp   = Reinforcement
                  [(GemOf Lancer, 4)]
                  [(GemOf Lancer, 8)]
                  [(MagicGemOf Lancer, 4)]
                  [(MagicGemOf Lancer, 8), (ClawOfChaos, 2)]
                  [(SecretGemOf Lancer, 4), (ClawOfChaos, 4)]
                  [(SecretGemOf Lancer, 8), (SeedOfYggdrasil, 4)]
                  [(SeedOfYggdrasil, 8), (CursedBeastGallstone, 2)]
                  [(CursedBeastGallstone, 5), (WarhorsesYoungHorn, 10)]
    }
  , { name      = "Minamoto-no-Raikou (Lancer)"
    , spoiler   = Nothing
    , id        = 181
    , rarity    = 4
    , class     = Lancer
    , stats     = { base  = { atk = 1528,  hp = 1938 }
                  , max   = { atk = 9168,  hp = 12112 }
                  , grail = { atk = 11100, hp = 14686 }
                  }
    , gen       = { starWeight = 89, starRate = 11.8, npAtk = 0.75, npDef = 4 }
    , death     = 24
    , curve     = 4
    , attr      = Sky
    , align     = [Lawful, Good]
    , gender    = Female
    , traits    = [Humanoid, Riding, Divine, EnumaElish]
    , deck      = Deck Quick Quick Arts Buster Buster
    , hits      = { quick = 3, arts = 4, buster = 1, ex = 5 }
    , skills    = [ { name   = "The Shadow Prefect"
                    , rank   = A
                    , icon   = Icon.StarUp
                    , cd     = 7
                    , effect = [ Grant Self 1 GatherUp <| Range 500 1000
                               , Grant Self 1 CritUp <| Range 30 50
                               ]
                    }
                  , { name   = "Cast Iron Yo-yo"
                    , rank   = C
                    , icon   = Icon.BusterUp
                    , cd     = 8
                    , effect = [ Grant Ally 3 (CardUp Buster) <| Range 20 40
                               , To Ally RemoveDebuffs Full
                               ]
                    }
                  , { name   = "Summer Catastrophe"
                    , rank   = EX
                    , icon   = Icon.SwordUp
                    , cd     = 7
                    , effect = [ Grant Party 3 AttackUp <| Range 10 20
                               , Grant Party 3 StarUp <| Range 20 30
                               ]
                    }
                  ]
    , passives  = [magicResistance C, riding APlus, madness C, divinity C]
    , phantasm  = { name   = "Vajra of India"
                  , desc   = "Shakudankan-in Kongousho"
                  , rank   = APlus
                  , card   = Buster
                  , kind   = "Anti-Personnel"
                  , hits   = 6
                  , effect = [ To Enemy DamageThruDef <| Range 600 1000 ]
                  , over   = [ To Party GainStars <| Range 20 40 ]
                  , first  = False
                  }
    , limited   = True
    , free      = False
    , ascendUp  = Ascension
                  [(Piece Lancer, 4)]
                  [(Piece Lancer, 10), (ShellOfReminiscence, 6)]
                  [(Monument Lancer, 4), (ProofOfHero, 24), (EternalGear, 4)]
                  [(Monument Lancer, 10), (EternalGear, 8), (HeartOfTheForeignGod, 4)]
    , skillUp   = Reinforcement
                  [(GemOf Lancer, 4)]
                  [(GemOf Lancer, 10)]
                  [(MagicGemOf Lancer, 4)]
                  [(MagicGemOf Lancer, 10), (ProofOfHero, 12)]
                  [(SecretGemOf Lancer, 4), (ProofOfHero, 24)]
                  [(SecretGemOf Lancer, 10), (ShellOfReminiscence, 4)]
                  [(ShellOfReminiscence, 8), (MysteriousDivineWine, 2)]
                  [(MysteriousDivineWine, 6), (WarhorsesYoungHorn, 12)]
    }
  , { name      = "Parvati"
    , spoiler   = Nothing
    , id        = 183
    , rarity    = 4
    , class     = Lancer
    , stats     = { base  = { atk = 1354, hp = 2120 }
                  , max   = { atk = 8127, hp = 13253 }
                  , grail = { atk = 9840, hp = 16069 }
                  }
    , gen       = { starWeight = 90, starRate = 11.8, npAtk = 1.08, npDef = 4 }
    , death     = 28
    , curve     = 29
    , attr      = Sky
    , align     = [Lawful, Good]
    , gender    = Female
    , traits    = [Humanoid, Divine, EnumaElish]
    , deck      = Deck Quick Quick Arts Buster Buster
    , hits      = { quick = 3, arts = 2, buster = 3, ex = 5 }
    , skills    = [ { name   = "Imaginary Around"
                    , rank   = EX
                    , icon   = Icon.QuickUp
                    , cd     = 7
                    , effect = [ Grant Self 3 (CardUp Quick) <| Range 20 30
                               , Grant Self 3 NPGen <| Range 20 30
                               ]
                    }
                  , { name   = "Ashes of Kama"
                    , rank   = EX
                    , icon   = Icon.SwordShieldUp
                    , cd     = 7
                    , effect = [ Grant Self 1 AttackUp <| Range 30 50
                               , Grant Self 1 DefenseUp <| Range 30 50
                               , Grant Self 1 StarUp <| Range 50 100
                               , Grant Self 3 DebuffResist <| Range 50 100
                               ]
                    }
                  , { name   = "Blessing of a Goddess"
                    , rank   = APlus
                    , icon   = Icon.Noble
                    , cd     = 7
                    , effect = [ To Ally GaugeUp <| Range 10 20
                               , To Ally Heal <| Range 2000 3000
                               , To Self GaugeSpend <| Flat 10
                               ]
                    }
                  ]
    , passives  = [magicResistance A, coreOfGoddess B]
    , phantasm  = { name   = "Trishula Shakti"
                  , desc   = "Knowing What is Love, and Refusing to Love; That is Antipathy"
                  , rank   = EX
                  , card   = Quick
                  , kind   = "Anti-Vehicle"
                  , hits   = 4
                  , effect = [ To Enemies Damage <| Range 600 1000
                             , Chance 60 <| Debuff Enemies 1 Charm Full
                             ]
                  , over   = [ To Party GaugeUp <| Range 10 30 ]
                  , first  = False
                  }
    , limited   = False
    , free      = False
    , ascendUp  = Ascension
                  [(Piece Lancer, 4)]
                  [(Piece Lancer, 10), (SerpentJewel, 5)]
                  [(Monument Lancer, 4), (WarhorsesYoungHorn, 5), (LampOfEvilSealing, 3)]
                  [(Monument Lancer, 10), (LampOfEvilSealing, 5), (MysteriousDivineWine, 4)]
    , skillUp   = Reinforcement
                  [(GemOf Lancer, 4)]
                  [(GemOf Lancer, 10)]
                  [(MagicGemOf Lancer, 4)]
                  [(MagicGemOf Lancer, 10), (WarhorsesYoungHorn, 3)]
                  [(SecretGemOf Lancer, 4), (WarhorsesYoungHorn, 5)]
                  [(SecretGemOf Lancer, 10), (SerpentJewel, 4)]
                  [(SerpentJewel, 7), (ScarabOfWisdom, 2)]
                  [(ScarabOfWisdom, 6), (HeartOfTheForeignGod, 8)]
    }
  , { name      = "Houzouin Inshun"
    , spoiler   = Nothing
    , id        = 186
    , rarity    = 3
    , class     = Lancer
    , stats     = { base  = { atk = 1261, hp = 1799 }
                  , max   = { atk = 6791, hp = 9996 }
                  , grail = { atk = 9191, hp = 13553 }
                  }
    , gen       = { starWeight = 90, starRate = 12.2, npAtk = 1.06, npDef = 4 }
    , death     = 36
    , curve     = 8
    , attr      = Man
    , align     = [Neutral, Balanced]
    , gender    = Male
    , traits    = [Humanoid, EnumaElish]
    , deck      = Deck Quick Quick Quick Arts Buster
    , hits      = { quick = 3, arts = 2, buster = 2, ex = 4 }
    , skills    = [ { name   = "Knowledge of the Sowa"
                    , rank   = B
                    , icon   = Icon.Bullseye
                    , cd     = 7
                    , effect = [ Grant Self 3 StarUp <| Range 10 30
                               , Grant Self 3 SureHit Full
                               ]
                    }
                  , { name   = "Seeking the Truth of Martial Arts"
                    , rank   = B
                    , icon   = Icon.QuickUp
                    , cd     = 7
                    , effect = [ Grant Self 1 (CardUp Quick) <| Range 30 50
                               , Grant Self 3 DebuffResist <| Flat 100
                               ]
                    }
                  , { name   = "Planning Ahead"
                    , rank   = BPlus
                    , icon   = Icon.Circuits
                    , cd     = 8
                    , effect = [ Debuff Enemy 1 SealNP Full
                               , Debuff Enemy 3 DefenseDown <| Range 10 20
                               ]
                    }
                  ]
    , passives  = [magicResistance DPlus]
    , phantasm  = { name   = "Oboro Urazuki, Eleven Forms"
                  , desc   = "11th Style: Inverted Moon Thrust"
                  , rank   = C
                  , card   = Arts
                  , kind   = "Anti-Personnel"
                  , hits   = 0
                  , effect = [ Grant Self 3 AttackUp <| Range 30 50
                             , Grant Self 3 CritUp <| Flat 100
                             , Times 1 <| Grant Self 1 Evasion Full
                             , Grant Self 1 DeathResist Full
                             ]
                  , over   = [ Grant Self 3 StarUp <| Range 100 200 ]
                  , first  = False
                  }
    , limited   = False
    , free      = False
    , ascendUp  = Ascension
                  [(Piece Lancer, 4)]
                  [(Piece Lancer, 8), (WarhorsesYoungHorn, 3)]
                  [(Monument Lancer, 4), (OctupletCrystals, 7), (PhoenixFeather, 3)]
                  [(Monument Lancer, 8), (PhoenixFeather, 6), (HeartOfTheForeignGod, 4)]
    , skillUp   = Reinforcement
                  [(GemOf Lancer, 4)]
                  [(GemOf Lancer, 8)]
                  [(MagicGemOf Lancer, 4)]
                  [(MagicGemOf Lancer, 8), (OctupletCrystals, 4)]
                  [(SecretGemOf Lancer, 4), (OctupletCrystals, 7)]
                  [(SecretGemOf Lancer, 8), (WarhorsesYoungHorn, 2)]
                  [(WarhorsesYoungHorn, 4), (RefinedMagatama, 4)]
                  [(RefinedMagatama, 12), (EvilBone, 48)]
    }
  , { name      = "Nezha"
    , spoiler   = Nothing
    , id        = 193
    , rarity    = 4
    , class     = Lancer
    , stats     = { base  = { atk = 1547,  hp = 1938 }
                  , max   = { atk = 9284,  hp = 12112 }
                  , grail = { atk = 11241, hp = 14686 }
                  }
    , gen       = { starWeight = 91, starRate = 12.2, npAtk = 0.72, npDef = 4 }
    , death     = 28
    , curve     = 4
    , attr      = Sky
    , align     = [Neutral, Good]
    , gender    = Female
    , traits    = [Humanoid, EnumaElish]
    , deck      = Deck Quick Quick Arts Buster Buster
    , hits      = { quick = 4, arts = 3, buster = 3, ex = 4 }
    , skills    = [ { name   = "Taoist Techniques"
                    , rank   = A
                    , icon   = Icon.QuickBusterUp
                    , cd     = 7
                    , effect = [ Grant Self 3 (CardUp Buster) <| Range 10 20
                               , Grant Self 3 (CardUp Quick) <| Range 10 20
                               , Grant Self 3 CritUp <| Range 20 30
                               ]
                    }
                  , { name   = "Spirit Pearl"
                    , rank   = A
                    , icon   = Icon.Kneel
                    , cd     = 9
                    , effect = [ Times 1 << Grant Self 5 Guts <| Range 1000 2000
                               , To Self GaugeUp <| Range 10 20
                               ]
                    }
                  , { name   = "Protection of Tathagata"
                    , rank   = B
                    , icon   = Icon.StarUp
                    , cd     = 7
                    , effect = [ Grant Self 1 GatherUp <| Range 300 500
                               , To Self RemoveDebuffs Full
                               ]
                    }
                  ]
    , passives  = [magicResistance A]
    , phantasm  = { name   = "Flying Bright Spirit, Fire-Tipped Spear"
                  , desc   = ""
                  , rank   = A
                  , card   = Buster
                  , kind   = "Anti-Army"
                  , hits   = 3
                  , effect = [ To Enemies Damage <| Range 300 500
                             , Debuff Enemies 5 Burn <| Flat 1000
                             ]
                  , over   = [ Grant Self 1 NPUp <| Range 20 60 ]
                  , first  = True
                  }
    , limited   = False
    , free      = False
    , ascendUp  = Ascension
                  [(Piece Lancer, 4)]
                  [(Piece Lancer, 10), (EternalGear, 6)]
                  [(Monument Lancer, 4), (HomunculusBaby, 8), (ClawOfChaos, 3)]
                  [(Monument Lancer, 10), (ClawOfChaos, 5), (WarhorsesYoungHorn, 6)]
    , skillUp   = Reinforcement
                  [(GemOf Lancer, 4)]
                  [(GemOf Lancer, 10)]
                  [(MagicGemOf Lancer, 4)]
                  [(MagicGemOf Lancer, 10), (HomunculusBaby, 4)]
                  [(SecretGemOf Lancer, 4), (HomunculusBaby, 8)]
                  [(SecretGemOf Lancer, 10), (EternalGear, 4)]
                  [(EternalGear, 8), (MysticSpinalFluid, 15)]
                  [(MysticSpinalFluid, 45), (RefinedMagatama, 20)]
    }
  , { name      = "Ereshkigal"
    , spoiler   = Nothing
    , id        = 196
    , rarity    = 5
    , class     = Lancer
    , stats     = { base  = { atk = 1598,  hp = 2356 }
                  , max   = { atk = 10343, hp = 16065 }
                  , grail = { atk = 11322, hp = 17600 }
                  }
    , gen       = { starWeight = 90, starRate = 11.8, npAtk = 0.54, npDef = 4 }
    , death     = 28
    , curve     = 30
    , attr      = Earth
    , align     = [Chaotic, Evil]
    , gender    = Female
    , traits    = [Humanoid, Divine]
    , deck      = Deck Quick Quick Arts Buster Buster
    , hits      = { quick = 4, arts = 6, buster = 1, ex = 4 }
    , skills    = [ { name   = "Concealed Great Crown"
                    , rank   = A
                    , icon   = Icon.Shield
                    , cd     = 8
                    , effect = [ Chances 60 80 <| Grant Self 1 DebuffResist Full
                               , Chances 60 80 <| Grant Self 1 DeathResist Full
                               , Chances 60 80 << Grant Self 1 BuffRemoveResist <| Flat 100
                               ]
                    }
                  , { name   = "Mana Burst (Prison)"
                    , rank   = APlus
                    , icon   = Icon.BusterUp
                    , cd     = 8
                    , effect = [ Grant Self 1 (CardUp Buster) <| Range 30 50
                               , To Self GaugeUp <| Range 30 50
                               ]
                    }
                  , { name   = "Blessing of Kur"
                    , rank   = EX
                    , icon   = Icon.Flower
                    , cd     = 8
                    , effect = [ To Party (ApplyTrait BlessingOfKur) <| Flat 3
                               , Grant Party 3 DefenseUp <| Range 10 20
                               , Grant Party 3 NPGen <| Range 20 30
                               , Grant Party 3 HPUp <| Range 2000 3000
                               ]
                    }
                  ]
    , passives  = [magicResistance D, territoryCreation APlus, coreOfGoddess B]
    , phantasm  = { name   = "Kur Ki Gal Irkalla"
                  , desc   = ""
                  , rank   = A
                  , card   = Buster
                  , kind   = "Anti-Mountain"
                  , hits   = 5
                  , effect = [ To Enemies Damage <| Range 300 500
                             , Grant (AlliesType BlessingOfKur) 3 AttackUp <| Flat 20
                             ]
                  , over   = [ Grant Self 1 (CardUp Buster) <| Range 10 50 ]
                  , first  = True
                  }
    , limited   = True
    , free      = False
    , ascendUp  = Ascension
                  [(Piece Lancer, 5)]
                  [(Piece Lancer, 12), (GhostLantern, 8)]
                  [(Monument Lancer, 5), (FoolsChain, 29), (HeartOfTheForeignGod, 2)]
                  [(Monument Lancer, 12), (HeartOfTheForeignGod, 4), (MysteriousDivineWine, 5)]
    , skillUp   = Reinforcement
                  [(GemOf Lancer, 5)]
                  [(GemOf Lancer, 12)]
                  [(MagicGemOf Lancer, 5)]
                  [(MagicGemOf Lancer, 12), (FoolsChain, 15)]
                  [(SecretGemOf Lancer, 5), (FoolsChain, 29)]
                  [(SecretGemOf Lancer, 12), (GhostLantern, 5)]
                  [(GhostLantern, 10), (RefinedMagatama, 6)]
                  [(RefinedMagatama, 18), (StakeOfWailingNight, 72)]
    }
  ]
