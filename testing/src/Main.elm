module Main exposing (main)

{-| ----------------------------------------------------------------------------
    Recipe super fast demo
    ============================================================================
    ⚠️ Writing all this stuff out by hand, error checking, etc, etc is
    very LABOURIOUS so find methods to speed up, create modules to simplify,
    build sensible types, have Ai create the model from types, etc.

      Silly errors like a misplaced `,` or `]` can be hard to spot.

    Focus
    -----
    Focus on the core message and story, with the core abstract features.
    The core features for most profiles are:

    - Currency (gold, silver, bronze)
    - Time (in a hurry)
    - Price (min/max/mean)
    - Location radius
    - Filters (one ingredient)

    Questions and fixes
    ------------------
    1. Can we only use `Advert a` in the update function?
        - I think so! I think you need to first narrow type for `alias record`
        - Then narrow type for the particular `alias record a` update type
    2. We're using a `visible` boolean for our `Meals` to filter on
        - Is there a better way to do this?
        - We need the "full list" and the "filtered list" somehow
    3. Should I use alphabetical for all the things?
        - `{ record deconstruct }`) etc
        - `model.record`, `model.order` etc
    4. Does `List.map` ALWAYS need a parent wrapper?
        - Just means a lot of redundant `div`s potentially

    Ai helper
    ---------
    1. Populate examples and check for errors (missing comma, etc)
    2. Manage nuance with ingredients for search parameters

    Wishlist
    --------
    > Scanning back and forth between implementing a `Meal`, say, and remembering
    > what a `Meal`s parameters are is a bit annoying. Perhaps splitting these
    > out into their own modules would be wise?

    1. Currently filtering by a single ingredient ... which is a form
    2. `List Ingredient` is in TWO places: `model.meals` and `model.advert`
    3. What about errors? Currently does nothing if `"ingredient"` doesn't exist
    4. Start thinking about better structures for:
        - `Model` and `Currency` etc
        - `User` and adding/editing (plus wishlist etc)
        - Master list of `Ingredients`
        - User interactions (three ingredients picked, filters, etc)
    5. What about nuance in ingredients and search?
        - "bacon" is also "pork"
        - "sweet potato fries" is also "sweet potato"
        - Look at all the nuances and get Ai to help you out.
-}

import Debug

import Browser
import Html exposing (..)
import Html.Attributes exposing (class, disabled, href, src, type_, value)
import Html.Events exposing (onClick)
-- import Json.Decode as JD exposing (value)

type EatType
  = Meat
  | Vegetarian
  | Vegan
  | Mixed

eatTypeString : EatType -> String
eatTypeString eat =
  case eat of
    Meat ->
      "Meat"
    Vegetarian ->
      "Vegetarian"
    Vegan ->
      "Vegan"
    Mixed ->
      "Mixed"

type MealType
  = Cafe
  | FastFood
  | MealDeal
  | Recipe
  | Restaurant

mealTypeString : MealType -> String
mealTypeString meal =
  case meal of
    Cafe ->
      "Cafe"
    FastFood ->
      "Fast Food"
    MealDeal ->
      "Meal Deal"
    Recipe ->
      "Recipe"
    Restaurant ->
      "Restaurant"


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

type alias Ingredients =
  List Ingredient

type alias Time =
  (Int, Int)

timeString : Time -> String
timeString time =
  "Time: "
  ++ (String.fromInt (Tuple.first time))
  ++ ":"
  ++ (String.fromInt (Tuple.second time))

type alias Meal =
  { visible : Bool
  , eatType : EatType
  , mealType : MealType
  , title : String
  , ingredients : Ingredients
  , time : Time -- #! This is going to get confusing: recipe? restaurant?
  }

listMeal : List Meal
listMeal =
  [ Meal True Meat Restaurant "Braised beef noodles" ["beef", "noodle", "radish" ] (3, 10)
  , Meal True Vegetarian Cafe "Cauliflower and sweet potato curry" ["cauliflower", "sweet potato", "spices" ] (5, 0)
  , Meal True Vegan Restaurant "Chongqing noodles" ["tofu", "noodle", "sesame paste", "bean sprouts" ] (2, 20)
  , Meal True Meat Recipe "Beef burritos" ["chilli", "beef", "cheese", "beans"] (40, 0)
  ]

