module Home exposing (..)

{-|

    ----------------------------------------------------------------------------
    Homepage view
    ============================================================================
    > Convert to Markdown as it's a chore writing Elm HTML

    1. Simplify the data formats (Elm html? Json Markdown? Json?)
    2. Make the content better (quick fixes)
    3. Sketch out some routes (for a more impressive website)
    4. Add links for flashcard alpha (and possible kids coding)
    5. Add stuff for short courses (and prototype or product owner)
-}




-- Markdown --------------------------------------------------------------------

{-| Consists of `gl-intro` and `gl-body`

⚠️ JSON -> Markdown -> Elm HTML for `main` and `footer` etc

Anything with lots of links in it and multiple `text` objects.
-}
main =
"""
## Life is a learning process;

It's full of big hairy problems (and little ones too!) — I can help you discover ideas, communicate clearly and learn what works.

- I help turn fuzzy ideas into simple solutions
- Delighted 1000s of customers, helping them find what works for them
- Make information fun, simple, and useful
"""



-- View ------------------------------------------------------------------------

{- ⚠️ I'm not sure this is needed -}
viewAside : Html msg
viewAside =
  aside [ class "gl-folio" ]
    [ p []
      [ text "The portfolio of Rob McDonald (a work in "
      , a [ href "https://github.com/badlydrawnrob/badlydrawnrob.github.io" ]
        [ text "progress" ]
      , text ")"
      , text " • carefully crafted for "
      ,  a [ href "https://github.com/badlydrawnrob/print-first-css" ]
        [ text "print" ]
      ]
    ]

view : Html msg
view =
  div [ class "gl-grid-square" ]
    [ viewNav
    , viewHeader
    , viewMain
    ]

viewNav : Html msg
viewNav =
  nav []
    [ ol []
      [ li [] [ a [ href "/" ] [ text "Home" ] ]
      , li [] [ a [ href "/learn" ] [ text "Learn to code"] ]
      , li [] [ a [ href "/contact" ] [ text "Contact" ] ]
      ]

    ]

viewHeader : Html msg
viewHeader =
  header []
      [ h1 [] [ text "Coding for humans" ]
      ]

viewMain : Html msg
viewMain =
  Debug.todo "Add the main markdown"


{- "Let's <abbr title="love">♥</abbr> learning together and get things done" -}
viewCTA : Html msg
viewCTA =
  Debug.todo "Make this more useful (a drop-down perhaps?)"


{-| ⚠️ Move to JSON -> Markdown?

> Add links to things I'm reading now or quote machine?
-}
viewFooter : Html msg
viewFooter =
  footer [ class "gl-footer" ]
    [ div [ class "gl-f-social" ]
      [ p []
        [ text "The cool kids like to dig around social media; I prefer escaping into natures _own_ rabbit holes, or relax with a good movie or book! That said, you can always ..." ]
      , ul []
        [ li []
            [ text "Say 👋 <span class="visually-hidden">hello</span> on <a href="https://www.linkedin.com/in/badlydrawnrob/">LinkedIn</a>" ]
        , li []
            [ text "View my 🕹 <span class="visually-hidden">code</span> on <a href="https://github.com/badlydrawnrob/">Github</a>" ]
        , li []
            [ text "Shoot me a good ol' fashioned <a href="/contact">✉️ email</a>" ]
      ]
    , div [ class "gl-f-tagline" ]
      [ div [ class "gl-ft-content" ]
        [ p []
          [ text "Making data fit for human consumption <a href="#">since 2001</a>" ]
        , p []
          [ text "Taking security <a href="/manifesto/#kiskis">seriously</a> 🔒" ]
        ]
      ]
    ]
