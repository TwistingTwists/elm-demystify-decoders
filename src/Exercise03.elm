module Exercise03 exposing (decoder)

import Json.Decode exposing (Decoder, fail)



{- So, this one is a tiny bit more challenging, since we don't want _just_ the
   contents of the JSON. No, we want them to be modified.

   input:

       var input = [ "foo", "bar" ];

   output:
       [ "FOO", "BAR" ]

-}


decoder : Decoder (List String)
decoder =
    -- fail "This is escalating quickly!"
    {- Alternative:
       Json.Decode.list (Json.Decode.string |> Json.Decode.map String.toUpper)
    -}
    Json.Decode.list upperString


upperString : Decoder String
upperString =
    Json.Decode.map String.toUpper Json.Decode.String


{- Once you think you're done, run the tests for this exercise from the root of
   the project:

   - If you have installed `elm-test` globally:
        `elm test tests/Exercise03`

   - If you have installed locally using `npm`:
        `npm run elm-test tests/Exercise03`

   - If you have installed locally using `yarn`:
        `yarn elm-test tests/Exercise03`
-}