type alias Advert =
  { visible : Bool -- Has it been filtered?
  , url : String
  , image : Int
  , title : String
  , info : String -- rich text
  , ingredients : Ingredients -- Linked to `visible`
  }

listAdvert : List Advert
listAdvert =
  [ Advert True "https://www.zapatistaburrito.com/" 1 "Taco Tuesdays"
    "Experience the love-infused perfection of authentic burritos, nachos, tacos, and beyond – a symphony of freshness, deliciousness, and healthiness."
    ["chicken", "tomato", "spices", "wheat", "lettuce"]
  , Advert True "https://blackfriarsrestaurant.co.uk/" 2 "Beef bourguignon"
    "When you really want to impress, but you don't want to work too hard. Come visit Blackfriars!"
    ["beef", "steak", "onion", "tomato", "red wine", "butter", "black pepper"]
  , Advert True "https://fiveguys.co.uk/" 3 "Beef burger and sweet potato fries"
    "Prime beef grain-fed in Scotland. All our fries come with an extra scoop in the bag!"
    ["beef", "sweet potato", "lettuce", "tomato", "pickle", "cheese"]
  , Advert True "https://www.marksandspencer.com/food" 4 "Christmas sandwich"
    "Unmissable offers this Christmas on sandwiches and snacks"
    ["turkey", "cranberry sauce", "brown bread", "lettuce", "bacon"]
  ]

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
  }

baseUrl : String
baseUrl = "./img/"

userImage : String
userImage = baseUrl ++ "user.jpg"

init : Model
init =
  { realName = "Sarah"
  , userName = "@sarah123"
  , userPref = Mixed
  , filter = Nothing -- #! Change
  , location = "54.977998, -1.614041"
  , meals = []
  , adverts = listAdvert
  , form = ""
  }


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
        ] []
    , button
        [ disabled (String.isEmpty string) ]
        [ text "Filter by ingredient" ]
    ]


viewUser : Model -> Html msg
viewUser model =
  article []
    [ img [ src userImage ] []
    , h2 [] [ text model.realName ]
    , h3 [] [ text model.userName ]
    , p [] [ text (eatTypeString model.userPref) ]
    ]


{- #! `List.map` MUST have a wrapper -}
viewMeals : List Meal -> Html msg
viewMeals meals =
  div []
    (List.map viewMeal meals)

viewMeal : Meal -> Html msg
viewMeal { visible, eatType, mealType, title, ingredients, time } =
  if visible then
    -- This is probably poor use of HTML5 tags
    article []
      [ small [] [ text (viewMealType eatType mealType) ]
      , h2 [] [ text title ]
      , viewIngredients ingredients
      , p [] [ text (timeString time) ]
      ]
  else
    text ""

viewMealType : EatType -> MealType -> String
viewMealType eat meal =
  String.concat
    [ "Type: "
    , (eatTypeString eat)
    , ", "
    , "Meal: "
    , (mealTypeString meal)
    ]


viewAdverts : List Advert -> Html msg
viewAdverts adverts =
  div []
    (List.map viewAdvert adverts)

viewAdvert : Advert -> Html msg
viewAdvert { visible, url, image, title, info, ingredients } =
  if visible then
    -- This is probably poor use of HTML5 tags
    article []
      [ img [ href url, src (baseUrl ++ (String.fromInt image) ++ ".jpg") ] []
      , h3 [] [ text title ]
      , p [] [ text info ]
      , viewIngredients ingredients
    ]
  else
    text ""


viewIngredients : Ingredients -> Html msg
viewIngredients ingredients =
  ul []
    (List.map viewIngredient ingredients)

viewIngredient : Ingredient -> Html msg
viewIngredient ingredient =
  li [] [ text ingredient ]

selectedIngredient : Maybe Ingredient -> Html Msg
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
          [ viewAdverts model.adverts ]
      ]
    ]


-- Update ----------------------------------------------------------------------
-- 1. List Ingredients in the `List Advert` branch
-- 2. List Ingredients in the `List Meal` branch

type Msg
  = Save
  | Reset

updateMeals : Filter -> List Meal -> List Meal
updateMeals filter meals =
  List.map (pickMeal filter) meals

updateAdverts : Filter -> List Advert -> List Advert
updateAdverts filter adverts =
  List.map (pickAdvert filter) adverts

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

main : Program () Model Msg
main =
  Browser.sandbox
    { init = init
    , view = view
    , update = update
    }
