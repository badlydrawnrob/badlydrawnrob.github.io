# badlydrawnrob.github.io

## Thema styles

> **Make concrete hard decisions and rules**
> Inheriting a mish-mash from ECSS, [GPS](https://medium.com/@jescalan/bem-is-terrible-f421495d093a), and [Thema](https://ns.editeur.org/thema/en) Styles

My styleguide might not be suitable when working in large teams (where change conflicts could be a serious issue), but it'll work in many cases. Thema book categories `CODE` is detatched from the category name, but here we make them similar. We're also using Pandoc as our static `/words` blog [compiler](https://app.studyraid.com/en/read/15019/519413/processing-multiple-files-with-wildcards).

1. As many specimen styles as possible (60% of styles or more)
    - Raw html, such as `h1`, `pre`, `code`
2. As few class names as possible (rather than named)
    - Raw html takes preference (`button` over `.gl-button`)
3. As many design-styleguide assets as possible!
    - Prefer predictability over variety (fewer design assets)
    - Most of these are `.gl-`obal elements (always prefixed)
4. Page styles for single-page-related content only
    - Always wrapped in a page ID (`#page .section`)
5. Naming conventions are optional, but preferred where possible
    - `.first-second` position gets shortened to `.f-second`
    - `.call-to-action` becomes `.cta` (use comment headings, avoid long class names)
6. Adding a space in before `style=` allows for quicker column scanning
    - You can render without whitespace with a compiler (like Pandoc)
7. CUT CODE DOWN! Wherever possible :)
8. When in doubt, prefer EXPLICIT naming of styles
    - See the `img.b-left` example below
    - Is `img.left` worse than `.img-left`? (floated images)
9. **Nesting should be no more than 3 levels deep**
    - 4 absolute maximum.
    - Prefer a flat style.

```css
/* CONCRETE AND STRICT BEATS WISHY-WASHY CONVENTIONS */
/* I prefer the flat styles of ECSS (limited nesting of classes) */
/* We've changed to a lowercase naming convention */

/* Grid styles should probably be separate so they're easily changed */
.grid
.grid .col1
.grid .col2

/* You should be using raw html wherever possible (cut code down!) */
/* Here we're directly styling html elements so no need for `.gl-header` class */
header
header h1
header h1 strong
header h1 strong a

/* Only lean into Thema styles where it's:
/*   (a) Obvious that you'll need multiple `header` elements on the same page       */
/*   (b) Internal class names relate to parent (we may as well add class to parent) */
/*   (c) It's hard to ascertain what's happening in the code without a class        */
/* NEVER presuppose you'll need (a), (b), or (c) until it actually happens (YAGNI)  */
.gl-header
.gl-h-wrapper
.gl-h-wrapper h1

/* Items are grouped together with comment headers so they're easy to find */
.gl-style         /* A suitable, singular, unique short name */
.gl-s-item        /* Abbreviated with inner child name       */
.gl-si-list       /* Similar naming convention for children  */
.gl-sil-whysolong /* Rarely nest classes 3+ levels deep      */

/* For variants of a class, prefer styling the direct parent (not the container) */
.gl-header        /* The container never changes in this instance */
.gl-h-title       /* Only our `-title` changes between pages      */
.gl-h-title.right /* `.right` or `-right` are equally valid       */

/* Add variants to the outermost element rarely: prefer standardised components */
/* For safety you could randomise the class name (Thema uses `5TD-EE-A`)     */
.gl-header.dark /* Like Thema we could randomise this class name `.dark123`  */
.gl-h-title     /* Is there a VERY good reason to deviate from `.gl-header`? */

/* Page-level sections (even if repeated) should be used */
/* I don't like the GPS #id#section as it's ugly. This way you could always */
/* reuse the `.namedsection` in another `#page` (might be a bit confusing)  */
#pagename
#pagename section       /* PREFER STYLING RAW HTML over class names  */
#pagename .namedsection /* If you _must_ use more than one word ...  */
#pagename .ns-item      /* You could use initials for child elements */
#pagename .nsi-position /* Again, fewer "codes" are better           */

/* You can move items up the hierarchy (from page style to global style) */
/* As we prefer standardised components over variety, move to a `.gl-` style */
.gl-section /* from `#pagename .section` */

/* ~~The DOWNSIDE of Thema styles is it restricts nesting css classes ..~~   */
/* (well, you could nest 2-3 levels deep but we're preferring flat style)     */
#ozaria .breakout
#ozaria .b-blob    /* We could've nested `.bb-number` here   */
#ozaria .bb-number /* But the naming convention disallows it */
/* You'd have to do `.breakout { .b-blob { .bb-number } }`   */

/* Be careful of NAMING CONFLICTS (this image will be sized TWICE)    */
/* Either make it more specific `>` or name them better `b-image-left` */
#ozaria figure:has(img.b-left),
#ozaria figure:has(img.b-right),
#ozaria .b-left /* left aligned content */
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

### Videos

> Github has a [file size limit](https://github.com/orgs/community/discussions/49949) for files

You can use Git LFS for larger files, but there's an [issue loading videos](https://stackoverflow.com/a/68627864) so use the link's fix or just use YouTube/Vimeo to host.

### Stop using Marked2 app

- Currently processing some `.md` files with Marked2 App (just use Pandoc)


## Tools

> **This is my rule** If I can't get it working in a few minutes, or understand the documentation quickly; if it's not simple, ideally single-purpose, quick to get started; maybe just DON'T use it!!!

A lot of programming tools and frameworks are _way_ more complex than they need to be. However, fairly soon I'll be better off using Elm and `elm-watch` with a simple static builder tool if the content becomes dynamic, or layout needs more complex. Avoid using anything more complicated than you _really_ need (YAGNI)!

- [ ] `npx live-server --no-browser` live reloads on `http://127.0.0.1:8080`
    - You can [ignore files](https://github.com/tapio/live-server/issues/151) if you like
    - Alternatively you could use [VS Code live-server plugin](https://marketplace.visualstudio.com/items?itemName=ritwickdey.LiveServer) to reduce dependencies
- [ ] [Pandoc Markdown](https://garrettgman.github.io/rmarkdown/authoring_pandoc_markdown.html) for the win!


## Money

1. Store up a full years wages
2. Then start to invest small amounts
3. Build up income drips and get f* moving


[^1]: **Don't be an annoyingly verbose Ai article!** Literally craft your articles as if they were a slide. Reduce the amount of information they have, use imagery to get your point across succinct, and aim for one idea (or sub-idea) per article.
