module Main exposing (main)

{-| ----------------------------------------------------------------------------
    Recipe super fast demo
    ============================================================================

    Focus on the core message and story, with the core abstract features.
    The core features for most profiles are:

    - Currency (gold, silver, bronze)
    - Time (in a hurry)
    - Price (min/max/mean)
    - Location radius
    - Filters (one ingredient)

    Questions
    ---------
    1. Can we only use `Advert a` in the update function?
        - Is the only way to narrow types for view with a type alias record?
    2. We're using a `visible` boolean for our `Meals` to filter on
        - Is there a better way to do this?
        - We need the "full list" and the "filtered list" somehow

    Wishlist
    --------
    1. Build a basic user
    2. Build a list of meals
       - Mix of recipes and eating out
    3. Filter by one ingredient
-}

import Debug

import Browser
import Html exposing (..)
import Html.Attributes exposing (class, src, href)
import Html.Events exposing (onClick)
import Json.Decode as JD exposing (..)

type EatType
  = Meat
  | Vegetarian
  | Vegan

type MealType
  = Recipe
  | Restaurant
  | Cafe
  | MealDeal

type Currency
  = Gold
  | Silver
  | Bronze

type Filter =
  String

type Ingredient =
  String

type Ingredients =
  List Ingredient

type alias Meal =
  { eatType : EatType
  , mealType : MealType
  , ingredients : Ingredients
  , time : (Int, Int) -- This is going to get confusing: recipe? restaurant?
  }

{- #! I think this can only be used for `Update` -}
type alias Visible a =
  { a
    | visible : Bool -- Filtered?
  }

type alias Model =
  { realName : String
  , userName : String
  , userPref : EatType
  , filter : Maybe Ingredient -- Search filter
  , location : String -- Radius
  , meals : List Meal
  , adverts : List Advert
  }

baseUrl : String
baseUrl = "./img/"

userImage : String
userImage = baseUrl ++ "user.jpg"


-- View ------------------------------------------------------------------------
-- 1. We're hardcoding our user for now
-- 2. We're filtering the advert and meal lists
-- 3. Click a button to filter

viewAdvert : Bool -> String -> Int -> String -> String -> List String -> Html msg
viewAdvert visible url image title info ingredients =
  if visible then
    -- This is probably poor use of HTML5 tags
    article []
      [ img [ href url, src (baseUrl ++ image) ] []
      , h3 [] [ text title ]
      , p [] [ text info ]
      , small [] viewIngredients ingredients
    ]
  else
    text ""

viewIngredients : Ingredients -> Html msg
viewIngredients ingredients =
  List.map (\ingredient -> li [] [ text ingredient ]) ingredients

viewUser : Model -> Html msg
viewUser model =
  article []
    [ img [ src userImage ] []
    , h2 [] [ text model.realName ]
    , h3 [] [ text model.userName ]
    , p [] [ text model.userPref ]
    ]

selectedIngredient : Maybe Ingredient -> Html msg
selectedIngredient ingredient =
  case ingredient of
    Nothing ->
      p [] [ text "" ]
    Just ingredient ->
      p []
        [ text (ingredient ++ " selected")
        , span [] [ button [ onClick Reset ] [ text "Reset" ] ]
        ]

view : Model -> Html Msg
view model =
  div [ class "container" ]
    [ div [ class "grid" ]
      [div [] -- Main content
          [ selectedIngredient model.filter
          , viewUser model -- !# Split out `model.user` as nested record?
          , viewMeals meals
          , button [ onClick (ClickedFilter "beef") ] [ text "Filter by ingredient" ]
          ]
      , div [] -- Sidebar
          [ viewAdvert adverts ]
      ]
    ]


-- Update ----------------------------------------------------------------------
-- 1. List Ingredients in the `List Advert` branch
-- 2. List Ingredients in the `List Meal` branch

type Msg
  = ClickedFilter String

updateMeals : Filter -> List Meal -> List Meal
updateMeals filter meals =
  List.map (pickMeal filter) meals

updateAdverts : Filter -> List Advert -> List Advert
updateAdverts filter adverts =
  List.map (pickAdvert filter) advert

pickMeal : Filter -> Meal -> Meal
pickMeal filter meal =
  makeVisible filter meal.ingredients meal

pickAdvert : Filter -> Advert -> Advert
pickAdvert filter advert =
  makeVisible filter advert.ingredients advert

makeVisible : Filter -> Ingredients -> Visible a -> Visible a
makeVisible filter ingredients visibleRecord =
  if String.isEmpty filter then
    { visibleRecord | visible = True }
  else
    { visibleRecord | visible = (filterByIngredient filter ingredients) }

filterByIngredient : Filter -> List Ingredient -> Bool
filterByIngredient filter ingredients =
  List.member filter ingredients

update : Msg -> Model -> Model
update msg model =
  case msg of
      ClickedFilter String ->
        { model
            | meals = updateMeals string model.meals
            , adverts = updateAdverts string model.adverts
        }

      Reset ->
        { model
            | meals = updateMeals "" model.meals
            , adverts = updateAdverts "" model.adverts
        }




-- Main ------------------------------------------------------------------------


