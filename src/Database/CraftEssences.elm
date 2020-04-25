module Database.CraftEssences exposing
  ( db
  , getBond
  , getAll
  )

{-| All Craft Essences. -}
-- Unlike Servants, which are divided into multiple subfiles,
-- Craft Essences are all included in this one file
-- along with their data model definition.

import Dict exposing (Dict)
import Maybe.Extra as Maybe

import Class.Has exposing (Has)
import Model.Icon as Icon
import Model.Card exposing (Card(..))
import Model.Class as Class exposing (Class(..))
import Model.CraftEssence exposing (CraftEssence)
import Model.Trait exposing (Trait(..))
import Model.Servant exposing (Servant)
import Model.Skill.Amount exposing (Amount(..))
import Model.Skill.BonusEffect exposing (BonusEffect(..), BonusType(..))
import Model.Skill.BuffEffect exposing (BuffEffect(..))
import Model.Skill.DebuffEffect exposing (DebuffEffect(..))
import Model.Skill.InstantEffect exposing (InstantEffect(..))
import Model.Skill.SkillEffect exposing (SkillEffect(..))
import Model.Skill.Special exposing (Special(..))
import Model.Skill.Target exposing (Target(..))

import Database


getAll : Has CraftEssence a -> List a
getAll =
    Database.genericGetAll db


