module Database.Servant.Archer exposing (archers)

import Database.Base exposing (..)
import Database.Passive exposing (..)
import Database.Servant exposing (..)
import Database.Skill exposing (..)

import Database.Icon as Icon

archers : List Servant
archers =
  [ { name      = "EMIYA"
    , spoiler   = Nothing
    , id        = 11
    , rarity    = 4
    , class     = Archer
    , attr      = Human
    , deck      = Deck Quick Arts Arts Arts Buster
    , curve     = 14
    , stats     = { base  = { atk = 1566,  hp = 1843 }
                  , max   = { atk = 9398, hp = 11521 }
                  , grail = { atk = 11379, hp = 13969 }
                  }
    , skills    = [ { name   = "Mind's Eye (True)"
                    , rank   = B
                    , icon   = Icon.Dodge
                    , cd     = 8
                    , effect = [ Grant Self 1 Evasion Full
                               , Grant Self 3 DefenseUp <| Range 9 18
                               ]
                    }
                  , { name   = "Hawkeye"
                    , rank   = BPlus
                    , icon   = Icon.StarHaloUp
                    , cd     = 8
                    , effect = [ Grant Self 3 StarUp <| Range 50 100
                               , Grant Self 3 CritUp <| Range 50 100
                               ]
                    }
                  , { name   = "Projection"
                    , rank   = A
                    , icon   = Icon.AllUp
                    , cd     = 7
                    , effect = [ Grant Self 1 (CardUp Arts) <| Range 25 40
                               , Grant Self 1 (CardUp Quick) <| Range 25 40
                               , Grant Self 1 (CardUp Buster) <| Range 25 40
                               ]
                    }
                  ]
    , passives  = [magicResistance D, independentAction B]
    , phantasm  = { name   = "Unlimited Blade Works"
                  , desc   = "Infinite Creation of Swords"
                  , rank   = APlusPlus
                  , card   = Buster
                  , kind   = "Unknown"
                  , hits   = 10
                  , effect = [ To Enemies DamageThruDef <| Range 400 600 ]
                  , over   = [ Debuff Enemies 3 AttackDown <| Range 10 30 ]
                  , first  = False
                  }
    , gen       = { starWeight = 145, starRate = 7.9, npAtk = 0.51, npDef = 3 }
    , hits      = { quick = 2, arts = 3, buster = 1, ex = 5 }
    , gender    = Male
    , traits    = [Humanoid, EnumaElish, LovedOne]
    , death     = 31.5
    , align     = [Neutral, Balanced]
    , limited   = False
    , free      = False
    , ascendUp  = Ascension
                  [(Piece Archer, 4)]
                  [(Piece Archer, 10), (ProofOfHero, 18)]
                  [(Monument Archer, 4), (HeartOfTheForeignGod, 2), (EternalGear, 8)]
                  [(Monument Archer, 10), (HeartOfTheForeignGod, 4), (VoidsDust, 20)]
    , skillUp   = Reinforcement
                  [(GemOf Archer, 4)]
                  [(GemOf Archer, 10)]
                  [(MagicGemOf Archer, 4)]
                  [(MagicGemOf Archer, 10), (EternalGear, 4)]
                  [(SecretGemOf Archer, 4), (EternalGear, 8)]
                  [(SecretGemOf Archer, 10), (ProofOfHero, 12)]
                  [(PhoenixFeather, 4), (ProofOfHero, 24)]
                  [(PhoenixFeather, 12), (VoidsDust, 40)]
    }
  , { name      = "Gilgamesh"
    , spoiler   = Nothing
    , id        = 12
    , rarity    = 5
    , class     = Archer
    , stats     = { base  = { atk = 1897,  hp = 1920 }
                  , max   = { atk = 12280, hp = 13097 }
                  , grail = { atk = 13442, hp = 14348 }
                  }
    , gen       = { starWeight = 153, starRate = 7.9, npAtk = 0.34, npDef = 3 }
    , death     = 31.5
    , curve     = 10
    , attr      = Sky
    , align     = [Chaotic, Good]
    , gender    = Male
    , traits    = [Humanoid, Divine, EnumaElish, King]
    , deck      = Deck Quick Arts Arts Buster Buster
    , hits      = { quick = 5, arts = 5, buster = 5, ex = 8 }
    , skills    = [ { name   = "Charisma"
                    , rank   = APlus
                    , icon   = Icon.SwordUp
                    , cd     = 7
                    , effect = [ Grant Party 3 AttackUp <| Range 10.5 21 ]
                    }
                  , { name   = "Golden Rule"
                    , rank   = A
                    , icon   = Icon.NobleUp
                    , cd     = 8
                    , effect = [ Grant Self 3 NPGen <| Range 20 50 ]
                    }
                  , { name   = "Treasury of Babylon"
                    , rank   = EX
                    , icon   = Icon.StarUp
                    , cd     = 7
                    , effect = [ Grant Self 3 GatherUp <| Range 300 600
                               , To Self GaugeUp <| Range 20 30
                               ]
                    }
                  ]
    , passives  = [magicResistance E, independentAction APlus, divinity B]
    , phantasm  = { name   = "Enuma Elish"
                  , desc   = "Star of Creation that Divided Heaven and Earth"
                  , rank   = EX
                  , card   = Buster
                  , kind   = "Anti-World"
                  , hits   = 1
                  , effect = [ Grant Self 1 NPUp <| Flat 30
                             , To Enemies Damage <| Range 400 600
                             ]
                  , over   = [ To Enemies (SpecialDamage <| VsTrait EnumaElish) <| Range 150 200 ]
                  , first  = False
                  }
    , limited   = True
    , free      = False
    , ascendUp  = Ascension
                  [(Piece Archer, 5)]
                  [(Piece Archer, 12), (SerpentJewel, 6)]
                  [(Monument Archer, 5), (ProofOfHero, 29), (DragonsReverseScale, 2)]
                  [( Monument Archer, 12), (DragonsReverseScale, 4), (HeartOfTheForeignGod, 5)]
    , skillUp   = Reinforcement
                  [(GemOf Archer, 5)]
                  [(GemOf Archer, 12)]
                  [(MagicGemOf Archer, 5)]
                  [(MagicGemOf Archer, 12), (ProofOfHero, 15)]
                  [(SecretGemOf Archer, 5), (ProofOfHero, 29)]
                  [(SecretGemOf Archer, 12), (SerpentJewel, 4)]
                  [(SerpentJewel, 8), (VoidsDust, 12)]
                  [(VoidsDust, 36), (HeartOfTheForeignGod, 10)]
    }
  , { name      = "Robin Hood"
    , spoiler   = Nothing
    , id        = 13
    , rarity    = 3
    , class     = Archer
    , attr      = Human
    , deck      = Deck Quick Quick Arts Arts Buster
    , curve     = 3
    , stats     = { base  = { atk = 1247, hp = 1833 }
                  , max   = { atk = 6715, hp = 10187 }
                  , grail = { atk = 9088, hp = 13812 }
                  }
    , skills    = [ { name   = "Sabotage"
                    , rank   = A
                    , icon   = Icon.SwordDown
                    , cd     = 7
                    , effect = [ Debuff Enemies 3 AttackDown <| Range 5 15
                               , Debuff Enemies 5 Poison <| Flat 500
                               ]
                    }
                  , { name   = "Golden Rule"
                    , rank   = E
                    , icon   = Icon.NobleUp
                    , cd     = 8
                    , effect = [ Grant Self 3 NPGen <| Range 12 30 ]
                    }
                  , { name   = "May King"
                    , rank   = B
                    , icon   = Icon.Dodge
                    , cd     = 8
                    , effect = [ Grant Self 1 SureHit Full
                               , Grant Self 1 Evasion Full
                               , To Party GainStars <| Range 10 20
                               ]
                    }
                  ]
    , passives  = [magicResistance D, independentAction A]
    , phantasm  = { name   = "Yew Bow"
                  , desc   = "Bow of Prayer"
                  , rank   = D
                  , card   = Arts
                  , kind   = "Anti-Personnel"
                  , hits   = 1
                  , effect = [ To Enemy Damage <| Range 900 1500 ]
                  , over   = [ To Enemy (SpecialDamage <| VsTrait Poisoned) <| Range 200 250 ]
                  , first  = False
                  }
    , gen       = { starWeight = 150, starRate = 8, npAtk = 0.87, npDef = 3 }
    , hits      = { quick = 3, arts = 2, buster = 1, ex = 3 }
    , gender    = Male
    , traits    = [Humanoid, EnumaElish, LovedOne]
    , death     = 31.5
    , align     = [Neutral, Good]
    , limited   = False
    , free      = True
    , ascendUp  = Ascension
                  [(Piece Archer, 4)]
                  [(Piece Archer, 8), (SeedOfYggdrasil, 6)]
                  [(Monument Archer, 4), (SerpentJewel, 6), (DragonFang, 8)]
                  [(Monument Archer, 8), (DragonFang, 16), (VoidsDust, 16)]
    , skillUp   = Reinforcement
                  [(GemOf Archer, 4)]
                  [(GemOf Archer, 8)]
                  [(MagicGemOf Archer, 4)]
                  [(MagicGemOf Archer, 8), (SerpentJewel, 3)]
                  [(SecretGemOf Archer, 4), (SerpentJewel, 6)]
                  [(SecretGemOf Archer, 8), (SeedOfYggdrasil, 4)]
                  [(SeedOfYggdrasil, 8), (PhoenixFeather, 4)]
                  [(PhoenixFeather, 10), (VoidsDust, 32)]
    }
  , { name      = "Atalante"
    , spoiler   = Nothing
    , id        = 14
    , rarity    = 4
    , class     = Archer
    , attr      = Earth
    , deck      = Deck Quick Quick Arts Arts Buster
    , curve     = 9
    , stats     = { base  = { atk = 1438,  hp = 1996 }
                  , max   = { atk = 8633,  hp = 12476 }
                  , grail = { atk = 10453, hp = 15127 }
                  }
    , skills    = [ { name   = "Beyond Arcadia"
                    , rank   = A
                    , icon   = Icon.QuickUp
                    , cd     = 7
                    , effect = [ Grant Party 1 (CardUp Quick) <| Range 30 50 ]
                    }
                  , { name   = "Hunter's Aesthetic"
                    , rank   = C
                    , icon   = Icon.StarUp
                    , cd     = 6
                    , effect = [ Grant Self 1 GatherUp <| Range 500 1000 ]
                    }
                  , { name   = "Calydonian Hunt"
                    , rank   = A
                    , icon   = Icon.Dodge
                    , cd     = 8
                    , effect = [ Grant Self 1 Evasion Full
                              , Grant Self 3 NPGen <| Range 30 50
                              ]
                    }
                  ]
    , passives  = [magicResistance D, independentAction A]
    , phantasm  = { name   = "Phoebus Catastrophe"
                  , desc   = "Complaint Message on the Arrow"
                  , rank   = BPlus
                  , card   = Quick
                  , kind   = "Anti-Army"
                  , hits   = 10
                  , effect = [ To Enemies Damage <| Range 800 1200 ]
                  , over   = [ To Party GainStars <| Range 15 35 ]
                  , first  = False
                  }
    , gen       = { starWeight = 148, starRate = 8, npAtk = 0.5, npDef = 3 }
    , hits      = { quick = 3, arts = 2, buster = 1, ex = 3 }
    , gender    = Female
    , traits    = [Argonaut, Humanoid, EnumaElish]
    , death     = 31.5
    , align     = [Neutral, Evil]
    , limited   = False
    , free      = False
    , ascendUp  = Ascension
                  [(Piece Archer, 4)]
                  [(Piece Archer, 10), (PhoenixFeather, 5)]
                  [(Monument Archer, 4), (DragonFang, 20), (SerpentJewel, 4)]
                  [(Monument Archer, 10), (SerpentJewel, 7), (SeedOfYggdrasil, 12)]
    , skillUp   = Reinforcement
                  [(GemOf Archer, 4)]
                  [(GemOf Archer, 10)]
                  [(MagicGemOf Archer, 4)]
                  [(MagicGemOf Archer, 10), (DragonFang, 10)]
                  [(SecretGemOf Archer, 4), (DragonFang, 20)]
                  [(SecretGemOf Archer, 10), (PhoenixFeather, 4)]
                  [(PhoenixFeather, 7), (VoidsDust, 10)]
                  [(VoidsDust, 30), (SeedOfYggdrasil, 24)]
    }
  , { name      = "Euryale"
    , spoiler   = Nothing
    , id        = 15
    , rarity    = 3
    , class     = Archer
    , attr      = Sky
    , deck      = Deck Quick Quick Arts Arts Buster
    , curve     = 3
    , stats     = { base  = { atk = 1306, hp = 1711 }
                  , max   = { atk = 7032, hp = 9506 }
                  , grail = { atk = 9517, hp = 12889 }
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
                    , icon   = Icon.ArtsUp
                    , cd     = 7
                    , effect = [ Grant Self 3 (CardUp Arts) <| Range 20 30 ]
                    }
                  ]
    , passives  = [magicResistance A, independentAction APlus, coreOfGoddess EX]
    , phantasm  = { name   = "Eye of the Euryale"
                  , desc   = "Gaze of the Goddess"
                  , rank   = B
                  , card   = Arts
                  , kind   = "Anti-Personnel"
                  , hits   = 1
                  , effect = [ To Enemy Damage <| Flat 1200
                             , To Enemy (SpecialDamage <| VsTrait Male) <| Range 150 250
                             , Chance 150 << Debuff Enemy 3 AttackDown <| Flat 20
                             ]
                  , over   = [ Chances 100 200 <| Debuff (EnemyType Male) 1 Charm Full ]
                  , first  = False
                  }
    , gen       = { starWeight = 156, starRate = 7.9, npAtk = 0.9, npDef = 3 }
    , hits      = { quick = 3, arts = 2, buster = 1, ex = 3 }
    , gender    = Female
    , traits    = [Humanoid, Divine, EnumaElish]
    , death     = 22.5
    , align     = [Chaotic, Good]
    , limited   = False
    , free      = True
    , ascendUp  = Ascension
                  [(Piece Archer, 4)]
                  [(Piece Archer, 8), (SerpentJewel, 4)]
                  [(Monument Archer, 4), (DragonsReverseScale, 3), (VoidsDust, 7)]
                  [(Monument Archer, 8), (VoidsDust, 13), (HeartOfTheForeignGod, 4)]
    , skillUp   = Reinforcement
                  [(GemOf Archer, 4)]
                  [(GemOf Archer, 8)]
                  [(MagicGemOf Archer, 4)]
                  [(MagicGemOf Archer, 8), (DragonsReverseScale, 2)]
                  [(SecretGemOf Archer, 4), (DragonsReverseScale, 3)]
                  [(SecretGemOf Archer, 8), (SerpentJewel, 3)]
                  [(SerpentJewel, 6), (ClawOfChaos, 3)]
                  [(ClawOfChaos, 8), (HeartOfTheForeignGod, 7)]
    }
  , { name      = "Arash"
    , spoiler   = Nothing
    , id        = 16
    , rarity    = 1
    , class     = Archer
    , attr      = Earth
    , deck      = Deck Quick Arts Arts Buster Buster
    , curve     = 1
    , stats     = { base  = { atk = 1057, hp = 1424 }
                  , max   = { atk = 5816, hp = 7122 }
                  , grail = { atk = 9037, hp = 10979 }
                  }
    , skills    = [ { name   = "Toughness"
                    , rank   = EX
                    , icon   = Icon.ShieldUp
                    , cd     = 7
                    , effect = [ Grant Self 3 DefenseUp <| Range 10 20
                               , Grant Self 3 (Resist Poison) <| Range 80 160
                               ]
                    }
                  , { name   = "Clairvoyance"
                    , rank   = A
                    , icon   = Icon.StarHaloUp
                    , cd     = 8
                    , effect = [ Grant Self 3 StarUp <| Range 20 40 ]
                    }
                  , { name   = "Arrow Construction"
                    , rank   = A
                    , icon   = Icon.Noble
                    , cd     = 8
                    , effect = [ To Self GaugeUp <| Range 20 30
                               , To Self Heal <| Range 1000 3000
                               ]
                    }
                  ]
    , passives  = [magicResistance C, independentAction C]
    , phantasm  = { name   = "Stella"
                  , desc   = "The Streaking Meteor"
                  , rank   = A
                  , card   = Buster
                  , kind   = "Anti-Army"
                  , hits   = 1
                  , effect = [ To Enemies Damage <| Range 800 1200
                             , To Self DemeritKill Full
                             ]
                  , over   = [ To Enemies Damage <| Range 0 800 ]
                  , first  = False
                  }
    , gen       = { starWeight = 147, starRate = 8, npAtk = 0.84, npDef = 3 }
    , hits      = { quick = 3, arts = 2, buster = 1, ex = 3 }
    , gender    = Male
    , traits    = [Humanoid, EnumaElish, LovedOne]
    , death     = 45
    , align     = [Chaotic, Balanced]
    , limited   = False
    , free      = True
    , ascendUp  = Ascension
                  [(Piece Archer, 2)]
                  [(Piece Archer, 4), (SeedOfYggdrasil, 3)]
                  [(Monument Archer, 2), (ProofOfHero, 10), (OctupletCrystals, 2)]
                  [(Monument Archer, 4), (OctupletCrystals, 4), (VoidsDust, 8)]
    , skillUp   = Reinforcement
                  [(GemOf Archer, 2)]
                  [(GemOf Archer, 4)]
                  [(MagicGemOf Archer, 2)]
                  [(MagicGemOf Archer, 4), (ProofOfHero, 5)]
                  [(SecretGemOf Archer, 2), (ProofOfHero, 10)]
                  [(SecretGemOf Archer, 4), (SeedOfYggdrasil, 2)]
                  [(SeedOfYggdrasil, 4), (HomunculusBaby, 2)]
                  [(HomunculusBaby, 6), (VoidsDust, 16)]
    }
  , { name      = "Orion"
    , spoiler   = Nothing
    , id        = 60
    , rarity    = 5
    , class     = Archer
    , attr      = Sky
    , deck      = Deck Quick Quick Arts Arts Buster
    , curve     = 25
    , stats     = { base  = { atk = 1716,  hp = 2134 }
                  , max   = { atk = 11107, hp = 14553 }
                  , grail = { atk = 12158, hp = 15943 }
                  }
    , skills    = [ { name   = "Grace of the Goddess"
                    , rank   = EX
                    , icon   = Icon.ShieldUp
                    , cd     = 7
                    , effect = [ Grant Self 1 DefenseUp <| Range 30 50
                               , Grant Self 3 AttackUp <| Flat 20
                               , Grant Self 3 DebuffResist <| Flat 50
                               ]
                    }
                  , { name = "Punish the Unfaithful"
                    , rank   = APlus
                    , icon   = Icon.DamageUp
                    , cd     = 7
                    , effect = [ Grant Self 1 (Special AttackUp <| VsTrait Male) <| Range 50 100 ]
                    }
                  , { name = "Mind's Eye (Fake)"
                    , rank   = BMinus
                    , icon   = Icon.Dodge
                    , cd     = 8
                    , effect = [ Grant Self 1 Evasion Full
                               , Grant Self 3 CritUp <| Range 17 34
                               ]
                    }
                  ]
    , passives  = [magicResistance D, independentAction APlus]
    , phantasm  = { name   = "Tri-Star Amore Mio"
                  , desc   = "Moon Goddess's Arrows of Love and Romance"
                  , rank   = APlus
                  , card   = Arts
                  , kind   = "Anti-Personnel"
                  , hits   = 5
                  , effect = [ To Enemy Damage <| Range 1200 1800
                             , Debuff Enemy 3 AttackDown <| Flat 20
                             , To Enemy GaugeDown <| Flat 1
                             ]
                  , over   = [ Debuff Enemy 3 CritChance <| Range 20 60 ]
                  , first  = False
                  }
    , gen       = { starWeight = 153, starRate = 8, npAtk = 1, npDef = 3 }
    , hits      = { quick = 3, arts = 1, buster = 1, ex = 4 }
    , gender    = Male
    , traits    = [Humanoid, GreekMythMale, EnumaElish]
    , death     = 27
    , align     = [Chaotic, Balanced]
    , limited   = False
    , free      = False
    , ascendUp  = Ascension
                  [(Piece Archer, 5)]
                  [(Piece Archer, 12), (HeartOfTheForeignGod, 3)]
                  [(Monument Archer, 5), (SerpentJewel, 8), (ClawOfChaos, 3)]
                  [(Monument Archer, 12), (ClawOfChaos, 6), (PhoenixFeather, 10)]
    , skillUp   = Reinforcement
                  [(GemOf Archer, 5)]
                  [(GemOf Archer, 12)]
                  [(MagicGemOf Archer, 5)]
                  [(MagicGemOf Archer, 12), (SerpentJewel, 4)]
                  [(SecretGemOf Archer, 5), (SerpentJewel, 8)]
                  [(SecretGemOf Archer, 12), (HeartOfTheForeignGod, 2)]
                  [(HeartOfTheForeignGod, 4), (VoidsDust, 12)]
                  [(VoidsDust, 36), (PhoenixFeather, 20)]
    }
  , { name      = "David"
    , spoiler   = Nothing
    , id        = 63
    , rarity    = 3
    , class     = Archer
    , attr      = Sky
    , deck      = Deck Quick Arts Arts Arts Buster
    , curve     = 23
    , stats     = { base  = { atk = 1436,  hp = 1555 }
                  , max   = { atk = 7736,  hp = 8643 }
                  , grail = { atk = 10470, hp = 11719 }
                  }
    , skills    = [ { name   = "Divine Protection"
                    , rank   = A
                    , icon   = Icon.ShieldUp
                    , cd     = 7
                    , effect = [ Grant Self 1 DefenseUp <| Flat 50
                               , To Self Heal <| Range 1000 2000
                               ]
                    }
                  , { name   = "Harp of Healing"
                    , rank   = B
                    , icon   = Icon.Bubbles
                    , cd     = 8
                    , effect = [ To Party RemoveMental Full
                               , Times 1 <| Grant Party 0 Evasion Full
                               , To Party Heal <| Range 300 800
                               ]
                    }
                  , { name   = "Charisma"
                    , rank   = B
                    , icon   = Icon.SwordUp
                    , cd     = 7
                    , effect = [ Grant Party 3 AttackUp <| Range 9 18 ]
                    }
                  ]
    , passives  = [magicResistance A, independentAction A]
    , phantasm  = { name   = "Hamesh Avanim"
                  , desc   = "The Five Stones"
                  , rank   = CMinus
                  , card   = Buster
                  , kind   = "Anti-Personnel"
                  , hits   = 1
                  , effect = [ Grant Self 1 SureHit Full
                             , To Enemy Damage <| Range 600 1000
                             ]
                  , over   = [ Chances 100 200 <| Debuff Enemy 1 SealSkills Full ]
                  , first  = False
                  }
    , gen       = { starWeight = 153, starRate = 8, npAtk = 0.76, npDef = 3 }
    , hits      = { quick = 2, arts = 2, buster = 1, ex = 3 }
    , gender    = Male
    , traits    = [Humanoid, EnumaElish, King]
    , death     = 36
    , align     = [Lawful, Balanced]
    , limited   = False
    , free      = True
    , ascendUp  = Ascension
                  [(Piece Archer, 4)]
                  [(Piece Archer, 8), (VoidsDust, 10)]
                  [(Monument Archer, 4), (HomunculusBaby, 7), (HeartOfTheForeignGod, 2)]
                  [(Monument Archer, 8), (HeartOfTheForeignGod, 3), (OctupletCrystals, 8)]
    , skillUp   = Reinforcement
                  [(GemOf Archer, 4)]
                  [(GemOf Archer, 8)]
                  [(MagicGemOf Archer, 4)]
                  [(MagicGemOf Archer, 8), (HomunculusBaby, 4)]
                  [(SecretGemOf Archer, 4), (HomunculusBaby, 7)]
                  [(SecretGemOf Archer, 8), (VoidsDust, 7)]
                  [(VoidsDust, 13), (ProofOfHero, 12)]
                  [(ProofOfHero, 36), (OctupletCrystals, 16)]
    }
  , { name      = "Oda Nobunaga"
    , spoiler   = Nothing
    , id        = 69
    , rarity    = 4
    , class     = Archer
    , attr      = Human
    , deck      = Deck Quick Arts Arts Buster Buster
    , curve     = 14
    , stats     = { base  = { atk = 1862,  hp = 1582 }
                  , max   = { atk = 9494,  hp = 11637 }
                  , grail = { atk = 11495, hp = 14110 }
                  }
    , skills    = [ { name   = "Strategy"
                    , rank   = B
                    , icon   = Icon.NobleUp
                    , cd     = 8
                    , effect = [ Grant Party 3 NPGen <| Range 20 30 ]
                    }
                  , { name   = "Unifying the Nation by Force"
                    , rank   = A
                    , icon   = Icon.DamageUp
                    , cd     = 7
                    , effect = [ Grant Self 1 (Special AttackUp <| VsTrait Divine) <| Range 50 100 ]
                    }
                  , { name   = "The Demonic King"
                    , rank   = A
                    , icon   = Icon.ExclamationUp
                    , cd     = 7
                    , effect = [ Grant Self 3 CritUp <| Range 20 50
                               , Grant Self 3 GatherUp <| Range 300 600
                               ]
                    }
                  ]
    , passives  = [magicResistance B, independentAction B]
    , phantasm  = { name   = "Three Line Formation"
                  , desc   = "Three Thousand Worlds"
                  , rank   = A
                  , card   = Buster
                  , kind   = "Anti-Army"
                  , hits   = 10
                  , effect = [ To Enemies Damage <| Range 300 500 ]
                  , over   = [ To Enemies (SpecialDamage <| VsTrait Riding) <| Range 150 200 ]
                  , first  = False
                  }
    , gen       = { starWeight = 150, starRate = 7.9, npAtk = 0.43, npDef = 3 }
    , hits      = { quick = 2, arts = 4, buster = 4, ex = 5 }
    , gender    = Female
    , traits    = [Humanoid, EnumaElish, King]
    , death     = 31.5
    , align     = [Lawful, Balanced]
    , limited   = True
    , free      = True
    , ascendUp  = Welfare "Golden Skull"
    , skillUp   = Reinforcement
                  [(GemOf Archer, 4)]
                  [(GemOf Archer, 10)]
                  [(MagicGemOf Archer, 4)]
                  [(MagicGemOf Archer, 10), (EvilBone, 12)]
                  [(SecretGemOf Archer, 4), (EvilBone, 24)]
                  [(SecretGemOf Archer, 10), (OctupletCrystals, 4)]
                  [(OctupletCrystals, 8), (ClawOfChaos, 3)]
                  [(ClawOfChaos, 9), (HeartOfTheForeignGod, 8)]
    }
  , { name      = "Nikola Tesla"
    , spoiler   = Nothing
    , id        = 77
    , rarity    = 5
    , class     = Archer
    , attr      = Star
    , deck      = Deck Quick Arts Arts Buster Buster
    , curve     = 10
    , stats     = { base  = { atk = 1820,  hp = 2027 }
                  , max   = { atk = 11781, hp = 13825 }
                  , grail = { atk = 12896, hp = 15146 }
                  }
    , skills    = [ { name   = "Tesla Coil"
                    , rank   = APlus
                    , icon   = Icon.NobleUp
                    , cd     = 7
                    , effect = [ Grant Self 3 NPGen <| Range 30 50
                               , Grant Others 3 NPGen <| Range 20 30
                               ]
                    }
                  , { name = "Inherent Wisdom"
                    , rank   = EX
                    , icon   = Icon.Kneel
                    , cd     = 7
                    , effect = [ Times 1 << Grant Self 3 Guts <| Range 1000 3000
                               , Chance 80 << Grant Self 3 DefenseUp <| Range 20 30
                               , Chance 80 << Grant Self 1 NPUp <| Range 20 30
                               , Grant Self 3 AttackUp <| Range 10 20
                               ]
                    }
                  , { name = "Pioneer of the Stars"
                    , rank   = EX
                    , icon   = Icon.Noble
                    , cd     = 8
                    , effect = [ To Self GaugeUp <| Range 30 50
                               , Grant Self 3 IgnoreInvinc Full
                               , To Party GainStars <| Flat 10
                               ]
                    }
                  ]
    , passives  = [magicResistance C, independentAction B]
    , phantasm  = { name   = "System Keraunos"
                  , desc   = "Legend of Mankind: Advent of Lightning"
                  , rank   = EX
                  , card   = Buster
                  , kind   = "Anti-Fortress"
                  , hits   = 3
                  , effect = [ To Enemies Damage <| Range 400 600
                             , Chance 40 <| Debuff Enemies 1 Stun Full
                             , To Self DemeritDamage <| Flat 500
                             ]
                  , over   = [ To Enemies (SpecialDamage <| VsTrait EarthOrSky) <| Range 150 200 ]
                  , first  = False
                  }
    , gen       = { starWeight = 147, starRate = 7.9, npAtk = 0.87, npDef = 3 }
    , hits      = { quick = 3, arts = 2, buster = 1, ex = 3 }
    , gender    = Male
    , traits    = [Humanoid, LovedOne]
    , death     = 31.5
    , align     = [Chaotic, Good]
    , limited   = False
    , free      = False
    , ascendUp  = Ascension
                  [(Piece Archer, 5)]
                  [(Piece Archer, 12), (VoidsDust, 15)]
                  [(Monument Archer, 5), (ForbiddenPage, 10), (EternalGear, 5)]
                  [(Monument Archer, 12), (EternalGear, 10), (GhostLantern, 12)]
    , skillUp   = Reinforcement
                  [(GemOf Archer, 5)]
                  [(GemOf Archer, 12)]
                  [(MagicGemOf Archer, 5)]
                  [(MagicGemOf Archer, 12), (ForbiddenPage, 5)]
                  [(SecretGemOf Archer, 5), (ForbiddenPage, 10)]
                  [(SecretGemOf Archer, 12), (VoidsDust, 10)]
                  [(VoidsDust, 20), (PhoenixFeather, 5)]
                  [(PhoenixFeather, 15), (GhostLantern, 24)]
    }
  , { name      = "Arjuna"
    , spoiler   = Nothing
    , id        = 84
    , rarity    = 5
    , class     = Archer
    , attr      = Sky
    , deck      = Deck Quick Arts Arts Arts Buster
    , curve     = 25
    , stats     = { base  = { atk = 1907,  hp = 1940 }
                  , max   = { atk = 12342, hp = 13230 }
                  , grail = { atk = 13510, hp = 14494 }
                  }
    , skills    = [ { name   = "Clairvoyance (Archer)"
                    , rank   = BPlus
                    , icon   = Icon.StarHaloUp
                    , cd     = 8
                    , effect = [ Grant Self 3 StarUp <| Range 30 50
                               , Grant Self 5 DebuffResist Full
                               ]
                    }
                  , { name = "Hero of the Endowed"
                    , rank   = A
                    , icon   = Icon.Noble
                    , cd     = 12
                    , effect = [ To Self GaugeUp <| Flat 25
                               , Grant Self 5 HealPerTurn <| Range 1000 2000
                               , Grant Self 5 StarsPerTurn <| Range 4 8
                               ]
                    }
                  , { name = "Mana Burst (Flame)"
                    , rank   = A
                    , icon   = Icon.BusterUp
                    , cd     = 7
                    , effect = [ Grant Self 1 (CardUp Buster) <| Range 20 30
                               , Grant Self 1 NPUp <| Range 10 20
                               ]
                    }
                  ]
    , passives  = [magicResistance C, independentAction A, divinity B]
    , phantasm  = { name   = "Pashupata"
                  , desc   = "Raised Hand of the Destruction God"
                  , rank   = APlus
                  , card   = Buster
                  , kind   = "Anti-Army"
                  , hits   = 1
                  , effect = [ To Enemies Damage <| Range 400 600
                             , To Enemies Death <| Flat 50
                             , To (EnemiesType Divine) Death <| Flat 80
                             ]
                  , over   = [ Debuff Enemies 3 DefenseDown <| Range 20 40 ]
                  , first  = False
                  }
    , gen       = { starWeight = 154, starRate = 8, npAtk = 0.51, npDef = 3 }
    , hits      = { quick = 2, arts = 3, buster = 3, ex = 5 }
    , gender    = Male
    , traits    = [Humanoid, Divine, EnumaElish]
    , death     = 31.5
    , align     = [Lawful, Balanced]
    , limited   = False
    , free      = False
    , ascendUp  = Ascension
                  [(Piece Archer, 5)]
                  [(Piece Archer, 12), (ProofOfHero, 22)]
                  [(Monument Archer, 5), (PhoenixFeather, 8), (SerpentJewel, 4)]
                  [(Monument Archer, 12), (SerpentJewel, 8), (HeartOfTheForeignGod, 5)]
    , skillUp   = Reinforcement
                  [(GemOf Archer, 5)]
                  [(GemOf Archer, 12)]
                  [(MagicGemOf Archer, 5)]
                  [(MagicGemOf Archer, 12), (PhoenixFeather, 4)]
                  [(SecretGemOf Archer, 5), (PhoenixFeather, 8)]
                  [(SecretGemOf Archer, 12), (ProofOfHero, 15)]
                  [(ProofOfHero, 29), (SeedOfYggdrasil, 8)]
                  [(SeedOfYggdrasil, 22), (HeartOfTheForeignGod, 10)]
    }
  , { name      = "Gilgamesh (Child)"
    , spoiler   = Nothing
    , id        = 95
    , rarity    = 3
    , class     = Archer
    , attr      = Sky
    , deck      = Deck Quick Arts Arts Buster Buster
    , curve     = 8
    , stats     = { base  = { atk = 1429,  hp = 1571 }
                  , max   = { atk = 7696,  hp = 8731 }
                  , grail = { atk = 10415, hp = 11838 }
                  }
    , skills    = [ { name   = "Charisma"
                    , rank   = APlus
                    , icon   = Icon.SwordUp
                    , cd     = 7
                    , effect = [ Grant Party 3 AttackUp <| Range 10.5 21 ]
                    }
                  , { name   = "Fair Youth"
                    , rank   = C
                    , icon   = Icon.Heart
                    , cd     = 9
                    , effect = [ Chances 45 75 <| Debuff (EnemyType Humanoid) 1 Charm Full ]
                    }
                  , { name   = "Golden Rule"
                    , rank   = A
                    , icon   = Icon.NobleUp
                    , cd     = 8
                    , effect = [ Grant Self 3 NPGen <| Range 20 50 ]
                    }
                  ]
    , passives  = [magicResistance E, independentAction A, divinity B]
    , phantasm  = { name   = "Gate of Babylon"
                  , desc   = "King's Treasury"
                  , rank   = BPlusPlus
                  , card   = Buster
                  , kind   = "Anti-Unit"
                  , hits   = 10
                  , effect = [ To Enemies Damage <| Range 400 600 ]
                  , over   = [ Debuff Enemies 1 NPDown <| Range 50 90
                             , Debuff Enemies 1 CritDown <| Range 50 90
                             , Debuff Enemies 1 DebuffVuln <| Range 20 40
                             ]
                  , first  = False
                  }
    , gen       = { starWeight = 153, starRate = 7.9, npAtk = 0.62, npDef = 3 }
    , hits      = { quick = 3, arts = 3, buster = 3, ex = 3 }
    , gender    = Male
    , traits    = [Humanoid, Divine, EnumaElish, King]
    , death     = 36
    , align     = [Chaotic, Good]
    , limited   = False
    , free      = True
    , ascendUp  = Ascension
                  [(Piece Archer, 4)]
                  [(Piece Archer, 8), (SeedOfYggdrasil, 6)]
                  [(Monument Archer, 4), (SerpentJewel, 6), (DragonsReverseScale, 2)]
                  [(Monument Archer, 8), (DragonsReverseScale, 3), (ProofOfHero, 24)]
    , skillUp   = Reinforcement
                  [(GemOf Archer, 4)]
                  [(GemOf Archer, 8)]
                  [(MagicGemOf Archer, 4)]
                  [(MagicGemOf Archer, 8), (SerpentJewel, 3)]
                  [(SecretGemOf Archer, 4), (SerpentJewel, 6)]
                  [(SecretGemOf Archer, 8), (SeedOfYggdrasil, 4)]
                  [(SeedOfYggdrasil, 8), (VoidsDust, 8)]
                  [(VoidsDust, 24), (PhoenixFeather, 13)]
    }
  , { name      = "Billy the Kid"
    , spoiler   = Nothing
    , id        = 105
    , rarity    = 3
    , class     = Archer
    , attr      = Human
    , deck      = Deck Quick Quick Arts Arts Buster
    , curve     = 3
    , stats     = { base  = { atk = 1279, hp = 1711 }
                  , max   = { atk = 6890, hp = 9506 }
                  , grail = { atk = 9325, hp = 12889 }
                  }
    , skills    = [ { name   = "Marksmanship"
                    , rank   = APlusPlus
                    , icon   = Icon.ExclamationUp
                    , cd     = 7
                    , effect = [ Grant Self 1 CritUp <| Range 60 120 ]
                    }
                  , { name   = "Quick Draw"
                    , rank   = APlus
                    , icon   = Icon.Noble
                    , cd     = 8
                    , effect = [ To Self GaugeUp <| Range 30 50 ]
                    }
                  , { name   = "Mind's Eye (Fake)"
                    , rank   = C
                    , icon   = Icon.Dodge
                    , cd     = 8
                    , effect = [ Grant Self 1 Evasion Full
                               , Grant Self 3 CritUp <| Range 16 32
                               ]
                    }
                  ]
    , passives  = [independentAction A, riding CPlus]
    , phantasm  = { name   = "Thunderer"
                  , desc   = "Discordant Thunderclap"
                  , rank   = CPlusPlusPlus
                  , card   = Quick
                  , kind   = "Anti-Unit"
                  , hits   = 3
                  , effect = [ Grant Self 1 SureHit Full
                             , To Enemy Damage <| Range 1600 2400
                             ]
                  , over   = [ Debuff Enemy 3 CritChance <| Range 20 60 ]
                  , first  = False
                  }
    , gen       = { starWeight = 150, starRate = 8, npAtk = 0.56, npDef = 3 }
    , hits      = { quick = 2, arts = 3, buster = 4, ex = 4 }
    , gender    = Male
    , traits    = [Humanoid, Riding, EnumaElish]
    , death     = 45
    , align     = [Chaotic, Balanced]
    , limited   = False
    , free      = True
    , ascendUp  = Ascension
                  [(Piece Archer, 4)]
                  [(Piece Archer, 8), (MeteorHorseshoe, 5)]
                  [(Monument Archer, 4), (EvilBone, 20), (PhoenixFeather, 3)]
                  [(Monument Archer, 8), (PhoenixFeather, 6), (ClawOfChaos, 5)]
    , skillUp   = Reinforcement
                  [(GemOf Archer, 4)]
                  [(GemOf Archer, 8)]
                  [(MagicGemOf Archer, 4)]
                  [(MagicGemOf Archer, 8), (EvilBone, 10)]
                  [(SecretGemOf Archer, 4), (EvilBone, 20)]
                  [(SecretGemOf Archer, 8), (MeteorHorseshoe, 4)]
                  [(MeteorHorseshoe, 7), (VoidsDust, 8)]
                  [(VoidsDust, 24), (TearstoneOfBlood, 10)]
    }
  , { name      = "Tristan"
    , spoiler   = Nothing
    , id        = 122
    , rarity    = 4
    , class     = Archer
    , attr      = Earth
    , deck      = Deck Quick Quick Arts Arts Buster
    , curve     = 14
    , stats     = { base  = { atk = 1622,  hp = 1862 }
                  , max   = { atk = 9735,  hp = 11637 }
                  , grail = { atk = 11787, hp = 14110 }
                  }
    , skills    = [ { name   = "Harp of Healing"
                    , rank   = C
                    , icon   = Icon.Bubbles
                    , cd     = 8
                    , effect = [ To Party RemoveMental Full
                               , Grant Party 0 Evasion Full
                               , To Party Heal <| Range 200 600
                               ]
                    }
                  , { name = "Grace of the Unexpected Birth"
                    , rank   = B
                    , icon   = Icon.Noble
                    , cd     = 8
                    , effect = [ To Self GaugeUp <| Range 30 50
                               , Debuff Self 1 SealNP Full
                               ]
                    }
                  , { name   = "Admonishment of the King of Knights"
                    , rank   = Unknown
                    , icon   = Icon.Circuits
                    , cd     = 7
                    , effect = [ To Enemy RemoveBuffs Full
                               , Debuff Enemy 3 CritChance <| Range 10 20
                               ]
                    }
                  ]
    , passives  = [magicResistance B, independentAction B]
    , phantasm  = { name   = "Failnaught"
                  , desc   = "Fantasia of Lamentation"
                  , rank   = APlus
                  , card   = Quick
                  , kind   = "Anti-Army"
                  , hits   = 7
                  , effect = [ Grant Self 1 SureHit Full
                             , To Enemy DamageThruDef <| Range 1600 2400
                             ]
                  , over   = [ Debuff Enemy 3 DebuffVuln <| Range 30 70 ]
                  , first  = False
                  }
    , gen       = { starWeight = 145, starRate = 8.1, npAtk = 0.58, npDef = 3 }
    , hits      = { quick = 4, arts = 3, buster = 5, ex = 6 }
    , gender    = Male
    , traits    = [Humanoid, EnumaElish]
    , death     = 31.5
    , align     = [Lawful, Good]
    , limited   = False
    , free      = False
    , ascendUp  = Ascension
                  [(Piece Archer, 4)]
                  [(Piece Archer, 10), (GreatKnightMedal, 12)]
                  [(Monument Archer, 4), (PhoenixFeather, 7), (ForbiddenPage, 4)]
                  [(Monument Archer, 10), (ForbiddenPage, 8), (TearstoneOfBlood, 6)]
    , skillUp   = Reinforcement
                  [(GemOf Archer, 4)]
                  [(GemOf Archer, 10)]
                  [(MagicGemOf Archer, 4)]
                  [(MagicGemOf Archer, 10), (PhoenixFeather, 4)]
                  [(SecretGemOf Archer, 4), (PhoenixFeather, 7)]
                  [(SecretGemOf Archer, 10), (GreatKnightMedal, 8)]
                  [(GreatKnightMedal, 16), (GhostLantern, 5)]
                  [(GhostLantern, 15), (FoolsChain, 60)]
    }
  , { name      = "Tawara Touta"
    , spoiler   = Nothing
    , id        = 125
    , rarity    = 3
    , class     = Archer
    , attr      = Human
    , deck      = Deck Quick Arts Arts Buster Buster
    , curve     = 28
    , stats     = { base  = { atk = 1306, hp = 1764 }
                  , max   = { atk = 7032, hp = 9800 }
                  , grail = { atk = 9517, hp = 13287 }
                  }
    , skills    = [ { name   = "Protection of the Dragon King"
                    , rank   = C
                    , icon   = Icon.BusterUp
                    , cd     = 8
                    , effect = [ Grant Self 3 (CardUp Buster) <| Range 20 30
                               , To Self Heal <| Range 1000 2000
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
                    , { name = "Inexhaustible Straw Bag"
                    , rank   = EX
                    , icon   = Icon.HPUp
                    , cd     = 7
                    , effect = [ Grant Party 3 HPUp <| Range 1000 2000 ]
                    }
                  ]
    , passives  = [magicResistance C, independentAction B]
    , phantasm  = { name   = "Hachiman Prayer"
                  , desc   = "O Great Bodhisattva of Arms, I beseech thy blessing upon this arrow!"
                  , rank   = BPlus
                  , card   = Buster
                  , kind   = "Anti-Army"
                  , hits   = 3
                  , effect = [ To Enemies Damage <| Range 400 600 ]
                  , over   = [ Grant Self 1 (Special AttackUp <| VsTrait Demonic) <| Range 50 100 ]
                  , first  = True
                  }
    , gen       = { starWeight = 150, starRate = 7.8, npAtk = 0.57, npDef = 3 }
    , hits      = { quick = 2, arts = 3, buster = 1, ex = 5 }
    , gender    = Male
    , traits    = [Humanoid, LovedOne, EnumaElish]
    , death     = 36
    , align     = [Neutral, Good]
    , limited   = False
    , free      = True
    , ascendUp  = Ascension
                  [(Piece Archer, 4)]
                  [(Piece Archer, 10), (SeedOfYggdrasil, 6)]
                  [(Monument Archer, 4), (PhoenixFeather, 3), (ProofOfHero, 20)]
                  [(Monument Archer, 10), (SpiritRoot, 4), (PhoenixFeather, 6)]
    , skillUp   = Reinforcement
                  [(GemOf Archer, 4)]
                  [(GemOf Archer, 8)]
                  [(MagicGemOf Archer, 4)]
                  [(MagicGemOf Archer, 8), (ProofOfHero, 10)]
                  [(SecretGemOf Archer, 4), (ProofOfHero, 20)]
                  [(SecretGemOf Archer, 8), (SeedOfYggdrasil, 4)]
                  [(SeedOfYggdrasil, 8), (OctupletCrystals, 4)]
                  [(OctupletCrystals, 12), (ScarabOfWisdom, 7)]
    }
  , { name      = "Altria Pendragon (Archer)"
    , spoiler   = Nothing
    , id        = 129
    , rarity    = 5
    , class     = Archer
    , attr      = Earth
    , deck      = Deck Quick Quick Arts Arts Buster
    , curve     = 5
    , stats     = { base  = { atk = 1742,  hp = 2134 }
                  , max   = { atk = 11276, hp = 14553 }
                  , grail = { atk = 12343, hp = 15943 }
                  }
    , skills    = [ { name   = "Summer Splash!"
                    , rank   = APlus
                    , icon   = Icon.ArtsUp
                    , cd     = 8
                    , effect = [ Grant Self 3 (CardUp Arts)  <| Range 20 30
                               , Grant Party 3 DefenseUp <| Range 10 20
                               ]
                    }
                  , { name   = "Beach House Protection"
                    , rank   = EX
                    , icon   = Icon.Heal
                    , cd     = 6
                    , effect = [ To Self Heal <| Range 2000 5000
                               , To Self DemeritGauge <| Flat 10
                               ]
                    }
                  , { name   = "Beach Flower"
                    , rank   = B
                    , icon   = Icon.SwordUp
                    , cd     = 7
                    , effect = [ Grant Party 3 AttackUp <| Range 8 18
                               , Grant (AlliesType Male) 3 StarUp <| Range 18 38
                               ]
                    }
                  ]
    , passives  = [magicResistance A, independentAction A, territoryCreation A]
    , phantasm  = { name   = "Excalibur Viviane"
                  , desc   = "Shining Sunlight—Sword of Promised Victory"
                  , rank   = A
                  , card   = Arts
                  , kind   = "Anti-Unit"
                  , hits   = 10
                  , effect = [ To Enemy Damage <| Range 900 1500
                             , Chance 70 << To Enemy GaugeDown <| Flat 1
                             ]
                  , over   = [ To Self GaugeUp <| Range 20 40 ]
                  , first  = False
                  }
    , gen       = { starWeight = 153, starRate = 8, npAtk = 0.59, npDef = 3 }
    , hits      = { quick = 4, arts = 3, buster = 3, ex = 5 }
    , gender    = Female
    , traits    = [Humanoid, EnumaElish, Arthur, Dragon, King, Saberface]
    , death     = 25.8
    , align     = [Lawful, Good]
    , limited   = True
    , free      = False
    , ascendUp  = Ascension
                  [(Piece Archer, 5)]
                  [(Piece Archer, 12), (ShellOfReminiscence, 8)]
                  [(Monument Archer, 5), (DragonFang, 24), (GreatKnightMedal, 10)]
                  [( DragonsReverseScale, 5), (Monument Archer, 12), (GreatKnightMedal, 20)]
    , skillUp   = Reinforcement
                  [(GemOf Archer, 5)]
                  [(GemOf Archer, 12)]
                  [(MagicGemOf Archer, 5)]
                  [(MagicGemOf Archer, 12), (DragonFang, 12)]
                  [(SecretGemOf Archer, 5), (DragonFang, 24)]
                  [(SecretGemOf Archer, 12), (ShellOfReminiscence, 5)]
                  [(ShellOfReminiscence, 10), (WarhorsesYoungHorn, 4)]
                  [(WarhorsesYoungHorn, 11), (SpiritRoot, 10)]
    }
  , { name      = "Anne Bonny & Mary Read (Archer)"
    , spoiler   = Nothing
    , id        = 131
    , rarity    = 4
    , class     = Archer
    , attr      = Human
    , deck      = Deck Quick Arts Arts Buster Buster
    , curve     = 29
    , stats     = { base  = { atk = 1574,  hp = 1843 }
                  , max   = { atk = 9446, hp = 11521 }
                  , grail = { atk = 11437, hp = 13969 }
                  }
    , skills    = [ { name   = "Beach Flower"
                    , rank   = APlus
                    , icon   = Icon.SwordUp
                    , cd     = 7
                    , effect = [ Grant Party 3 AttackUp <| Range 9.5 19.5
                               , Grant (AlliesType Male) 3 StarUp <| Range 21 41
                               ]
                    }
                  , { name    = "Treasure Hunt (Sea)"
                    , rank   = C
                    , icon    = Icon.StarHaloUp
                    , cd      = 8
                    , effect = [ Grant Self 1 GatherUp <| Range 300 600
                              , To Party GainStars <| Range 5 15
                              ]
                    }
                  , { name    = "Pirate's Glory"
                    , rank   = CPlus
                    , icon    = Icon.SwordUp
                    , cd      = 7
                    , effect = [ Grant Self 3 AttackUp <| Range 8.5 25.5
                              , Times 1 << Grant Self 0 Guts <| Flat 1
                              , Debuff Self 3 DebuffVuln <| Flat 50
                              ]
                    }
                  ]
    , passives  = [magicResistance D, independentAction A]
    , phantasm  = { name   = "Caribbean Free Bird Act 2"
                  , desc   = "Bond of Lovebirds"
                  , rank   = CPlusPlus
                  , card   = Buster
                  , kind   = "Anti-Unit"
                  , hits   = 9
                  , effect = [ To Enemy Damage <| Range 600 1000
                             , To Enemy LastStand <| Flat 600
                             ]
                  , over   = [ Debuff Enemy 3 DefenseDown <| Range 10 30 ]
                  , first  = False
                  }
    , gen       = { starWeight = 153, starRate = 8.1, npAtk = 0.85, npDef = 3 }
    , hits      = { quick = 3, arts = 2, buster = 1, ex = 5 }
    , gender    = Female
    , traits    = [Humanoid, EnumaElish]
    , death     = 40.5
    , align     = [Chaotic, Balanced]
    , limited   = True
    , free      = False
    , ascendUp  = Ascension
                  [(Piece Archer, 4)]
                  [(Piece Archer, 10), (SerpentJewel, 5)]
                  [(Monument Archer, 4), (OctupletCrystals, 8), (ShellOfReminiscence, 4)]
                  [(Monument Archer, 10), (ShellOfReminiscence, 8), (ClawOfChaos, 6)]
    , skillUp   = Reinforcement
                  [(GemOf Archer, 4)]
                  [(GemOf Archer, 10)]
                  [(MagicGemOf Archer, 4)]
                  [(MagicGemOf Archer, 10), (OctupletCrystals, 4)]
                  [(SecretGemOf Archer, 4), (OctupletCrystals, 8)]
                  [(SecretGemOf Archer, 10), (SerpentJewel, 4)]
                  [(SerpentJewel, 7), (FoolsChain, 15)]
                  [(FoolsChain, 45), (BlackBeastGrease, 12)]
    }
  , { name      = "Chloe von Einzbern"
    , spoiler   = Nothing
    , id        = 137
    , rarity    = 4
    , class     = Archer
    , attr      = Sky
    , deck      = Deck Quick Quick Arts Arts Buster
    , curve     = 9
    , stats     = { base  = { atk = 1640,  hp = 1746 }
                  , max   = { atk = 9845,  hp = 10914 }
                  , grail = { atk = 11920, hp = 13239 }
                  }
    , skills    = [ { name   = "Mind's Eye (Fake)"
                    , rank   = B
                    , icon   = Icon.Dodge
                    , cd     = 8
                    , effect = [ Grant Self 1 Evasion Full
                              , Grant Self 3 CritUp <| Range 18 36
                              ]
                    }
                  , { name = "Projection"
                    , rank   = B
                    , icon   = Icon.AllUp
                    , cd     = 7
                    , effect = [ Grant Self 1 (CardUp Arts) <| Range 20 35
                               , Grant Self 1 (CardUp Quick) <| Range 20 35
                               , Grant Self 1 (CardUp Buster) <| Range 20 35
                               ]
                    }
                  , { name    = "Kissing Freak"
                    , rank    = BPlusPlus
                    , icon    = Icon.Noble
                    , cd      = 8
                    , effect = [ To Self GaugeUp <| Range 30 50
                               , Grant Self 3 StarUp <| Range 50 100
                               , Grant (AlliesType Illya) 3 BuffUp <| Flat 30
                               ]
                    }
                  ]
    , passives  = [magicResistance C, independentAction B]
    , phantasm  = { name   = "Triple Crane Wings"
                  , desc   = "Kakuyoku San-Ren"
                  , rank   = C
                  , card   = Arts
                  , kind   = "Anti-Unit"
                  , hits   = 6
                  , effect = [ Grant Self 1 SureHit Full
                             , To Enemy Damage <| Range 900 1500
                             ]
                  , over   = [ Debuff Enemy 3 CritChance <| Range 20 60 ]
                  , first  = False
                  }
    , gen       = { starWeight = 148, starRate = 8, npAtk = 0.38, npDef = 3 }
    , hits      = { quick = 3, arts = 6, buster = 2, ex = 4 }
    , gender    = Female
    , traits    = [Humanoid, PseudoServant, EnumaElish]
    , death     = 36
    , align     = [Chaotic, Good]
    , limited   = True
    , free      = True
    , ascendUp  = Welfare "Heart Bracelet"
    , skillUp   = Reinforcement
                  [(GemOf Archer, 4)]
                  [(GemOf Archer, 10)]
                  [(MagicGemOf Archer, 4)]
                  [(MagicGemOf Archer, 10), (EternalGear, 4)]
                  [(SecretGemOf Archer, 4), (EternalGear, 8)]
                  [(SecretGemOf Archer, 10), (HomunculusBaby, 4)]
                  [(HomunculusBaby, 8), (TearstoneOfBlood, 3)]
                  [(TearstoneOfBlood, 9), (HeartOfTheForeignGod, 8)]
    }
  , { name      = "Ishtar"
    , spoiler   = Nothing
    , id        = 142
    , rarity    = 5
    , class     = Archer
    , attr      = Sky
    , deck      = Deck Quick Arts Arts Buster Buster
    , curve     = 5
    , stats     = { base  = { atk = 1893,  hp = 2048 }
                  , max   = { atk = 12252, hp = 13965 }
                  , grail = { atk = 13412, hp = 15299 }
                  }
    , skills    = [ { name   = "Manifestation of Beauty"
                    , rank   = B
                    , icon   = Icon.SwordUp
                    , cd     = 7
                    , effect = [ Grant Party 3 AttackUp <| Range 10 20
                               , Grant Party 3 CritUp <| Range 10 20
                               ]
                    }
                  , { name   = "Shining Majestic Crown"
                    , rank   = A
                    , icon   = Icon.Noble
                    , cd     = 8
                    , effect = [ To Self GaugeUp <| Range 30 50
                               , Chance 80 <| Grant Self 1 Invincibility Full
                               , Chance 80 <| Grant Self 1 IgnoreInvinc Full
                               ]
                    }
                  , { name   = "Mana Burst (Gem)"
                    , rank   = APlus
                    , icon   = Icon.ClockUp
                    , cd     = 5
                    , effect = [ After 1 << Grant Self 1 AttackUp <| Range 30 50 ]
                    }
                  ]
    , passives  = [magicResistance A, independentAction A, coreOfGoddess B]
    , phantasm  = { name   = "An Gal Tā Kigal Shē"
                  , desc   = "Kindle of Venus For Tectonic Deformation"
                  , rank   = EX
                  , card   = Buster
                  , kind   = "Anti-Terrain/Anti-Mountain/Anti-Volcano"
                  , hits   = 3
                  , effect = [ To Enemies Damage <| Range 400 600
                             , To Party GainStars <| Flat 20
                             ]
                  , over   = [ Grant Self 1 (CardUp Buster) <| Range 20 60 ]
                  , first  = True
                  }
    , gen       = { starWeight = 153, starRate = 8, npAtk = 0.45, npDef = 3 }
    , hits      = { quick = 4, arts = 4, buster = 1, ex = 7 }
    , gender    = Female
    , traits    = [Humanoid, Divine, EnumaElish, PseudoServant]
    , death     = 22.5
    , align     = [Lawful, Good]
    , limited   = True
    , free      = False
    , ascendUp  = Ascension
                  [(Piece Archer, 5)]
                  [(Piece Archer, 12), (OctupletCrystals, 8)]
                  [(Monument Archer, 5), (PhoenixFeather, 8), (ScarabOfWisdom, 2)]
                  [(Monument Archer, 12), (ScarabOfWisdom, 4), (TearstoneOfBlood, 8)]
    , skillUp   = Reinforcement
                  [(GemOf Archer, 5)]
                  [(GemOf Archer, 12)]
                  [(MagicGemOf Archer, 5)]
                  [(MagicGemOf Archer, 12), (PhoenixFeather, 4)]
                  [(SecretGemOf Archer, 5), (PhoenixFeather, 8)]
                  [(SecretGemOf Archer, 12), (OctupletCrystals, 5)]
                  [(OctupletCrystals, 10), (SerpentJewel, 5)]
                  [(SerpentJewel, 15), (LampOfEvilSealing, 15)]
    }
  , { name      = "James Moriarty"
    , spoiler   = Just "Shinjuku"
    , id        = 156
    , rarity    = 5
    , class     = Archer
    , stats     = { base  = { atk = 1820,  hp = 2007 }
                  , max   = { atk = 11781, hp = 13685 }
                  , grail = { atk = 12896, hp = 14992 }
                  }
    , gen       = { starWeight = 153, starRate = 8, npAtk = 0.38, npDef = 3 }
    , death     = 31.5
    , curve     = 10
    , attr      = Human
    , align     = [Chaotic, Evil]
    , gender    = Male
    , traits    = [Humanoid, EnumaElish]
    , deck      = Deck Quick Arts Arts Arts Buster
    , hits      = { quick = 3, arts = 4, buster = 5, ex = 6 }
    , skills    = [ { name   = "The Freeshooter"
                    , rank   = EX
                    , icon   = Icon.ShieldBreak
                    , cd     = 7
                    , effect = [ Grant Self 1 GatherUp <| Range 300 600
                               , Grant Self 1 IgnoreInvinc Full
                               ]
                    }
                  , { name   = "End of the Spider's Web"
                    , rank   = APlusPlus
                    , icon   = Icon.Noble
                    , cd     = 8
                    , effect = [ To Self GaugeUp <| Range 30 50
                               , Grant Self 3 NPUp <| Flat 20
                               , To Party DemeritStars <| Flat 10
                               ]
                    }
                  , { name   = "Charisma of Wicked Wisdom"
                    , rank   = A
                    , icon   = Icon.SwordUp
                    , cd     = 7
                    , effect = [ Grant Party 3 AttackUp <| Range 10 20
                               , Grant (AlliesType Evil) 7 AttackUp <| Range 10 20
                               ]
                    }
                  ]
    , passives  = [magicResistance D, independentAction APlus]
    , phantasm  = { name   = "The Dynamics of an Asteroid"
                  , desc   = "The Ultimate Crime"
                  , rank   = APlus
                  , card   = Buster
                  , kind   = "Anti-Army"
                  , hits   = 12
                  , effect = [ To Enemy Damage <| Range 600 1000 ]
                  , over   = [ Debuff Enemy 3 DefenseDown <| Range 20 40 ]
                  , first  = True
                  }
    , limited   = False
    , free      = False
    , ascendUp  = Ascension
                  [(Piece Archer, 5)]
                  [(Piece Archer, 12), (ForbiddenPage, 8)]
                  [(Monument Archer, 5), (DeadlyPoisonousNeedle, 24), (ClawOfChaos, 3)]
                  [(Monument Archer, 12), (ClawOfChaos, 6), (ScarabOfWisdom, 5)]
    , skillUp   = Reinforcement
                  [(GemOf Archer, 5)]
                  [(GemOf Archer, 12)]
                  [(MagicGemOf Archer, 5)]
                  [(MagicGemOf Archer, 12), (DeadlyPoisonousNeedle, 12)]
                  [(SecretGemOf Archer, 5), (DeadlyPoisonousNeedle, 24)]
                  [(SecretGemOf Archer, 12), (ForbiddenPage, 5)]
                  [(ForbiddenPage, 10), (VoidsDust, 12)]
                  [(VoidsDust, 36), (MysticSpinalFluid, 72)]
    },
    { name      = "EMIYA (Alter)"
    , spoiler   = Nothing
    , id        = 157
    , rarity    = 4
    , class     = Archer
    , stats     = { base  = { atk = 1499,  hp = 1960 }
                  , max   = { atk = 8996,  hp = 12250 }
                  , grail = { atk = 10892, hp = 14853 }
                  }
    , gen       = { starWeight = 145, starRate = 7.9, npAtk = 0.43, npDef = 3 }
    , death     = 31.5
    , curve     = 4
    , attr      = Human
    , align     = [Chaotic, Evil]
    , gender    = Male
    , traits    = [Humanoid, EnumaElish]
    , deck      = Deck Quick Quick Arts Arts Buster
    , hits      = { quick = 4, arts = 4, buster = 4, ex = 5 }
    , skills    = [ { name   = "Bulletproof"
                    , rank   = A
                    , icon   = Icon.ShieldUp
                    , cd     = 7
                    , effect = [ Grant Self 3 DefenseUp <| Range 30 50
                               , Grant Self 3 DamageCut <| Range 300 500
                               ]
                    }
                  , { name   = "Projection"
                    , rank   = C
                    , icon   = Icon.AllUp
                    , cd     = 7
                    , effect = [ Grant Self 1 (CardUp Arts) <| Range 15 30
                               , Grant Self 1 (CardUp Quick) <| Range 15 30
                               , Grant Self 1 (CardUp Buster) <| Range 15 30
                               ]
                    }
                  , { name   = "Icy Sneer"
                    , rank   = A
                    , icon   = Icon.SwordUp
                    , cd     = 7
                    , effect = [ Times 3 << Grant Self 5 AttackUp <| Range 20 40 ]
                    }
                  ]
    , passives  = [magicResistance D, independentAction A]
    , phantasm  = { name   = "Unlimited Lost Works"
                  , desc   = "-Infinite- Creation of Swords"
                  , rank   = A
                  , card   = Arts
                  , kind   = "Anti-Unit"
                  , hits   = 10
                  , effect = [ To Enemy DamageThruDef <| Range 900 1500 ]
                  , over   = [ Chances 60 100 << To Enemy GaugeDown <| Flat 1 ]
                  , first  = False
                  }
    , limited   = False
    , free      = False
    , ascendUp  = Ascension
                  [(Piece Archer, 4)]
                  [(Piece Archer, 10), (FoolsChain, 18)]
                  [(Monument Archer, 4), (EternalGear, 8), (BlackBeastGrease, 3)]
                  [(Monument Archer, 10), (BlackBeastGrease, 5), (MysticSpinalFluid, 30)]
    , skillUp   = Reinforcement
                  [(GemOf Archer, 4)]
                  [(GemOf Archer, 10)]
                  [(MagicGemOf Archer, 4)]
                  [(MagicGemOf Archer, 10), (EternalGear, 4)]
                  [(SecretGemOf Archer, 4), (EternalGear, 8)]
                  [(SecretGemOf Archer, 10), (FoolsChain, 12)]
                  [(FoolsChain, 24), (CursedBeastGallstone, 2)]
                  [(CursedBeastGallstone, 6), (ShellOfReminiscence, 20)]
    }
  , { name      = "Helena Blavatsky (Archer)"
    , spoiler   = Nothing
    , id        = 180
    , rarity    = 4
    , class     = Archer
    , stats     = { base  = { atk = 1574,  hp = 1824 }
                  , max   = { atk = 9446,  hp = 11404 }
                  , grail = { atk = 11437, hp = 13827 }
                  }
    , gen       = { starWeight = 153, starRate = 8, npAtk = 0.38, npDef = 3 }
    , death     = 27
    , curve     = 4
    , attr      = Human
    , align     = [Chaotic, Good]
    , gender    = Female
    , traits    = [Humanoid, EnumaElish]
    , deck      = Deck Quick Quick Arts Arts Buster
    , hits      = { quick = 3, arts = 5, buster = 1, ex = 3 }
    , skills    = [ { name   = "Summer Vacation!"
                    , rank   = A
                    , icon   = Icon.Noble
                    , cd     = 10
                    , effect = [ To Party GaugeUp <| Range 10 20
                               , Grant Self 5 StarsPerTurn <| Flat 5
                               ]
                    }
                  , { name   = "NYARF!"
                    , rank   = B
                    , icon   = Icon.DamageUp
                    , cd     = 8
                    , effect = [ Times 5 << Grant Self 5 DamageUp <| Range 1000 2000
                               , To Enemy GaugeDown <| Flat 1
                               ]
                    }
                  , { name   = "Colonel's Summer Break"
                    , rank   = B
                    , icon   = Icon.ArtsUp
                    , cd     = 7
                    , effect = [ Grant Self 1 (CardUp Arts) <| Range 20 40
                               , Times 1 <| Grant Self 1 DebuffResist Full
                               ]
                    }
                  ]
    , passives  = [magicResistance C, independentAction C]
    , phantasm  = { name   = "Sanat Kumara Wheel"
                  , desc   = "Silver Torus of the Venusian Goddess"
                  , rank   = BPlus
                  , card   = Arts
                  , kind   = "Anti-Army"
                  , hits   = 4
                  , effect = [ To Enemies Damage <| Range 450 750 ]
                  , over   = [ Debuff Enemies 3 DebuffVuln <| Range 10 30
                             , Debuff Enemies 3 DefenseDown <| Range 10 30
                             ]
                  , first  = False
                  }
    , limited   = True
    , free      = False
    , ascendUp  = Ascension
                  [(Piece Archer, 4)]
                  [(Piece Archer, 10), (SerpentJewel, 5)]
                  [(Monument Archer, 4), (LampOfEvilSealing, 5), (BlackBeastGrease, 3)]
                  [(Monument Archer, 10), (BlackBeastGrease, 5), (ShellOfReminiscence, 10)]
    , skillUp   = Reinforcement
                  [(GemOf Archer, 4)]
                  [(GemOf Archer, 10)]
                  [(MagicGemOf Archer, 4)]
                  [(MagicGemOf Archer, 10), (LampOfEvilSealing, 3)]
                  [(SecretGemOf Archer, 4), (LampOfEvilSealing, 5)]
                  [(SecretGemOf Archer, 10), (SerpentJewel, 4)]
                  [(SerpentJewel, 7), (VoidsDust, 10)]
                  [(VoidsDust, 30), (TearstoneOfBlood, 12)]
    }
  , { name      = "Tomoe Gozen"
    , spoiler   = Just "Inferno"
    , id        = 184
    , rarity    = 4
    , class     = Archer
    , stats     = { base  = { atk = 1657,  hp = 1728 }
                  , max   = { atk = 9946,  hp = 10804 }
                  , grail = { atk = 12043, hp = 13100 }
                  }
    , gen       = { starWeight = 153, starRate = 7.9, npAtk = 0.87, npDef = 3 }
    , death     = 31.5
    , curve     = 14
    , attr      = Earth
    , align     = [Neutral, Balanced]
    , gender    = Female
    , traits    = [Humanoid, EnumaElish, Demonic]
    , deck      = Deck Quick Arts Arts Buster Buster
    , hits      = { quick = 3, arts = 2, buster = 2, ex = 5 }
    , skills    = [ { name   = "Demonic Nature of Oni"
                    , rank   = B
                    , icon   = Icon.SwordUp
                    , cd     = 7
                    , effect = [ Grant Party 3 AttackUp <| Range 9 19
                               , Grant Self 3 NPUp <| Range 18 28
                               ]
                    }
                  , { name   = "Knowledge of Chaotic Battle"
                    , rank   = B
                    , icon   = Icon.StarUp
                    , cd     = 8
                    , effect = [ Grant Self 3 GatherUp <| Range 300 600
                               , Grant Party 3 StarUp <| Range 30 50
                               ]
                    }
                  , { name   = "Adrenaline Rush"
                    , rank   = A
                    , icon   = Icon.Kneel
                    , cd     = 9
                    , effect = [ Times 1 << Grant Self 5 Guts <| Range 1000 2000
                               , Grant Self 5 HPUp <| Range 1000 3000
                               ]
                    }
                  ]
    , passives  = [magicResistance B, independentAction A, madness E]
    , phantasm  = { name   = "On Arorikya Sowaka"
                  , desc   = "Shoukannon Bosatsu Mantra"
                  , rank   = B
                  , card   = Buster
                  , kind   = "Anti-Unit"
                  , hits   = 1
                  , effect = [ To Enemy Damage <| Range 600 1000
                             , Debuff Enemy 3 CritChance <| Flat 20
                             ]
                  , over   = [ Debuff Enemy 5 Burn <| Range 1000 3000 ]
                  , first  = False
                  }
    , limited   = False
    , free      = False
    , ascendUp  = Ascension
                  [(Piece Archer, 4)]
                  [(Piece Archer, 10), (MeteorHorseshoe, 6)]
                  [(Monument Archer, 4), (PhoenixFeather, 7), (RefinedMagatama, 4)]
                  [(Monument Archer, 10), (RefinedMagatama, 8), (BlackBeastGrease, 6)]
    , skillUp   = Reinforcement
                  [(GemOf Archer, 4)]
                  [(GemOf Archer, 10)]
                  [(MagicGemOf Archer, 4)]
                  [(MagicGemOf Archer, 10), (PhoenixFeather, 4)]
                  [(SecretGemOf Archer, 4), (PhoenixFeather, 7)]
                  [(SecretGemOf Archer, 10), (MeteorHorseshoe, 4)]
                  [(MeteorHorseshoe, 8), (MysteriousDivineWine, 2)]
                  [(MysteriousDivineWine, 6), (TearstoneOfBlood, 12)]
    }
  , { name      = "Attila the San(ta)"
    , spoiler   = Nothing
    , id        = 197
    , rarity    = 4
    , class     = Archer
    , stats     = { base  = { atk = 1626,  hp = 1682 }
                  , max   = { atk = 9759,  hp = 11637 }
                  , grail = { atk = 11816, hp = 14110 }
                  }
    , gen       = { starWeight = 153, starRate = 8.1, npAtk = 0.59, npDef = 3 }
    , death     = 27
    , curve     = 4
    , attr      = Star
    , align     = [Chaotic, Good]
    , gender    = Female
    , traits    = [Humanoid, Divine, Riding, King]
    , deck      = Deck Quick Quick Arts Arts Buster
    , hits      = { quick = 3, arts = 3, buster = 3, ex = 4 }
    , skills    = [ { name   = "Gift of the Star"
                    , rank   = B
                    , icon   = Icon.Noble
                    , cd     = 7
                    , effect = [ To Ally GaugeUp <| Range 10 20
                               , Grant Ally 3 StarUp <| Flat 30
                               ]
                    }
                  , { name   = "Rainbow Candy"
                    , rank   = B
                    , icon   = Icon.BeamUp
                    , cd     = 7
                    , effect = [ Grant Ally 1 NPUp <| Range 20 30
                               , Grant Ally 1 CritUp <| Range 20 30
                               ]
                    }
                  , { name   = "Crest of the Shiny Star"
                    , rank   = EX
                    , icon   = Icon.ShieldBreak
                    , cd     = 7
                    , effect = [ Grant Self 3 IgnoreInvinc Full
                               , Grant Self 3 GatherUp <| Range 300 600
                               , Grant Self 3 DefenseUp <| Range 20 30
                               , After 3 <| Debuff Self 1 Stun Full
                               ]
                    }
                  ]
    , passives  = [magicResistance C, riding EX, civilizationEncroachment EX, divinity B]
    , phantasm  = { name   = "Candy Star Photon Ray"
                  , desc   = "Holy Night's Rainbow, Sword of the God of War"
                  , rank   = EX
                  , card   = Quick
                  , kind   = "Anti-World"
                  , hits   = 10
                  , effect = [ To Enemy Damage <| Range 1200 2000 ]
                  , over   = [ To Party GainStars <| Range 20 40 ]
                  , first  = False
                  }
    , limited   = True
    , free      = True
    , ascendUp  = Welfare "Santa's Moustache"
    , skillUp   = Reinforcement
                  [(GemOf Archer, 4)]
                  [(GemOf Archer, 10)]
                  [(MagicGemOf Archer, 4)]
                  [(MagicGemOf Archer, 10), (SeedOfYggdrasil, 5)]
                  [(SecretGemOf Archer, 4), (SeedOfYggdrasil, 10)]
                  [(SecretGemOf Archer, 10), (MeteorHorseshoe, 4)]
                  [(MeteorHorseshoe, 8), (SpiritRoot, 2)]
                  [(SpiritRoot, 6), (PrimordialLanugo, 12)]
    }
  , { name      = "Asagami Fujino"
    , spoiler   = Nothing
    , id        = 200
    , rarity    = 4
    , class     = Archer
    , stats     = { base  = { atk = 1716,  hp = 1764 }
                  , max   = { atk = 10299, hp = 11025 }
                  , grail = { atk = 12470, hp = 13368 }
                  }
    , gen       = { starWeight = 148, starRate = 7.9, npAtk = 0.59, npDef = 3 }
    , death     = 27
    , curve     = 9
    , attr      = Human
    , align     = [Lawful, Evil]
    , gender    = Female
    , traits    = [Humanoid]
    , deck      = Deck Quick Arts Arts Buster Buster
    , hits      = { quick = 3, arts = 3, buster = 3, ex = 5 }
    , skills    = [ { name   = "Mystic Eyes of Distortion"
                    , rank   = EX
                    , icon   = Icon.BusterUp
                    , cd     = 7
                    , effect = [ Grant Self 3 (CardUp Buster) <| Range 20 35
                               , Grant Self 3 IgnoreDef Full
                               , Grant Self 3 NPGen <| Range 20 30
                               ]
                    }
                  , { name   = "Clairvoyance (Darkness)"
                    , rank   = C
                    , icon   = Icon.Bullseye
                    , cd     = 7
                    , effect = [ Grant Self 3 SureHit Full
                               , To Party GainStars <| Range 5 15
                               ]
                    }
                  , { name   = "Remaining Sense of Pain"
                    , rank   = A
                    , icon   = Icon.ShieldUp
                    , cd     = 7
                    , effect = [ Debuff Self 3 HPDown <| Flat 2000
                               , Grant Self 3 DamageCut <| Range 1000 2000
                               , Times 1 << Grant Self 3 Guts <| Flat 1
                               ]
                    }
                  ]
    , passives  = [magicResistance D, independentAction APlus, territoryCreation B]
    , phantasm  = { name   = "Vijñapti-mātratā: Mystic Eyes of Distortion"
                  , desc   = "Yuishiki—Waikyoku no Magan"
                  , rank   = EX
                  , card   = Buster
                  , kind   = "Anti-World"
                  , hits   = 3
                  , effect = [ To Enemy Damage <| Range 600 1000
                             , Times 1 <| Debuff Enemy 3 BuffBlock Full
                             ]
                  , over   = [ Debuff Enemies 3 AttackDown <| Range 10 30 ]
                  , first  = False
                  }
    , limited   = True
    , free      = False
    , ascendUp  = Ascension
                  [(Piece Archer, 4)]
                  [(Piece Archer, 10), (EvilBone, 18)]
                  [(Monument Archer, 4), (VoidsDust, 16), (CursedBeastGallstone, 2)]
                  [(Monument Archer, 10), (CursedBeastGallstone, 4), (TearstoneOfBlood, 6)]
    , skillUp   = Reinforcement
                  [(GemOf Archer, 4)]
                  [(GemOf Archer, 10)]
                  [(MagicGemOf Archer, 4)]
                  [(MagicGemOf Archer, 10), (VoidsDust, 8)]
                  [(SecretGemOf Archer, 4), (VoidsDust, 16)]
                  [(SecretGemOf Archer, 10), (EvilBone, 12)]
                  [(EvilBone, 24), (StakeOfWailingNight, 15)]
                  [(StakeOfWailingNight, 45), (MysticSpinalFluid, 60)]
    }
  ]
