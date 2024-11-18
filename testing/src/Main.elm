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
        - I think so! I think you need to first narrow type for `alias record`
        - Then narrow type for the particular `alias record a` update type
    2. We're using a `visible` boolean for our `Meals` to filter on
        - Is there a better way to do this?
        - We need the "full list" and the "filtered list" somehow
    3. Should I use alphabetical for all the things?
        - `{ record deconstruct }`) etc
        - `model.record`, `model.order` etc

    Wishlist
    --------
    1. Currently filtering by a single ingredient ... which is a form
    2. `List Ingredient` is in TWO places: `model.meals` and `model.advert`
    3. What about errors? Currently does nothing if `"ingredient"` doesn't exist
    4. Start thinking about better structures for:
        - `Model` and `Currency` etc
        - `User` and adding/editing (plus wishlist etc)
        - Master list of `Ingredients`
        - User interactions (three ingredients picked, filters, etc)
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

eatTypeString : EatType -> String
eatTypeString eat =
  case eat of
    Meat ->
      "Meat"
    Vegetarian ->
      "Vegetarian"
    Vegan ->
      "Vegan"

type MealType
  = Recipe
  | Restaurant
  | Cafe
  | MealDeal

mealTypeString : MealType -> String
mealTypeString meal =
  case meal of
      Recipe ->
        "Recipe"
      Restaurant ->
        "Restaurant"
      Cafe ->
        "Cafe"
      MealDeal ->
        "Meal Deal"

type Currency
  = Gold
  | Silver
  | Bronze String

currencyString : Currency -> String
currencyString currency =
  case currency of
      Gold ->
        "Gold: loved it"
      Silver ->
        "Silver: liked it"
      Bronze str ->
        "Bronze: " ++ str

type alias Filter =
  String

type alias Ingredient =
  String

type Ingredients =
  List Ingredient

type alias Time =
  (Int, Int)

timeString : Time -> String
timeString time =
  "Time: "
  ++ (String.fromInt Tuple.first time)
  ++ ":"
  ++ (String.fromInt Tuple.second time)

type alias Meal =
  { visible : Bool
  , eatType : EatType
  , mealType : MealType
  , title : String
  , ingredients : Ingredients
  , time : Time -- This is going to get confusing: recipe? restaurant?
  }

type alias Advert =
  { visible : Bool -- Has it been filtered?
  , url : String
  , image : Int
  , title : String
  , info : String -- rich text
  , ingredients : Ingredients -- Linked to `visible`
  }

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
  , form : String
  , error : String
  }

baseUrl : String
baseUrl = "./img/"

userImage : String
userImage = baseUrl ++ "user.jpg"


-- View ------------------------------------------------------------------------
-- 1. We're hardcoding our user for now
-- 2. We're filtering the advert and meal lists
-- 3. Click a button to filter

viewForm : String -> Html Msg
viewForm string =
  form [ onClick Save ]
    [ input
        [ type_ "text"
        , value string
        ]
    , button
        [ disabled (String.empty string) ]
        [ text "Filter by ingredient" ]
    ]


viewUser : Model -> Html msg
viewUser model =
  article []
    [ img [ src userImage ] []
    , h2 [] [ text model.realName ]
    , h3 [] [ text model.userName ]
    , p [] [ text model.userPref ]
    ]


viewMeals : Meals -> Html msg
viewMeals meals =
  List.map viewMeal meals

viewMeal : Meal -> Html msg
viewMeal { visible, eatType, mealType, title, ingredients, time } =
  if visible then
    -- This is probably poor use of HTML5 tags
    article []
      [ small [] [ text (viewMealType eatType mealType) ]
      , H2 [] [ text ]
      , viewIngredients ingredients
      , time
      ]

viewMealType : EatType -> MealType -> Html msg
viewMealType eat meal =
  String.concat
    [ "Type: "
    , (eatTypeString eat)
    , ", "
    , "Meal: "
    , (mealTypeString meal)
    ]


viewAdvert : List Advert -> Html msg
viewAdvert adverts =
  List.map viewAdvert adverts

viewAdvert : Advert -> Html msg
viewAdvert { visible, url, image, title, info, ingredients } =
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

selectedIngredient : Maybe Ingredient -> Html msg
selectedIngredient ingredient =
  case ingredient of
    Nothing ->
      p [] [ text "" ]
    Just filter ->
      p []
        [ text (filter ++ " selected")
        , span [] [ button [ onClick Reset ] [ text "Reset" ] ]
        ]

view : Model -> Html Msg
view model =
  div [ class "container" ]
    [ div [ class "grid" ]
      [div [] -- Main content
          [ selectedIngredient model.filter
          , viewForm model.form
          , viewUser model -- !# Split out `model.user` as nested record?
          , viewMeals model.meals
          ]
      , div [] -- Sidebar
          [ viewAdvert model.adverts ]
      ]
    ]


-- Update ----------------------------------------------------------------------
-- 1. List Ingredients in the `List Advert` branch
-- 2. List Ingredients in the `List Meal` branch

type Msg
  = ClickedFilter String
  | Save
  | Reset

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
      Save ->
        { model
            | meals = updateMeals model.form model.meals
            , adverts = updateAdverts model.form model.adverts
        }

      Reset ->
        { model
            | meals = updateMeals "" model.meals
            , adverts = updateAdverts "" model.adverts
            , form = ""
        }




-- Main ------------------------------------------------------------------------


