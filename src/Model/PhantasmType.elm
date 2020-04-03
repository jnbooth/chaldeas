module Model.PhantasmType exposing
  ( PhantasmType(..)
  , show
  )


type PhantasmType
    = SingleTarget
    | MultiTarget
    | Support


show : PhantasmType -> String
show a =
    case a of
        SingleTarget -> "Single-Target"
        MultiTarget  -> "Multi-Target"
        Support      -> "Support"
