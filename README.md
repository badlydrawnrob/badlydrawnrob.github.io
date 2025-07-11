# badlydrawnrob.github.io

## Thema styles

> **Make concrete hard decisions and rules**
> Inheriting a mish-mash from ECSS, [GPS](https://medium.com/@jescalan/bem-is-terrible-f421495d093a), and [Thema](https://ns.editeur.org/thema/en) Styles

My styleguide might not be suitable when working in large teams (where change conflicts could be a serious issue), but it'll work in many cases. Thema book categories `CODE` is detatched from the category name, but here we make them similar. We're also using Pandoc as our static `/words` blog [compiler](https://app.studyraid.com/en/read/15019/519413/processing-multiple-files-with-wildcards).

1. As many specimen styles as possible (60% of styles or more)
    - Raw html, such as `h1`, `pre`, `code`
2. As few class names as possible (rather than named)
    - Raw html, such as `button` (over `.gl-button`)
3. As many design-styleguide assets as possible
    - Prefer predictability over variety (fewer design assets)
    - Most of these would be `.gl-`obal elements
4. Page styles are for page-related content only
    - Always wrapped in a page ID (`#page .section`)

```css
/* CONCRETE AND STRICT BEATS WISHY-WASHY CONVENTIONS */
/* I prefer the flat styles of ECSS (limited nesting of classes) */
/* We've changed to a lowercase naming convention */

/* Grid styles should probably be separate so they're easily changed */
.grid
.grid .col1
.grid .col2

/* You should be using raw html wherever possible (cut code down!) */
/* Only lean into Thema styles where it's hard to discern what's happening */
.gl-header
.gl-header h1
.gl-header h1 strong
.gl-header h1 strong a

/* Items are grouped together so they're easy to find */
/* Ideally class names should be singular and short  */
.gl-style         /* A suitable unique name */
.gl-s-item        /* You can use named comment headers */
.gl-si-left       /* Or `.gl-s-item.left` */
.gl-sil-whysolong /* You should rarely need this many nested class names */

/* If it's a variant, prefer the direct parent to be styled (rather than container) */
.gl-header        /* We don't style the parent in this instance ... */
.gl-h-title
.gl-h-title.right /* Because the child is the only thing that moves */

/* Otherwise, variants can be added to the outermost element   */
/* The old style was `.gl-header-variant` which is a bit safer */
.gl-header.dark /* Aim to use unique singular classnames (or add a `.dark123` number) */
.gl-h-title
.gl-ht-inner

/* In Thema, qualifiers have numbers to start, like `5TD-EE-A` ... */
/* Could this be utilised for something?! */
.dark123

/* Page-level sections (even if repeated) should be used */
/* I don't like the GPS #id#section as it's ugly. This way you could always */
/* reuse the `.namedsection` in another `#page` (might be a bit confusing) */
#pagename
#pagename section       /* PREFER THIS STYLE (raw html) */
#pagename .namedsection /* If two words ...  */
#pagename .ns-item      /* Perhaps we use initials like `.ns` for short */
#pagename .nsi-position /* Again, fewer "codes" are better */

/* If we find we need a page style on a different page ... */
/* Move that class name up in the hierarchy (with global styles) */
/* #pagename .namedsection */
.gl-namedsection
```

If there's no need for class names — don't add them! There's two ways we could design this navigation, and the first route is totally valid.

```html
<!-- If there's no need for class names, don't add them! -->
<!-- This is perfectly valid                         -->
<header>
  <nav>
    <ul><li>No classes needed</li></ul>
  <nav>
</header>

<header class=".gl-col1">
  <nav class="gl-nav">
    <!-- The below two class names are redundant! -->
    <ul class="gl-n-ul">
      <li class="gl-nl-li">No classes needed</li>
    </ul>
  <nav>
</header>
```

Using `@media` properly ...

- How am I handling light/dark theme, mobile-first, print-first, and so on?
- Are lots of `@media` queries preferable?
- A nice grid layout, with 2-column articles and interesting layout
- Buttons should make more sense (no need for Tally form button AND other button)


## Some issues with Pandoc

> It may be wiser to lean on Elm or 11ty for more complex layout needs
> Pandoc is perfect for general writing though (use Elm `Http.get` with `json` or file?)

1. `<p>` tags are added inside `<div>` wrappers (no way around this?)
    - It means you've got to remove paragraphy styling (`margin` etc)


## To do tasks

### Make naming conventions concrete

```css
/* Change this from ... */

.animate .animate-words .animate-w-hidden
.animate .animate-static

/* To our new convention ... */
#home .animate
#home .a-words
#home .aw-static
```

### Writing styleguide

> **Is all my content "evergreen"?**
> Start simple for now (build later/never)
> Is it fun to look at? (finger painting for adults and kids)

1. **Simplify articles (ONE idea per slide)**[^1]

**Writing should be front-and-center** as well as being **more legible at all screen sizes (current font/size sucks for articles).** Make some concrete rules for yourself on writing. Add more colour to your writing, with fun examples. Perhaps add nice typographic touches like ligatures (or pull-quotes, pull-images, so on).

### The image

> **What image of myself do I want to project?**

1. **I'm a fast prototyper and light coder** with _methods_
2. **I teach to a beginner level** design, python, and (maybe) Elm 
    - With flashcard tools and Ai (light data, light state, light ...)
    - With pre-prepared curriculums (and study aids)
    - An introduction to ... (books etc)
3. **Lead magnets (marketing course)**
    - Use `{{ mustache }}` or dynamic pages for flashcards?
    - Integrate Ai for auto-generated flashcards?
4. What about accessibility and ease-of-reading?
    - Stuff like [grid order](https://rachelandrew.co.uk/archives/2019/06/04/grid-content-re-ordering-and-accessibility/)

### Stop using Marked2 app

- Currently processing some `.md` files with Marked2 App (just use Pandoc)


## Tools

> **This is my rule** If I can't get it working in a few minutes, or understand the documentation quickly; if it's not simple, ideally single-purpose, quick to get started; maybe just DON'T use it!!!

A lot of programming tools and frameworks are _way_ more complex than they need to be. However, fairly soon I'll be better off using Elm and `elm-watch` with a simple static builder tool if the content becomes dynamic, or layout needs more complex. Avoid using anything more complicated than you _really_ need (YAGNI)!

- [ ] `npx live-server --no-browser` live reloads on `http://127.0.0.1:8080`
    - You can [ignore files](https://github.com/tapio/live-server/issues/151) if you like
- [ ] [Pandoc Markdown](https://garrettgman.github.io/rmarkdown/authoring_pandoc_markdown.html) for the win!


## Money

1. Store up a full years wages
2. Then start to invest small amounts
3. Build up income drips and get f* moving


[^1]: **Don't be an annoyingly verbose Ai article!** Literally craft your articles as if they were a slide. Reduce the amount of information they have, use imagery to get your point across succinct, and aim for one idea (or sub-idea) per article.
