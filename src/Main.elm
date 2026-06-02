module Main exposing (main)

{-|

    ----------------------------------------------------------------------------
    Portfolio
    ============================================================================
    > For now a simple embedded typewriter heading.

-}


import Browser
import Html exposing (..)
import Typewriter

type alias Model =
  Typewriter.Model

init : ( Model, Cmd Msg )
init =
    Typewriter.withWords [ "one", "two", "three" ]
        |> Typewriter.init


view : Model -> Html msg
view model =
    Html.h1 [] [ Html.text (Typewriter.view model) ]


type alias Msg =
    Typewriter.Msg


main : Program () Model Msg
main =
    Browser.element
        { init = \_ -> init
        , view = view
        , update = Typewriter.update
        , subscriptions = \_ -> Sub.none
        }
