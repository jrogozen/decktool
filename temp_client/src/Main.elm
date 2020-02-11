module Main exposing (..)

import Browser
import Dict exposing (Dict)
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
    , cardType : Dict String Bool
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
    , health = Just 2
    , hitPoints = Nothing
    , thw = Just 1
    , thwConsequence = Just 1
    , resources = Just [ CardResource "energy" 1 ]
    , primary = "black"
    , secondary = "gold"
    , tertiary = "yellow"
    , author = "decktool"
    , illustrator = ""
    , notes = ""
    , cardType = Dict.fromList [ ( "Ally", True ), ( "Hero", False ) ]
    , attributes = "hero for hire"
    , description = "<b>Forced Response</b>: After you play Black Cat, discard the top 2 cards of your deck. Add each card with a printed :mental: resource discarded this way to your hand."
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


updateAtkConsequence : String -> Model -> Model
updateAtkConsequence str model =
    { model | atkConsequence = String.toInt str }


updateCost : String -> Model -> Model
updateCost str model =
    { model | cost = String.toInt str }


updateThw : String -> Model -> Model
updateThw str model =
    { model | thw = String.toInt str }


updateThwConsequence : String -> Model -> Model
updateThwConsequence str model =
    { model | thwConsequence = String.toInt str }


updateHealth : String -> Model -> Model
updateHealth str model =
    { model | health = String.toInt str }


updateSelect : String -> Model -> Model
updateSelect str model =
    let
        changeSelection ( key, _ ) =
            if key == str then
                True

            else
                False
    in
    { model
        | cardType = Dict.map changeSelection model.cardType
    }


type Msg
    = EditTitle String
    | EditSubtitle String
    | EditAttributes String
    | EditDescription String
    | EditQuote String
    | EditAtk String
    | EditAtkConsequence String
    | EditCost String
    | EditThw String
    | EditThwConsequence String
    | EditHealth String
    | Select String


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

        EditAtkConsequence str ->
            ( updateAtkConsequence str model, Cmd.none )

        EditCost str ->
            ( updateCost str model, Cmd.none )

        EditThw str ->
            ( updateThw str model, Cmd.none )

        EditThwConsequence str ->
            ( updateThwConsequence str model, Cmd.none )

        EditHealth str ->
            ( updateHealth str model, Cmd.none )

        Select str ->
            ( updateSelect str model, Cmd.none )


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
            , div [] [ editCardType model ]
            , Html.form [ class "card-creator-form" ]
                [ div [ class "card-creator-text" ]
                    (editCardText model)
                , div [ class "card-creator-stats" ]
                    (editCardStats model)
                ]
            , p [] [ text (Debug.toString model) ]
            ]
        ]
    }



-- viewCardEditorByType : Model -> Html Msg
-- viewCardEditorByType model =


editCardType : Model -> Html Msg
editCardType model =
    let
        toOption ( cardType, isSelected ) =
            option
                [ value cardType
                , selected isSelected
                ]
                [ text cardType ]
    in
    select [ onInput Select ] (List.map toOption <| Dict.toList model.cardType)


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
    , textarea
        [ onInput EditDescription
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


maybeIntToString : Maybe Int -> String
maybeIntToString int =
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
        , value (maybeIntToString model.atk)
        ]
        []
    , input
        [ type_ "number"
        , onInput EditAtkConsequence
        , placeholder "atkConsequence"
        , value (maybeIntToString model.atkConsequence)
        ]
        []
    , input
        [ type_ "number"
        , onInput EditCost
        , placeholder "cost"
        , value (maybeIntToString model.cost)
        ]
        []
    , input
        [ type_ "number"
        , onInput EditThw
        , placeholder "thw"
        , value (maybeIntToString model.thw)
        ]
        []
    , input
        [ type_ "number"
        , onInput EditThwConsequence
        , placeholder "thwConsequence"
        , value (maybeIntToString model.thwConsequence)
        ]
        []
    , input
        [ type_ "number"
        , onInput EditHealth
        , placeholder "health"
        , value (maybeIntToString model.health)
        ]
        []
    ]
