module Site.Section exposing
  ( Section(..)
  , enum
  , show
  )


{-| The site's layout is broken up into `Section`s.
On mobile, instead of showing `Section`s in sidebars,
each is a separate page. -}
type Section
    = Browse
    | Settings
    | SortBy
    | Include
    | Filter


enum : List Section
enum =
    [ Browse
    , Settings
    , SortBy
    , Include
    , Filter
    ]


show : Section -> String
show a =
    case a of
        Browse   -> "Browse"
        Settings -> "Settings"
        SortBy   -> "Sort By"
        Include  -> "Include"
        Filter   -> "Filter"
