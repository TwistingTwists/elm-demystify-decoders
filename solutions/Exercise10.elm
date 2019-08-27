module Exercise10 exposing (Person, PersonDetails, Role(..), decoder)

import Json.Decode exposing (Decoder, andThen, at, fail, field, list, map, map2, map3, string, succeed)



{- Let's try and do a complicated decoder, this time. No worries, nothing new
   here: applying the techniques you've used in the previous decoders should
   help you through this one.

   A couple of pointers:
    - try working "inside out". Write decoders for the details and role first
    - combine those decoders + the username and map them into the Person constructor
    - finally, wrap it all together to build it into a list of people


   Example input:

        [ { "username": "Phoebe"
          , "role": "regular"
          , "details":
            { "registered": "yesterday"
            , "aliases": [ "Phoebs" ]
            }
          }
        ]
-}


type alias Person =
    { username : String
    , role : Role
    , details : PersonDetails
    }


type alias PersonDetails =
    { registered : String
    , aliases : List String
    }


type Role
    = Newbie
    | Regular
    | OldFart


decoder : Decoder (List Person)
decoder =
    list personDecoder



{-
   personDecoder : Decoder Person
   personDecoder =
       map2 Person
           (map2 PersonDetails
           (at ["details","registered"] string)
           (at ["details","aliases" (list string)])
           )
           (at [ "role" ] |> andThen roleDecoder)
-}


personDecoder : Decoder Person
personDecoder =
    map3 Person
        (field "username" string)
        (field "role" string |> andThen roleDecoder)
        (field "details" personDetailsDecoder)


personDetailsDecoder : Decoder PersonDetails
personDetailsDecoder =
    map2 PersonDetails
        (field "registered" string)
        (field "aliases" (list string))


roleDecoder : String -> Decoder Role
roleDecoder str =
    case str of
        "regular" ->
            succeed Regular

        "newbie" ->
            succeed Newbie

        "oldfart" ->
            succeed OldFart

        _ ->
            fail "Role not found! "



{- Once you think you're done, run the tests for this exercise from the root of
   the project:

   - If you have installed `elm-test` globally:
        `elm test tests/Exercise10`

   - If you have installed locally using `npm`:
        `npm run elm-test tests/Exercise10`

   - If you have installed locally using `yarn`:
        `yarn elm-test tests/Exercise10`
-}
