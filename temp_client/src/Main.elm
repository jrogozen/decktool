module Main exposing (..)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput)


main : Program String Model Msg
main =
    Browser.document
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


type alias CardResource =
    { name : String
    , count : Int
    }


type alias Model =
    { atk : Maybe Int
    , atkConsequence : Maybe Int
    , cost : Maybe Int
    , def : Maybe Int
    , health : Maybe Int
    , hitPoints : Maybe Int
    , thw : Maybe Int
    , thwConsequence : Maybe Int
    , resources : Maybe (List CardResource)
    , primary : String
    , secondary : String
    , tertiary : String
    , author : String
    , illustrator : String
    , notes : String
    , type_ : String
    , attributes : String
    , description : String
    , quote : String
    , setName : String
    , setPosition : String
    , subtitle : String
    , title : String
    }


modelInitialValue : Model
modelInitialValue =
    { atk = Just 1
    , atkConsequence = Just 0
    , cost = Just 2
    , def = Nothing
    , health = Nothing
    , hitPoints = Just 2
    , thw = Just 1
    , thwConsequence = Just 1
    , resources = Just [ CardResource "energy" 1 ]
    , primary = "black"
    , secondary = "gold"
    , tertiary = "yellow"
    , author = "decktool"
    , illustrator = ""
    , notes = ""
    , type_ = "MARVEL_CHAMPIONS:ALLY"
    , attributes = "hero for hire"
    , description = "<b>Forced Response</b>: After you play Black Cat, discard the top 2 cards of your deck. Add Each card with a printed :mental: resource discarded this way to your hand."
    , quote = "I'm not a hero. I'm a thief."
    , setName = "spider-man"
    , setPosition = "1/15"
    , subtitle = "felicia hardy"
    , title = "black cat"
    }


init : String -> ( Model, Cmd Msg )
init _ =
    ( modelInitialValue, Cmd.none )



-- update


updateTitle : String -> Model -> Model
updateTitle title model =
    { model | title = title }


updateSubtitle : String -> Model -> Model
updateSubtitle subtitle model =
    { model | subtitle = subtitle }


updateAttributes : String -> Model -> Model
updateAttributes attr model =
    { model | attributes = attr }


updateDescription : String -> Model -> Model
updateDescription desc model =
    { model | description = desc }


updateQuote : String -> Model -> Model
updateQuote quote model =
    { model | quote = quote }


updateAtk : String -> Model -> Model
updateAtk atkString model =
    { model | atk = String.toInt atkString }


type Msg
    = EditTitle String
    | EditSubtitle String
    | EditAttributes String
    | EditDescription String
    | EditQuote String
    | EditAtk String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        EditTitle title ->
            ( updateTitle title model, Cmd.none )

        EditSubtitle subtitle ->
            ( updateSubtitle subtitle model, Cmd.none )

        EditAttributes attr ->
            ( updateAttributes attr model, Cmd.none )

        EditDescription desc ->
            ( updateDescription desc model, Cmd.none )

        EditQuote quote ->
            ( updateQuote quote model, Cmd.none )

        EditAtk atkString ->
            ( updateAtk atkString model, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none



-- view


view : Model -> Browser.Document Msg
view model =
    { title = "Document Title"
    , body =
        [ div [ class "decktool" ]
            [ h1 [] [ text "decktool app" ]
            , Html.form [ class "card-creator-form" ]
                [ div []
                    (editCardText model)
                , div []
                    (editCardStats model)
                ]
            , p [] [ text (Debug.toString model) ]
            ]
        ]
    }


editCardText : Model -> List (Html Msg)
editCardText model =
    [ input
        [ type_ "text"
        , onInput EditTitle
        , value model.title
        ]
        []
    , input
        [ type_ "text"
        , onInput EditSubtitle
        , value model.subtitle
        ]
        []
    , input
        [ type_ "text"
        , onInput EditAttributes
        , value model.attributes
        ]
        []
    , input
        [ type_ "text"
        , onInput EditDescription
        , value model.description
        ]
        []
    , input
        [ type_ "text"
        , onInput EditQuote
        , value model.quote
        ]
        []
    ]


getIntAsString : Maybe Int -> String
getIntAsString int =
    case int of
        Nothing ->
            ""

        Just i ->
            String.fromInt i


editCardStats : Model -> List (Html Msg)
editCardStats model =
    [ input
        [ type_ "number"
        , onInput EditAtk
        , placeholder "atk"
        , value (getIntAsString model.atk)
        ]
        []
    ]