{-| All Craft Essences available in EN. -}
-- Note: Names _must_ be true to their EN localization.
-- GrandOrder.Wiki is only trustworthy for CEs that have been in the game
-- for a while. Craft Essences introduced during events and the like should be
-- checked against the official announcement.
db : List CraftEssence
db =
    let
        gutsPercent =
            Times 1 <<
            Grant Self 0 GutsPercent <<
            Flat

        self buff =
            Grant Self 0 buff <<
            Flat

        party buff =
            Grant Party 0 buff <<
            Flat

        party_ card =
            party (CardUp card)

        demeritAll debuff =
            Debuff Party 0 debuff <<
            Flat

        demeritOthers debuff =
            Debuff Others 0 debuff <<
            Flat

        atkChance chance =
            When "attacking" <<
            Chance chance

        bond id name servant icon effect =
            { name     = name
            , id       = id
            , rarity   = 4
            , icon     = icon
            , stats    = { base = { atk = 100, hp = 100 }
                         , max  = { atk = 100, hp = 100 }
                         }
            , effect  = effect
            , bond    = Just servant
            , limited = False
            }

        gift id name icon effect =
            { name     = name
            , id       = id
            , rarity   = 4
            , icon     = icon
            , stats    = { base = { atk = 100, hp = 100 }
                         , max  = { atk = 100, hp = 100 }
                         }
            , effect  = effect
            , bond    = Nothing
            , limited = True
            }
    in
    [ { name    = "Tenacity"
      , id      = 1
      , rarity  = 1
      , icon    = Icon.ShieldUp
      , stats   = { base = { atk = 0, hp = 100 }
                  , max  = { atk = 0, hp = 300 }
                  }
      , effect  = [ Grant Self 0 DefenseUp <| Range 3 5 ]
      , bond    = Nothing
      , limited = False
      }
    , { name    = "Meditation"
      , id      = 2
      , rarity  = 1
      , icon    = Icon.HoodUp
      , stats   = { base = { atk = 0, hp = 150 }
                  , max  = { atk = 0, hp = 450 }
                  }
      , effect  = [ Grant Self 0 DebuffResist <| Range 5 10 ]
      , bond    = Nothing
      , limited = False
      }
    , { name    = "Technique"
      , id      = 3
      , rarity  = 1
      , icon    = Icon.ArtsUp
      , stats   = { base = { atk = 100, hp = 0 }
                  , max  = { atk = 300, hp = 0 }
                  }
      , effect  = [ Grant Self 0 (CardUp Arts) <| Range 3 5 ]
      , bond    = Nothing
      , limited = False
      }
    , { name    = "Preemption"
      , id      = 4
      , rarity  = 1
      , icon    = Icon.QuickUp
      , stats   = { base = { atk = 100, hp = 0 }
                  , max  = { atk = 300, hp = 0 }
                  }
      , effect  = [Grant Self 0 (CardUp Quick) <| Range 3 5]
      , bond    = Nothing
      , limited = False
      }
    , { name    = "Destruction"
      , id      = 5
      , rarity  = 1
      , icon    = Icon.BusterUp
      , stats   = { base = { atk = 100, hp = 0 }
                  , max  = { atk = 300, hp = 0 }
                  }
      , effect  = [ Grant Self 0 (CardUp Buster) <| Range 3 5 ]
      , bond    = Nothing
      , limited = False
      }
    , { name    = "Flash"
      , id      = 6
      , rarity  = 2
      , icon    = Icon.ExclamationUp
      , stats   = { base = { atk = 150, hp = 0 }
                  , max  = { atk = 500, hp = 0 }
                  }
      , effect  = [ Grant Self 0 CritUp <| Range 5 10 ]
      , bond    = Nothing
      , limited = False
      }
    , { name    = "Opportunity"
      , id      = 7
      , rarity  = 2
      , icon    = Icon.StarHaloUp
      , stats   = { base = { atk = 75,  hp = 112 }
                  , max  = { atk = 250, hp = 375 }
                  }
      , effect  = [ Grant Self 0 StarUp <| Range 5 10 ]
      , bond    = Nothing
      , limited = False
      }
    , { name    = "Fruitful"
      , id      = 8
      , rarity  = 2
      , icon    = Icon.Noble
      , stats   = { base = { atk = 75,  hp = 112 }
                  , max  = { atk = 250, hp = 375 }
                  }
      , effect  = [ To Self GaugeUp <| Range 10 20 ]
      , bond    = Nothing
      , limited = False
      }
    , { name    = "Concentration"
      , id      = 9
      , rarity  = 2
      , icon    = Icon.NobleUp
      , stats   = { base = { atk = 75,  hp = 112 }
                  , max  = { atk = 250, hp = 375 }
                  }
      , effect  = [ Grant Self 0 NPGen <| Range 5 10 ]
      , bond    = Nothing
      , limited = False
      }
    , { name    = "Divine Oracle"
      , id      = 10
      , rarity  = 2
      , icon    = Icon.BeamUp
      , stats   = { base = { atk = 150, hp = 0 }
                  , max  = { atk = 500, hp = 0 }
                  }
      , effect  = [ Grant Self 0 NPUp <| Range 5 10 ]
      , bond    = Nothing
      , limited = False
      }
    , { name    = "Azoth Blade"
      , id      = 11
      , rarity  = 3
      , icon    = Icon.ShieldUp
      , stats   = { base = { atk = 0, hp = 200 }
                  , max  = { atk = 0, hp = 1000 }
                  }
      , effect  = [ Grant Self 0 DefenseUp <| Range 8 10 ]
      , bond    = Nothing
      , limited = False
      }
    , { name    = "False Attendant's Writings"
      , id      = 12
      , rarity  = 3
      , icon    = Icon.HoodUp
      , stats   = { base = { atk = 0, hp = 300 }
                  , max  = { atk = 0, hp = 1500 }
                  }
      , effect  = [ Grant Self 0 DebuffResist <| Range 15 20 ]
      , bond    = Nothing
      , limited = False
      }
    , { name    = "The Azure Black Keys"
      , id      = 13
      , rarity  = 3
      , icon    = Icon.ArtsUp
      , stats   = { base = { atk = 200, hp = 0 }
                  , max  = { atk = 1000, hp = 0 }
                  }
      , effect  = [ Grant Self 0 (CardUp Arts) <| Range 8 10 ]
      , bond    = Nothing
      , limited = False
      }
    , { name    = "The Verdant Black Keys"
      , id      = 14
      , rarity  = 3
      , icon    = Icon.QuickUp
      , stats   = { base = { atk = 200,  hp = 0 }
                  , max  = { atk = 1000, hp = 0 }
                  }
      , effect  = [ Grant Self 0 (CardUp Quick) <| Range 8 10 ]
      , bond    = Nothing
      , limited = False
      }
    , { name    = "The Crimson Black Keys"
      , id      = 15
      , rarity  = 3
      , icon    = Icon.BusterUp
      , stats   = { base = { atk = 200,  hp = 0 }
                  , max  = { atk = 1000, hp = 0 }
                  }
      , effect  = [ Grant Self 0 (CardUp Buster) <| Range 8 10 ]
      , bond    = Nothing
      , limited = False
      }
    , { name    = "Rin's Pendant"
      , id      = 16
      , rarity  = 3
      , icon    = Icon.ExclamationUp
      , stats   = { base = { atk = 200,  hp = 0 }
                  , max  = { atk = 1000, hp = 0 }
                  }
      , effect  = [ Grant Self 0 CritUp <| Range 15 20 ]
      , bond    = Nothing
      , limited = False
      }
    , { name    = "Spell Tome"
      , id      = 17
      , rarity  = 3
      , icon    = Icon.StarHaloUp
      , stats   = { base = { atk = 100, hp = 150 }
                  , max  = { atk = 500, hp = 750 }
                  }
      , effect  = [ Grant Self 0 StarUp <| Range 15 20 ]
      , bond    = Nothing
      , limited = False
      }
    , { name    = "Dragon's Meridian"
      , id      = 18
      , rarity  = 3
      , icon    = Icon.Noble
      , stats   = { base = { atk = 100, hp = 150 }
                  , max  = { atk = 500, hp = 750 }
                  }
      , effect  = [ To Self GaugeUp <| Range 30 50 ]
      , bond    = Nothing
      , limited = False
      }
    , { name    = "Sorcery Ore"
      , id      = 19
      , rarity  = 3
      , icon    = Icon.NobleUp
      , stats   = { base = { atk = 100, hp = 150 }
                  , max  = { atk = 500, hp = 750 }
                  }
      , effect  = [ Grant Self 0 NPGen <| Range 15 20 ]
      , bond    = Nothing
      , limited = False
      }
    , { name    = "Dragonkin"
      , id      = 20
      , rarity  = 3
      , icon    = Icon.BeamUp
      , stats   = { base = { atk = 200,  hp = 0 }
                  , max  = { atk = 1000, hp = 0 }
                  }
      , effect  = [ Grant Self 0 NPUp <| Range 15 20 ]
      , bond    = Nothing
      , limited = False
      }
    , { name    = "Iron-Willed Training"
      , id      = 21
      , rarity  = 4
      , icon    = Icon.ShieldUp
      , stats   = { base = { atk = 0, hp = 400 }
                  , max  = { atk = 0, hp = 1500 }
                  }
      , effect  = [ Grant Self 0 DefenseUp <| Range 15 20 ]
      , bond    = Nothing
      , limited = False
      }
    , { name    = "Primeval Curse"
      , id      = 22
      , rarity  = 4
      , icon    = Icon.HoodUp
      , stats   = { base = { atk = 0, hp = 600 }
                  , max  = { atk = 0, hp = 2250 }
                  }
      , effect  = [ Grant Self 0 DebuffResist <| Range 25 30 ]
      , bond    = Nothing
      , limited = False
      }
    , { name    = "Projection"
      , id      = 23
      , rarity  = 4
      , icon    = Icon.ArtsUp
      , stats   = { base = { atk = 400, hp = 0 }
                  , max  = { atk = 1500, hp = 0 }
                  }
      , effect  = [ Grant Self 0 (CardUp Arts) <| Range 15 20 ]
      , bond    = Nothing
      , limited = False
      }
    , { name    = "Gandr"
      , id      = 24
      , rarity  = 4
      , icon    = Icon.QuickUp
      , stats   = { base = { atk = 400, hp = 0 }
                  , max  = { atk = 1500, hp = 0 }
                  }
      , effect  = [ Grant Self 0 (CardUp Quick) <| Range 15 20 ]
      , bond    = Nothing
      , limited = False
      }
    , { name    = "Verdant Sound of Destruction"
      , id      = 25
      , rarity  = 4
      , icon    = Icon.BusterUp
      , stats   = { base = { atk = 400,  hp = 0 }
                  , max  = { atk = 1500, hp = 0 }
                  }
      , effect  = [ Grant Self 0 (CardUp Buster) <| Range 15 20 ]
      , bond    = Nothing
      , limited = False
      }
    , { name    = "Gem Magecraft: Antumbra"
      , id      = 26
      , rarity  = 4
      , icon    = Icon.ExclamationUp
      , stats   = { base = { atk = 400,  hp = 0 }
                  , max  = { atk = 1500, hp = 0 }
                  }
      , effect  = [ Grant Self 0 CritUp <| Range 25 30 ]
      , bond    = Nothing
      , limited = False
      }
    , { name    = "Be Elegant"
      , id      = 27
      , rarity  = 4
      , icon    = Icon.StarHaloUp
      , stats   = { base = { atk = 200, hp = 300 }
                  , max  = { atk = 750, hp = 1125 }
                  }
      , effect  = [ Grant Self 0 StarUp <| Range 25 30 ]
      , bond    = Nothing
      , limited = False
      }
    , { name    = "The Imaginary Element"
      , id      = 28
      , rarity  = 4
      , icon    = Icon.Noble
      , stats   = { base = { atk = 200, hp = 300 }
                  , max  = { atk = 750, hp = 1125 }
                  }
      , effect  = [ To Self GaugeUp <| Range 60 75 ]
      , bond    = Nothing
      , limited = False
      }
    , { name    = "Divine Banquet"
      , id      = 29
      , rarity  = 4
      , icon    = Icon.NobleUp
      , stats   = { base = { atk = 200, hp = 300 }
                  , max  = { atk = 750, hp = 1125 }
                  }
      , effect  = [ Grant Self 0 NPGen <| Range 25 30 ]
      , bond    = Nothing
      , limited = False
      }
    , { name    = "Angel's Song"
      , id      = 30
      , rarity  = 4
      , icon    = Icon.BeamUp
      , stats   = { base = { atk = 400,  hp = 0 }
                  , max  = { atk = 1500, hp = 0 }
                  }
      , effect  = [ Grant Self 0 NPUp <| Range 25 30 ]
      , bond    = Nothing
      , limited = False
      }
    , { name    = "Formal Craft"
      , id      = 31
      , rarity  = 5
      , icon    = Icon.ArtsUp
      , stats   = { base = { atk = 500,  hp = 0 }
                  , max  = { atk = 2000, hp = 0 }
                  }
      , effect  = [ Grant Self 0 (CardUp Arts) <| Range 25 30 ]
      , bond    = Nothing
      , limited = False
      }
    , { name    = "Imaginary Around"
      , id      = 32
      , rarity  = 5
      , icon    = Icon.QuickUp
      , stats   = { base = { atk = 500,  hp = 0 }
                  , max  = { atk = 2000, hp = 0 }
                  }
      , effect  = [ Grant Self 0 (CardUp Quick) <| Range 25 30 ]
      , bond    = Nothing
      , limited = False
      }
    , { name    = "Limited/Zero Over"
      , id      = 33
      , rarity  = 5
      , icon    = Icon.BusterUp
      , stats   = { base = { atk = 500,  hp = 0 }
                  , max  = { atk = 2000, hp = 0 }
                  }
      , effect  = [ Grant Self 0 (CardUp Buster) <| Range 25 30 ]
      , bond    = Nothing
      , limited = False
      }
    , { name    = "Kaleidoscope"
      , id      = 34
      , rarity  = 5
      , icon    = Icon.Noble
      , stats   = { base = { atk = 500,  hp = 0 }
                  , max  = { atk = 2000, hp = 0 }
                  }
      , effect  = [ To Self GaugeUp <| Range 80 100 ]
      , bond    = Nothing
      , limited = False
      }
    , { name    = "Heaven's Feel"
      , id      = 35
      , rarity  = 5
      , icon    = Icon.BeamUp
      , stats   = { base = { atk = 500,  hp = 0 }
                  , max  = { atk = 2000, hp = 0 }
                  }
      , effect  = [ Grant Self 0 NPUp <| Range 40 50 ]
      , bond    = Nothing
      , limited = False
      }
    , { name    = "Beginning of the Journey"
      , id      = 36
      , rarity  = 4
      , icon    = Icon.Road
      , stats   = { base = { atk = 50,  hp = 50 }
                  , max  = { atk = 50, hp = 50 }
                  }
      , effect  = [ Bonus FriendPoints Units <| Flat 75 ]
      , bond    = Nothing
      , limited = True
      }
    , { name    = "Parted Sea"
      , id      = 37
      , rarity  = 3
      , icon    = Icon.Dodge
      , stats   = { base = { atk = 0, hp = 300 }
                  , max  = { atk = 0, hp = 1500 }
                  }
      , effect  = [ Times 1 <| Grant Self 0 Evasion Full
                  , Grant Self 0 DebuffResist <| Range 5 10
                  ]
      , bond    = Nothing
      , limited = False
      }
    , { name    = "Seal Designation Enforcer"
      , id      = 38
      , rarity  = 4
      , icon    = Icon.StarUp
      , stats   = { base = { atk = 400,  hp = 0 }
                  , max  = { atk = 1500, hp = 0 }
                  }
      , effect  = [ Grant Self 0 GatherUp <| Range 600 800 ]
      , bond    = Nothing
      , limited = False
      }
    , { name    = "Holy Shroud of Magdalene"
      , id      = 39
      , rarity  = 4
      , icon    = Icon.ShieldUp
      , stats   = { base = { atk = 0, hp = 400 }
                  , max  = { atk = 0, hp = 1500 }
                  }
      , effect  = [ Grant Self 0 (Special DefenseUp <| VsTrait Male) <| Range 25 35 ]
      , bond    = Nothing
      , limited = False
      }
    , { name    = "Prisma Cosmos"
      , id      = 40
      , rarity  = 5
      , icon    = Icon.NobleTurn
      , stats   = { base = { atk = 250,  hp = 375 }
                  , max  = { atk = 1000, hp = 1500 }
                  }
      , effect  = [ Grant Self 0 GaugePerTurn <| Range 8 10 ]
      , bond    = Nothing
      , limited = False
      }
    , { name    = "Nightless Rose"
      , id      = 41
      , rarity  = 5
      , icon    = Icon.Kneel
      , stats   = { base = { atk = 0, hp = 500 }
                  , max  = { atk = 0, hp = 2000 }
                  }
      , effect  = [ Times 1 << Grant Self 0 Guts <| Range 500 1000 ]
      , bond    = Nothing
      , limited = True
      }
    , { name    = "Mooncell Automaton"
      , id      = 42
      , rarity  = 3
      , icon    = Icon.AllUp
      , stats   = { base = { atk = 200,  hp = 0 }
                  , max  = { atk = 1000, hp = 0 }
                  }
      , effect  = [ Grant Self 0 (CardUp Arts) <| Range 3 5
                  , Grant Self 0 (CardUp Buster) <| Range 3 5
                  , Grant Self 0 (CardUp Quick) <| Range 3 5
                  ]
      , bond    = Nothing
      , limited = False
      }
    , { name    = "Moony Jewel"
      , id      = 43
      , rarity  = 4
      , icon    = Icon.HoodUp
      , stats   = { base = { atk = 0, hp = 600 }
                  , max  = { atk = 0, hp = 2250 }
                  }
      , effect  = [ Grant Self 0 (Resist Charm) <| Range 80 100 ]
      , bond    = Nothing
      , limited = True
      }
    , { name    = "Moon Goddess' Bath"
      , id      = 44
      , rarity  = 5
      , icon    = Icon.HealTurn
      , stats   = { base = { atk = 0, hp = 500 }
                  , max  = { atk = 0, hp = 2000 }
                  }
      , effect  = [ Grant Self 0 HealPerTurn <| Range 500 750 ]
      , bond    = Nothing
      , limited = True
      }
    , { name    = "Moonlight Fest"
      , id      = 45
      , rarity  = 5
      , icon    = Icon.StarHaloUp
      , stats   = { base = { atk = 250,  hp = 375 }
                  , max  = { atk = 1000, hp = 1500 }
                  }
      , effect  = [ Grant Self 0 StarUp <| Range 15 20
                  , Grant Self 0 CritUp <| Range 15 20
                  ]
      , bond    = Nothing
      , limited = True
      }
    , { name    = "Runestone"
      , id      = 46
      , rarity  = 3
      , icon    = Icon.HoodUp
      , stats   = { base = { atk = 100, hp = 150 }
                  , max  = { atk = 500, hp = 750 }
                  }
      , effect  = [ Grant Self 0 DebuffResist <| Range 5 10
                  , Grant Self 0 GatherUp <| Range 100 200
                  ]
      , bond    = Nothing
      , limited = False
      }
    , { name    = "With One Strike"
      , id      = 47
      , rarity  = 4
      , icon    = Icon.Bullseye
      , stats   = { base = { atk = 400,  hp = 0 }
                  , max  = { atk = 1500, hp = 0 }
                  }
      , effect  = [ Grant Self 0 SureHit Full
                  , Grant Self 0 (CardUp Quick) <| Range 8 10
                  ]
      , bond    = Nothing
      , limited = False
      }
    , { name    = "The Black Grail"
      , id      = 48
      , rarity  = 5
      , icon    = Icon.BeamUp
      , stats   = { base = { atk = 600,  hp = 0 }
                  , max  = { atk = 2400, hp = 0 }
                  }
      , effect  = [ Grant Self 0 NPUp <| Range 60 80
                  , Debuff Self 0 HealthLoss <| Flat 500
                  ]
      , bond    = Nothing
      , limited = False
      }
    , { name    = "Jack-o'-lantern"
      , id      = 49
      , rarity  = 3
      , icon    = Icon.DamageUp
      , stats   = { base = { atk = 200,  hp = 0 }
                  , max  = { atk = 1000, hp = 0 }
                  }
      , effect  = [ Grant Self 0 DamageUp <| Range 100 200 ]
      , bond    = Nothing
      , limited = True
      }
    , { name    = "Trick or Treat"
      , id      = 50
      , rarity  = 3
      , icon    = Icon.StaffUp
      , stats   = { base = { atk = 100, hp = 150 }
                  , max  = { atk = 500, hp = 750 }
                  }
      , effect  = [ Grant Self 0 DebuffUp <| Range 10 12 ]
      , bond    = Nothing
      , limited = True
      }
    , { name    = "Halloween Arrangement"
      , id      = 51
      , rarity  = 4
      , icon    = Icon.CrosshairUp
      , stats   = { base = { atk = 0, hp = 600 }
                  , max  = { atk = 0, hp = 2250 }
                  }
      , effect  = [ Grant Self 1 Taunt Full
                  , Grant Self 1 DefenseUp <| Range 60 80
                  ]
      , bond    = Nothing
      , limited = True
      }
    , { name    = "Halloween Princess"
      , id      = 52
      , rarity  = 5
      , icon    = Icon.BeamUp
      , stats   = { base = { atk = 250,  hp = 375 }
                  , max  = { atk = 1000, hp = 1500 }
                  }
      , effect  = [ Grant Self 0 NPUp <| Range 15 20
                  , To Self GaugeUp <| Range 30 50
                  ]
      , bond    = Nothing
      , limited = True
      }
    , { name    = "Little Halloween Devil"
      , id      = 53
      , rarity  = 5
      , icon    = Icon.NobleUp
      , stats   = { base = { atk = 500,  hp = 0 }
                  , max  = { atk = 2000, hp = 0 }
                  }
      , effect  = [ Grant Self 0 NPGen <| Range 20 25
                  , To Self GaugeUp <| Range 50 60
                  ]
      , bond    = Nothing
      , limited = True
      }
    , { name    = "Maid in Halloween"
      , id      = 54
      , rarity  = 5
      , icon    = Icon.HealUp
      , stats   = { base = { atk = 0, hp = 750 }
                  , max  = { atk = 0, hp = 3000 }
                  }
      , effect  = [ Grant Self 0 HealingReceived <| Range 60 75 ]
      , bond    = Nothing
      , limited = True
      }
    , { name    = "Anchors Aweigh"
      , id      = 55
      , rarity  = 3
      , icon    = Icon.HealTurn
      , stats   = { base = { atk = 300,  hp = 0 }
                  , max  = { atk = 1500, hp = 0 }
                  }
      , effect  = [ Grant Self 0 HealPerTurn <| Range 100 200 ]
      , bond    = Nothing
      , limited = False
      }
    , { name    = "Code Cast"
      , id      = 56
      , rarity  = 4
      , icon    = Icon.SwordShieldUp
      , stats   = { base = { atk = 200, hp = 300 }
                  , max  = { atk = 750, hp = 1125 }
                  }
      , effect  = [ Grant Self 3 AttackUp <| Range 25 30
                  , Grant Self 3 DefenseUp <| Range 25 30
                  ]
      , bond    = Nothing
      , limited = False
      }
    , { name    = "Victor of the Moon"
      , id      = 57
      , rarity  = 5
      , icon    = Icon.BusterUp
      , stats   = { base = { atk = 600,  hp = 0 }
                  , max  = { atk = 2400, hp = 0 }
                  }
      , effect  = [ Grant Self 0 (CardUp Buster) <| Range 10 15
                  , Grant Self 0 CritUp <| Range 20 25
                  ]
      , bond    = Nothing
      , limited = False
      }
    , { name    = "Another Ending"
      , id      = 58
      , rarity  = 5
      , icon    = Icon.ArtsUp
      , stats   = { base = { atk = 600,  hp = 0 }
                  , max  = { atk = 2400, hp = 0 }
                  }
      , effect  = [ Grant Self 0 (CardUp Arts) <| Range 10 15
                  , Grant Self 0 CritUp <| Range 20 25
                  ]
      , bond    = Nothing
      , limited = False
      }
    , { name    = "Fate GUDAGUDA Order"
      , id      = 59
      , rarity  = 3
      , icon    = Icon.AllUp
      , stats   = { base = { atk = 100, hp = 150 }
                  , max  = { atk = 500, hp = 750 }
                  }
      , effect  = [ Grant Self 0 (CardUp Quick) <| Range 1 2
                  , Grant Self 0 (CardUp Arts) <| Range 1 2
                  , Grant Self 0 (CardUp Buster) <| Range 1 2
                  , Grant Self 0 StarUp <| Range 1 2
                  , Grant Self 0 GatherUp <| Range 1 2
                  , Grant Self 0 NPGen <| Range 1 2
                  , Grant Self 0 NPUp <| Range 1 2
                  , Grant Self 0 DebuffUp <| Range 1 2
                  , Grant Self 0 DebuffResist <| Range 1 2
                  ]
      , bond    = Nothing
      , limited = True
      }
    , { name    = "After-Party Order!"
      , id      = 60
      , rarity  = 4
      , icon    = Icon.QuickBusterUp
      , stats   = { base = { atk = 400,  hp = 0 }
                  , max  = { atk = 1500, hp = 0 }
                  }
      , effect  = [ Grant Self 0 (CardUp Quick) <| Range 10 15
                  , Grant Self 0 (CardUp Buster) <| Range 10 15
                  ]
      , bond    = Nothing
      , limited = True
      }
    , { name    = "Guda-o"
      , id      = 61
      , rarity  = 5
      , icon    = Icon.DamageUp
      , stats   = { base = { atk = 500,  hp = 0 }
                  , max  = { atk = 2000, hp = 0 }
                  }
      , effect  = [ Grant Self 0 CritUp <| Range 15 20
                  , Grant Self 0 NPUp <| Range 15 20
                  ]
      , bond    = Nothing
      , limited = True
      }
    , { name    = "GUDAGUDA Poster Girl"
      , id      = 62
      , rarity  = 5
      , icon    = Icon.CrosshairUp
      , stats   = { base = { atk = 0, hp = 750 }
                  , max  = { atk = 0, hp = 3000 }
                  }
      , effect  = [ Grant Self 3 Taunt Full
                  , Grant Self 3 AttackUp <| Range 60 80
                  ]
      , bond    = Nothing
      , limited = True
      }
    , { name    = "Demon Boar"
      , id      = 65
      , rarity  = 3
      , icon    = Icon.QuickUp
      , stats   = { base = { atk = 200,  hp = 0 }
                  , max  = { atk = 1000, hp = 0 }
                  }
      , effect  = [ Grant Self 0 (CardUp Quick) <| Range 15 20 ]
      , bond    = Nothing
      , limited = False
      }
    , { name    = "Knight's Dignity"
      , id      = 66
      , rarity  = 4
      , icon    = Icon.ExclamationUp
      , stats   = { base = { atk = 200, hp = 300 }
                  , max  = { atk = 750, hp = 1125 }
                  }
      , effect  = [ Grant Self 0 CritUp <| Range 40 50
                  , Debuff Self 0 DefenseDown <| Flat 20
                  ]
      , bond    = Nothing
      , limited = False
      }
    , { name    = "A Fragment of 2030"
      , id      = 67
      , rarity  = 5
      , icon    = Icon.StarTurn
      , stats   = { base = { atk = 0, hp = 750 }
                  , max  = { atk = 0, hp = 3000 }
                  }
      , effect  = [ Grant Self 0 StarsPerTurn <| Range 8 10 ]
      , bond    = Nothing
      , limited = False
      }
    , { name    = "Lightning Reindeer"
      , id      = 68
      , rarity  = 3
      , icon    = Icon.BusterUp
      , stats   = { base = { atk = 200,  hp = 0 }
                  , max  = { atk = 1000, hp = 0 }
                  }
      , effect  = [ Grant Self 3 (CardUp Buster) <| Range 15 20 ]
      , bond    = Nothing
      , limited = True
      }
    , { name    = "March of the Saint"
      , id      = 69
      , rarity  = 4
      , icon    = Icon.HealTurn
      , stats   = { base = { atk = 0, hp = 600 }
                  , max  = { atk = 0, hp = 2250 }
                  }
      , effect  = [ Grant Self 0 HealPerTurn <| Range 200 300
                  , Grant Self 0 GaugePerTurn <| Range 3 4
                  ]
      , bond    = Nothing
      , limited = True
      }
    , { name    = "Present For My Master"
      , id      = 70
      , rarity  = 5
      , icon    = Icon.StarUp
      , stats   = { base = { atk = 0, hp = 750 }
                  , max  = { atk = 0, hp = 3000 }
                  }
      , effect  = [ Grant Self 0 GatherUp <| Range 100 200
                  , Grant Self 0 HealingReceived <| Range 40 50
                  ]
      , bond    = Nothing
      , limited = True
      }
    , { name    = "Holy Night Sign"
      , id      = 71
      , rarity  = 5
      , icon    = Icon.QuickUp
      , stats   = { base = { atk = 250,  hp = 375 }
                  , max  = { atk = 1000, hp = 1500 }
                  }
      , effect  = [ Grant Self 0 (CardUp Quick) <| Range 8 10
                  , Grant Self 0 CritUp <| Range 15 20
                  ]
      , bond    = Nothing
      , limited = True
      }
    , { name    = "Clock Tower"
      , id      = 72
      , rarity  = 3
      , icon    = Icon.NobleTurn
      , stats   = { base = { atk = 0, hp = 300 }
                  , max  = { atk = 0, hp = 1500 }
                  }
      , effect  = [ Grant Self 0 GaugePerTurn <| Range 2 3 ]
      , bond    = Nothing
      , limited = False
      }
    , { name    = "Necromancy"
      , id      = 73
      , rarity  = 4
      , icon    = Icon.Kneel
      , stats   = { base = { atk = 0, hp = 600 }
                  , max  = { atk = 0, hp = 2400 }
                  }
      , effect  = [ Chance 50 << Times 1 << Grant Self 0 Guts <| Range 500 1000 ]
      , bond    = Nothing
      , limited = False
      }
    , { name    = "Awakened Will"
      , id      = 74
      , rarity  = 4
      , icon    = Icon.NobleTurn
      , stats   = { base = { atk = 200, hp = 300 }
                  , max  = { atk = 750, hp = 1125 }
                  }
      , effect  = [ Chance 60 << Grant Self 0 GaugePerTurn <| Range 12 15
                  , Debuff Self 0 HealthLoss <| Flat 500
                  ]
      , bond    = Nothing
      , limited = False
      }
    , { name    = "500-Year Obsession"
      , id      = 75
      , rarity  = 5
      , icon    = Icon.Circuits
      , stats   = { base = { atk = 600,  hp = 0 }
                  , max  = { atk = 2400, hp = 0 }
                  }
      , effect  = [ When "defeated by an enemy" <| Debuff Target 2 SealNP Full
                  , When "defeated by an enemy" <<
                    Debuff Target 10 Curse <| Range 1000 2000
                  ]
      , bond    = Nothing
      , limited = False
      }
    , { name    = "Peacefulness of 2018"
      , id      = 76
      , rarity  = 3
      , icon    = Icon.HealTurn
      , stats   = { base = { atk = 0, hp = 300 }
                  , max  = { atk = 0, hp = 1500 }
                  }
      , effect  = [ Grant Self 0 HealPerTurn <| Range 200 300
                  , Debuff Self 0 AttackDown <| Flat 10
                  ]
      , bond    = Nothing
      , limited = True
      }
    , { name    = "Heroic New Year"
      , id      = 77
      , rarity  = 4
      , icon    = Icon.HoodUp
      , stats   = { base = { atk = 200, hp = 320 }
                  , max  = { atk = 750, hp = 1200 }
                  }
      , effect  = [ Times 1 <| Grant Self 0 DebuffResist Full
                  , Grant Self 0 DefenseUp <| Range 8 10
                  ]
      , bond    = Nothing
      , limited = True
      }
    , { name    = "Law of the Jungle"
      , id      = 78
      , rarity  = 3
      , icon    = Icon.Crystal
      , stats   = { base = { atk = 200,  hp = 0 }
                  , max  = { atk = 1000, hp = 0 }
                  }
      , effect  = [ Bonus QPQuest Units <| Range 2017 2018 ]
      , bond    = Nothing
      , limited = True
      }
    , { name    = "Grand New Year"
      , id      = 79
      , rarity  = 5
      , icon    = Icon.Shield
      , stats   = { base = { atk = 0, hp = 750 }
                  , max  = { atk = 0, hp = 3000 }
                  }
      , effect  = [ Grant Self 1 Taunt Full
                  , Grant Self 1 Invincibility Full
                  , Grant Self 0 DebuffResist <| Range 10 20
                  ]
      , bond    = Nothing
      , limited = True
      }
    , { name    = "Mona Lisa"
      , id      = 80
      , rarity  = 5
      , icon    = Icon.Crystal
      , stats   = { base = { atk = 250,  hp = 400 }
                  , max  = { atk = 1000, hp = 1600 }
                  }
      , effect  = [ Bonus QPDrop Percent <| Range 2 10 ]
      , bond    = Nothing
      , limited = True
      }
    , { name    = "Happy x3 Order"
      , id      = 81
      , rarity  = 4
      , icon    = Icon.StarTurn
      , stats   = { base = { atk = 0, hp = 2018 }
                  , max  = { atk = 0, hp = 2018 }
                  }
      , effect  = [ Grant Self 0 StarsPerTurn <| Range 0 1 ]
      , bond    = Nothing
      , limited = True
      }
    , { name    = "Purely Bloom"
      , id      = 82
      , rarity  = 5
      , icon    = Icon.BeamUp
      , stats   = { base = { atk = 500,  hp = 0 }
                  , max  = { atk = 2000, hp = 0 }
                  }
      , effect  = [ ToMax (Range 40 50) << Grant Self 0 NPUp <| Flat 5 ]
      , bond    = Nothing
      , limited = True
      }
    , { name    = "Star of Altria"
      , id      = 83
      , rarity  = 5
      , icon    = Icon.Kneel
      , stats   = { base = { atk = 500,  hp = 0 }
                  , max  = { atk = 2000, hp = 0 }
                  }
      , effect  = [ Times 1 << Grant Self 0 Guts <| Flat 1
                  , Grant Self 0 DebuffResist <| Range 5 10
                  ]
      , bond    = Nothing
      , limited = True
      }
    , { name    = "Trueshot"
      , id      = 84
      , rarity  = 3
      , icon    = Icon.Bullseye
      , stats   = { base = { atk = 200, hp = 0 }
                  , max  = { atk = 1000, hp = 0 }
                  }
      , effect  = [ Grant Self 0 SureHit Full
                  , Grant Self 0 CritUp <| Range 3 5
                  ]
      , bond    = Nothing
      , limited = True
      }
    , { name    = "Mikotto! Bride Training"
      , id      = 85
      , rarity  = 4
      , icon    = Icon.HealTurn
      , stats   = { base = { atk = 0, hp = 600 }
                  , max  = { atk = 0, hp = 2250 }
                  }
      , effect  = [ Chance 65 << Grant Self 0 HealPerTurn <| Range 750 1000 ]
      , bond    = Nothing
      , limited = True
      }
    , { name    = "The Crimson Land of Shadows"
      , id      = 86
      , rarity  = 5
      , icon    = Icon.DamageUp
      , stats   = { base = { atk = 250,  hp = 400 }
                  , max  = { atk = 1000, hp = 1600 }
                  }
      , effect  = [ ToMax (Range 1000 1200) << Grant Self 0 DamageUp <| Flat 100 ]
      , bond    = Nothing
      , limited = True
      }
    , { name    = "Ryudoji Temple"
      , id      = 89
      , rarity  = 3
      , icon    = Icon.BeamUp
      , stats   = { base = { atk = 100, hp = 160 }
                  , max  = { atk = 500, hp = 800 }
                  }
      , effect  = [ Grant Self 0 NPUp <| Range 10 15
                  , To Self GaugeUp <| Range 20 30
                  ]
      , bond    = Nothing
      , limited = False
      }
    , { name    = "Mana Gauge"
      , id      = 90
      , rarity  = 3
      , icon    = Icon.DamageUp
      , stats   = { base = { atk = 200,  hp = 0 }
                  , max  = { atk = 1000, hp = 0  }
                  }
      , effect  = [ Grant Self 0 (Special AttackUp <| VsClass Caster) <| Range 8 10 ]
      , bond    = Nothing
      , limited = False
      }
    , { name    = "Elixir of Love"
      , id      = 91
      , rarity  = 3
      , icon    = Icon.Heart
      , stats   = { base = { atk = 100, hp = 160 }
                  , max  = { atk = 500, hp = 800 }
                  }
      , effect  = [ Grant Self 0 (Success Charm) <| Range 12 15 ]
      , bond    = Nothing
      , limited = False
      }
    , { name    = "Storch Ritter"
      , id      = 92
      , rarity  = 3
      , icon    = Icon.BeamUp
      , stats   = { base = { atk = 200,  hp = 0 }
                  , max  = { atk = 1000, hp = 0 }
                  }
      , effect  = [ equipped Berserker << Grant Self 0 NPUp <| Range 15 25 ]
      , bond    = Nothing
      , limited = False
      }
    , { name    = "Hermitage"
      , id      = 93
      , rarity  = 3
      , icon    = Icon.ArtsUp
      , stats   = { base = { atk = 200,  hp = 0 }
                  , max  = { atk = 1000, hp = 0 }
                  }
      , effect  = [ Grant Self 3 (CardUp Arts) <| Range 15 20 ]
      , bond    = Nothing
      , limited = False
      }
    , { name    = "Motored Cuirassier"
      , id      = 94
      , rarity  = 3
      , icon    = Icon.DamageUp
      , stats   = { base = { atk = 200,  hp = 0 }
                  , max  = { atk = 1000, hp = 0 }
                  }
      , effect  = [ Grant Self 0 (Special AttackUp <| VsClass Rider) <| Range 8 10 ]
      , bond    = Nothing
      , limited = False
      }
    , { name    = "Stuffed Lion"
      , id      = 95
      , rarity  = 3
      , icon    = Icon.Heal
      , stats   = { base = { atk = 0, hp = 300 }
                  , max  = { atk = 0, hp = 1500 }
                  }
      , effect  = [ When "defeated" << To Party Heal <| Range 800 1000 ]
      , bond    = Nothing
      , limited = False
      }
    , { name    = "Lugh's Halo"
      , id      = 96
      , rarity  = 3
      , icon    = Icon.HoodUp
      , stats   = { base = { atk = 0, hp = 300 }
                  , max  = { atk = 0, hp = 1500 }
                  }
      , effect  = [ Grant Self 0 (Resist Stun) <| Range 25 30 ]
      , bond    = Nothing
      , limited = False
      }
    , { name    = "Vessel of the Saint"
      , id      = 97
      , rarity  = 5
      , icon    = Icon.HoodUp
      , stats   = { base = { atk = 250,  hp = 400 }
                  , max  = { atk = 1000, hp = 1600 }
                  }
      , effect  = [ Times 3 <| Grant Self 0 DebuffResist Full
                  , Grant Self 0 NPGen <| Range 15 20
                  ]
      , bond    = Nothing
      , limited = False
      }
    , { name    = "Golden Millennium Tree"
      , id      = 98
      , rarity  = 4
      , icon    = Icon.HPUp
      , stats   = { base = { atk = 0, hp = 600 }
                  , max  = { atk = 0, hp = 2250 }
                  }
      , effect  = [ ToMax (Flat 3000) << Grant Self 0 HPUp <| Range 200 300 ]
      , bond    = Nothing
      , limited = False
      }
    , { name    = "Heroic Portrait: Mash Kyrielight"
      , id      = 99
      , rarity  = 4
      , icon    = Icon.Rainbow
      , stats   = { base = { atk = 500, hp = 500 }
                  , max  = { atk = 500, hp = 500 }
                  }
      , effect  = [ Bonus Bond Units <| Flat 50 ]
      , bond    = Nothing
      , limited = True
      }
    , { name    = "Heroic Portrait: Altria Pendragon"
      , id      = 100
      , rarity  = 4
      , icon    = Icon.Rainbow
      , stats   = { base = { atk = 500, hp = 500 }
                  , max  = { atk = 500, hp = 500 }
                  }
      , effect  = [ Bonus Bond Units <| Flat 50 ]
      , bond    = Nothing
      , limited = True
      }
    , { name    = "Heroic Portrait: Jeanne d'Arc"
      , id      = 101
      , rarity  = 4
      , icon    = Icon.Rainbow
      , stats   = { base = { atk = 500, hp = 500 }
                  , max  = { atk = 500, hp = 500 }
                  }
      , effect  = [ Bonus Bond Units <| Flat 50 ]
      , bond    = Nothing
      , limited = True
      }
    , { name    = "Heroic Portrait: Altera"
      , id      = 102
      , rarity  = 4
      , icon    = Icon.Rainbow
      , stats   = { base = { atk = 500, hp = 500 }
                  , max  = { atk = 500, hp = 500 }
                  }
      , effect  = [ Bonus Bond Units <| Flat 50 ]
      , bond    = Nothing
      , limited = True
      }
    , { name    = "Heroic Portrait: Arjuna"
      , id      = 103
      , rarity  = 4
      , icon    = Icon.Rainbow
      , stats   = { base = { atk = 500, hp = 500 }
                  , max  = { atk = 500, hp = 500 }
                  }
      , effect  = [ Bonus Bond Units <| Flat 50 ]
      , bond    = Nothing
      , limited = True
      }
    , { name    = "Heroic Portrait: Scathach"
      , id      = 104
      , rarity  = 4
      , icon    = Icon.Rainbow
      , stats   = { base = { atk = 500, hp = 500 }
                  , max  = { atk = 500, hp = 500 }
                  }
      , effect  = [ Bonus Bond Units <| Flat 50 ]
      , bond    = Nothing
      , limited = True
      }
    , { name    = "Heroic Portrait: Ushiwakamaru"
      , id      = 105
      , rarity  = 4
      , icon    = Icon.Rainbow
      , stats   = { base = { atk = 500, hp = 500 }
                  , max  = { atk = 500, hp = 500 }
                  }
      , effect  = [ Bonus Bond Units <| Flat 50 ]
      , bond    = Nothing
      , limited = True
      }
    , { name    = "Heroic Portrait: Henry Jekyll & Hyde"
      , id      = 106
      , rarity  = 4
      , icon    = Icon.Rainbow
      , stats   = { base = { atk = 500, hp = 500 }
                  , max  = { atk = 500, hp = 500 }
                  }
      , effect  = [ Bonus Bond Units <| Flat 50 ]
      , bond    = Nothing
      , limited = True
      }
    , { name    = "Heroic Portrait: Mephistopheles"
      , id      = 107
      , rarity  = 4
      , icon    = Icon.Rainbow
      , stats   = { base = { atk = 500, hp = 500 }
                  , max  = { atk = 500, hp = 500 }
                  }
      , effect  = [ Bonus Bond Units <| Flat 50 ]
      , bond    = Nothing
      , limited = True
      }
    , { name    = "Heroic Portrait: Darius III"
      , id      = 108
      , rarity  = 4
      , icon    = Icon.Rainbow
      , stats   = { base = { atk = 500, hp = 500 }
                  , max  = { atk = 500, hp = 500 }
                  }
      , effect  = [ Bonus Bond Units <| Flat 50 ]
      , bond    = Nothing
      , limited = True
      }
    , { name    = "Valentine Dojo of Tears"
      , id      = 109
      , rarity  = 3
      , icon    = Icon.Bullseye
      , stats   = { base = { atk = 200,  hp = 0 }
                  , max  = { atk = 1000, hp = 0 }
                  }
      , effect  = [ Grant Self 0 SureHit Full
                  , Grant Self 0 GaugePerTurn <| Range 3 5
                  , Debuff Self 0 CharmVuln <| Flat 10
                  ]
      , bond    = Nothing
      , limited = True
      }
    , { name    = "Kitchen ☆ Patissiere"
      , id      = 110
      , rarity  = 4
      , icon    = Icon.StarHaloUp
      , stats   = { base = { atk = 200, hp = 320 }
                  , max  = { atk = 750, hp = 1200 }
                  }
      , effect  = [ Grant Self 0 StarUp <| Range 15 20
                  , Grant Self 0 NPGen <| Range 15 20
                  ]
      , bond    = Nothing
      , limited = True
      }
    , { name    = "Street Choco-Maid"
      , id      = 111
      , rarity  = 5
      , icon    = Icon.ArtsQuickUp
      , stats   = { base = { atk = 250, hp = 400 }
                  , max  = { atk = 1000, hp = 1600 }
                  }
      , effect  = [ Grant Self 0 (CardUp Arts) <| Range 10 15
                  , Grant Self 0 (CardUp Quick) <| Range 10 15
                  , Grant Self 0 HealingReceived <| Range 20 30
                  ]
      , bond    = Nothing
      , limited = True
      }
    , { name    = "Melty Sweetheart"
      , id      = 112
      , rarity  = 5
      , icon    = Icon.ShieldUp
      , stats   = { base = { atk = 0, hp = 750 }
                  , max  = { atk = 0, hp = 3000 }
                  }
      , effect  = [ Times 3 << Grant Self 0 (Special DefenseUp <| VsTrait Male) <| Flat 100
                  , Grant Self 0 StarUp <| Range 10 20
                  ]
      , bond    = Nothing
      , limited = True
      }
    , { name    = "Decapitating Bunny 2018"
      , id      = 154
      , rarity  = 5
      , icon    = Icon.ShieldBreak
      , stats   = { base = { atk = 500,  hp = 0 }
                  , max  = { atk = 2000, hp = 0 }
                  }
      , effect  = [ Grant Self 0 IgnoreInvinc Full
                  , Grant Self 0 (CardUp Quick) <| Range 8 10
                  ]
      , bond    = Nothing
      , limited = True
      }
    , { name    = "Mature Gentleman"
      , id      = 155
      , rarity  = 5
      , icon    = Icon.FireUp
      , stats   = { base = { atk = 0, hp = 750 }
                  , max  = { atk = 0, hp = 3000 }
                  }
      , effect  = [ Grant Self 0 DeathResist <| Range 60 80 ]
      , bond    = Nothing
      , limited = True
      }
    , { name    = "Grand Puppeteer"
      , id      = 156
      , rarity  = 5
      , icon    = Icon.Noble
      , stats   = { base = { atk = 250,  hp = 400 }
                  , max  = { atk = 1000, hp = 1600 }
                  }
      , effect  = [ To Self GaugeUp <| Range 50 60
                  , Grant Self 3 (CardUp Arts) <| Range 15 20
                  ]
      , bond    = Nothing
      , limited = True
      }
    , { name    = "Threefold Barrier"
      , id      = 157
      , rarity  = 5
      , icon    = Icon.ShieldUp
      , stats   = { base = { atk = 0, hp = 750 }
                  , max  = { atk = 0, hp = 3000 }
                  }
      , effect  = [ Times 3 << Grant Self 0 DamageCut <| Range 1000 1200 ]
      , bond    = Nothing
      , limited = True
      }
    , { name    = "Vivid Dance of Fists"
      , id      = 158
      , rarity  = 4
      , icon    = Icon.DamageUp
      , stats   = { base = { atk = 400,  hp = 0 }
                  , max  = { atk = 1500, hp = 0 }
                  }
      , effect  = [ Grant Self 0 DamageUp <| Range 800 1000 ]
      , bond    = Nothing
      , limited = True
      }
    , { name    = "Mystic Eyes of Distortion"
      , id      = 159
      , rarity  = 4
      , icon    = Icon.BusterUp
      , stats   = { base = { atk = 400,  hp = 0 }
                  , max  = { atk = 1500, hp = 0 }
                  }
      , effect  = [ Grant Self 0 (CardUp Buster) <| Range 20 25
                  , Debuff Self 0 DefenseDown <| Flat 15
                  ]
      , bond    = Nothing
      , limited = True
      }
    , { name    = "Summer's Precognition"
      , id      = 160
      , rarity  = 4
      , icon    = Icon.Dodge
      , stats   = { base = { atk = 0, hp = 600 }
                  , max  = { atk = 0, hp = 2250 }
                  }
      , effect  = [ Times 1 <| Grant Self 0 Evasion Full
                  , Grant Self 0 StarUp <| Range 15 20
                  ]
      , bond    = Nothing
      , limited = True
      }
    , { name    = "Chorus"
      , id      = 161
      , rarity  = 4
      , icon    = Icon.StarUp
      , stats   = { base = { atk = 200, hp = 320 }
                  , max  = { atk = 750, hp = 1200 }
                  }
      , effect  = [ Grant Self 0 GatherUp <| Range 300 400
                  , Grant Self 3 DebuffResist <| Range 15 20
                  ]
      , bond    = Nothing
      , limited = True
      }
    , { name    = "Sprinter"
      , id      = 162
      , rarity  = 3
      , icon    = Icon.QuickUp
      , stats   = { base = { atk = 0, hp = 300 }
                  , max  = { atk = 0, hp = 1500 }
                  }
      , effect  = [ Grant Self 0 (CardUp Quick) <| Range 5 8
                  , Grant Self 0 DebuffResist <| Range 10 15
                  ]
      , bond    = Nothing
      , limited = True
      }
    , { name    = "Repeat Magic"
      , id      = 163
      , rarity  = 3
      , icon    = Icon.Noble
      , stats   = { base = { atk = 200,  hp = 0 }
                  , max  = { atk = 1000, hp = 0 }
                  }
      , effect  = [ To Self GaugeUp <| Range 20 30
                  , Grant Self 0 NPGen <| Range 10 15
                  ]
      , bond    = Nothing
      , limited = True
      }
    , { name    = "Kiss Your Hand"
      , id      = 165
      , rarity  = 5
      , icon    = Icon.AllUp
      , stats   = { base = { atk = 500,  hp = 0 }
                  , max  = { atk = 2000, hp = 0 }
                  }
      , effect  = [ Grant Self 0 (CardUp Arts) <| Range 10 12
                  , Grant Self 0 (CardUp Buster) <| Range 10 12
                  , Grant Self 0 (CardUp Quick) <| Range 10 12
                  ]
      , bond    = Nothing
      , limited = True
      }
    , { name    = "Teacher and I"
      , id      = 166
      , rarity  = 5
      , icon    = Icon.Noble
      , stats   = { base = { atk = 0, hp = 750 }
                  , max  = { atk = 0, hp = 3000 }
                  }
      , effect  = [ To Self GaugeUp <| Range 5 60
                  , Grant Self 0 GatherUp <| Range 300 400
                  ]
      , bond    = Nothing
      , limited = True
      }
    , { name    = "Versus"
      , id      = 167
      , rarity  = 5
      , icon    = Icon.DamageUp
      , stats   = { base = { atk = 250,  hp = 400 }
                  , max  = { atk = 1000, hp = 1600 }
                  }
      , effect  = [ Grant Self 3 (Special AttackUp <| VsTrait Divine) <| Range 80 100
                  , Grant Self 3 (Special DefenseUp <| VsTrait Divine) <| Range 40 50
                  ]
      , bond    = Nothing
      , limited = True
      }
    , { name    = "Beasts Under the Moon"
      , id      = 168
      , rarity  = 4
      , icon    = Icon.NobleUp
      , stats   = { base = { atk = 400,  hp = 0 }
                  , max  = { atk = 1500, hp = 0 }
                  }
      , effect  = [ Grant Self 0 NPGen <| Range 12 15
                  , Grant Self 0 StarUp <| Range 12 15
                  , Grant Self 0 HealPerTurn <| Range 200 300
                  ]
      , bond    = Nothing
      , limited = True
      }
    , { name    = "Glass Full Sweet Time"
      , id      = 169
      , rarity  = 4
      , icon    = Icon.Bullseye
      , stats   = { base = { atk = 200, hp = 320 }
                  , max  = { atk = 750, hp = 1200 }
                  }
      , effect  = [ Grant Self 0 SureHit Full
                  , Grant Self 0 DamageUp <| Range 400 600
                  , Grant Self 0 DamageCut <| Range 200 300
                  ]
      , bond    = Nothing
      , limited = True
      }
    , { name    = "Salon de Marie"
      , id      = 170
      , rarity  = 3
      , icon    = Icon.Dodge
      , stats   = { base = { atk = 0, hp = 300 }
                  , max  = { atk = 0, hp = 1500 }
                  }
      , effect  = [ Times 1 <| Grant Self 0 Evasion Full
                  , Grant Self 0 HealingReceived <| Range 5 10
                  , Grant Self 0 DebuffUp <| Range 3 5
                  ]
      , bond    = Nothing
      , limited = True
      }
    , { name    = "Prince of Slayer"
      , id      = 171
      , rarity  = 3
      , icon    = Icon.StarTurn
      , stats   = { base = { atk = 100, hp = 160 }
                  , max  = { atk = 500, hp = 800 }
                  }
      , effect  = [ Grant Self 0 StarsPerTurn <| Range 1 2
                  , Grant Self 0 (Special AttackUp <| VsTrait Dragon) <| Range 8 10
                  ]
      , bond    = Nothing
      , limited = True
      }
    , { name    = "Noisy Obsession"
      , id      = 172
      , rarity  = 4
      , icon    = Icon.ExclamationUp
      , stats   = { base = { atk = 400,  hp = 0 }
                  , max  = { atk = 1500, hp = 0 }
                  }
      , effect  = [ Grant Self 0 CritUp <| Range 15 20
                  , Grant Self 0 NPUp <| Range 15 20
                  , Grant Self 0 (Success Charm) <| Range 12 15
                  ]
      , bond    = Nothing
      , limited = True
      }
    , gift 174 "[Heaven's Feel]" Icon.QuickUp
      [self (CardUp Quick) 10, To Self GaugeUp <| Flat 40]
    , { name    = "Ideal Holy King"
      , id      = 175
      , rarity  = 5
      , icon    = Icon.HPUp
      , stats   = { base = { atk = 250,  hp = 400 }
                  , max  = { atk = 1000, hp = 1600 }
                  }
      , effect  = [ Grant Party 0 HPUp <| Range 1000 1200 ]
      , bond    = Nothing
      , limited = False
      }
    , { name    = "Record Holder"
      , id      = 176
      , rarity  = 4
      , icon    = Icon.StaffUp
      , stats   = { base = { atk = 400,  hp = 0 }
                  , max  = { atk = 1500, hp = 0 }
                  }
      , effect  = [ Grant Self 0 DebuffUp <| Range 15 20 ]
      , bond    = Nothing
      , limited = False
      }
    , { name    = "Beast of Billows"
      , id      = 177
      , rarity  = 3
      , icon    = Icon.BeamUp
      , stats   = { base = { atk = 200,  hp = 0 }
                  , max  = { atk = 1000, hp = 0 }
                  }
      , effect  = [ equipped Lancer << Grant Self 0 NPUp <| Range 15 25 ]
      , bond    = Nothing
      , limited = False
      }
    , { name    = "Personal Training"
      , id      = 178
      , rarity  = 5
      , icon    = Icon.Road
      , stats   = { base = { atk = 250,  hp = 400 }
                  , max  = { atk = 1000, hp = 1600 }
                  }
      , effect  = [ Bonus EXP Percent <| Range 2 10 ]
      , bond    = Nothing
      , limited = True
      }
    , { name    = "The Scholars of Chaldea"
      , id      = 179
      , rarity  = 5
      , icon    = Icon.Noble
      , stats   = { base = { atk = 250,  hp = 400 }
                  , max  = { atk = 1000, hp = 1600 }
                  }
      , effect  = [ To Self GaugeUp <| Range 30 50
                  , Grant Self 0 HealingReceived <| Range 20 30
                  ]
      , bond    = Nothing
      , limited = True
      }
    , { name    = "Maiden Leading Chaldea"
      , id      = 180
      , rarity  = 5
      , icon    = Icon.StarTurn
      , stats   = { base = { atk = 500,  hp = 0 }
                  , max  = { atk = 2000, hp = 0 }
                  }
      , effect  = [ Grant Self 0 StarsPerTurn <| Range 3 4
                  , Grant Self 0 (CardUp Buster) <| Range 10 15
                  ]
      , bond    = Nothing
      , limited = True
      }
    , { name    = "The Merciless One"
      , id      = 181
      , rarity  = 5
      , icon    = Icon.Noble
      , stats   = { base = { atk = 500,  hp = 0 }
                  , max  = { atk = 2000, hp = 0 }
                  }
      , effect  = [ When "defeated" << To Party GaugeUp <| Range 15 20
                  , Grant Self 0 (CardUp Buster) <| Range 10 15
                  ]
      , bond    = Nothing
      , limited = True
      }
    , { name    = "Art of the Poisonous Snake"
      , id      = 182
      , rarity  = 4
      , icon    = Icon.ArtsUp
      , stats   = { base = { atk = 200, hp = 320 }
                  , max  = { atk = 750, hp = 1200 }
                  }
      , effect  = [ Grant Self 3 (CardUp Arts) <| Range 30 40 ]
      , bond    = Nothing
      , limited = False
      }
    , { name    = "Art of Death"
      , id      = 183
      , rarity  = 4
      , icon    = Icon.DamageUp
      , stats   = { base = { atk = 400,  hp = 0 }
                  , max  = { atk = 1500, hp = 0 }
                  }
      , effect  = [ Grant Self 0 (Special AttackUp <| VsTrait Humanoid) <| Range 25 30 ]
      , bond    = Nothing
      , limited = False
      }
    , { name    = "Gentle Affection"
      , id      = 184
      , rarity  = 4
      , icon    = Icon.HealUp
      , stats   = { base = { atk = 0, hp = 600 }
                  , max  = { atk = 0, hp = 2250 }
                  }
      , effect  = [ Grant Self 0 HealUp <| Range 15 20 ]
      , bond    = Nothing
      , limited = False
      }
    , { name    = "Volumen Hydrargyrum"
      , id      = 185
      , rarity  = 5
      , icon    = Icon.Shield
      , stats   = { base = { atk = 0, hp = 750 }
                  , max  = { atk = 0, hp = 3000 }
                  }
      , effect  = [ Times 3 <| Grant Self 0 Invincibility Full
                  , Grant Self 0 DamageUp <| Range 200 500
                  ]
      , bond    = Nothing
      , limited = False
      }
    , { name    = "Innocent Maiden"
      , id      = 186
      , rarity  = 4
      , icon    = Icon.NobleTurn
      , stats   = { base = { atk = 200, hp = 320 }
                  , max  = { atk = 750, hp = 1200 }
                  }
      , effect  = [ Grant Self 0 GaugePerTurn <| Range 4 5
                  , Grant Self 0 (CardUp Quick) <| Range 10 12
                  ]
      , bond    = Nothing
      , limited = False
      }
    , { name    = "Self Geas Scroll"
      , id      = 187
      , rarity  = 3
      , icon    = Icon.StaffUp
      , stats   = { base = { atk = 0, hp = 300 }
                  , max  = { atk = 0, hp = 1500 }
                  }
      , effect  = [ Grant Self 0 (Success Stun) <| Range 12 15 ]
      , bond    = Nothing
      , limited = False
      }
    , { name    = "Before Awakening"
      , id      = 188
      , rarity  = 5
      , icon    = Icon.AllUp
      , stats   = { base = { atk = 500,  hp = 0 }
                  , max  = { atk = 2000, hp = 0 }
                  }
      , effect  = [ Grant Self 0 (CardUp Arts) <| Range 8 10
                  , Grant Self 0 (CardUp Buster) <| Range 8 10
                  , Grant Self 0 (CardUp Quick) <| Range 8 10
                  , Grant Self 0 DefenseUp <| Range 8 10
                  ]
      , bond    = Nothing
      , limited = False
      }
    , { name    = "His Rightful Place"
      , id      = 189
      , rarity  = 5
      , icon    = Icon.StarTurn
      , stats   = { base = { atk = 250,  hp = 400 }
                  , max  = { atk = 1000, hp = 1600 }
                  }
      , effect  = [ Grant Self 0 StarsPerTurn <| Range 3 4
                  , To Self GaugeUp <| Range 30 50
                  ]
      , bond    = Nothing
      , limited = True
      }
    , bond 191 "Crown of the Star" "Altria Pendragon" Icon.DamageUp
      [party AttackUp 15]
    , bond 192 "Relic of the King" "Zhuge Liang (Lord El-Melloi II)" Icon.BusterUp
      [party_ Buster 15]
    , bond 193 "Triumph of the Lord Impaler" "Vlad III" Icon.BeamUp
      [self NPUp 30, atkChance 30 << To Self GaugeUp <| Flat 5]
    , bond 194 "Revelation from Heaven" "Jeanne d'Arc" Icon.BusterUp
      [party_ Buster 15]
    , bond 195 "Memories of the Dragon" "Altria Pendragon (Alter)" Icon.BeamUp
      [self NPUp 30, atkChance 30 << Debuff Target 3 DefenseDown <| Flat 5]
    , bond 196 "Hunter of the Red Plains" "EMIYA" Icon.BeamUp
      [self NPUp 30, atkChance 30 << To Party GainStars <| Flat 5]
    , bond 197 "Castle of Snow" "Heracles" Icon.Kneel
      [Times 3 <| self Guts 500]
    , bond 198 "Yggdrasil Tree" "Cu Chulainn (Caster)" Icon.BeamUp
      [self NPUp 30, atkChance 30 << To Self Heal <| Flat 500]
    , bond 199 "Scorching Embrace" "Kiyohime" Icon.BeamUp
      [self NPUp 30, atkChance 30 << Debuff Target 5 Burn <| Flat 500]
    , bond 200 "Worthless Jewel" "Mata Hari" Icon.NobleUp
      [party NPGen 15]
    , bond 201 "Eternal Solitude" "Altera" Icon.SwordUp
      [party AttackUp 15]
    , bond 202 "Queen's Present" "Chevalier d'Eon" Icon.ArtsUp
      [party_ Arts 15]
    , bond 203 "Elixir" "Elisabeth Bathory" Icon.HealTurn
      [party HealPerTurn 500]
    , bond 204 "My Necklace" "Marie Antoinette" Icon.StarHaloUp
      [party StarUp 20]
    , bond 205 "Staff He Gave Me" "Martha" Icon.HealUp
      [party HealingReceived 30]
    , bond 206 "Iron Maiden" "Carmilla" Icon.BeamUp
      [self NPUp 30, atkChance 10 <| Debuff Target 1 SealNP Full]
    , bond 207 "Cat Apron" "Tamamo Cat" Icon.Heal
      [party HPUp 2000]
    , bond 208 "Thirst for Victory" "Boudica" Icon.StarHaloUp
      [party StarUp 20]
    , bond 209 "To My Dear Friend" "Hans Christian Andersen" Icon.HoodUp
      [party DebuffResist 30]
    , bond 210 "Sacred Devotion" "Arash" Icon.Heal
      [ When "defeated" <| To Party RemoveDebuffs Full
      , When "defeated" <| To Party Heal <| Flat 5000
      ]
    , { name    = "The Wandering Tales of Shana-oh"
      , id      = 211
      , rarity  = 5
      , icon    = Icon.QuickUp
      , stats   = { base = { atk = 250,  hp = 400 }
                  , max  = { atk = 1000, hp = 1600 }
                  }
      , effect  = [ Grant Self 0 (CardUp Quick) <| Range 10 15
                  , When "defeated" <<
                    Grant Party 1 (CardUp Quick) <| Range 20 30
                  ]
      , bond    = Nothing
      , limited = True
      }
    , { name    = "Golden Captures the Carp"
      , id      = 212
      , rarity  = 5
      , icon    = Icon.Noble
      , stats   = { base = { atk = 500,  hp = 0 }
                  , max  = { atk = 2000, hp = 0 }
                  }
      , effect  = [ To Self GaugeUp <| Range 30 50
                  , To Party GainStars <| Range 15 20
                  ]
      , bond    = Nothing
      , limited = True
      }
    , { name    = "A Fox Night's Dream"
      , id      = 213
      , rarity  = 5
      , icon    = Icon.NobleUp
      , stats   = { base = { atk = 250,  hp = 400 }
                  , max  = { atk = 1000, hp = 1600 }
                  }
      , effect  = [ Grant Self 0 NPGen <| Range 20 25
                  , Grant Self 0 StarsPerTurn <| Range 3 4
                  ]
      , bond    = Nothing
      , limited = True
      }
    , { name    = "Burning Tale of Love"
      , id      = 214
      , rarity  = 4
      , icon    = Icon.DamageUp
      , stats   = { base = { atk = 400,  hp = 0 }
                  , max  = { atk = 1500, hp = 0 }
                  }
      , effect  = [ Grant Self 0 (Special AttackUp <| VsTrait Male) <| Range 25 30
                  , Grant Self 0 DebuffUp <| Range 12 15
                  ]
      , bond    = Nothing
      , limited = True
      }
    , { name    = "Reciting the Subscription List"
      , id      = 215
      , rarity  = 3
      , icon    = Icon.HoodUp
      , stats   = { base = { atk = 0, hp = 300 }
                  , max  = { atk = 0, hp = 1500 }
                  }
      , effect  = [ Times 1 <| Grant Self 0 DebuffResist Full ]
      , bond    = Nothing
      , limited = True
      }
    , bond 216 "Key of the King's Law" "Gilgamesh" Icon.BeamUp
      [self NPUp 30, atkChance 30 << Grant Self 3 CritUp <| Flat 10]
    , bond 217 "Golden Glass" "Sakata Kintoki" Icon.BeamUp
      [self NPUp 30, atkChance 30 << To Self GaugeUp <| Flat 5]
    , bond 218 "Thunderous Applause" "Nero Claudius" Icon.ArtsUp
      [party_ Arts 15]
    , bond 219 "Das Rheingold" "Siegfried" Icon.NobleUp
      [party NPGen 15]
    , bond 220 "Radiance of the Goddess" "Stheno" Icon.QuickUp
      [party_ Quick 15]
    , bond 221 "Voyage of the Flowers" "Altria Pendragon (Lily)" Icon.SwordUp
      [party AttackUp 10, party StarUp 10]
    , bond 222 "Ark of the Covenant" "David" Icon.BeamUp
      [self NPUp 30, When "attacking" << To Enemy Death <| Flat 10]
    , bond 223 "Door to Babylon" "Darius III" Icon.BusterUp
      [party_ Buster 15]
    , bond 224 "Blood-Thirsting Axe" "Eric Bloodaxe" Icon.ExclamationUp
      [party CritUp 25]
    , bond 225 "Insurrection" "Spartacus" Icon.Kneel
      [gutsPercent 50]
    , { name    = "Go West!!"
      , id      = 226
      , rarity  = 5
      , icon    = Icon.BeamUp
      , stats   = { base = { atk = 250,  hp = 400 }
                  , max  = { atk = 1000, hp = 1600 }
                  }
      , effect  = [ Grant Self 0 NPUp <| Range 20 25
                  , Grant Self 0 StarsPerTurn <| Range 3 4
                  ]
      , bond    = Nothing
      , limited = True
      }
    , { name    = "The Classic Three Great Heroes"
      , id      = 227
      , rarity  = 5
      , icon    = Icon.BeamUp
      , stats   = { base = { atk = 250,  hp = 400 }
                  , max  = { atk = 1000, hp = 1600 }
                  }
      , effect  = [ Grant Self 0 NPUp <| Range 15 20
                  , Grant Self 0 StarUp <| Range 15 20
                  , To Self GaugeUp <| Range 25 40
                  ]
      , bond    = Nothing
      , limited = True
      }
    , { name    = "True Samadhi Fire"
      , id      = 228
      , rarity  = 4
      , icon    = Icon.BeamUp
      , stats   = { base = { atk = 400,  hp = 0 }
                  , max  = { atk = 1500, hp = 0 }
                  }
      , effect  = [ Grant Self 0 NPUp <| Range 15 20
                  , Grant Self 0 (CardUp Buster) <| Range 8 10
                  ]
      , bond    = Nothing
      , limited = True
      }
    , { name    = "All Three Together"
      , id      = 229
      , rarity  = 3
      , icon    = Icon.StarUp
      , stats   = { base = { atk = 200,  hp = 0 }
                  , max  = { atk = 1000, hp = 0 }
                  }
      , effect  = [ Grant Self 0 GatherUp <| Range 100 200
                  , Grant Self 0 CritUp <| Range 5 10
                  ]
      , bond    = Nothing
      , limited = True
      }
    , bond 230 "Tristar Belt" "Orion" Icon.ExclamationUp
      [party CritUp 25]
    , bond 231 "Golden Helm" "Francis Drake" Icon.BeamUp
      [party NPUp 20]
    , bond 232 "Black Knight's Helmet" "Lancelot" Icon.BeamUp
      [self NPUp 30, atkChance 30 << Debuff Target 3 CritChance <| Flat 30]
    , bond 233 "Golden Apple" "Atalante" Icon.QuickUp
      [party_ Quick 15]
    , bond 234 "Holy Pumpkin Grail" "Elisabeth Bathory (Halloween)" Icon.HoodUp
      [party DebuffResist 30]
    , bond 235 "Rotary Matchlock" "Oda Nobunaga" Icon.ExclamationUp
      [party CritUp 25]
    , bond 236 "Llamrei Unit II" "Altria Pendragon (Santa Alter)" Icon.StarHaloUp
      [party StarUp 20]
    , bond 237 "Things to Calm the Heart" "Henry Jekyll & Hyde" Icon.BusterUp
      [party_ Buster 15]
    , bond 238 "Glory of the Past Days" "Edward Teach" Icon.BusterUp
      [party_ Buster 15]
    , bond 239 "Heaven Among the Mountains" "Sasaki Kojirou" Icon.QuickUp
      [party_ Quick 15]
    , { name    = "Divine Princess of the Storm"
      , id      = 240
      , rarity  = 5
      , icon    = Icon.ShieldUp
      , stats   = { base = { atk = 0, hp = 750 }
                  , max  = { atk = 0, hp = 3000 }
                  }
      , effect  = [ When "defeated" << Grant Party 3 DefenseUp <| Range 20 25 ]
      , bond    = Nothing
      , limited = True
      }
    , { name    = "Ox-Demon King"
      , id      = 241
      , rarity  = 5
      , icon    = Icon.BusterUp
      , stats   = { base = { atk = 500,  hp = 0 }
                  , max  = { atk = 2000, hp = 0 }
                  }
      , effect  = [ Grant Party 3 (CardUp Buster) <| Range 10 15 ]
      , bond    = Nothing
      , limited = True
      }
    , { name    = "Personal Lesson"
      , id      = 242
      , rarity  = 5
      , icon    = Icon.Road
      , stats   = { base = { atk = 500,  hp = 0 }
                  , max  = { atk = 2000, hp = 0 }
                  }
      , effect  = [ Bonus MysticCode Percent <| Flat 2 ]
      , bond    = Nothing
      , limited = True
      }
    , { name    = "Bronze-Link Manipulator"
      , id      = 243
      , rarity  = 3
      , icon    = Icon.SwordUp
      , stats   = { base = { atk = 200,  hp = 0 }
                  , max  = { atk = 1000, hp = 0 }
                  }
      , effect  = [ Grant Self 3 AttackUp <| Range 15 20 ]
      , bond    = Nothing
      , limited = False
      }
    , { name    = "Ath nGabla"
      , id      = 244
      , rarity  = 3
      , icon    = Icon.QuickUp
      , stats   = { base = { atk = 100, hp = 160 }
                  , max  = { atk = 500, hp = 800 }
                  }
      , effect  = [ Grant Self 0 (CardUp Quick) <| Range 10 15
                  , Debuff Self 0 DefenseDown <| Flat 10
                  ]
      , bond    = Nothing
      , limited = False
      }
    , { name    = "Bygone Dream"
      , id      = 245
      , rarity  = 3
      , icon    = Icon.BeamUp
      , stats   = { base = { atk = 200,  hp = 0 }
                  , max  = { atk = 1000, hp = 0 }
                  }
      , effect  = [ equipped Assassin << Grant Self 0 NPUp <| Range 15 25 ]
      , bond    = Nothing
      , limited = False
      }
    , { name    = "Extremely Spicy Mapo Tofu"
      , id      = 246
      , rarity  = 3
      , icon    = Icon.HealUp
      , stats   = { base = { atk = 200,  hp = 0 }
                  , max  = { atk = 1000, hp = 0 }
                  }
      , effect  = [ Grant Self 0 HealingReceived <| Range 10 20 ]
      , bond    = Nothing
      , limited = False
      }
    , { name    = "Jeweled Sword Zelretch"
      , id      = 247
      , rarity  = 3
      , icon    = Icon.NobleUp
      , stats   = { base = { atk = 100, hp = 160 }
                  , max  = { atk = 500, hp = 800 }
                  }
      , effect  = [ Grant Self 0 NPGen <| Range 5 10
                  , To Self GaugeUp <| Range 25 40
                  ]
      , bond    = Nothing
      , limited = False
      }
    , bond 248 "Tamamo's Club" "Tamamo-no-Mae" Icon.ArtsUp
      [party_ Arts 15]
    , bond 249 "Headband of Resolve" "Okita Souji" Icon.ExclamationUp
      [party CritUp 25]
    , bond 250 "Calico Jack" "Anne Bonny & Mary Read" Icon.ExclamationUp
      [party CritUp 25]
    , bond 251 "Gazing Upon Dun Scaith" "Scathach" Icon.QuickUp
      [party_ Quick 15]
    , bond 252 "Star of Prophecy" "Cu Chulainn" Icon.BeamUp
      [self NPUp 30, atkChance 30 << Grant Self 3 CritUp <| Flat 10]
    , bond 253 "Hekate's Staff" "Medea" Icon.ArtsUp
      [party_ Arts 15]
    , bond 254 "Formless Island" "Medusa" Icon.NobleUp
      [party NPGen 15]
    , bond 255 "Cask of the Wise" "Alexander" Icon.QuickUp
      [party_ Quick 15]
    , bond 256 "Shaytan's Arm" "Hassan of the Cursed Arm" Icon.ReaperUp
      [party DeathUp 20]
    , bond 257 "Ariadne's Thread" "Asterios" Icon.QuickUp
      [party_ Quick 15]
    , { name    = "Dumplings Over Flowers"
      , id      = 258
      , rarity  = 5
      , icon    = Icon.QuickUp
      , stats   = { base = { atk = 250,  hp = 400 }
                  , max  = { atk = 1000, hp = 1600 }
                  }
      , effect  = [ Grant Self 0 (CardUp Quick) <| Range 15 20
                  , Grant Self 0 NPUp <| Range 15 20
                  ]
      , bond    = Nothing
      , limited = True
      }
    , { name    = "Faithful Companions"
      , id      = 259
      , rarity  = 4
      , icon    = Icon.ArtsUp
      , stats   = { base = { atk = 0, hp = 600 }
                  , max  = { atk = 0, hp = 2250 }
                  }
      , effect  = [ Grant Self 0 (CardUp Arts) <| Range 8 10
                  , Grant Self 0 NPGen <| Range 15 20
                  ]
      , bond    = Nothing
      , limited = True
      }
    , { name    = "Hidden Sword: Pheasant Reversal"
      , id      = 260
      , rarity  = 3
      , icon    = Icon.QuickUp
      , stats   = { base = { atk = 200,  hp = 0 }
                  , max  = { atk = 1000, hp = 0 }
                  }
      , effect  = [ Grant Self 0 (CardUp Quick) <| Range 3 5
                  , Grant Self 0 CritUp <| Range 8 10
                  ]
      , bond    = Nothing
      , limited = True
      }
    , { name    = "Golden Sumo: Boulder Tournament"
      , id      = 261
      , rarity  = 5
      , icon    = Icon.SwordUp
      , stats   = { base = { atk = 500,  hp = 0 }
                  , max  = { atk = 2000, hp = 0 }
                  }
      , effect  = [ Grant Self 0 AttackUp <| Range 10 15
                  , To Self GaugeUp <| Range 30 50
                  ]
      , bond    = Nothing
      , limited = True
      }
    , { name    = "Hot Spring Under the Moon"
      , id      = 262
      , rarity  = 5
      , icon    = Icon.ExclamationUp
      , stats   = { base = { atk = 500,  hp = 0 }
                  , max  = { atk = 2000, hp = 0 }
                  }
      , effect  = [ Grant Self 0 CritUp <| Range 20 25
                  , Grant Self 0 StarsPerTurn <| Range 3 4
                  ]
      , bond    = Nothing
      , limited = True
      }
    , { name    = "Origin Bullet"
      , id      = 263
      , rarity  = 5
      , icon    = Icon.ShieldBreak
      , stats   = { base = { atk = 500,  hp = 0 }
                  , max  = { atk = 2000, hp = 0 }
                  }
      , effect  = [ Grant Self 0 IgnoreInvinc Full
                  , Grant Self 0 (Special AttackUp <| VsClass Caster) <| Range 35 40
                  ]
      , bond    = Nothing
      , limited = False
      }
    , { name    = "Covering Fire"
      , id      = 264
      , rarity  = 4
      , icon    = Icon.DamageUp
      , stats   = { base = { atk = 200, hp = 320 }
                  , max  = { atk = 750, hp = 1200 }
                  }
      , effect  = [ Grant Self 0 DamageUp <| Range 400 600
                  , Grant Self 0 CritUp <| Range 15 20
                  ]
      , bond    = Nothing
      , limited = False
      }
    , { name    = "Battle of Camlann"
      , id      = 265
      , rarity  = 3
      , icon    = Icon.Noble
      , stats   = { base = { atk = 0, hp = 300 }
                  , max  = { atk = 0, hp = 1500 }
                  }
      , effect  = [ When "defeated" << To Party GaugeUp <| Range 10 15 ]
      , bond    = Nothing
      , limited = False
      }
    , bond 266 "Who Am I?" "Mordred" Icon.BeamUp
      [party NPUp 20]
    , bond 267 "The Misty Night of London" "Jack the Ripper" Icon.ExclamationUp
      [party CritUp 25]
    , bond 268 "Wonderland" "Nursery Rhyme" Icon.ExclamationUp
      [party CritUp 15, party HealingReceived 10]
    , bond 269 "Faceless King" "Robin Hood" Icon.ArtsUp
      [party_ Arts 15]
    , bond 270 "Usumidori" "Ushiwakamaru" Icon.QuickUp
      [party_ Quick 15]
    , bond 271 "Etiquette of Nine Guests" "Jing Ke" Icon.BeamUp
      [self NPUp 30, atkChance 30 << Grant Self 3 DeathUp <| Flat 30]
    , bond 272 "Heaven Scorcher Halberd" "Lu Bu Fengxian" Icon.BusterUp
      [party_ Buster 15]
    , bond 273 "What can be Left Behind" "Georgios" Icon.Shield
      [ When "defeated" << Times 1 <| Grant Party 0 Invincibility Full
      , When "defeated" << Grant Party 3 DamageCut <| Flat 1000
      ]
    , bond 274 "Thermopylae" "Leonidas I" Icon.BusterUp
      [party_ Buster 15]
    , bond 275 "Haydn Quartets" "Wolfgang Amadeus Mozart" Icon.BeamUp
      [party NPUp 20]
    , gift 276 "Anniversary Heroines" Icon.SwordUp
      [self AttackUp 10, self StarsPerTurn 3]
    , { name    = "Leisure Stroll"
      , id      = 277
      , rarity  = 5
      , icon    = Icon.StarUp
      , stats   = { base = { atk = 250,  hp = 400 }
                  , max  = { atk = 1000, hp = 1600 }
                  }
      , effect  = [ Grant Self 0 GatherUp <| Range 400 600
                  , Grant Self 0 (CardUp Arts) <| Range 10 15
                  ]
      , bond    = Nothing
      , limited = True
      }
    , { name    = "Partake with the King"
      , id      = 278
      , rarity  = 5
      , icon    = Icon.BusterUp
      , stats   = { base = { atk = 500,  hp = 0 }
                  , max  = { atk = 2000, hp = 0 }
                  }
      , effect  = [ Grant Self 0 (CardUp Buster) <| Range 10 15
                  , To Self GaugeUp <| Range 50 60
                  ]
      , bond    = Nothing
      , limited = True
      }
    , { name    = "Goldfish Scooping"
      , id      = 279
      , rarity  = 4
      , icon    = Icon.Bullseye
      , stats   = { base = { atk = 200, hp = 320 }
                  , max  = { atk = 750, hp = 1200 }
                  }
      , effect  = [ Grant Self 0 SureHit Full
                  , Grant Self 0 (CardUp Buster) <| Range 8 10
                  ]
      , bond    = Nothing
      , limited = True
      }
    , { name    = "Fire Flower"
      , id      = 280
      , rarity  = 3
      , icon    = Icon.StarHaloUp
      , stats   = { base = { atk = 0, hp = 300 }
                  , max  = { atk = 0, hp = 1500 }
                  }
      , effect  = [ Grant Self 0 StarUp <| Range 5 10
                  , Grant Self 0 CritUp <| Range 5 10
                  ]
      , bond    = Nothing
      , limited = True
      }
    , bond 281 "Arm of Raiden" "Nikola Tesla" Icon.BeamUp
      [party NPUp 20]
    , bond 282 "Endowed Hero" "Arjuna" Icon.BeamUp
      [self NPUp 30, self GatherUp 1000]
    , bond 283 "Light of the Deprived" "Karna" Icon.AllUp
      [party_ Quick 8, party_ Arts 8, party_ Buster 8]
    , bond 284 "Procedure to Humanity" "Frankenstein" Icon.QuickUp
      [party_ Quick 15]
    , bond 285 "Black Helmet" "Altria Pendragon (Lancer Alter)" Icon.NobleUp
      [party NPGen 15]
    , bond 286 "Legend of the Gallic War" "Gaius Julius Caesar" Icon.QuickUp
      [party_ Quick 15]
    , bond 287 "Rome" "Romulus" Icon.BeamUp
      [party NPUp 20]
    , bond 288 "Encounter at Gojou Bridge" "Musashibou Benkei" Icon.NobleRedUp
      [party NPFromDamage 20]
    , bond 289 "Impure Death Mask" "Phantom of the Opera" Icon.QuickUp
      [party_ Quick 15]
    , bond 290 "Really Convenient" "William Shakespeare" Icon.NobleUp
      [party NPGen 15]
    , { name    = "Pirates Party!"
      , id      = 291
      , rarity  = 5
      , icon    = Icon.ShieldBreak
      , stats   = { base = { atk = 500,  hp = 0 }
                  , max  = { atk = 2000, hp = 0 }
                  }
      , effect  = [ Grant Self 0 IgnoreInvinc Full
                  , Grant Self 0 StarsPerTurn <| Range 3 4
                  ]
      , bond    = Nothing
      , limited = True
      }
    , { name    = "Summertime Mistress"
      , id      = 292
      , rarity  = 5
      , icon    = Icon.ExclamationUp
      , stats   = { base = { atk = 500,  hp = 0 }
                  , max  = { atk = 2000, hp = 0 }
                  }
      , effect  = [ Grant Self 0 CritUp <| Range 15 20
                  , To Self GaugeUp <| Range 30 50
                  ]
      , bond    = Nothing
      , limited = True
      }
    , { name    = "Twilight Memory"
      , id      = 293
      , rarity  = 4
      , icon    = Icon.QuickUp
      , stats   = { base = { atk = 200, hp = 320 }
                  , max  = { atk = 750, hp = 1200 }
                  }
      , effect  = [ Times 1 <| Grant Self 0 Evasion Full
                  , Grant Self 0 (CardUp Quick) <| Range 8 10
                  ]
      , bond    = Nothing
      , limited = True
      }
    , { name    = "Shiny Goddess"
      , id      = 294
      , rarity  = 3
      , icon    = Icon.ArtsUp
      , stats   = { base = { atk = 0, hp = 300 }
                  , max  = { atk = 0, hp = 1500 }
                  }
      , effect  = [ Grant Self 0 DefenseUp <| Range 3 5
                  , Grant Self 0 (CardUp Arts) <| Range 3 5
                  ]
      , bond    = Nothing
      , limited = True
      }
    , { name    = "Knights of Marines"
      , id      = 295
      , rarity  = 5
      , icon    = Icon.QuickUp
      , stats   = { base = { atk = 500,  hp = 0 }
                  , max  = { atk = 2000, hp = 0 }
                  }
      , effect  = [ Grant Self 0 (CardUp Quick) <| Range 10 15
                  , To Self GaugeUp <| Range 50 60
                  ]
      , bond    = Nothing
      , limited = True
      }
    , { name    = "Chaldea Lifesavers"
      , id      = 296
      , rarity  = 5
      , icon    = Icon.Kneel
      , stats   = { base = { atk = 0, hp = 750 }
                  , max  = { atk = 0, hp = 3000 }
                  }
      , effect  = [ Times 1 << Grant Self 0 Guts <| Flat 1
                  , Grant Self 0 NPGen <| Range 15 20
                  ]
      , bond    = Nothing
      , limited = True
      }
    , { name    = "Meat Wars"
      , id      = 297
      , rarity  = 4
      , icon    = Icon.HealTurn
      , stats   = { base = { atk = 200, hp = 320 }
                  , max  = { atk = 750, hp = 1200 }
                  }
      , effect  = [ Grant Self 0 HealPerTurn <| Range 200 300
                  , Grant Self 0 (CardUp Arts) <| Range 8 10
                  ]
      , bond    = Nothing
      , limited = True
      }
    , { name    = "Shaved Ice (Void's Dust Flavor)"
      , id      = 298
      , rarity  = 3
      , icon    = Icon.ShieldUp
      , stats   = { base = { atk = 0, hp = 300 }
                  , max  = { atk = 0, hp = 1500 }
                  }
      , effect  = [ Grant Self 0 DamageCut <| Range 100 200
                  , Grant Self 0 DebuffResist <| Range 5 10
                  ]
      , bond    = Nothing
      , limited = True
      }
    , bond 299 "Annihilation List" "Mysterious Heroine X" Icon.DamageUp
      [party (Special AttackUp <| VsClass Saber) 20]
    , bond 300 "Imperishable Flames" "Brynhild" Icon.BusterUp
      [party_ Buster 10, party NPGen 10]
    , bond 301 "Ring of Bay Laurel" "Nero Claudius (Bride)" Icon.ArtsUp
      [party_ Arts 15]
    , bond 302 "Final Battle" "Beowulf" Icon.DamageUp
      [party (Special AttackUp <| VsTrait Dragon) 20]
    , bond 303 "Bratan of Wisdom" "Fionn mac Cumhaill" Icon.ArtsUp
      [party_ Arts 10, party NPUp 10]
    , bond 304 "Prelati's Spellbook" "Gilles de Rais" Icon.BusterUp
      [party_ Buster 20, demeritAll DebuffVuln 20]
    , bond 305 "Parasitic Bomb" "Mephistopheles" Icon.BeamUp
      [party NPUp 20]
    , bond 306 "Seethe of a Warrior" "Fergus mac Roich" Icon.BusterUp
      [party_ Buster 10, party NPUp 10]
    , bond 307 "My Loathsome Life" "Charles-Henri Sanson" Icon.ReaperUp
      [party DeathUp 10, party NPGen 10]
    , bond 308 "There is No Love Here" "Caligula" Icon.BusterUp
      [party_ Buster 20, demeritAll DefenseDown 10]
    , { name    = "Magical Girl of Sapphire"
      , id      = 309
      , rarity  = 5
      , icon    = Icon.NobleUp
      , stats   = { base = { atk = 500,  hp = 0 }
                  , max  = { atk = 2000, hp = 0 }
                  }
      , effect  = [ Grant Self 0 NPGen <| Range 25 30
                  , To Self GaugeUp <| Range 40 50
                  ]
      , bond    = Nothing
      , limited = True
      }
    , { name    = "Kill on Sight"
      , id      = 310
      , rarity  = 4
      , icon    = Icon.ArtsUp
      , stats   = { base = { atk = 200, hp = 320 }
                  , max  = { atk = 750, hp = 1200 }
                  }
      , effect  = [ Grant Self 0 (CardUp Arts) <| Range 8 10
                  , Grant Self 0 NPUp <| Range 15 20
                  ]
      , bond    = Nothing
      , limited = True
      }
    , { name    = "Zunga Zunga!"
      , id      = 311
      , rarity  = 3
      , icon    = Icon.ShieldUp
      , stats   = { base = { atk = 0, hp = 300 }
                  , max  = { atk = 0, hp = 1500 }
                  }
      , effect  = [ Grant Self 0 DamageCut <| Range 100 200
                  , Grant Self 0 HealingReceived <| Range 5 10
                  ]
      , bond    = Nothing
      , limited = True
      }
    , { name    = "Kaleid Ruby"
      , id      = 312
      , rarity  = 4
      , icon    = Icon.BusterUp
      , stats   = { base = { atk = 400,  hp = 0 }
                  , max  = { atk = 1500, hp = 0 }
                  }
      , effect  = [ Grant Self 0 (CardUp Buster) <| Range 10 15
                  , Grant Self 0 NPUp <| Range 8 10
                  ]
      , bond    = Nothing
      , limited = True
      }
    , { name    = "Kaleid Sapphire"
      , id      = 313
      , rarity  = 4
      , icon    = Icon.ArtsUp
      , stats   = { base = { atk = 400,  hp = 0 }
                  , max  = { atk = 1500, hp = 0 }
                  }
      , effect  = [ Grant Self 0 (CardUp Arts) <| Range 10 15
                  , Grant Self 0 NPUp <| Range 8 10
                  ]
      , bond    = Nothing
      , limited = True
      }
    , bond 315 "Mugashiki—Shinkuu Myou" "Ryougi Shiki (Saber)" Icon.ArtsUp
      [party_ Arts 15]
    , bond 316 "Frontliner's Flag" "Amakusa Shirou" Icon.DamageUp
      [ party (Special AttackUp <| VsTrait Undead) 20
      , party (Special AttackUp <| VsTrait Demonic) 20
      ]
    , bond 317 "Chateau d'If" "Edmond Dantes" Icon.QuickUp
      [party_ Quick 15]
    , bond 318 "Unlimited Pancakes" "Medea (Lily)" Icon.HealUp
      [party HealingReceived 30]
    , bond 319 "Red Leather Jacket" "Ryougi Shiki (Assassin)" Icon.ReaperUp
      [party DeathUp 30]
    , bond 320 "Otherworldly Mystical Horse" "Astolfo" Icon.Dodge
      [self NPUp 30, Times 1 <| Grant Party 0 Evasion Full]
    , bond 321 "Letter From a Friend" "Gilles de Rais (Caster)" Icon.BusterUp
      [party_ Buster 20, demeritAll StarDown 20]
    , bond 322 "Hound of Culann" "Cu Chulainn (Prototype)" Icon.DamageUp
      [party (Special AttackUp <| VsTrait WildBeast) 20]
    , bond 323 "Radiance of the Goddess (Euryale)" "Euryale" Icon.ArtsUp
      [party_ Arts 15]
    , bond 324 "Hero's Armament" "Hektor" Icon.BeamUp
      [party NPUp 20]
    , { name    = "Glory Is With Me"
      , id      = 325
      , rarity  = 5
      , icon    = Icon.BeamUp
      , stats   = { base = { atk = 500,  hp = 0 }
                  , max  = { atk = 2000, hp = 0 }
                  }
      , effect  = [ Grant Self 0 NPUp <| Range 15 20
                  , Grant Self 0 CritUp <| Range 15 20
                  , Grant Self 0 StarsPerTurn <| Range 3 4
                  ]
      , bond    = Nothing
      , limited = True
      }
    , { name    = "Original Legion"
      , id      = 326
      , rarity  = 4
      , icon    = Icon.ShieldUp
      , stats   = { base = { atk = 200, hp = 320 }
                  , max  = { atk = 750, hp = 1200 }
                  }
      , effect  = [ Grant Self 0 DefenseUp <| Range 8 20
                  , Grant Self 0 NPUp <| Range 15 20
                  ]
      , bond    = Nothing
      , limited = True
      }
    , { name    = "Howl at the Moon"
      , id      = 327
      , rarity  = 3
      , icon    = Icon.BusterUp
      , stats   = { base = { atk = 200,  hp = 0 }
                  , max  = { atk = 1000, hp = 0 }
                  }
      , effect  = [ Grant Self 0 (CardUp Buster) <| Range 10 15
                  , Debuff Self 0 DebuffVuln <| Flat 20
                  ]
      , bond    = Nothing
      , limited = True
      }
    , { name    = "Princess of the White Rose"
      , id      = 328
      , rarity  = 5
      , icon    = Icon.Kneel
      , stats   = { base = { atk = 250,  hp = 400 }
                  , max  = { atk = 1000, hp = 1600 }
                  }
      , effect  = [ Times 1 << Grant Self 0 Guts <| Flat 1
                  , To Self GaugeUp <| Range 10 20
                  ]
      , bond    = Nothing
      , limited = True
      }
    , { name    = "Joint Recital"
      , id      = 329
      , rarity  = 5
      , icon    = Icon.BusterUp
      , stats   = { base = { atk = 500,  hp = 0 }
                  , max  = { atk = 2000, hp = 0 }
                  }
      , effect  = [ Grant Self 0 (CardUp Buster) <| Range 15 20
                  , Grant Self 0 CritUp <| Range 15 20
                  ]
      , bond    = Nothing
      , limited = True
      }
    , { name    = "Chaldea Lunchtime"
      , id      = 330
      , rarity  = 5
      , icon    = Icon.Rainbow
      , stats   = { base = { atk = 250,  hp = 400 }
                  , max  = { atk = 1000, hp = 1600 }
                  }
      , effect  = [ Bonus Bond Percent <| Range 2 10 ]
      , bond    = Nothing
      , limited = True
      }
    , { name    = "Fragarach"
      , id      = 331
      , rarity  = 3
      , icon    = Icon.StarUp
      , stats   = { base = { atk = 200,  hp = 0 }
                  , max  = { atk = 1000, hp = 0 }
                  }
      , effect  = [ Grant Self 0 GatherUp <| Range 200 300 ]
      , bond    = Nothing
      , limited = False
      }
    , { name    = "Inverted Moon of the Heavens"
      , id      = 332
      , rarity  = 3
      , icon    = Icon.StarTurn
      , stats   = { base = { atk = 0, hp = 300 }
                  , max  = { atk = 0, hp = 1500 }
                  }
      , effect  = [ Grant Self 0 StarsPerTurn <| Range 1 2
                  , Grant Self 0 DebuffResist <| Range 5 10
                  ]
      , bond    = Nothing
      , limited = False
      }
    , { name    = "Hydra Dagger"
      , id      = 333
      , rarity  = 3
      , icon    = Icon.ReaperUp
      , stats   = { base = { atk = 200,  hp = 0 }
                  , max  = { atk = 1000, hp = 0 }
                  }
      , effect  = [ Grant Self 0 DeathUp <| Range 5 10 ]
      , bond    = Nothing
      , limited = False
      }
    , bond 334 "Indefatigable" "Florence Nightingale" Icon.BusterUp
      [party_ Buster 10, party HealingReceived 20]
    , bond 335 "One-Man War" "Cu Chulainn (Alter)" Icon.Kneel
      [self NPUp 30, gutsPercent 20]
    , bond 336 "Sacred Spring" "Queen Medb" Icon.NobleUp
      [party NPGen 15]
    , bond 337 "Indestructible Blade" "Rama" Icon.ExclamationUp
      [party CritUp 25]
    , bond 338 "Concealed Goddess" "Helena Blavatsky" Icon.DamageUp
      [party (Special AttackUp <| VsClass Assassin) 20]
    , bond 339 "Lights of Civilization" "Thomas Edison" Icon.NobleUp
      [party NPGen 15]
    , bond 340 "Reaching the Zenith of My Skill" "Li Shuwen" Icon.ArtsUp
      [party_ Arts 15]
    , bond 341 "Knight's Oath" "Diarmuid Ua Duibhne" Icon.ArtsUp
      [party_ Quick 10, party_ Arts 10]
    , bond 342 "Elemental" "Paracelsus von Hohenheim" Icon.ArtsUp
      [party_ Arts 10, party NPUp 10]
    , bond 343 "NEO Difference Engine" "Charles Babbage" Icon.BusterUp
      [party_ Buster 20, demeritAll DefenseDown 10]
    , { name    = "Dangerous Beast"
      , id      = 344
      , rarity  = 5
      , icon    = Icon.QuickUp
      , stats   = { base = { atk = 500,  hp = 0 }
                  , max  = { atk = 2000, hp = 0 }
                  }
      , effect  = [ Grant Self 0 (CardUp Quick) <| Range 15 20
                  , Grant Self 0 StarsPerTurn <| Range 3 4
                  ]
      , bond    = Nothing
      , limited = True
      }
    , { name    = "Witch Under the Moonlight"
      , id      = 345
      , rarity  = 4
      , icon    = Icon.ArtsUp
      , stats   = { base = { atk = 200, hp = 320 }
                  , max  = { atk = 750, hp = 1200 }
                  }
      , effect  = [ Grant Self 0 (CardUp Arts) <| Range 10 15
                  , Grant Self 0 NPGen <| Range 5 10
                  ]
      , bond    = Nothing
      , limited = True
      }
    , { name    = "Count Romani Archaman's Hospitality"
      , id      = 346
      , rarity  = 3
      , icon    = Icon.NobleUp
      , stats   = { base = { atk = 0, hp = 300 }
                  , max  = { atk = 0, hp = 1500 }
                  }
      , effect  = [ Grant Self 0 NPGen <| Range 5 10
                  , Grant Self 0 DefenseUp <| Range 3 5
                  ]
      , bond    = Nothing
      , limited = True
      }
    , { name    = "Hero Elly's Adventure"
      , id      = 347
      , rarity  = 5
      , icon    = Icon.BusterUp
      , stats   = { base = { atk = 500,  hp = 0 }
                  , max  = { atk = 2000, hp = 0 }
                  }
      , effect  = [ Grant Self 0 (CardUp Buster) <| Range 10 15
                  , Grant Self 0 NPUp <| Range 20 25
                  ]
      , bond    = Nothing
      , limited = True
      }
    , { name    = "Wizard & Priest"
      , id      = 348
      , rarity  = 4
      , icon    = Icon.BeamUp
      , stats   = { base = { atk = 200, hp = 320 }
                  , max  = { atk = 750, hp = 1200 }
                  }
      , effect  = [ Grant Self 0 NPUp <| Range 15 20
                  , Grant Self 0 HealingReceived <| Range 10 20
                  ]
      , bond    = Nothing
      , limited = True
      }
    , { name    = "Mata Hari's Tavern"
      , id      = 349
      , rarity  = 3
      , icon    = Icon.AllUp
      , stats   = { base = { atk = 200,  hp = 0 }
                  , max  = { atk = 1000, hp = 0 }
                  }
      , effect  = [ Grant Self 0 (CardUp Arts) <| Range 2 3
                  , Grant Self 0 (CardUp Buster) <| Range 2 3
                  , Grant Self 0 (CardUp Quick) <| Range 2 3
                  , Grant Self 0 CritUp <| Range 5 10
                  ]
      , bond    = Nothing
      , limited = True
      }
    , bond 350 "Hell of Blazing Punishment" "Jeanne d'Arc (Alter)" Icon.BusterUp
      [party_ Buster 15]
    , bond 351 "Gordian Knot" "Iskandar" Icon.SwordUp
      [party AttackUp 15]
    , bond 352 "White Dragon" "Xuanzang Sanzang" Icon.BusterUp
      [party_ Buster 20, demeritAll DefenseDown 10]
    , bond 353 "The Sun Shines Here" "Emiya (Assassin)" Icon.ArtsQuickUp
      [party_ Quick 10, party_ Arts 10]
    , bond 354 "Dress of Heaven" "Irisviel (Holy Grail)" Icon.HealUp
      [party HealingReceived 30]
    , bond 355 "Manifestation of the Golden Rule" "Gilgamesh (Child)" Icon.NobleUp
      [party NPGen 15]
    , bond 356 "Spirit of the Vast Land" "Geronimo" Icon.NobleUp
      [party NPGen 15]
    , bond 357 "Extolling the Revolver" "Billy the Kid" Icon.ExclamationUp
      [party CritUp 25]
    , bond 358 "Library of Hundred Men" "Hassan of the Hundred Personas" Icon.AllUp
      [party_ Buster 8, party_ Quick 8, party_ Arts 8]
    , bond 359 "Final Fragment" "Angra Mainyu" Icon.DamageUp
      [ gutsPercent 20
      , self (Special AttackUp <| VsClass Beast1) 200
      , self (Special AttackUp <| VsClass Beast2) 200
      , self (Special AttackUp <| VsClass Beast3L) 200
      , self (Special AttackUp <| VsClass Beast3R) 200
      ]
    , gift 360 "Fate/EXTELLA" Icon.ExclamationUp
      [self CritUp 15, self StarsPerTurn 3]
    , gift 361 "Spiritron Portrait: Nero Claudius" Icon.Road
      [Bonus EXP Units <| Flat 50]
    , gift 362 "Spiritron Portrait: Nameless" Icon.Road
      [Bonus EXP Units <| Flat 50]
    , gift 363 "Spiritron Portrait: Tamamo-no-Mae" Icon.Road
      [Bonus EXP Units <| Flat 50]
    , gift 364 "Spiritron Portrait: Karna" Icon.Road
      [Bonus EXP Units <| Flat 50]
    , gift 365 "Spiritron Portrait: Altera" Icon.Road
      [Bonus EXP Units <| Flat 50]
    , gift 366 "Spiritron Portrait: Gilgamesh" Icon.Road
      [Bonus EXP Units <| Flat 50]
    , bond 367 "Divine Wine—Shinpen Kidoku" "Shuten-Douji" Icon.ArtsQuickUp
      [party_ Quick 10, party_ Arts 10]
    , bond 368 "Doujigiri Yasutsuna" "Minamoto-no-Raikou" Icon.BusterUp
      [party_ Buster 10, party CritUp 15]
    , bond 369 "Ramesseum" "Ozymandias" Icon.BusterArtsUp
      [party_ Arts 10, party_ Buster 10]
    , bond 370 "Bone Sword (Nameless)" "Ibaraki-Douji" Icon.BusterUp
      [party_ Buster 20, demeritAll DefenseDown 10]
    , bond 371 "Unit Golden Bear" "Sakata Kintoki (Rider)" Icon.StarHaloUp
      [party StarUp 20]
    , bond 372 "Gringolet" "Gawain" Icon.BusterUp
      [party_ Buster 15]
    , bond 373 "But I Lied Once" "Tristan" Icon.ExclamationUp
      [party CritUp 25]
    , bond 374 "Exercising the Royal Authority" "Nitocris" Icon.NobleUp
      [party NPGen 10, party NPUp 10]
    , bond 375 "Mask of a Demon" "Fuuma \"Evil-wind\" Kotarou" Icon.QuickUp
      [party_ Quick 15]
    , bond 376 "Cook Despite of Exhaustion" "Tawara Touta" Icon.HealTurn
      [party HealPerTurn 500]
    , bond 377 "King's Horse" "Altria Pendragon (Lancer)" Icon.SwordUp
      [party AttackUp 10, party NPUp 10]
    , bond 378 "All-Encompassing Wisdom" "Leonardo da Vinci" Icon.BeamUp
      [party NPUp 20]
    , bond 379 "Sunset Beach" "Tamamo-no-Mae (Lancer)" Icon.QuickBusterUp
      [party_ Quick 10, party_ Buster 10]
    , bond 380 "Lady of the Lake" "Lancelot (Saber)" Icon.NobleUp
      [party NPGen 10, party CritUp 10]
    , bond 381 "Reminiscence of the Summer"
              "Marie Antoinette (Caster)" Icon.ExclamationUp
      [party CritUp 25]
    , bond 382 "Currently in the Middle of a Shower"
              "Anne Bonny & Mary Read (Archer)" Icon.BusterArtsUp
      [party_ Buster 10, party_ Arts 10]
    , bond 383 "Prydwen" "Mordred (Rider)" Icon.BeamUp
      [party NPUp 20]
    , bond 384 "Beach Love Letter (Terror)" "Kiyohime (Lancer)" Icon.BusterUp
      [party_ Buster 20, demeritAll DefenseDown 10]
    , bond 385 "Lost Right Arm" "Bedivere" Icon.BusterUp
      [party_ Buster 10, party NPGen 10]
    , bond 386 "Proof of Existence" "Hassan of the Serenity" Icon.QuickUp
      [party_ Quick 15]
    , { name    = "A Moment of Tranquility"
      , id      = 387
      , rarity  = 5
      , icon    = Icon.ArtsQuickUp
      , stats   = { base = { atk = 500,  hp = 0 }
                  , max  = { atk = 2000, hp = 0 }
                  }
      , effect  = [ Grant Self 0 (CardUp Quick) <| Range 10 15
                  , Grant Self 0 (CardUp Arts) <| Range 10 15
                  , Grant Self 0 NPGen <| Range 10 15
                  ]
      , bond    = Nothing
      , limited = True
      }
    , { name    = "Reading on the Holy Night"
      , id      = 388
      , rarity  = 4
      , icon    = Icon.NobleUp
      , stats   = { base = { atk = 200, hp = 320 }
                  , max  = { atk = 750, hp = 1200 }
                  }
      , effect  = [ Grant Self 0 NPGen <| Range 15 20
                  , Grant Self 0 NPUp <| Range 15 20
                  ]
      , bond    = Nothing
      , limited = True
      }
    , { name    = "Saint's Invitation"
      , id      = 389
      , rarity  = 3
      , icon    = Icon.ShieldUp
      , stats   = { base = { atk = 0, hp = 300 }
                  , max  = { atk = 0, hp = 1500 }
                  }
      , effect  = [ Grant Self 0 DefenseUp <| Range 3 5
                  , Grant Self 0 DamageCut <| Range 100 200
                  ]
      , bond    = Nothing
      , limited = True
      }
    , { name    = "Holy Night Supper"
      , id      = 390
      , rarity  = 5
      , icon    = Icon.Noble
      , stats   = { base = { atk = 500,  hp = 0 }
                  , max  = { atk = 2000, hp = 0 }
                  }
      , effect  = [ To Self GaugeUp <| Range 30 50
                  , Grant Self 0 CritUp <| Range 10 15
                  , Grant Self 0 NPUp <| Range 10 15
                  ]
      , bond    = Nothing
      , limited = True
      }
    , bond 391 "Champion Cup" "Altria Pendragon (Archer)" Icon.SwordUp
      [party AttackUp 15]
    , bond 392 "Phantasmal Summoning (Install)" "Illyasviel von Einzbern" Icon.AllUp
      [party_ Buster 8, party_ Quick 8, party_ Arts 8]
    , bond 393 "Serpent of Fate" "Cleopatra" Icon.BeamUp
      [party NPUp 25, demeritAll DefenseDown 10]
    , bond 394 "Holy Knuckle" "Martha (Ruler)" Icon.BusterUp
      [party_ Buster 15]
    , bond 395 "Minimal Prudence" "Scathach (Assassin)" Icon.QuickUp
      [party_ Quick 15]
    , bond 396 "Sharing of Pain" "Chloe von Einzbern" Icon.ExclamationUp
      [party CritUp 30, demeritAll HealthLoss 200]
    , bond 397 "Creed at the Bottom of the Earth" "Vlad III (EXTRA)" Icon.QuickBusterUp
      [party_ Quick 10, party_ Buster 10]
    , bond 398 "Invitation to Halloween" "Elisabeth Bathory (Brave)" Icon.BusterUp
      [party_ Buster 20, demeritAll DefenseDown 10]
    , gift 399 "First Order" Icon.Road
      [Bonus MysticCode Units <| Flat 50]
    , { name    = "Devilish Bodhisattva"
      , id      = 400
      , rarity  = 5
      , icon    = Icon.SunUp
      , stats   = { base = { atk = 250,  hp = 400 }
                  , max  = { atk = 1000, hp = 1600 }
                  }
      , effect  = [ To Self GaugeUp <| Range 50 60
                  , Times 1 << Grant Self 0 Overcharge <| Flat 2
                  ]
      , bond    = Nothing
      , limited = False
      }
    , { name    = "Room Guard"
      , id      = 401
      , rarity  = 4
      , icon    = Icon.StarUp
      , stats   = { base = { atk = 0, hp = 600 }
                  , max  = { atk = 0, hp = 2250 }
                  }
      , effect  = [ Grant Self 0 GatherUp <| Range 300 400
                  , Grant Self 0 DamageCut <| Range 300 400
                  ]
      , bond    = Nothing
      , limited = False
      }
    , { name    = "Over the Cuckoo's Nest"
      , id      = 414
      , rarity  = 3
      , icon    = Icon.Crystal
      , stats   = { base = { atk = 200,  hp = 0 }
                  , max  = { atk = 1000, hp = 0 }
                  }
      , effect  = [ Bonus QPQuest Units <| Flat 2019
                  , Grant Self 0 DamageUp <| Range 0 19
                  ]
      , bond    = Nothing
      , limited = True
      }
    , { name    = "Cheers to 2019"
      , id      = 415
      , rarity  = 4
      , icon    = Icon.HealTurn
      , stats   = { base = { atk = 0, hp = 2019 }
                  , max  = { atk = 0, hp = 2019 }
                  }
      , effect  = [ Grant Self 0 HealPerTurn <| Flat 100 ]
      , bond    = Nothing
      , limited = True
      }
    , { name    = "Reality Marble"
      , id      = 418
      , rarity  = 3
      , icon    = Icon.BeamUp
      , stats   = { base = { atk = 100, hp = 160 }
                  , max  = { atk = 500, hp = 800 }
                  }
      , effect  = [ equipped Archer << Grant Self 0 NPUp <| Range 15 25 ]
      , bond    = Nothing
      , limited = False
      }
    , { name    = "Potion of Youth"
      , id      = 419
      , rarity  = 3
      , icon    = Icon.HoodUp
      , stats   = { base = { atk = 0, hp = 300 }
                  , max  = { atk = 0, hp = 1500 }
                  }
      , effect  = [ Grant Self 0 (Resist AttackDown) <| Range 25 30 ]
      , bond    = Nothing
      , limited = False
      }
    , { name    = "Collection of Mysterious Masks"
      , id      = 420
      , rarity  = 3
      , icon    = Icon.StarUp
      , stats   = { base = { atk = 100, hp = 160 }
                  , max  = { atk = 500, hp = 800 }
                  }
      , effect  = [ Grant Self 0 GatherUp <| Range 100 200
                  , Grant Self 0 StarUp <| Range 5 10
                  ]
      , bond    = Nothing
      , limited = False
      }
    , { name    = "Cute Orangette"
      , id      = 421
      , rarity  = 5
      , icon    = Icon.NobleUp
      , stats   = { base = { atk = 500,  hp = 0 }
                  , max  = { atk = 2000, hp = 0 }
                  }
      , effect  = [ Grant Self 0 NPGen <| Range 25 30
                  , Grant Self 0 NPUp <| Range 15 20
                  ]
      , bond    = Nothing
      , limited = True
      }
    , { name    = "Chocolatier"
      , id      = 422
      , rarity  = 5
      , icon    = Icon.ArtsUp
      , stats   = { base = { atk = 250,  hp = 400 }
                  , max  = { atk = 1000, hp = 1600 }
                  }
      , effect  = [ Grant Self 0 (CardUp Arts) <| Range 15 20
                  , Grant Self 0 StarsPerTurn <| Range 3 4
                  ]
      , bond    = Nothing
      , limited = True
      }
    , { name    = "Bitter Black"
      , id      = 424
      , rarity  = 4
      , icon    = Icon.HealUp
      , stats   = { base = { atk = 200, hp = 320 }
                  , max  = { atk = 750, hp = 1200 }
                  }
      , effect  = [ Grant Self 0 HealingReceived <| Range 15 20
                  , Grant Self 0 NPGen <| Range 15 20
                  ]
      , bond    = Nothing
      , limited = True
      }
    , { name    = "Blissful Time"
      , id      = 425
      , rarity  = 3
      , icon    = Icon.HealUp
      , stats   = { base = { atk = 200,  hp = 0 }
                  , max  = { atk = 1000, hp = 0 }
                  }
      , effect  = [ Grant Self 0 HealingReceived <| Range 5 10
                  , Grant Self 0 StarUp <| Range 5 10
                  ]
      , bond    = Nothing
      , limited = True
      }
    , { name    = "Arrogance of a Victor"
      , id      = 426
      , rarity  = 3
      , icon    = Icon.ShieldUp
      , stats   = { base = { atk = 0, hp = 300 }
                  , max  = { atk = 0, hp = 1500 }
                  }
      , effect  = [ Grant Self 0 DamageCut <| Range 100 200
                  , Grant Self 0 StarUp <| Range 5 10
                  ]
      , bond    = Nothing
      , limited = True
      }
    , { name    = "Sweet Crystal"
      , id      = 427
      , rarity  = 5
      , icon    = Icon.ShieldBreak
      , stats   = { base = { atk = 500,  hp = 0 }
                  , max  = { atk = 2000, hp = 0 }
                  }
      , effect  = [ Grant Self 0 IgnoreInvinc Full
                  , To Self GaugeUp <| Range 30 50
                  ]
      , bond    = Nothing
      , limited = True
      }
    , { name    = "Fondant au Chocolat"
      , id      = 428
      , rarity  = 5
      , icon    = Icon.DamageUp
      , stats   = { base = { atk = 500,  hp = 0 }
                  , max  = { atk = 2000, hp = 0 }
                  }
      , effect  = [ Grant Self 0 (Special AttackUp <| VsTrait Divine) <| Range 25 30
                  , To Self GaugeUp <| Range 30 50
                  ]
      , bond    = Nothing
      , limited = True
      }
    , bond 403 "Seven-Headed Warhammer Sita" "Ishtar" Icon.BusterUp
      [party_ Buster 20, demeritAll DebuffVuln 20]
    , bond 404 "Flower of Humbaba" "Enkidu" Icon.HealTurn
      [party HealPerTurn 500]
    , bond 405 "Piedra del Sol" "Quetzalcoatl" Icon.BusterArtsUp
      [party_ Arts 10, party_ Buster 10]
    , bond 406 "Door to the Ocean" "Jeanne d'Arc Alter Santa Lily" Icon.HealUp
      [party HealingReceived 30]
    , bond 407 "Dup Shimati" "Gilgamesh (Caster)" Icon.BeamUp
      [party NPUp 20]
    , bond 408 "Chrysaor" "Gorgon" Icon.BusterUp
      [party_ Buster 10, party NPGen 10]
    , bond 409 "Uncertainty About the Future" "Medusa (Lancer)" Icon.QuickUp
      [party_ Quick 10, party NPGen 10]
    , bond 410 "Primeval Flame" "Jaguar Warrior" Icon.BusterUp
      [party_ Buster 15]
    , bond 411 "The Furthest Tower" "Merlin" Icon.BusterUp
      [party_ Buster 10, party CritUp 15]
    , bond 416 "Buddhism of Emptiness" "Miyamoto Musashi" Icon.HoodUp
      [self NPUp 30, Times 3 <| Grant Self 0 DebuffResist Full]
    , bond 417 "The Rift of the Valley" "\"First Hassan\"" Icon.HoodUp
      [self DebuffResist 100]
    , bond 429 "Dark Knight-Kun" "Mysterious Heroine X (Alter)" Icon.DamageUp
      [party (Special AttackUp <| VsClass Saber) 20]
    , bond 546 "The Dynamics of an Asteroid" "James Moriarty" Icon.BeamUp
      [Grant (AlliesType Evil) 0 NPUp <| Flat 25]
    , bond 547 "Kanshou & Bakuya (Revolvers)" "EMIYA (Alter)" Icon.AllUp
      [party_ Quick 8, party_ Arts 8, party_ Buster 8]
    , bond 548 "Jenseits der Wildnis" "Hessian Lobo" Icon.QuickUp
      [self (CardUp Quick) 10, party NPGen 10]
    , bond 549 "108 Stars of Destiny" "Yan Qing" Icon.QuickUp
      [party_ Quick 10, party CritUp 15]
    , { name    = "Conversation on the Hot Sands"
      , id      = 550
      , rarity  = 5
      , icon    = Icon.StarUp
      , stats   = { base = { atk = 500,  hp = 0 }
                  , max  = { atk = 2000, hp = 0 }
                  }
      , effect  = [ Grant Self 0 GatherUp <| Range 400 600
                  , Grant Self 0 CritUp <| Range 20 25
                  ]
      , bond    = Nothing
      , limited = True
      }
    , { name    = "The Dantes Files: The Case of the Spring Jaunt"
      , id      = 551
      , rarity  = 5
      , icon    = Icon.ShieldBreak
      , stats   = { base = { atk = 250,  hp = 400 }
                  , max  = { atk = 1000, hp = 1600 }
                  }
      , effect  = [ Grant Self 0 IgnoreInvinc Full
                  , Grant Self 0 (CardUp Arts) <| Range 8 10
                  ]
      , bond    = Nothing
      , limited = True
      }
    , { name    = "Cafe Camelot"
      , id      = 553
      , rarity  = 4
      , icon    = Icon.HealUp
      , stats   = { base = { atk = 0, hp = 600 }
                  , max  = { atk = 0, hp = 2250 }
                  }
      , effect  = [ Grant Self 0 HealingReceived <| Range 8 10
                  , Grant Self 0 DebuffResist <| Range 8 10
                  , Grant Self 0 DefenseUp <| Range 8 10
                  ]
      , bond    = Nothing
      , limited = True
      }
    , { name    = "Outrage"
      , id      = 554
      , rarity  = 4
      , icon    = Icon.CrosshairUp
      , stats   = { base = { atk = 400,  hp = 0 }
                  , max  = { atk = 1500, hp = 0 }
                  }
      , effect  = [ Grant Self 1 Taunt Full
                  , Grant Self 1 NPGen <| Range 15 20
                  ]
      , bond    = Nothing
      , limited = True
      }
    , { name    = "Operation Fianna"
      , id      = 555
      , rarity  = 4
      , icon    = Icon.Star
      , stats   = { base = { atk = 200, hp = 320 }
                  , max  = { atk = 750, hp = 1200 }
                  }
      , effect  = [ To Party GainStars <| Range 10 20
                  , Grant Self 0 (CardUp Buster) <| Range 8 10
                  ]
      , bond    = Nothing
      , limited = True
      }
    , { name    = "Quatre Feuilles"
      , id      = 556
      , rarity  = 3
      , icon    = Icon.AllUp
      , stats   = { base = { atk = 100, hp = 160 }
                  , max  = { atk = 500, hp = 800 }
                  }
      , effect  = [ Grant Self 0 (CardUp Arts) <| Range 2 3
                  , Grant Self 0 (CardUp Buster) <| Range 2 3
                  , Grant Self 0 (CardUp Quick) <| Range 2 3
                  , Grant Self 0 MentalResist <| Range 3 5
                  ]
      , bond    = Nothing
      , limited = True
      }
    , { name    = "Neverland"
      , id      = 557
      , rarity  = 3
      , icon    = Icon.StarHaloUp
      , stats   = { base = { atk = 200,  hp = 0 }
                  , max  = { atk = 1000, hp = 0 }
                  }
      , effect  = [ Grant Self 0 CritUp <| Range 4 8
                  , Grant Self 0 StarUp <| Range 4 8
                  , Grant Self 0 NPUp <| Range 4 8
                  ]
      , bond    = Nothing
      , limited = True
      }
    , bond 559 "Garden" "Arthur Pendragon (Prototype)" Icon.SwordUp
      [party AttackUp 15]
    , { name    = "Demon King of the Sixth Heaven"
      , id      = 560
      , rarity  = 5
      , icon    = Icon.BusterUp
      , stats   = { base = { atk = 500,  hp = 0 }
                  , max  = { atk = 2000, hp = 0 }
                  }
      , effect  = [ Grant Self 0 (CardUp Buster) <| Range 15 20
                  , Grant Self 0 NPUp <| Range 15 20
                  ]
      , bond    = Nothing
      , limited = True
      }
    , { name    = "Fortress of the Sun"
      , id      = 561
      , rarity  = 5
      , icon    = Icon.ExclamationUp
      , stats   = { base = { atk = 250,  hp = 400 }
                  , max  = { atk = 1000, hp = 1600 }
                  }
      , effect  = [ Grant Self 0 CritUp <| Range 15 20
                  , Grant Self 0 StarUp <| Range 15 20
                  , To Self GaugeUp <| Range 25 40
                  ]
      , bond    = Nothing
      , limited = True
      }
    , { name    = "Wolves of Mibu"
      , id      = 562
      , rarity  = 5
      , icon    = Icon.QuickBusterUp
      , stats   = { base = { atk = 500,  hp = 0 }
                  , max  = { atk = 2000, hp = 0 }
                  }
      , effect  = [ Grant Self 0 (CardUp Buster) <| Range 8 10
                  , Grant Self 0 (CardUp Quick) <| Range 8 10
                  , Grant Self 0 StarsPerTurn <| Range 3 4
                  ]
      , bond    = Nothing
      , limited = True
      }
    , { name    = "A Stroll in the Spring Breeze"
      , id      = 563
      , rarity  = 4
      , icon    = Icon.NobleUp
      , stats   = { base = { atk = 0, hp = 600 }
                  , max  = { atk = 0, hp = 2250 }
                  }
      , effect  = [ Grant Self 0 NPGen <| Range 15 20
                  , Grant Self 0 DamageCut <| Range 300 400
                  ]
      , bond    = Nothing
      , limited = True
      }
    , { name    = "The Flower of High Society"
      , id      = 564
      , rarity  = 3
      , icon    = Icon.ArtsQuickUp
      , stats   = { base = { atk = 100, hp = 160 }
                  , max  = { atk = 500, hp = 800 }
                  }
      , effect  = [ Grant Self 0 (CardUp Arts) <| Range 4 6
                  , Grant Self 0 (CardUp Quick) <| Range 4 6
                  ]
      , bond    = Nothing
      , limited = True
      }
    , bond 567 "Haori of the Oath" "Hijikata Toshizo" Icon.Kneel
      [Times 1 << Grant Self 0 Guts <| Flat 1, self CritUp 30]
    , bond 568 "Adzuki Beanbag" "Chacha" Icon.BeamUp
      [party NPUp 25, demeritAll DefenseDown 10]
    , { name    = "Conquering the Great Sea of Stars"
      , id      = 569
      , rarity  = 5
      , icon    = Icon.BusterUp
      , stats   = { base = { atk = 500,  hp = 0 }
                  , max  = { atk = 2000, hp = 0 }
                  }
      , effect  = [ Grant Self 0 (CardUp Buster) <| Range 15 20
                  , Grant Self 0 NPGen <| Range 15 20
                  ]
      , bond    = Nothing
      , limited = True
      }
    , { name    = "One Summer"
      , id      = 570
      , rarity  = 5
      , icon    = Icon.QuickUp
      , stats   = { base = { atk = 0, hp = 750 }
                  , max  = { atk = 0, hp = 3000 }
                  }
      , effect  = [ Grant Self 0 (CardUp Quick) <| Range 8 10
                  , Grant Self 0 NPUp <| Range 8 10
                  , To Self GaugeUp <| Range 30 50
                  ]
      , bond    = Nothing
      , limited = True
      }
    , { name    = "Premonition of Beginnings"
      , id      = 572
      , rarity  = 4
      , icon    = Icon.StarTurn
      , stats   = { base = { atk = 200, hp = 320 }
                  , max  = { atk = 750, hp = 1200 }
                  }
      , effect  = [ Grant Self 0 StarsPerTurn <| Range 2 3
                  , Grant Self 0 GaugePerTurn <| Range 2 3
                  ]
      , bond    = Nothing
      , limited = True
      }
    , bond 575 "The Radiant One" "Meltryllis" Icon.QuickUp
      [self (CardUp Quick) 20, self CritUp 30, demeritOthers CritDown 10]
    , bond 576 "Don't Avert Your Eyes Away From Me" "Passionlip" Icon.BusterUp
      [party_ Buster 20, demeritAll DebuffVuln 20]
    , bond 577 "A Passerby's Dream" "BB" Icon.AllUp
      [party_ Quick 8, party_ Arts 8, party_ Buster 8]
    , bond 578 "Tenma's Spring Training" "Suzuka Gozen" Icon.BusterUp
      [self (CardUp Buster) 10, party NPUp 10]
    , bond 579 "Dream from the Cradle" "Sessyoin Kiara" Icon.ArtsUp
      [self (CardUp Arts) 20, self HPUp 3000, demeritOthers HPDown 1000]
    , { name    = "Marugoshi Shinji"
      , id      = 581
      , rarity  = 3
      , icon    = Icon.HoodUp
      , stats   = { base = { atk = 0, hp = 300 }
                  , max  = { atk = 0, hp = 1500 }
                  }
      , effect  = [ Grant Self 0 (Resist DefenseDown) <| Range 25 30 ]
      , bond    = Nothing
      , limited = False
      }
    , { name    = "Ruined Church"
      , id      = 580
      , rarity  = 3
      , icon    = Icon.ShieldUp
      , stats   = { base = { atk = 100, hp = 160 }
                  , max  = { atk = 500, hp = 800 }
                  }
      , effect  = [ Grant Self 0 (Special DefenseUp <| VsTrait Male) <| Range 15 20 ]
      , bond    = Nothing
      , limited = False
      }
    , gift 583 "Fate/Apocrypha" Icon.Road
      [Bonus MysticCode Units <| Flat 50]
    , bond 586 "King Shahryay's Bedchamber" "Scheherazade" Icon.HoodUp
      [self DebuffResist 100]
    , bond 587 "The Palace of Luoyang" "Wu Zetian" Icon.QuickUp
      [party_ Quick 20, demeritAll DefenseDown 10]
    , bond 588 "Military Sash of the War God" "Penthesilea" Icon.BusterUp
      [party_ Buster 20, demeritAll DefenseDown 10]
    , bond 589 "Nina" "Christopher Columbus" Icon.BusterUp
      [party_ Buster 10, party NPGen 10]
    , { name    = "Chaldea Anniversary"
      , id      = 590
      , rarity  = 5
      , icon    = Icon.ArtsQuickUp
      , stats   = { base = { atk = 250,  hp = 400 }
                  , max  = { atk = 1000, hp = 1600 }
                  }
      , effect  = [ Grant Self 0 (CardUp Arts) <| Range 8 10
                  , Grant Self 0 (CardUp Quick) <| Range 8 10
                  , To Self GaugeUp <| Range 50 60
                  ]
      , bond    = Nothing
      , limited = True
      }
    , { name    = "Afternoon Party"
      , id      = 591
      , rarity  = 4
      , icon    = Icon.NobleTurn
      , stats   = { base = { atk = 200, hp = 320 }
                  , max  = { atk = 750, hp = 1200 }
                  }
      , effect  = [ Grant Self 0 GaugePerTurn <| Range 4 5
                  , Grant Self 0 (CardUp Arts) <| Range 10 12
                  ]
      , bond    = Nothing
      , limited = True
      }
    , { name    = "Starlight Fest"
      , id      = 592
      , rarity  = 3
      , icon    = Icon.StarUp
      , stats   = { base = { atk = 100, hp = 160 }
                  , max  = { atk = 500, hp = 800 }
                  }
      , effect  = [ Grant Self 0 GatherUp <| Range 100 200
                  , Grant Self 0 (CardUp Quick) <| Range 2 3
                  ]
      , bond    = Nothing
      , limited = True
      }
    , gift 593 "Learning With Manga! FGO" Icon.Road
      [Bonus EXP Units <| Flat 50]
    , gift 607 "Formal Portrait: Atalante" Icon.Road
      [Bonus MysticCode Units <| Flat 50]
    , bond 641 "Frontier" "Paul Bunyan" Icon.BusterUp
      [party_ Buster 15]
    , bond 642 "The Vaunted One" "Sherlock Holmes" Icon.QuickUp
      [party_ Quick 10, party CritUp 15]
    , { name    = "Summer Little"
      , id      = 643
      , rarity  = 5
      , icon    = Icon.NobleUp
      , stats   = { base = { atk = 250,  hp = 400 }
                  , max  = { atk = 1000, hp = 1600 }
                  }
      , effect  = [ Grant Self 0 NPGen <| Range 25 30
                  , Grant Self 0 NPUp <| Range 10 15
                  , Grant Self 0 CritUp <| Range 10 15
                  ]
      , bond    = Nothing
      , limited = True
      }
    , { name    = "White Cruising"
      , id      = 644
      , rarity  = 4
      , icon    = Icon.BusterArtsUp
      , stats   = { base = { atk = 200, hp = 320 }
                  , max  = { atk = 750, hp = 1200 }
                  }
      , effect  = [ Grant Self 0 (CardUp Arts) <| Range 8 10
                  , Grant Self 0 (CardUp Buster) <| Range 8 10
                  , Grant Self 0 NPGen <| Range 8 10
                  ]
      , bond    = Nothing
      , limited = True
      }
    , { name    = "Sugar Vacation"
      , id      = 645
      , rarity  = 3
      , icon    = Icon.ShieldUp
      , stats   = { base = { atk = 0, hp = 300 }
                  , max  = { atk = 0, hp = 1500 }
                  }
      , effect  = [ Grant Self 0 DefenseUp <| Range 3 5
                  , Grant Self 0 (CardUp Quick) <| Range 3 5
                  ]
      , bond    = Nothing
      , limited = True
      }
    , { name    = "Seaside Luxury"
      , id      = 646
      , rarity  = 5
      , icon    = Icon.StarHaloUp
      , stats   = { base = { atk = 500,  hp = 0 }
                  , max  = { atk = 2000, hp = 0 }
                  }
      , effect  = [ Grant Self 0 StarUp <| Range 20 25
                  , Grant Self 0 StarsPerTurn <| Range 3 4
                  ]
      , bond    = Nothing
      , limited = True
      }
    , bond 647 "Domus Aurea de Curcubeu Mare" "Nero Claudius (Caster)" Icon.BusterUp
      [party_ Buster 10, party NPGen 10]
    , bond 648 "Handy-Bandages" "Frankenstein (Saber)" Icon.QuickUp
      [self (CardUp Quick) 10, party NPGen 10]
    , bond 649 "A Gift From Ra" "Nitocris (Assassin)" Icon.ArtsUp
      [party_ Arts 10, party NPGen 10]
    , bond 650 "Tenka Fubu -2017 Summer.ver-" "Oda Nobunaga (Berserker)" Icon.BusterUp
      [party_ Buster 15, party CritUp 15, demeritAll DefenseDown 10]
    , bond 651 "Champion's Cup of the Goddess" "Ishtar (Rider)" Icon.QuickUp
      [party_ Quick 10, party NPUp 10]
    , bond 656 "Mop of Selection" "Altria Pendragon (Rider Alter)" Icon.SwordUp
      [party AttackUp 20, demeritAll DefenseDown 15]
    , bond 657 "NYARF!" "Helena Blavatsky (Archer)" Icon.ArtsQuickUp
      [party_ Quick 10, party_ Arts 10]
    , bond 658 "Kyougoku" "Minamoto-no-Raikou (Lancer)" Icon.QuickBusterUp
      [party_ Quick 10, party_ Buster 10]
    , { name    = "Battle Olympia"
      , id      = 660
      , rarity  = 5
      , icon    = Icon.BusterArtsUp
      , stats   = { base = { atk = 500,  hp = 0 }
                  , max  = { atk = 2000, hp = 0 }
                  }
      , effect  = [ Grant Self 0 (CardUp Arts) <| Range 8 10
                  , Grant Self 0 (CardUp Buster) <| Range 8 10
                  , To Self GaugeUp <| Range 50 60
                  ]
      , bond    = Nothing
      , limited = True
      }
    , { name    = "Divine Three-Legged Race"
      , id      = 661
      , rarity  = 5
      , icon    = Icon.Kneel
      , stats   = { base = { atk = 500,  hp = 0 }
                  , max  = { atk = 2000, hp = 0 }
                  }
      , effect  = [ Times 1 << Grant Self 0 Guts <| Flat 1
                  , Grant Self 0 NPUp <| Range 15 20
                  ]
      , bond    = Nothing
      , limited = True
      }
    , { name    = "At Wish's End"
      , id      = 666
      , rarity  = 5
      , icon    = Icon.StarUp
      , stats   = { base = { atk = 250,  hp = 400 }
                  , max  = { atk = 1000, hp = 1600 }
                  }
      , effect  = [ Grant Self 0 GatherUp <| Range 400 600
                  , Grant Self 0 (CardUp Buster) <| Range 10 15
                  ]
      , bond    = Nothing
      , limited = True
      }
    , { name    = "Comrades"
      , id      = 667
      , rarity  = 4
      , icon    = Icon.BusterArtsUp
      , stats   = { base = { atk = 400,  hp = 0 }
                  , max  = { atk = 1500, hp = 0 }
                  }
      , effect  = [ Grant Self 0 (CardUp Arts) <| Range 8 10
                  , Grant Self 0 (CardUp Buster) <| Range 8 10
                  , Grant Self 0 NPUp <| Range 5 10
                  ]
      , bond    = Nothing
      , limited = True
      }
    , bond 669 "Urvara Nandi" "Parvati" Icon.QuickUp
      [party_ Quick 10, party NPGen 10]
    , gift 670 "Heroic Costume: Medusa" Icon.Road
      [Bonus MysticCode Units <| Flat 50]
    , gift 671 "Heroic Costume: Leonardo da Vinci" Icon.Road
      [Bonus MysticCode Units <| Flat 50]
    , gift 672 "Heroic Costume: Jeanne d'Arc" Icon.Road
      [Bonus MysticCode Units <| Flat 50]
    , gift 673 "Heroic Costume: Nero Claudius" Icon.Road
      [Bonus MysticCode Units <| Flat 50]
    , bond 675 "A Wish Spanning 3 Generations" "Tomoe Gozen" Icon.BusterUp
      [party_ Buster 10, party NPUp 10]
    , bond 676 "Getsurin Kuyou" "Mochizuki Chiyome" Icon.ArtsQuickUp
      [party_ Quick 10, party_ Arts 10]
    , bond 677 "Jumonji Yari" "Houzouin Inshun" Icon.QuickUp
      [party_ Quick 10, party CritUp 15]
    , bond 678 "Double-Tiered Kasa" "Yagyu Munenori" Icon.ArtsUp
      [party_ Arts 10, party NPUp 10]
    , bond 679 "Danzou's Ox" "Katou Danzo" Icon.QuickBusterUp
      [party_ Quick 10, party_ Buster 10]
    , bond 686 "Princess' Origami" "Osakabehime" Icon.NobleUp
      [party NPGen 15]
    , bond 687 "Electrologica Diagram" "Mecha Eli-chan" Icon.BusterUp
      [party_ Buster 20, demeritAll DebuffVuln 20]
    , bond 688 "Guardian Gigantic" "Mecha Eli-chan MkII" Icon.BusterUp
      [party_ Buster 20, demeritAll DebuffVuln 20]
    , gift 689 "Pray Upon the Sword, Wish Upon Life" Icon.Road
      [Bonus EXP Units <| Flat 50]
    , { name    = "Soul Eater"
      , id      = 691
      , rarity  = 3
      , icon    = Icon.BeamUp
      , stats   = { base = { atk = 200,  hp = 0 }
                  , max  = { atk = 1000, hp = 0 }
                  }
      , effect  = [ equipped Caster << Grant Self 0 NPUp <| Range 15 25 ]
      , bond    = Nothing
      , limited = False
      }
    , { name    = "Divine Construct"
      , id      = 674
      , rarity  = 3
      , icon    = Icon.BeamUp
      , stats   = { base = { atk = 200,  hp = 0 }
                  , max  = { atk = 1000, hp = 0 }
                  }
      , effect  = [ equipped Saber << Grant Self 0 NPUp <| Range 15 25 ]
      , bond    = Nothing
      , limited = False
      }
    , gift 690 "FGO VR Mash Kyrielight" Icon.Road
      [Bonus EXP Units <| Flat 50 ]
    , bond 692 "Falcon Witch's Banquet" "Circe" Icon.NobleUp
      [party NPGen 10, party NPUp 10]
    , bond 693 "Universe Ring" "Nezha" Icon.QuickUp
      [party_ Quick 10, party NPUp 10]
    , bond 694 "Tributes to King Solomon" "Queen of Sheba" Icon.BusterArtsUp
      [party_ Arts 10, party_ Buster 10]
    , bond 695 "Rosarium de Clavis Argenteus" "Abigail Williams" Icon.BeamUp
      [Times 3 <| Grant Self 0 DeathResist Full]
    , bond 700 "Blooming Flowers in Kur" "Ereshkigal" Icon.BusterUp
      [party_ Buster 10, party NPUp 10]
    , bond 701 "The Rainbow Soaring Under the Night Sky" "Attila the San(ta)" Icon.QuickUp
      [party_ Quick 10, party CritUp 15]
    , { name    = "New Beginning"
      , id      = 704
      , rarity  = 5
      , icon    = Icon.ArtsUp
      , stats   = { base = { atk = 250,  hp = 400 }
                  , max  = { atk = 1000, hp = 1600 }
                  }
      , effect  = [ Grant Self 0 (CardUp Arts) <| Range 10 15
                  , Grant Self 0 CritUp <| Range 10 15
                  , To Self GaugeUp <| Range 40 50
                  ]
      , bond    = Nothing
      , limited = True
      }
    , bond 709 "Painting of a Dragon Passing Over Mount Fuji" "Katsushika Hokusai" Icon.Kneel
      [Times 1 << Grant Self 0 GutsPercent <| Flat 20]
    , bond 717 "Mysterious Glass" "Semiramis" Icon.BusterUp
      [party_ Buster 10, party NPUp 10]
    , bond 762 "Summer Rain" "Asagami Fujino" Icon.BusterArtsUp
      [party_ Arts 10, party_ Buster 10]
    , { name    = "Chaldea Special Investigation Unit"
      , id      = 768
      , rarity  = 4
      , icon    = Icon.Bullseye
      , stats   = { base = { atk = 200, hp = 320 }
                  , max  = { atk = 750, hp = 1200 }
                  }
      , effect  = [ Grant Self 0 SureHit Full
                  , Grant Self 0 (CardUp Arts) <| Range 5 8
                  , Grant Self 0 (CardUp Buster) <| Range 5 8
                  ]
      , bond    = Nothing
      , limited = True
      }
    , { name    = "The Star of Camelot"
      , id      = 764
      , rarity  = 5
      , icon    = Icon.StarUp
      , stats   = { base = { atk = 500,  hp = 0 }
                  , max  = { atk = 2000, hp = 0 }
                  }
      , effect  = [ Grant Self 0 GatherUp <| Range 400 600
                  , Grant Self 0 StarsPerTurn <| Range 3 4
                  ]
      , bond    = Nothing
      , limited = True
      }
    , { name    = "The Dantes Files: Undercover in a Foreign Land"
      , id      = 765
      , rarity  = 5
      , icon    = Icon.BusterArtsUp
      , stats   = { base = { atk = 250,  hp = 400 }
                  , max  = { atk = 1000, hp = 1600 }
                  }
      , effect  = [ Grant Self 0 (CardUp Arts) <| Range 10 15
                  , Grant Self 0 (CardUp Buster) <| Range 10 15
                  , Grant Self 0 NPGen <| Range 10 15
                  ]
      , bond    = Nothing
      , limited = True
      }
    , bond 787 "OTMA" "Anastasia Nikolaevna Romanova" Icon.ArtsUp
      [party_ Arts 10, party NPUp 10]
    , bond 788 "Calydon's Hide" "Atalante (Alter)" Icon.QuickUp
      [party_ Quick 15, party CritUp 25, demeritAll DefenseDown 10]
    , bond 789 "Truth and Death" "Avicebron" Icon.BusterArtsUp
      [party_ Arts 10, party_ Buster 10]
    , bond 790 "Wildfire Blade" "Antonio Salieri" Icon.ArtsUp
      [party_ Arts 10, party NPGen 10]
    , bond 791 "Library of Ivan the Terrible" "Ivan the Terrible" Icon.BusterUp
      [party_ Buster 10, party NPUp 10]
    , { name    = "Distant Pilgrimage"
      , id      = 792
      , rarity  = 5
      , icon    = Icon.NobleUp
      , stats   = { base = { atk = 250,  hp = 400 }
                  , max  = { atk = 1000, hp = 1600 }
                  }
      , effect  = [ Grant Self 0 NPGen <| Range 10 15
                  , Grant Self 0 NPUp <| Range 10 15
                  , To Self GaugeUp <| Range 40 50
                  ]
      , bond    = Nothing
      , limited = True
      }
    , { name    = "Moment of Bliss"
      , id      = 793
      , rarity  = 4
      , icon    = Icon.BusterArtsUp
      , stats   = { base = { atk = 0, hp = 600 }
                  , max  = { atk = 0, hp = 2250 }
                  }
      , effect  = [ Grant Self 0 (CardUp Buster) <| Range 8 10
                  , Grant Self 0 (CardUp Arts) <| Range 8 10
                  , Grant Self 0 DefenseUp <| Range 3 5
                  ]
      , bond    = Nothing
      , limited = True
      }
    , { name    = "Away We Go!"
      , id      = 794
      , rarity  = 3
      , icon    = Icon.QuickUp
      , stats   = { base = { atk = 100, hp = 160 }
                  , max  = { atk = 500, hp = 800 }
                  }
      , effect  = [ Grant Self 0 (CardUp Quick) <| Range 3 5
                  , Grant Self 0 NPGen <| Range 5 10
                  ]
      , bond    = Nothing
      , limited = True
      }
    , { name    = "An Afternoon at the Fortress"
      , id      = 795
      , rarity  = 5
      , icon    = Icon.BusterArtsUp
      , stats   = { base = { atk = 0, hp = 750 }
                  , max  = { atk = 0, hp = 3000 }
                  }
      , effect  = [ Grant Self 0 (CardUp Buster) <| Range 10 15
                  , Grant Self 0 (CardUp Arts) <| Range 10 15
                  , Grant Self 0 NPUp <| Range 10 15
                  ]
      , bond    = Nothing
      , limited = True
      }
    , { name    = "At Trifas"
      , id      = 796
      , rarity  = 5
      , icon    = Icon.NobleUp
      , stats   = { base = { atk = 500,  hp = 0 }
                  , max  = { atk = 2000, hp = 0 }
                  }
      , effect  = [ Grant Self 0 NPGen <| Range 10 15
                  , Grant Self 0 CritUp <| Range 10 15
                  , Grant Self 0 StarsPerTurn <| Range 3 4
                  ]
      , bond    = Nothing
      , limited = True
      }
    , bond 798 "The Object That Can Hold a Universe" "Achilles" Icon.Shield
      [self NPUp 30, Times 1 <| Grant Party 3 Invincibility Full]
    , bond 799 "The Purpose of Learning and Teaching" "Chiron" Icon.ArtsQuickUp
      [party_ Arts 10, party_ Quick 10]
    , bond 800 "Nameless Death" "Sieg" Icon.NobleUp
      [party NPGen 10, party NPUp 10]
    ]


equipped : Class -> SkillEffect -> SkillEffect
equipped =
    When << (++) "equipped by a " << Class.show


{-| Retrieves the corresponding Bond CE. Memoized for performance. -}
getBond : Servant -> Maybe CraftEssence
getBond s =
    Dict.get s.name bondMap


{-| Memoization table for `getBond`. -}
bondMap : Dict String CraftEssence
bondMap =
    let
        go ce =
            Maybe.map (\bond -> (bond, ce)) ce.bond
    in
    db
        |> List.map go
        >> Maybe.values
        >> Dict.fromList
