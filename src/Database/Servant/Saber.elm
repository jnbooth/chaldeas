module Database.Servant.Saber exposing (sabers)

import Database.Base exposing (..)
import Database.Passive exposing (..)
import Database.Servant exposing (..)
import Database.Skill exposing (..)

import Database.Icon as Icon

sabers : List Servant
sabers =
  [ { name      = "Altria Pendragon"
    , spoiler   = Nothing
    , id        = 2
    , rarity    = 5
    , class     = Saber
    , attr      = Earth
    , deck      = Deck Quick Arts Arts Buster Buster
    , curve     = 5
    , stats     = { base  = { atk = 1734,  hp = 2222 }
                  , max   = { atk = 11221, hp = 15150 }
                  , grail = { atk = 12283, hp = 16597 }
                  }
    , skills    = [ { name   = "Charisma"
                    , rank   = B
                    , icon   = Icon.SwordUp
                    , cd     = 7
                    , effect = [ Grant Party 3 AttackUp <| Range 9 18 ]
                    }
                  , { name   = "Mana Burst"
                    , rank   = A
                    , icon   = Icon.BusterUp
                    , cd     = 7
                    , effect = [ Grant Self 1 (CardUp Buster) <| Range 30 50 ]
                    }
                  , { name   = "Intuition"
                    , rank   = A
                    , icon   = Icon.Star
                    , cd     = 7
                    , effect = [ To Party GainStars <| Range 5 15 ]
                    }
                  ]
    , passives  = [magicResistance A, riding B]
    , phantasm  = { name   = "Excalibur"
                  , desc   = "Sword of Promised Victory"
                  , rank   = APlusPlus
                  , card   = Buster
                  , kind   = "Anti-Fortress"
                  , hits   = 1
                  , effect = [ To Enemies Damage <| Range 400 600 ]
                  , over   = [ To Self GaugeUp <| Range 20 50 ]
                  , first  = False
                  }
    , gen       = { starWeight = 102, starRate = 10, npAtk = 0.86, npDef = 3 }
    , hits      = { quick = 2, arts = 2, buster = 1, ex = 3 }
    , gender    = Female
    , traits    = [Humanoid, Riding, Dragon, Saberface, Arthur, EnumaElish, King]
    , death     = 21
    , align     = [Lawful, Good]
    , limited   = False
    , free      = False
    , ascendUp  = Ascension
                  [(Piece Saber, 5)]
                  [(Piece Saber, 12), (DragonFang, 18)]
                  [(Monument Saber, 5), (ProofOfHero, 29), (PhoenixFeather, 4)]
                  [(Monument Saber, 12), (PhoenixFeather, 8), (DragonsReverseScale, 5)]
    , skillUp   = Reinforcement
                  [(GemOf Saber, 5)]
                  [(GemOf Saber, 12)]
                  [(MagicGemOf Saber, 5)]
                  [(MagicGemOf Saber, 12), (ProofOfHero, 15)]
                  [(SecretGemOf Saber, 5), (ProofOfHero, 29)]
                  [(SecretGemOf Saber, 12), (DragonFang, 12)]
                  [(DragonFang, 24), (ClawOfChaos, 4)]
                  [(ClawOfChaos, 11), (DragonsReverseScale, 10)]
    }
  , { name      = "Altria Pendragon (Alter)"
    , spoiler   = Nothing
    , id        = 3
    , rarity    = 4
    , class     = Saber
    , attr      = Man
    , deck      = Deck Quick Arts Arts Buster Buster
    , curve     = 14
    , stats     = { base  = { atk = 1708,  hp = 1854 }
                  , max   = { atk = 10248, hp = 11589 }
                  , grail = { atk = 12408, hp = 14051 }
                  }
    , skills    = [ { name   = "Mana Burst"
                    , rank   = A
                    , icon   = Icon.BusterUp
                    , cd     = 7
                    , effect = [ Grant Self 1 (CardUp Buster) <| Range 30 50 ]
                    }
                  , { name   = "Intuition"
                    , rank   = B
                    , icon   = Icon.Star
                    , cd     = 7
                    , effect = [ To Party GainStars <| Range 4 14 ]
                    }
                  , { name   = "Charisma"
                    , rank   = E
                    , icon   = Icon.SwordUp
                    , cd     = 7
                    , effect = [ Grant Party 3 AttackUp <| Range 6 12 ]
                    }
                  ]
    , passives  = [magicResistance B]
    , phantasm  = { name   = "Excalibur Morgan"
                  , desc   = "Sword of Promised Victory"
                  , rank   = APlusPlus
                  , card   = Buster
                  , kind   = "Anti-Fortress"
                  , hits   = 3
                  , effect = [ To Enemies Damage <| Range 450 650 ]
                  , over   = [ To Self GaugeUp <| Range 10 30 ]
                  , first  = False
                  }
    , gen       = { starWeight = 99, starRate = 9.9, npAtk = 0.86, npDef = 3 }
    , hits      = { quick = 2, arts = 2, buster = 1, ex = 3 }
    , gender    = Female
    , traits    = [Humanoid, Dragon, Saberface, Arthur, EnumaElish, King]
    , death     = 19.2
    , align     = [Lawful, Evil]
    , limited   = False
    , free      = False
    , ascendUp  = Ascension
                  [(Piece Saber, 4)]
                  [(Piece Saber, 10), (DragonFang, 15)]
                  [(Monument Saber, 4), (ClawOfChaos, 5), (DragonsReverseScale, 2)]
                  [( Monument Saber, 10), (DragonsReverseScale, 4), (HeartOfTheForeignGod, 4)]
    , skillUp   = Reinforcement
                  [(GemOf Saber, 4)]
                  [(GemOf Saber, 10)]
                  [(MagicGemOf Saber, 4)]
                  [(MagicGemOf Saber, 10), (ClawOfChaos, 3)]
                  [(SecretGemOf Saber, 4), (ClawOfChaos, 5)]
                  [(SecretGemOf Saber, 10), (DragonFang, 10)]
                  [(DragonFang, 20), (VoidsDust, 10)]
                  [(VoidsDust, 30), (HeartOfTheForeignGod, 8)]
    }
  , { name      = "Altria Pendragon (Lily)"
    , spoiler   = Nothing
    , id        = 4
    , rarity    = 4
    , class     = Saber
    , attr      = Earth
    , deck      = Deck Quick Arts Arts Buster Buster
    , curve     = 14
    , stats     = { base  = { atk = 1287, hp = 1699 }
                  , max   = { atk = 7726, hp = 10623 }
                  , grail = { atk = 9355, hp = 12880 }
                  }
    , skills    = [ { name   = "Intuition"
                    , rank   = B
                    , icon   = Icon.Star
                    , cd     = 7
                    , effect = [ To Party GainStars <| Range 4 14 ]
                    }
                  , { name   = "Mana Burst"
                    , rank   = A
                    , icon   = Icon.BusterUp
                    , cd     = 7
                    , effect = [ Grant Self 1 (CardUp Buster) <| Range 30 50 ]
                    }
                  , { name   = "Journey of the Flowers"
                    , rank   = EX
                    , icon   = Icon.NobleUp
                    , cd     = 7
                    , effect = [ Grant Party 3 NPGen <| Range 10 20 ]
                    }
                  ]
    , passives  = [magicResistance B, riding C]
    , phantasm  = { name   = "Caliburn"
                  , desc   = "Golden Sword of Assured Victory"
                  , rank   = BPlus
                  , card   = Buster
                  , kind   = "Anti-Personnel"
                  , hits   = 8
                  , effect = [ To Enemies Damage <| Range 400 700 ]
                  , over   = [ To Self Heal <| Range 2000 6000 ]
                  , first  = False
                  }
    , gen       = { starWeight = 102, starRate = 10, npAtk = 0.86, npDef = 3 }
    , hits      = { quick = 2, arts = 2, buster = 1, ex = 3 }
    , gender    = Female
    , traits    = [Humanoid, Riding, Dragon, Saberface, Arthur, EnumaElish, King]
    , death     = 21
    , align     = [Lawful, Good]
    , limited   = True
    , free      = True
    , ascendUp  = Ascension
                  [(Piece Saber, 4)]
                  [(Piece Saber, 10), (ProofOfHero, 18)]
                  [(Monument Saber, 4), (DragonFang, 20), (SeedOfYggdrasil, 5)]
                  [(Monument Saber, 10), (SeedOfYggdrasil, 10), (DragonsReverseScale, 4)]
    , skillUp   = Reinforcement
                  [(GemOf Saber, 4)]
                  [(GemOf Saber, 10)]
                  [(MagicGemOf Saber, 4)]
                  [(MagicGemOf Saber, 10), (DragonFang, 10)]
                  [(SecretGemOf Saber, 4), (DragonFang, 20)]
                  [(SecretGemOf Saber, 10), (ProofOfHero, 12)]
                  [(ProofOfHero, 24), (ClawOfChaos, 3)]
                  [(ClawOfChaos, 9), (DragonsReverseScale, 8)]
    }
  , { name      = "Nero Claudius"
    , spoiler   = Nothing
    , id        = 5
    , rarity    = 4
    , class     = Saber
    , attr      = Man
    , deck      = Deck Quick Arts Arts Buster Buster
    , curve     = 15
    , stats     = { base  = { atk = 1574,  hp = 1880 }
                  , max   = { atk = 9449,  hp = 11753 }
                  , grail = { atk = 11441, hp = 14250 }
                  }
    , skills    = [ { name   = "Migraine"
                    , rank   = B
                    , icon   = Icon.HoodUp
                    , cd     = 7
                    , effect = [ Grant Self 3 MentalResist <| Range 50 100
                               , To Self Heal <| Range 500 2000
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
                  , { name   = "Invictus Spiritus"
                    , rank   = A
                    , icon   = Icon.Kneel
                    , cd     = 12
                    , effect = [ Times 3 << Grant Self 5 Guts <| Range 300 600 ]
                    }
                  ]
    , passives  = [magicResistance C, riding B]
    , phantasm  = { name   = "Laus St. Claudius"
                  , desc   = "Imperium of the Maiden's Flowery Words"
                  , rank   = B
                  , card   = Arts
                  , kind   = "Anti-Encampment"
                  , hits   = 1
                  , effect = [ To Enemies DamageThruDef <| Range 600 900 ]
                  , over   = [ Debuff Enemies 1 DefenseDown <| Range 20 40 ]
                  , first  = False
                  }
    , gen       = { starWeight = 102, starRate = 10.1, npAtk = 0.84, npDef = 3 }
    , hits      = { quick = 2, arts = 2, buster = 1, ex = 5 }
    , gender    = Female
    , traits    = [Humanoid, Riding, Roman, Saberface, EnumaElish, King]
    , death     = 24.5
    , align     = [Chaotic, Good]
    , limited   = False
    , free      = False
    , ascendUp  = Ascension
                  [(Piece Saber, 4)]
                  [(Piece Saber, 10), (OctupletCrystals, 6)]
                  [(Monument Saber, 4), (PhoenixFeather, 7), (GhostLantern, 4)]
                  [(Monument Saber, 10), (GhostLantern, 8), (EternalGear, 10)]
    , skillUp   = Reinforcement
                  [(GemOf Saber, 4)]
                  [(GemOf Saber, 10)]
                  [(MagicGemOf Saber, 4)]
                  [(MagicGemOf Saber, 10), (PhoenixFeather, 4)]
                  [(SecretGemOf Saber, 4), (PhoenixFeather, 7)]
                  [(SecretGemOf Saber, 10), (OctupletCrystals, 4)]
                  [(OctupletCrystals, 8), (DragonFang, 12)]
                  [(DragonFang, 36), (EternalGear, 20)]
    }
  , { name      = "Siegfried"
    , spoiler   = Nothing
    , id        = 6
    , rarity    = 4
    , class     = Saber
    , attr      = Earth
    , deck      = Deck Quick Arts Arts Buster Buster
    , curve     = 4
    , stats     = { base  = { atk = 1363, hp = 2266 }
                  , max   = { atk = 8181, hp = 14165 }
                  , grail = { atk = 9905, hp = 17175 }
                  }
    , skills    = [ { name   = "Golden Rule"
                    , rank   = CMinus
                    , icon   = Icon.NobleUp
                    , cd     = 8
                    , effect = [ Grant Self 3 NPGen <| Range 15 37.5 ]
                    }
                  , { name   = "Disengage"
                    , rank   = A
                    , icon   = Icon.Bubbles
                    , cd     = 7
                    , effect = [ To Self RemoveDebuffs Full
                               , To Self Heal <| Range 1000 2500
                               ]
                    }
                  , { name   = "Dragon-Slayer"
                    , rank   = APlusPlus
                    , icon   = Icon.DamageUp
                    , cd     = 7
                    , effect = [ Grant Self 3 (Special AttackUp <| VsTrait Dragon) <| Range 50 80
                               , Grant Self 3 (Special DefenseUp <| VsTrait Dragon) <| Flat 30
                               , Grant Self 1 (CardUp Buster) <| Range 30 50
                               ]
                    }
                  ]
    , passives  = [riding B]
    , phantasm  = { name   = "Balmung"
                  , desc   = "Illusory Greatsword: Felling of the Sky Demon"
                  , rank   = EX
                  , card   = Buster
                  , kind   = "Anti-Army"
                  , hits   = 1
                  , effect = [ To Enemies Damage <| Range 400 600
                             , Grant Self 3 NPGen <| Flat 20
                             ]
                  , over   = [ To Enemies (SpecialDamage <| VsTrait Dragon) <| Range 150 200 ]
                  , first  = False
                  }
    , gen       = { starWeight = 97, starRate = 10, npAtk = 0.83, npDef = 3 }
    , hits      = { quick = 2, arts = 2, buster = 1, ex = 3 }
    , gender    = Male
    , traits    = [Humanoid, King, Riding, LovedOne, Dragon, EnumaElish]
    , death     = 28
    , align     = [Chaotic, Good]
    , limited   = False
    , free      = False
    , ascendUp  = Ascension
                  [(Piece Saber, 4)]
                  [(Piece Saber, 10), (DragonFang, 15)]
                  [(Monument Saber, 4), (SeedOfYggdrasil, 10), (ProofOfHero, 12)]
                  [(Monument Saber, 10), (ProofOfHero, 24), (DragonsReverseScale, 4)]
    , skillUp   = Reinforcement
                  [(GemOf Saber, 4)]
                  [(GemOf Saber, 10)]
                  [(MagicGemOf Saber, 4)]
                  [(MagicGemOf Saber, 10), (SeedOfYggdrasil, 5)]
                  [(SecretGemOf Saber, 4), (SeedOfYggdrasil, 10)]
                  [(SecretGemOf Saber, 10), (DragonFang, 10)]
                  [(DragonFang, 20), (HeartOfTheForeignGod, 2)]
                  [(HeartOfTheForeignGod, 6), (DragonsReverseScale, 8)]
    }
  , { name      = "Gaius Julius Caesar"
    , spoiler   = Nothing
    , id        = 7
    , rarity    = 3
    , class     = Saber
    , attr      = Man
    , deck      = Deck Quick Quick Arts Buster Buster
    , curve     = 13
    , stats     = { base  = { atk = 1392,  hp = 1727 }
                  , max   = { atk = 7497,  hp = 9595 }
                  , grail = { atk = 10146, hp = 13009 }
                  }
    , skills    = [ { name   = "Tactics"
                    , rank   = B
                    , icon   = Icon.BeamUp
                    , cd     = 7
                    , effect = [ Grant Party 1 NPUp <| Range 9 18 ]
                    }
                  , { name   = "Charisma"
                    , rank   = C
                    , icon   = Icon.SwordUp
                    , cd     = 7
                    , effect = [ Grant Party 3 AttackUp <| Range 8 16 ]
                    }
                  , { name   = "Incite"
                    , rank   = EX
                    , icon   = Icon.ExclamationUp
                    , cd     = 7
                    , effect = [ Grant Ally 3 CritUp <| Range 20 40
                               , Grant Ally 3 StarUp <| Range 50 100
                               , Debuff Ally 3 DefenseDown <| Flat 20
                               ]
                    }
                  ]
    , passives  = [magicResistance C, riding B, divinity D]
    , phantasm  = { name   = "Crocea Mors"
                  , desc   = "The Yellow Death"
                  , rank   = BPlus
                  , card   = Quick
                  , kind   = "Anti-Personnel"
                  , hits   = 10
                  , effect = [ To Enemy Damage <| Range 1200 2000 ]
                  , over   = [ To Party GainStars <| Range 5 25 ]
                  , first  = False
                  }
    , gen       = { starWeight = 99, starRate = 10, npAtk = 1.1, npDef = 3 }
    , hits      = { quick = 2, arts = 2, buster = 1, ex = 3 }
    , gender    = Male
    , traits    = [Humanoid, Riding, LovedOne, Roman, Divine, EnumaElish, King]
    , death     = 31.5
    , align     = [Neutral, Balanced]
    , limited   = False
    , free      = False
    , ascendUp  = Ascension
                  [(Piece Saber, 4)]
                  [(Piece Saber, 8), (ProofOfHero, 15)]
                  [(Monument Saber, 4), (EternalGear, 7), (ForbiddenPage, 4)]
                  [(Monument Saber, 8), (ForbiddenPage, 7), (ClawOfChaos, 5)]
    , skillUp   = Reinforcement
                  [(GemOf Saber, 4)]
                  [(GemOf Saber, 8)]
                  [(MagicGemOf Saber, 4)]
                  [(MagicGemOf Saber, 8), (EternalGear, 4)]
                  [(SecretGemOf Saber, 4), (EternalGear, 7)]
                  [(SecretGemOf Saber, 8), (ProofOfHero, 10)]
                  [(ProofOfHero, 20), (MeteorHorseshoe, 4)]
                  [(MeteorHorseshoe, 12), (ClawOfChaos, 10)]
    }
  , { name      = "Altera"
    , spoiler   = Nothing
    , id        = 8
    , rarity    = 5
    , class     = Saber
    , attr      = Man
    , deck      = Deck Quick Arts Arts Buster Buster
    , curve     = 5
    , stats     = { base  = { atk = 1907,  hp = 2039 }
                  , max   = { atk = 12343, hp = 13907 }
                  , grail = { atk = 13511, hp = 15236 }
                  }
    , skills    = [ { name   = "Tactics"
                    , rank   = B
                    , icon   = Icon.BeamUp
                    , cd     = 7
                    , effect = [ Grant Party 1 NPUp <| Range 9 18 ]
                    }
                  , { name   = "Natural Body"
                    , rank   = EX
                    , icon   = Icon.HoodUp
                    , cd     = 7
                    , effect = [ Grant Self 3 OffensiveResist <| Range 60 120
                               , To Self Heal <| Range 1000 3000
                               , Grant Self 1 GatherUp <| Range 100 300
                               ]
                    }
                  , { name   = "Crest of the Star"
                    , rank   = EX
                    , icon   = Icon.SwordUp
                    , cd     = 7
                    , effect = [ Grant Self 3 AttackUp <| Range 10 30
                               , To Party GainStars <| Range 5 15
                               ]
                    }
                  ]
    , passives  = [magicResistance B, riding A, divinity B]
    , phantasm  = { name   = "Photon Ray"
                  , desc   = "Sword of the God of War"
                  , rank   = A
                  , card   = Buster
                  , kind   = "Anti-Army"
                  , hits   = 1
                  , effect = [ To Enemies Damage <| Range 400 600 ]
                  , over   = [ Debuff Enemies 3 DefenseDown <| Range 20 40 ]
                  , first  = False
                  }
    , gen       = { starWeight = 102, starRate = 10.1, npAtk = 0.84, npDef = 3 }
    , hits      = { quick = 2, arts = 2, buster = 1, ex = 3 }
    , gender    = Female
    , traits    = [Humanoid, Riding, Divine, EnumaElish, King]
    , death     = 24.5
    , align     = [Chaotic, Good]
    , limited   = False
    , free      = False
    , ascendUp  = Ascension
                  [(Piece Saber, 5)]
                  [(Piece Saber, 12), (VoidsDust, 15)]
                  [(Monument Saber, 5), (ClawOfChaos, 6), (MeteorHorseshoe, 5)]
                  [(Monument Saber, 12), (MeteorHorseshoe, 10), (HeartOfTheForeignGod, 5)]
    , skillUp   = Reinforcement
                  [(GemOf Saber, 5)]
                  [(GemOf Saber, 12)]
                  [(MagicGemOf Saber, 5)]
                  [(MagicGemOf Saber, 12), (ClawOfChaos, 3)]
                  [(SecretGemOf Saber, 5), (ClawOfChaos, 6)]
                  [(SecretGemOf Saber, 12), (VoidsDust, 10)]
                  [(VoidsDust, 20), (EvilBone, 18)]
                  [(EvilBone, 54), (HeartOfTheForeignGod, 10)]
    }
  , { name      = "Gilles de Rais"
    , spoiler   = Nothing
    , id        = 9
    , rarity    = 3
    , class     = Saber
    , attr      = Man
    , deck      = Deck Quick Arts Arts Buster Buster
    , curve     = 13
    , stats     = { base  = { atk = 1228, hp = 1889 }
                  , max   = { atk = 6615, hp = 10498 }
                  , grail = { atk = 8952, hp = 14234 }
                  }
    , skills    = [ { name   = "Tactics"
                    , rank   = C
                    , icon   = Icon.BeamUp
                    , cd     = 7
                    , effect = [ Grant Party 1 NPUp <| Range 8 16 ]
                    }
                  , { name   = "Golden Rule"
                    , rank   = B
                    , icon   = Icon.NobleUp
                    , cd     = 8
                    , effect = [ Grant Self 3 NPGen <| Range 18 45 ]
                    }
                  , { name   = "Prelati's Encouragement"
                    , rank   = B
                    , icon   = Icon.BusterUp
                    , cd     = 7
                    , effect = [ Grant Self 5 (CardUp Buster) <| Range 20 40 ]
                    }
                  ]
    , passives  = [magicResistance B, riding B, madness EX]
    , phantasm  = { name   = "Saint War Order"
                  , desc   = "Rally Thy War Cries Under the Holy Flag"
                  , rank   = B
                  , card   = Arts
                  , kind   = "Anti-Personnel"
                  , hits   = 0
                  , effect = [ Grant Self 2 AttackUp <| Range 50 100
                             , Debuff Self 3 DefenseDown <| Flat 50
                             ]
                  , over   = [ To Party GainStars <| Range 5 25 ]
                  , first  = False
                  }
    , gen       = { starWeight = 98, starRate = 9.9, npAtk = 0.82, npDef = 3 }
    , hits      = { quick = 2, arts = 2, buster = 1, ex = 3 }
    , gender    = Male
    , traits    = [Humanoid, Riding, LovedOne, EnumaElish]
    , death     = 31.5
    , align     = [Lawful, Good]
    , limited   = False
    , free      = False
    , ascendUp  = Ascension
                  [(Piece Saber, 4)]
                  [(Piece Saber, 8), (ProofOfHero, 15)]
                  [(Monument Saber, 4), (VoidsDust, 13), (EvilBone, 10)]
                  [(Monument Saber, 8), (EvilBone, 20), (HeartOfTheForeignGod, 4)]
    , skillUp   = Reinforcement
                  [(GemOf Saber, 4)]
                  [(GemOf Saber, 8)]
                  [(MagicGemOf Saber, 4)]
                  [(MagicGemOf Saber, 8), (VoidsDust, 7)]
                  [(SecretGemOf Saber, 4), (VoidsDust, 13)]
                  [(SecretGemOf Saber, 8), (ProofOfHero, 10)]
                  [(ProofOfHero, 20), (GhostLantern, 4)]
                  [(GhostLantern, 12), (HeartOfTheForeignGod, 7)]
    }
  , { name      = "Chevalier d'Eon"
    , spoiler   = Nothing
    , id        = 10
    , rarity    = 4
    , class     = Saber
    , attr      = Man
    , deck      = Deck Quick Arts Arts Buster Buster
    , curve     = 9
    , stats     = { base  = { atk = 1734,  hp = 2121 }
                  , max   = { atk = 8765,  hp = 13256 }
                  , grail = { atk = 10613, hp = 16073 }
                  }
    , skills    = [ { name   = "Mind's Eye (True)"
                    , rank   = C
                    , icon   = Icon.Dodge
                    , cd     = 8
                    , effect = [ Grant Self 1 Evasion Full
                               , Grant Self 3 DefenseUp <| Range 8 16
                               ]
                    }
                  , { name   = "Self-Suggestion"
                    , rank   = A
                    , icon   = Icon.Bubbles
                    , cd     = 7
                    , effect = [ To Self RemoveDebuffs Full
                               , Grant Self 3 DebuffResist <| Range 50 100
                               ]
                    }
                  , { name   = "Beautiful Appearance"
                    , rank   = C
                    , icon   = Icon.Face
                    , cd     = 7
                    , effect = [ Grant Self 3 Taunt Full
                               , To Self Heal <| Range 1000 2500
                               ]
                    }
                  ]
    , passives  = [magicResistance C, riding B]
    , phantasm  = { name   = "Fleur de Lis"
                  , desc   = "Gorgeous Blooming Lilies"
                  , rank   = CPlus
                  , card   = Arts
                  , kind   = "Anti-Army"
                  , hits   = 0
                  , effect = [ Debuff Enemies 3 AttackDown <| Range 10 30
                             , Debuff Enemies 3 DefenseDown <| Range 10 30
                             ]
                  , over   = [ Chances 30 70 <| Debuff Enemies 1 Charm Full ]
                  , first  = False
                  }
    , gen       = { starWeight = 102, starRate = 10, npAtk = 0.83, npDef = 3 }
    , hits      = { quick = 2, arts = 2, buster = 1, ex = 3 }
    , gender    = Nonbinary
    , traits    = [Humanoid, Riding, EnumaElish]
    , death     = 28
    , align     = [Neutral, Balanced]
    , limited   = False
    , free      = False
    , ascendUp  = Ascension
                  [(Piece Saber, 4)]
                  [(Piece Saber, 10), (ProofOfHero, 18)]
                  [(Monument Saber, 4), (SeedOfYggdrasil, 10), (PhoenixFeather, 4)]
                  [(Monument Saber, 10), (PhoenixFeather, 7), (SerpentJewel, 8)]
    , skillUp   = Reinforcement
                  [(GemOf Saber, 4)]
                  [(GemOf Saber, 10)]
                  [(MagicGemOf Saber, 4)]
                  [(MagicGemOf Saber, 10), (SeedOfYggdrasil, 5)]
                  [(SecretGemOf Saber, 4), (SeedOfYggdrasil, 10)]
                  [(SecretGemOf Saber, 10), (ProofOfHero, 12)]
                  [(ProofOfHero, 24), (ForbiddenPage, 5)]
                  [(ForbiddenPage, 15), (SerpentJewel, 16)]
    }
  , { name  =   "Okita Souji"
    , spoiler   = Nothing
    , id        = 68
    , rarity    = 5
    , class     = Saber
    , attr      = Man
    , deck      = Deck Quick Quick Arts Buster Buster
    , curve     = 10
    , stats     = { base  = { atk = 1865,  hp = 1939 }
                  , max   = { atk = 12068, hp = 13225 }
                  , grail = { atk = 13210, hp = 14489 }
                  }
    , skills    = [ { name   = "Shukuchi"
                    , rank   = B
                    , icon   = Icon.QuickUp
                    , cd     = 7
                    , effect = [ Grant Self 1 (CardUp Quick) <| Range 30 50 ]
                    }
                  , { name   = "Weak Constitution"
                    , rank   = A
                    , icon   = Icon.StarUp
                    , cd     = 7
                    , effect = [ Grant Self 1 GatherUp <| Range 500 1000 ]
                    }
                  , { name   = "Mind's Eye (Fake)"
                    , rank   = A
                    , icon   = Icon.Dodge
                    , cd     = 8
                    , effect = [ Grant Self 1 Evasion Full
                               , Grant Self 3 CritUp <| Range 20 40
                               ]
                    }
                  ]
    , passives  = [magicResistance E, riding E]
    , phantasm  = { name   = "Mumyou Sandanzuki"
                  , desc   = "Three-Stage Thrust"
                  , rank   = Unknown
                  , card   = Quick
                  , kind   = "Anti-Personnel"
                  , hits   = 3
                  , effect = [ To Enemy DamageThruDef <| Range 1200 2000 ]
                  , over   = [ Debuff Enemy 3 DefenseDown <| Range 30 50 ]
                  , first  = False
                  }
    , gen       = { starWeight = 98, starRate = 10.2, npAtk = 1.09, npDef = 3 }
    , hits      = { quick = 5, arts = 2, buster = 1, ex = 3 }
    , gender    = Female
    , traits    = [Humanoid, Riding, Saberface, EnumaElish]
    , death     = 35
    , align     = [Neutral, Balanced]
    , limited   = True
    , free      = False
    , ascendUp  = Ascension
                  [(Piece Saber, 5)]
                  [(Piece Saber, 12), (VoidsDust, 15)]
                  [(Monument Saber, 5), (DragonFang, 24), (EternalGear, 5)]
                  [(Monument Saber, 12), (EternalGear, 10), (PhoenixFeather, 10)]
    , skillUp   = Reinforcement
                  [(GemOf Saber, 5)]
                  [(GemOf Saber, 12)]
                  [(MagicGemOf Saber, 5)]
                  [(MagicGemOf Saber, 12), (DragonFang, 12)]
                  [(SecretGemOf Saber, 5), (DragonFang, 24)]
                  [(SecretGemOf Saber, 12), (VoidsDust, 10)]
                  [(VoidsDust, 20), (ClawOfChaos, 4)]
                  [(ClawOfChaos, 11), (PhoenixFeather, 20)]
    }
  , { name      = "Fergus mac Roich"
    , spoiler   = Nothing
    , id        = 72
    , rarity    = 3
    , class     = Saber
    , attr      = Earth
    , deck      = Deck Quick Arts Buster Buster Buster
    , curve     = 23
    , stats     = { base  = { atk = 1385,  hp = 1761 }
                  , max   = { atk = 7460,  hp = 9786 }
                  , grail = { atk = 10096, hp = 13268 }
                  }
    , skills    = [ { name   = "Valor"
                    , rank   = A
                    , icon   = Icon.SwordUp
                    , cd     = 7
                    , effect = [ Grant Self 3 AttackUp <| Range 10 30
                               , Grant Self 3 MentalResist <| Range 20 40
                               ]
                    }
                  , { name   = "Defiant"
                    , rank   = B
                    , icon   = Icon.ShieldUp
                    , cd     = 7
                    , effect = [ Grant Self 3 DefenseUp <| Range 15 25
                               , Debuff Self 3 AttackBuffDown <| Flat 50
                               ]
                    }
                  , { name   = "Mind's Eye (True)"
                    , rank   = A
                    , icon   = Icon.Dodge
                    , cd     = 8
                    , effect = [ Grant Self 1 Evasion Full
                               , Grant Self 3 DefenseUp <| Range 10 20
                               ]
                    }
                  ]
    , passives  = [magicResistance B, riding B]
    , phantasm  = { name   = "Caladbolg"
                  , desc   = "Rainbow Sword"
                  , rank   = APlus
                  , card   = Buster
                  , kind   = "Anti-Army"
                  , hits   = 5
                  , effect = [ To Enemies Damage <| Range 400 600
                             , Debuff Enemies 3 DefenseDown <| Flat 20
                             ]
                  , over   = [ Debuff Enemies 3 DebuffVuln <| Range 20 60 ]
                  , first  = False
                  }
    , gen       = { starWeight = 99, starRate = 10, npAtk = 1.09, npDef = 3 }
    , hits      = { quick = 2, arts = 2, buster = 1, ex = 3 }
    , gender    = Male
    , traits    = [Humanoid, Riding, LovedOne, EnumaElish, King]
    , death     = 35
    , align     = [Lawful, Balanced]
    , limited   = False
    , free      = False
    , ascendUp  = Ascension
                  [(Piece Saber, 4)]
                  [(Piece Saber, 8), (ProofOfHero, 15)]
                  [(Monument Saber, 4), (OctupletCrystals, 7), (HeartOfTheForeignGod, 2)]
                  [(Monument Saber, 8), (HeartOfTheForeignGod, 3), (MeteorHorseshoe, 8)]
    , skillUp   = Reinforcement
                  [(GemOf Saber, 4)]
                  [(GemOf Saber, 8)]
                  [(MagicGemOf Saber, 4)]
                  [(MagicGemOf Saber, 8), (OctupletCrystals, 4)]
                  [(SecretGemOf Saber, 4), (OctupletCrystals, 7)]
                  [(SecretGemOf Saber, 8), (ProofOfHero, 10)]
                  [(ProofOfHero, 20), (SeedOfYggdrasil, 5)]
                  [(SeedOfYggdrasil, 15), (MeteorHorseshoe, 16)]
    }
  , { name      = "Mordred"
    , spoiler   = Nothing
    , id        = 76
    , rarity    = 5
    , class     = Saber
    , attr      = Earth
    , deck      = Deck Quick Arts Arts Buster Buster
    , curve     = 25
    , stats     = { base  = { atk = 1811,  hp = 2153 }
                  , max   = { atk = 11723, hp = 14680 }
                  , grail = { atk = 12833, hp = 16083 }
                  }
    , skills    = [ { name   = "Mana Burst"
                    , rank   = A
                    , icon   = Icon.BusterUp
                    , cd     = 7
                    , effect = [ Grant Self 1 (CardUp Buster) <| Range 30 50 ]
                    }
                  , { name   = "Intuition"
                    , rank   = B
                    , icon   = Icon.Star
                    , cd     = 7
                    , effect = [ To Party GainStars <| Range 4 14 ]
                    }
                  , { name   = "Secret of Pedigree"
                    , rank   = EX
                    , icon   = Icon.ShieldUp
                    , cd     = 8
                    , effect = [ Grant Self 1 DefenseUp <| Range 30 50
                               , To Self RemoveDebuffs Full
                               , To Self GaugeUp <| Range 10 30
                               ]
                    }
                  ]
    , passives  = [magicResistance B, riding B]
    , phantasm  = { name   = "Clarent Blood Arthur"
                  , desc   = "Rebellion Against My Beautiful Father"
                  , rank   = APlus
                  , card   = Buster
                  , kind   = "Anti-Army"
                  , hits   = 5
                  , effect = [ To Enemies Damage <| Range 400 600 ]
                  , over   = [ To Enemies (SpecialDamage <| VsTrait Arthur) <| Range 180 220
                             , To Self GaugeUp <| Range 20 40
                             ]
                  , first  = False
                  }
    , gen       = { starWeight = 98, starRate = 10, npAtk = 0.56, npDef = 3 }
    , hits      = { quick = 2, arts = 3, buster = 1, ex = 4 }
    , gender    = Female
    , traits    = [Humanoid, Riding, Dragon, Saberface, EnumaElish]
    , death     = 24.5
    , align     = [Chaotic, Balanced]
    , limited   = False
    , free      = False
    , ascendUp  = Ascension
                  [(Piece Saber, 5)]
                  [(Piece Saber, 12), (DragonFang, 18)]
                  [(Monument Saber, 5), (OctupletCrystals, 10), (HeartOfTheForeignGod, 2)]
                  [( Monument Saber, 12), (HeartOfTheForeignGod, 4), (DragonsReverseScale, 5)]
    , skillUp   = Reinforcement
                  [(GemOf Saber, 5)]
                  [(GemOf Saber, 12)]
                  [(MagicGemOf Saber, 5)]
                  [(MagicGemOf Saber, 12), (OctupletCrystals, 5)]
                  [(SecretGemOf Saber, 5), (OctupletCrystals, 10)]
                  [(SecretGemOf Saber, 12), (DragonFang, 12)]
                  [(DragonFang, 24), (ClawOfChaos, 4)]
                  [(ClawOfChaos, 11), (DragonsReverseScale, 10)]
    }
  , { name      = "Nero Claudius (Bride)"
    , spoiler   = Nothing
    , id        = 90
    , rarity    = 5
    , class     = Saber
    , attr      = Man
    , deck      = Deck Quick Arts Arts Buster Buster
    , curve     = 30
    , stats     = { base  = { atk = 1793,  hp = 2089 }
                  , max   = { atk = 11607, hp = 14284 }
                  , grail = { atk = 12706, hp = 15609 }
                  }
    , skills    = [ { name   = "Stars for the Sky"
                    , rank   = A
                    , icon   = Icon.NobleUp
                    , cd     = 9
                    , effect = [ Grant Ally 3 NPGen <| Range 35 45 ]
                    }
                  , { name   = "Flowers for the Earth"
                    , rank   = A
                    , icon   = Icon.SwordUp
                    , cd     = 8
                    , effect = [ Grant Ally 3 AttackUp <| Range 30 40
                               , Grant Ally 3 StarUp <| Range 30 50
                               ]
                    }
                  , { name   = "Love for the People"
                    , rank   = A
                    , icon   = Icon.Heal
                    , cd     = 7
                    , effect = [ To Ally Heal <| Range 1000 3000
                               , Grant Ally 3 DefenseUp <| Range 10 20
                               ]
                    }
                  ]
    , passives  = [magicResistance C, riding B]
    , phantasm  = { name   = "Fax Caelestis"
                  , desc   = "Ending of the Rose of Prominence"
                  , rank   = BPlusPlus
                  , card   = Arts
                  , kind   = "Anti-Personnel"
                  , hits   = 2
                  , effect = [ To Enemy Damage <| Range 1200 1800 ]
                  , over   = [ Debuff Enemy 5 Burn <| Range 1000 2000
                             , Debuff Enemy 5 DefenseDown <| Range 20 40
                             , Debuff Enemy 5 CritChance <| Range 20 40
                             ]
                  , first  = False
                  }
    , gen       = { starWeight = 102, starRate = 10.1, npAtk = 0.7, npDef = 3 }
    , hits      = { quick = 3, arts = 3, buster = 1, ex = 5 }
    , gender    = Female
    , traits    = [Humanoid, Riding, Saberface, Roman, EnumaElish, King]
    , death     = 35
    , align     = [Chaotic, Bride]
    , limited   = True
    , free      = False
    , ascendUp  = Ascension
                  [(Piece Saber, 5)]
                  [(Piece Saber, 12), (OctupletCrystals, 8)]
                  [(Monument Saber, 5), (PhoenixFeather, 4), (GhostLantern, 10)]
                  [(Monument Saber, 12), (SeedOfYggdrasil, 15), (PhoenixFeather, 8)]
    , skillUp   = Reinforcement
                  [(GemOf Saber, 5)]
                  [(GemOf Saber, 12)]
                  [(MagicGemOf Saber, 5)]
                  [(MagicGemOf Saber, 12), (GhostLantern, 5)]
                  [(SecretGemOf Saber, 5), (GhostLantern, 10)]
                  [(SecretGemOf Saber, 12), (OctupletCrystals, 5)]
                  [(OctupletCrystals, 10), (SerpentJewel, 5)]
                  [(SerpentJewel, 15), (EternalGear, 24)]
    }
  , { name      = "Ryougi Shiki (Saber)"
    , spoiler   = Nothing
    , id        = 91
    , rarity    = 5
    , class     = Saber
    , attr      = Man
    , deck      = Deck Quick Arts Arts Buster Buster
    , curve     = 15
    , stats     = { base  = { atk = 1656,  hp = 2266 }
                  , max   = { atk = 10721, hp = 15453 }
                  , grail = { atk = 11736, hp = 16929 }
                  }
    , skills    = [ { name   = "Mystic Eyes of Death Perception"
                    , rank   = C
                    , icon   = Icon.Mystic
                    , cd     = 7
                    , effect = [ Grant Self 1 IgnoreInvinc Full
                               , Grant Self 1 (CardUp Arts) <| Range 25 40
                               , Debuff Enemies 1 DeathVuln <| Range 60 80
                               ]
                    }
                  , { name   = "Unyou"
                    , rank   = B
                    , icon   = Icon.SwordUp
                    , cd     = 7
                    , effect = [ Grant Self 3 AttackUp <| Range 15 25
                               , Grant Self 3 MentalResist <| Range 18 36
                               ]
                    }
                  , { name   = "Yin-Yang"
                    , rank   = A
                    , icon   = Icon.YinYang
                    , cd     = 6
                    , effect = [ To Self Heal <| Range 2000 5000
                               , To Self DemeritGauge <| Flat 10
                               ]
                    }
                  ]
    , passives  = [magicResistance A, connectionRoot A, independentManifestation C]
    , phantasm  = { name   = "Amalavijñāna—Boundary of Emptiness"
                  , desc   = "Mukushiki Kara no Kyoukai"
                  , rank   = EX
                  , card   = Arts
                  , kind   = "Anti-Unit"
                  , hits   = 1
                  , effect = [ To Enemies DamageThruDef <| Range 450 750
                             , To Party RemoveDebuffs Full
                             ]
                  , over   = [ To Enemies Death <| Range 60 100 ]
                  , first  = False
                  }
    , gen       = { starWeight = 102, starRate = 9.9, npAtk = 0.84, npDef = 3 }
    , hits      = { quick = 4, arts = 2, buster = 1, ex = 4 }
    , gender    = Female
    , traits    = [Humanoid, EnumaElish, PseudoServant]
    , death     = 24.5
    , align     = [Neutral, Balanced]
    , limited   = True
    , free      = False
    , ascendUp  = Ascension
                  [(Piece Saber, 5)]
                  [(Piece Saber, 12), (VoidsDust, 15)]
                  [(Monument Saber, 5), (PhoenixFeather, 8), (ClawOfChaos, 3)]
                  [(Monument Saber, 12), (ClawOfChaos, 6), (HeartOfTheForeignGod, 5)]
    , skillUp   = Reinforcement
                  [(GemOf Saber, 5)]
                  [(GemOf Saber, 12)]
                  [(MagicGemOf Saber, 5)]
                  [(MagicGemOf Saber, 12), (PhoenixFeather, 4)]
                  [(SecretGemOf Saber, 5), (PhoenixFeather, 8)]
                  [(SecretGemOf Saber, 12), (VoidsDust, 10)]
                  [(VoidsDust, 20), (OctupletCrystals, 6)]
                  [(OctupletCrystals, 18), (GhostLantern, 24)]
    }
  , { name      = "Rama"
    , spoiler   = Nothing
    , id        = 101
    , rarity    = 4
    , class     = Saber
    , attr      = Sky
    , deck      = Deck Quick Arts Arts Buster Buster
    , curve     = 24
    , stats     = { base  = { atk = 1642,  hp = 1901 }
                  , max   = { atk = 9854,  hp = 11882 }
                  , grail = { atk = 11931, hp = 14541 }
                  }
    , skills    = [ { name   = "Blessing of Martial Arts"
                    , rank   = A
                    , icon   = Icon.StarUp
                    , cd     = 6
                    , effect = [ Grant Self 1 GatherUp <| Range 300 500
                               , Grant Self 1 CritUp <| Range 50 100
                               ]
                    }
                  , { name   = "Charisma"
                    , rank   = B
                    , icon   = Icon.SwordUp
                    , cd     = 7
                    , effect = [ Grant Party 3 AttackUp <| Range 9 18 ]
                    }
                  , { name   = "Curse of Separation"
                    , rank   = A
                    , icon   = Icon.Kneel
                    , cd     = 9
                    , effect = [ Times 1 << Grant Self 3 Guts <| Flat 1000
                               , To Self Heal <| Range 1000 3000
                               ]
                    }
                  ]
    , passives  = [magicResistance A, riding APlus, divinity A]
    , phantasm  = { name   = "Brahmastra"
                  , desc   = "The Rakshasa-Piercing Immortal"
                  , rank   = APlus
                  , card   = Buster
                  , kind   = "Anti-Demon"
                  , hits   = 5
                  , effect = [ To Enemy Damage <| Range 600 1000 ]
                  , over   = [ To Enemy (SpecialDamage <| VsTrait Demonic) <| Range 150 200 ]
                  , first  = False
                  }
    , gen       = { starWeight = 100, starRate = 10.2, npAtk = 0.84, npDef = 3 }
    , hits      = { quick = 2, arts = 2, buster = 1, ex = 4 }
    , gender    = Male
    , traits    = [Humanoid, Riding, King, LovedOne, Divine, EnumaElish]
    , death     = 24.5
    , align     = [Lawful, Good]
    , limited   = False
    , free      = False
    , ascendUp  = Ascension
                  [(Piece Saber, 4)]
                  [(Piece Saber, 10), (SeedOfYggdrasil, 8)]
                  [(Monument Saber, 4), (HeartOfTheForeignGod, 4), (OctupletCrystals, 4)]
                  [(Monument Saber, 10), (OctupletCrystals, 8), (SpiritRoot, 4)]
    , skillUp   = Reinforcement
                  [(GemOf Saber, 4)]
                  [(GemOf Saber, 10)]
                  [(MagicGemOf Saber, 4)]
                  [(MagicGemOf Saber, 10), (HeartOfTheForeignGod, 2)]
                  [(SecretGemOf Saber, 4), (HeartOfTheForeignGod, 4)]
                  [(SecretGemOf Saber, 10), (SeedOfYggdrasil, 5)]
                  [(SeedOfYggdrasil, 10), (ClawOfChaos, 3)]
                  [(ClawOfChaos, 9), (EvilBone, 60)]
    }
  , { name      = "Lancelot (Saber)"
    , spoiler   = Nothing
    , id        = 121
    , rarity    = 4
    , class     = Saber
    , attr      = Earth
    , deck      = Deck Quick Arts Arts Buster Buster
    , curve     = 14
    , stats     = { base  = { atk = 1658,  hp = 1854 }
                  , max   = { atk = 9949,  hp = 11589 }
                  , grail = { atk = 12046, hp = 14051 }
                  }
    , skills    = [ { name   = "Knight of the Lake"
                    , rank   = A
                    , icon   = Icon.Noble
                    , cd     = 8
                    , effect = [ To Self GaugeUp <| Flat 30
                               , To Party GainStars <| Range 10 20
                               ]
                    }
                  , { name   = "Eternal Arms Mastery"
                    , rank   = APlus
                    , icon   = Icon.StarUp
                    , cd     = 7
                    , effect = [ Grant Self 3 GatherUp <| Range 3000 6000 ]
                    }
                  , { name   = "Knight of Owner"
                    , rank   = APlusPlus
                    , icon   = Icon.StarTurn
                    , cd     = 8
                    , effect = [ Grant Self 3 StarsPerTurn <| Range 5 15
                               , Grant Self 3 CritUp <| Range 30 50
                               ]
                    }
                  ]
    , passives  = [magicResistance B, riding B]
    , phantasm  = { name   = "Arondight Overload"
                  , desc   = "Severance of the Binding Chains—Lake's Overflowing Light"
                  , rank   = A
                  , card   = Arts
                  , kind   = "Anti-Army"
                  , hits   = 1
                  , effect = [ Grant Self 1 (CardUp Arts) <| Flat 30
                             , To Enemy Damage <| Range 900 1500
                             ]
                  , over   = [ Debuff Enemy 5 DamageVuln <| Range 1000 3000 ]
                  , first  = False
                  }
    , gen       = { starWeight = 100, starRate = 10, npAtk = 0.83, npDef = 3 }
    , hits      = { quick = 3, arts = 2, buster = 4, ex = 5 }
    , gender    = Male
    , traits    = [Humanoid, LovedOne, Riding, EnumaElish]
    , death     = 28
    , align     = [Lawful, Good]
    , limited   = False
    , free      = False
    , ascendUp  = Ascension
                  [(Piece Saber, 4)]
                  [(Piece Saber, 10), (EternalGear, 6)]
                  [(Monument Saber, 4), (GreatKnightMedal, 16), (DragonFang, 10)]
                  [(Monument Saber, 10), (DragonFang, 20), (DragonsReverseScale, 4)]
    , skillUp   = Reinforcement
                  [(GemOf Saber, 4)]
                  [(GemOf Saber, 10)]
                  [(MagicGemOf Saber, 4)]
                  [(MagicGemOf Saber, 10), (GreatKnightMedal, 8)]
                  [(SecretGemOf Saber, 4), (GreatKnightMedal, 16)]
                  [(SecretGemOf Saber, 10), (EternalGear, 4)]
                  [(EternalGear, 8), (VoidsDust, 10)]
                  [(VoidsDust, 30), (TearstoneOfBlood, 12)]
    }
  , { name      = "Gawain"
    , spoiler   = Nothing
    , id        = 123
    , rarity    = 4
    , class     = Saber
    , attr      = Earth
    , deck      = Deck Quick Arts Buster Buster Buster
    , curve     = 4
    , stats     = { base  = { atk = 1695,  hp = 1827 }
                  , max   = { atk = 10173, hp = 11419 }
                  , grail = { atk = 12317, hp = 13845 }
                  }
    , skills    = [ { name   = "Numeral of the Saint"
                    , rank   = EX
                    , icon   = Icon.SwordUp
                    , cd     = 7
                    , effect = [ Grant Self 3 AttackUp <| Flat 20
                               , When "on Open field with Sunshine" << Grant Self 3 (CardUp Buster) <| Range 20 30
                               ]
                    }
                  , { name   = "Charisma"
                    , rank   = E
                    , icon   = Icon.SwordUp
                    , cd     = 7
                    , effect = [ Grant Party 3 AttackUp <| Range 6 12 ]
                    }
                  , { name   = "Belt of Bertilak"
                    , rank   = EX
                    , icon   = Icon.Noble
                    , cd     = 8
                    , effect = [ To Self GaugeUp <| Flat 20
                               , To Party GainStars <| Range 5 10
                               , Times 1 << Grant Self 1 Guts <| Range 1000 2000
                               ]
                    }
                  ]
    , passives  = [magicResistance B, riding B]
    , phantasm  = { name   = "Excalibur Galatine"
                  , desc   = "The Reborn Sword of Victory"
                  , rank   = APlus
                  , card   = Buster
                  , kind   = "Anti-Army"
                  , hits   = 4
                  , effect = [ To Enemies Damage <| Range 300 500
                             , Debuff Enemies 1 SealSkills Full
                             ]
                  , over   = [ Debuff Enemies 5 Burn <| Range 1000 5000 ]
                  , first  = False
                  }
    , gen       = { starWeight = 102, starRate = 10, npAtk = 1.14, npDef = 3 }
    , hits      = { quick = 2, arts = 2, buster = 1, ex = 5 }
    , gender    = Male
    , traits    = [Humanoid, LovedOne, Riding, EnumaElish]
    , death     = 21
    , align     = [Lawful, Good]
    , limited   = False
    , free      = False
    , ascendUp  = Ascension
                  [(Piece Saber, 4)]
                  [(Piece Saber, 10), (OctupletCrystals, 6)]
                  [(Monument Saber, 4), (DragonsReverseScale, 4), (GreatKnightMedal, 8)]
                  [(Monument Saber, 10), (GreatKnightMedal, 16), (ProofOfHero, 30)]
    , skillUp   = Reinforcement
                  [(GemOf Saber, 4)]
                  [(GemOf Saber, 10)]
                  [(MagicGemOf Saber, 4)]
                  [(MagicGemOf Saber, 10), (DragonsReverseScale, 2)]
                  [(SecretGemOf Saber, 4), (DragonsReverseScale, 4)]
                  [(SecretGemOf Saber, 10), (OctupletCrystals, 4)]
                  [(OctupletCrystals, 8), (DragonFang, 12)]
                  [(DragonFang, 36), (SpiritRoot, 8)]
    }
  , { name      = "Bedivere"
    , spoiler   = Nothing
    , id        = 126
    , rarity    = 3
    , class     = Saber
    , attr      = Star
    , deck      = Deck Quick Quick Arts Buster Buster
    , curve     = 13
    , stats     = { base  = { atk = 1416,  hp = 1727 }
                  , max   = { atk = 7627,  hp = 9595 }
                  , grail = { atk = 10322, hp = 13009 }
                  }
    , skills    = [ { name   = "Tactics"
                    , rank   = C
                    , icon   = Icon.BeamUp
                    , cd     = 7
                    , effect = [ Grant Party 1 NPUp <| Range 8 16 ]
                    }
                  , { name   = "Calm and Collected"
                    , rank   = B
                    , icon   = Icon.Noble
                    , cd     = 8
                    , effect = [ To Self GaugeUp <| Flat 30
                               , Grant Self 3 DebuffResist <| Range 30 50
                               ]
                    }
                  , { name   = "Oath of Protection"
                    , rank   = B
                    , icon   = Icon.ShieldUp
                    , cd     = 7
                    , effect = [ Grant Party 1 DefenseUp <| Flat 30
                               , Grant Self 1 DebuffResist <| Range 30 50
                               ]
                    }
                  ]
    , passives  = [magicResistance B, riding A]
    , phantasm  = { name   = "Switch On—Airgetlám"
                  , desc   = "Be my Sword, Silver Arm"
                  , rank   = CPlus
                  , card   = Buster
                  , kind   = "Anti-Unit"
                  , hits   = 2
                  , effect = [ To Enemy Damage <| Range 800 1200 ]
                  , over   = [ Grant Self 1 (CardUp Buster) <| Range 30 90 ]
                  , first  = True
                  }
    , gen       = { starWeight = 100, starRate = 10.2, npAtk = 1.11, npDef = 3 }
    , hits      = { quick = 2, arts = 2, buster = 1, ex = 5 }
    , gender    = Male
    , traits    = [Humanoid, LovedOne, EnumaElish]
    , death     = 28
    , align     = [Lawful, Good]
    , limited   = False
    , free      = True
    , ascendUp  = Ascension
                  [(Piece Saber, 4)]
                  [(Piece Saber, 8), (ProofOfHero, 15)]
                  [(Monument Saber, 4), (EternalGear, 4), (VoidsDust, 13)]
                  [(Monument Saber, 8), (EternalGear, 7), (GreatKnightMedal, 16)]
    , skillUp   = Reinforcement
                  [(GemOf Saber, 4)]
                  [(GemOf Saber, 8)]
                  [(MagicGemOf Saber, 4)]
                  [(MagicGemOf Saber, 8), (VoidsDust, 7)]
                  [(SecretGemOf Saber, 4), (VoidsDust, 13)]
                  [(SecretGemOf Saber, 8), (ProofOfHero, 10)]
                  [(FoolsChain, 12), (ProofOfHero, 20)]
                  [(FoolsChain, 36), (TearstoneOfBlood, 10)]
    }
  , { name      = "Elisabeth Bathory (Brave)"
    , spoiler   = Nothing
    , id        = 138
    , rarity    = 4
    , class     = Saber
    , attr      = Earth
    , deck      = Deck Quick Arts Arts Buster Buster
    , curve     = 12
    , stats     = { base  = { atk = 1649,  hp = 1799 }
                  , max   = { atk = 9899,  hp = 11248 }
                  , grail = { atk = 11986, hp = 13638 }
                  }
    , skills    = [ { name   = "Hero's Principles"
                    , rank   = EX
                    , icon   = Icon.Shield
                    , cd     = 8
                    , effect = [ Grant Self 1 NPGen <| Range 30 50
                               , Grant Self 1 Invincibility Full
                               ]
                    }
                  , { name   = "Mana Burst (Courage)"
                    , rank   = D
                    , icon   = Icon.BusterUp
                    , cd     = 7
                    , effect = [ Grant Self 1 (CardUp Buster) <|
                                 Range 20 40
                               , Grant Self 1 DefenseUp <| Flat 20
                               ]
                    }
                  , { name   = "Legend of the Crimson Hero"
                    , rank   = EX
                    , icon   = Icon.DamageUp
                    , cd     = 8
                    , effect = [ To Self GaugeSpend <| Flat 100
                               , To Self ApplyAtRandom <| Flat 1
                               , Grant Self 3 (CardUp Buster) <|
                                 Range 30 50
                               , Grant Party 1 Invincibility Full
                               , To Party Heal <| Range 2000 3000
                               , Grant Party 1 AttackUp <| Range 30 50
                               , To Party GainStars <| Range 30 50
                               ]
                    }
                  ]
    , passives  = [magicResistance A, territoryCreation C, doubleClass E]
    , phantasm  = { name   = "Báthory Brave Erzsébet"
                  , desc   = "Tornado Demon Daughter of Fresh Blood"
                  , rank   = B
                  , card   = Buster
                  , kind   = "Anti-Army"
                  , hits   = 7
                  , effect = [ To Enemy DamageThruDef <| Range 600 1000 ]
                  , over   = [ Debuff Enemy 5 Burn <| Range 500 2500 ]
                  , first  = False
                  }
    , gen       = { starWeight = 100, starRate = 9.9, npAtk = 0.55, npDef = 3 }
    , hits      = { quick = 4, arts = 3, buster = 1, ex = 5 }
    , gender    = Female
    , traits    = [Humanoid, Dragon, EnumaElish]
    , death     = 28
    , align     = [Chaotic, Good]
    , limited   = True
    , free      = True
    , ascendUp  = Welfare "Dragon Orb"
    , skillUp   = Reinforcement
                  [(GemOf Saber, 4)]
                  [(GemOf Saber, 10)]
                  [(MagicGemOf Saber, 4)]
                  [(MagicGemOf Saber, 10), (ProofOfHero, 12)]
                  [(SecretGemOf Saber, 4), (ProofOfHero, 24)]
                  [(SecretGemOf Saber, 10), (DragonFang, 10)]
                  [(DragonFang, 20), (GreatKnightMedal, 10)]
                  [(GreatKnightMedal, 30), (DragonsReverseScale, 8)]
    }
  , { name      = "Miyamoto Musashi"
    , spoiler   = Nothing
    , id        = 153
    , rarity    = 5
    , class     = Saber
    , stats     = { base  = { atk = 1860,  hp = 1999 }
                  , max   = { atk = 12037, hp = 13635 }
                  , grail = { atk = 13176, hp = 14938 }
                  }
    , gen       = { starWeight = 100, starRate = 10, npAtk = 0.87, npDef = 3 }
    , death     = 35
    , curve     = 5
    , attr      = Man
    , align     = [Chaotic, Good]
    , gender    = Female
    , traits    = [Humanoid, EnumaElish]
    , deck      = Deck Quick Arts Buster Buster Buster
    , hits      = { quick = 3, arts = 3, buster = 2, ex = 4 }
    , skills    = [ { name   = "Fifth Force"
                    , rank   = A
                    , icon   = Icon.SwordsRed
                    , cd     = 8
                    , effect = [ Grant Self 1 HitCount <| Flat 200
                               , Grant Self 1 AttackUp <| Range 0 30
                               ]
                    }
                  , { name   = "Heavenly Eye"
                    , rank   = A
                    , icon   = Icon.ShieldBreak
                    , cd     = 7
                    , effect = [ Grant Self 1 (CardUp Buster) <| Range 30 50
                               , Grant Self 1 IgnoreInvinc Full
                               ]
                    }
                  , { name   = "Emptiness"
                    , rank   = A
                    , icon   = Icon.Shield
                    , cd     = 8
                    , effect = [ Grant Self 3 StarUp <| Range 10 30
                               , To Self RemoveDebuffs Full
                               , Grant Self 1 Invincibility Full
                               ]
                    }
                  ]
    , passives  = [ magicResistance A ]
    , phantasm  = { name   = "Six Paths, Five Rings: Kurikara Divine Blade"
                  , desc   = "Five Planes of the Six Realms, The Divine Figure of Kurikara"
                  , rank   = A
                  , card   = Buster
                  , kind   = "Anti-Unit"
                  , hits   = 7
                  , effect = [ To Enemy Damage <| Range 600 1000
                             , To Enemy RemoveBuffs Full
                             ]
                  , over   = [ Grant Self 1 NPUp <| Range 20 60 ]
                  , first  = True
                  }
    , limited   = True
    , free      = False
    , ascendUp  = Ascension
                  [(Piece Saber, 5)]
                  [(Piece Saber, 12), (ProofOfHero, 22)]
                  [(Monument Saber, 5), (OctupletCrystals, 10), (EternalGear, 5)]
                  [(Monument Saber, 12), (EternalGear, 10), (HeartOfTheForeignGod, 5)]
    , skillUp   = Reinforcement
                  [(GemOf Saber, 5)]
                  [(GemOf Saber, 12)]
                  [(MagicGemOf Saber, 5)]
                  [(MagicGemOf Saber, 12), (OctupletCrystals, 5)]
                  [(SecretGemOf Saber, 5), (OctupletCrystals, 10)]
                  [(SecretGemOf Saber, 12), (ProofOfHero, 15)]
                  [(ProofOfHero, 29), (VoidsDust, 12)]
                  [(VoidsDust, 36), (PrimordialLanugo, 15)]
    }
  , { name      = "Arthur Pendragon (Prototype)"
    , spoiler   = Nothing
    , id        = 160
    , rarity    = 5
    , class     = Saber
    , stats     = { base  = { atk = 1926,  hp = 2049 }
                  , max   = { atk = 12465, hp = 13975 }
                  , grail = { atk = 13645, hp = 15310 }
                  }
    , gen       = { starWeight = 100, starRate = 10, npAtk = 0.84, npDef = 3 }
    , death     = 24.5
    , curve     = 5
    , attr      = Earth
    , align     = [Lawful, Good]
    , gender    = Male
    , traits    = [Humanoid, EnumaElish, Dragon, Riding, Arthur, LovedOne, King]
    , deck      = Deck Quick Arts Arts Buster Buster
    , hits      = { quick = 3, arts = 2, buster = 1, ex = 5 }
    , skills    = [ { name   = "Mana Burst"
                    , rank   = A
                    , icon   = Icon.BusterUp
                    , cd     = 7
                    , effect = [ Grant Self 1 (CardUp Buster) <| Range 30 50 ]
                    }
                  , { name   = "Intuition"
                    , rank   = A
                    , icon   = Icon.Star
                    , cd     = 7
                    , effect = [ To Party GainStars <| Range 5 15 ]
                    }
                  , { name   = "Giant Beast Hunt"
                    , rank   = A
                    , icon   = Icon.DamageUp
                    , cd     = 7
                    , effect = [ Grant Self 1 (Special DamageUp <| VsTrait SuperGiant) <| Range 50 100 ]
                    }
                  ]
    , passives  = [magicResistance A, riding B]
    , phantasm  = { name   = "Excalibur"
                  , desc   = "Sword of Promised Victory"
                  , rank   = EX
                  , card   = Buster
                  , kind   = "??"
                  , hits   = 3
                  , effect = [ To Enemies Damage <| Range 300 500 ]
                  , over   = [ Grant Self 1 NPUp <| Range 10 50 ]
                  , first  = True
                  }
    , limited   = True
    , free      = False
    , ascendUp  = Ascension
                  [(Piece Saber, 5)]
                  [(Piece Saber, 12), (GreatKnightMedal, 15)]
                  [(Monument Saber, 5), (ProofOfHero, 29), (DragonFang, 12)]
                  [(Monument Saber, 12), (DragonFang, 24), (DragonsReverseScale, 5)]
    , skillUp   = Reinforcement
                  [(GemOf Saber, 5)]
                  [(GemOf Saber, 12)]
                  [(MagicGemOf Saber, 5)]
                  [(MagicGemOf Saber, 12), (ProofOfHero, 15)]
                  [(SecretGemOf Saber, 5), (ProofOfHero, 29)]
                  [(SecretGemOf Saber, 12), (GreatKnightMedal, 10)]
                  [(GreatKnightMedal, 20), (PrimordialLanugo, 4)]
                  [(PrimordialLanugo, 11), (SpiritRoot, 10)]
    }
  , { name      = "Suzuka Gozen"
    , spoiler   = Nothing
    , id        = 165
    , rarity    = 4
    , class     = Saber
    , stats     = { base  = { atk = 1590,  hp = 1880 }
                  , max   = { atk = 9544,  hp = 11753 }
                  , grail = { atk = 11556, hp = 14250 }
                  }
    , gen       = { starWeight = 100, starRate = 10.2, npAtk = 0.57, npDef = 3 }
    , death     = 21
    , curve     = 29
    , attr      = Sky
    , align     = [Neutral, Evil]
    , gender    = Female
    , traits    = [Humanoid, Divine, Riding, EnumaElish]
    , deck      = Deck Quick Arts Arts Buster Buster
    , hits      = { quick = 3, arts = 3, buster = 3, ex = 4 }
    , skills    = [ { name   = "Divine Power"
                    , rank   = B
                    , icon   = Icon.BusterUp
                    , cd     = 7
                    , effect = [ Grant Self 1 (CardUp Buster) <| Range 20 40
                               , Grant Self 1 StarUp <| Range 30 50
                               ]
                    }
                  , { name   = "Mystic Eyes"
                    , rank   = BPlus
                    , icon   = Icon.Heart
                    , cd     = 8
                    , effect = [ Debuff (EnemyType Male) 1 Stun <| Range 50 100
                               , Debuff Enemy 1 AttackDown <| Range 10 20
                               ]
                    }
                  , { name   = "Blessings of Talent"
                    , rank   = C
                    , icon   = Icon.NobleTurn
                    , cd     = 8
                    , effect = [ Grant Self 5 GaugePerTurn <| Range 5 10
                               , Grant Self 3 SureHit Full
                               , Grant Self 3 NPUp <| Flat 20
                               ]
                    }
                  ]
    , passives  = [magicResistance A, riding B, divinity A]
    , phantasm  = { name   = "Tenkiame"
                  , desc   = "Heavenly Demon Rain"
                  , rank   = BPlus
                  , card   = Buster
                  , kind   = "Anti-Army"
                  , hits   = 10
                  , effect = [ To Enemies Damage <| Range 300 500 ]
                  , over   = [ Grant Self 3 CritUp <| Range 40 80 ]
                  , first  = False
                  }
    , limited   = False
    , free      = False
    , ascendUp  = Ascension
                  [(Piece Saber, 4)]
                  [(Piece Saber, 10), (EvilBone, 18)]
                  [(Monument Saber, 4), (SeedOfYggdrasil, 10), (PhoenixFeather, 4)]
                  [(Monument Saber, 10), (PhoenixFeather, 7), (ScarabOfWisdom, 4)]
    , skillUp   = Reinforcement
                  [(GemOf Saber, 4)]
                  [(GemOf Saber, 10)]
                  [(MagicGemOf Saber, 4)]
                  [(MagicGemOf Saber, 10), (SeedOfYggdrasil, 5)]
                  [(SecretGemOf Saber, 4), (SeedOfYggdrasil, 10)]
                  [(SecretGemOf Saber, 10), (EvilBone, 12)]
                  [(EvilBone, 24), (ShellOfReminiscence, 5)]
                  [(ShellOfReminiscence, 15), (SpiritRoot, 8)]
    }
  , { name      = "Frankenstein (Saber)"
    , spoiler   = Nothing
    , id        = 176
    , rarity    = 4
    , class     = Saber
    , stats     = { base  = { atk = 1558,  hp = 1919 }
                  , max   = { atk = 9353,  hp = 11993 }
                  , grail = { atk = 11325, hp = 14541 }
                  }
    , gen       = { starWeight = 102, starRate = 9.9, npAtk = 0.7, npDef = 3 }
    , death     = 31.5
    , curve     = 4
    , attr      = Earth
    , align     = [Neutral, Summer]
    , gender    = Female
    , traits    = [Humanoid, EnumaElish]
    , deck      = Deck Quick Quick Arts Buster Buster
    , hits      = { quick = 3, arts = 4, buster = 5, ex = 5 }
    , skills    = [ { name   = "Summer Galvanism"
                    , rank   = BPlus
                    , icon   = Icon.NobleUp
                    , cd     = 7
                    , effect = [ Grant Self 3 NPGen <| Range 40 80
                               , To Self GaugeSpend <| Flat 10
                               ]
                    }
                  , { name   = "Lamenting the Summer Heat"
                    , rank   = A
                    , icon   = Icon.SwordDown
                    , cd     = 7
                    , effect = [ To Enemy RemoveBuffs Full
                               , Debuff Enemy 3 AttackDown <| Range 10 20
                               , To Self HealthSpend <| Flat 500
                               ]
                    }
                  , { name   = "Barely Loads"
                    , rank   = C
                    , icon   = Icon.SwordUp
                    , cd     = 7
                    , effect = [ Grant Self 3 AttackUp <| Range 10 20
                               , Grant Self 3 NPUp <| Range 10 20
                               , Debuff Self 5 Burn <| Flat 200
                               ]
                    }
                  ]
    , passives  = [magicResistance E, riding EX, madness E]
    , phantasm  = { name   = "Skewered Plasma Blade"
                  , desc   = "Skewering Thunder Blade"
                  , rank   = B
                  , card   = Quick
                  , kind   = "Anti-Personnel"
                  , hits   = 5
                  , effect = [ To Enemy Damage <| Range 1200 200
                             , After 1 << Chance 20 <| Debuff Enemies 1 Stun Full
                             ]
                  , over   = [ Chances 60 100 <| Debuff Enemy 1 Stun Full ]
                  , first  = False
                  }
    , limited   = True
    , free      = False
    , ascendUp  = Ascension 
                  [(Piece Saber, 4)]
                  [(Piece Saber, 10), (ShellOfReminiscence, 6)]
                  [(Monument Saber, 4), (BlackBeastGrease, 5), (OctupletCrystals, 4)]
                  [(Monument Saber, 10), (OctupletCrystals, 8), (EternalGear, 10)]
    , skillUp   = Reinforcement
                  [(GemOf Saber, 4)]
                  [(GemOf Saber, 10)]
                  [(MagicGemOf Saber, 4)]
                  [(MagicGemOf Saber, 10), (BlackBeastGrease, 3)]
                  [(SecretGemOf Saber, 4), (BlackBeastGrease, 5)]
                  [(SecretGemOf Saber, 10), (ShellOfReminiscence, 4)]
                  [(ShellOfReminiscence, 8), (HomunculusBaby, 5)]
                  [(HomunculusBaby, 15), (MysticSpinalFluid, 60)]
    }
  , { name      = "Yagyu Munenori"
    , spoiler   = Nothing
    , id        = 187
    , rarity    = 4
    , class     = Saber
    , stats     = { base  = { atk = 1666,  hp = 1781 }
                  , max   = { atk = 9999,  hp = 11135 }
                  , grail = { atk = 12107, hp = 13501 }
                  }
    , gen       = { starWeight = 100, starRate = 10.3, npAtk = 0.81, npDef = 3 }
    , death     = 35
    , curve     = 4
    , attr      = Man
    , align     = [Lawful, Balanced]
    , gender    = Male
    , traits    = [Humanoid, EnumaElish]
    , deck      = Deck Quick Arts Arts Buster Buster
    , hits      = { quick = 4, arts = 2, buster = 1, ex = 4 }
    , skills    = [ { name   = "Shinkage-ryu"
                    , rank   = APlusPlus
                    , icon   = Icon.ArtsUp
                    , cd     = 7
                    , effect = [ Grant Self 1 (CardUp Arts) <| Range 30 50
                               , Grant Self 1 (CardGather Arts) <| Range 300 500
                               , Grant Self 1 DebuffResist <| Flat 100
                               ]
                    }
                  , { name   = "Suigetsu"
                    , rank   = B
                    , icon   = Icon.Dodge
                    , cd     = 8
                    , effect = [ Grant Self 1 AttackUp <| Range 10 20
                               , Grant Self 1 Evasion Full
                               ]
                    }
                  , { name   = "Bladeless State"
                    , rank   = A
                    , icon   = Icon.SwordDown
                    , cd     = 7
                    , effect = [ Debuff Enemy 1 AttackDown <| Range 30 50
                               , Grant Self 1 NPGen <| Range 30 50
                               ]
                    }
                  ]
    , passives  = [magicResistance C, riding B]
    , phantasm  = { name   = "Kenjutsu Musou - Kenzen Ichinyo"
                  , desc   = "Peerless Swordsmanship - Zen and the Blade as One"
                  , rank   = A
                  , card   = Arts
                  , kind   = "Anti-Personnel Ultimate Secret Technique"
                  , hits   = 4
                  , effect = [ To Enemy Damage <| Range 900 1500 ]
                  , over   = [ Debuff Enemy 3 AttackDown <| Range 20 60 ]
                  , first  = False
                  }
    , limited   = False
    , free      = False
    , ascendUp  = Ascension
                  [(Piece Saber, 4)]
                  [(Piece Saber, 10), (VoidsDust, 12)]
                  [(Monument Saber, 4), (ProofOfHero, 24), (PrimordialLanugo, 3)]
                  [(Monument Saber, 10), (PrimordialLanugo, 5), (RefinedMagatama, 10)]
    , skillUp   = Reinforcement
                  [(GemOf Saber, 4)]
                  [(GemOf Saber, 10)]
                  [(MagicGemOf Saber, 4)]
                  [(MagicGemOf Saber, 10), (ProofOfHero, 12)]
                  [(SecretGemOf Saber, 4), (ProofOfHero, 24)]
                  [(SecretGemOf Saber, 10), (VoidsDust, 8)]
                  [(VoidsDust, 16), (OctupletCrystals, 5)]
                  [(OctupletCrystals, 15), (MysteriousDivineWine, 8)]
    }
  ]
