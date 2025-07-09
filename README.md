# badlydrawnrob.github.io

## Thema styles

> **Make concrete hard decisions and rules**
> Inheriting a mish-mash from ECSS, [GPS](https://medium.com/@jescalan/bem-is-terrible-f421495d093a), and [Thema](https://ns.editeur.org/thema/en) Styles

Your specimen file (global `h1, ul, a, ...`) should set up the lion's share of the styles, before moving on to style with `.gl-` classes.

- `.gl-`obal elements (changes to these should be monitored v. carefully)
- `gl-nav` and `gl-nav-title` if name is short?
- `gl-header` and `gl-h-title` if name is not short?
- What about areas that are duplicated only on one page? (use `.pg-` styles?)
- `#page` and `.repeatable` elements (non-global styles)
- `#page #section` and `.section-styles` (non-global, limited to that page)
- **SPLIT OUT THE GRID ELEMENTS?**
- **FIX UNECESSARY `<p>` TAGS** for Markdown output (currently processes as Markdown inside divs)

I don't like two `#id#ids` together. Feels weird. `#id .id-scoped` better?
Or even just `#name .regular` might be enough, so long as it's scoped to page
I quite like using flat styles like we were in ECSS, not nesting too heavily.
Thema book categories `CODE` is detatched from the title name, we try to attach it.

```css
/* examples */

.animate .animate-words .animate-w-hidden
.animate .animate-static
```

Process [multiple files](https://app.studyraid.com/en/read/15019/519413/processing-multiple-files-with-wildcards) with Pandoc (terminal command)


## Tools

> **Rule** If I can't get it working in a few minutes, or understand the documentation quickly, and if it's not simple, mostly single-purpose, and quick to get started ... maybe just don't use it. A lot of `js` tools are _way_ more complex than they need to be.

Fairly soon I'd be better off using Elm-Land or elm-watch and perhaps a static site builder tool.

- [ ] `npx live-server` to run server and watch for changes on `http://127.0.0.1:8080`
- [ ] [Ignore files](https://github.com/tapio/live-server/issues/151) with `live-server`
- [ ] [Pandoc Markdown](https://garrettgman.github.io/rmarkdown/authoring_pandoc_markdown.html) (an overview)

## To Do

1. **Simplify articles (ONE idea per slide)**[^1]
2. Lead magnets (teaching, flashcards, etc)
3. Thema CSS and GPS style (and simplify code where possible)
4. Remove EVERYTHING that's ECSS style (model-first, not components first)
4. Build it with Elm Lang (using `json` data and markdown)
5. What about accessibility? (stuff like [grid order](https://rachelandrew.co.uk/archives/2019/06/04/grid-content-re-ordering-and-accessibility/))

## `@media`

- How am I handling light/dark theme, mobile-first, print-first, and so on?
- Are lots of `@media` queries preferable?
- A nice grid layout, with 2-column articles and interesting layout
- Buttons should make more sense (no need for Tally form button AND other button)

## Writing

> Is all my content "evergreen"?
> Start simple for now (build later/never)
> Is it fun to look at? (finger painting for adults and kids)

**Be more legible at all screen sizes (current font/size sucks for articles).** Make some concrete rules for yourself on writing. Add more colour to your writing, with fun examples. Perhaps add nice typographic touches like ligatures (or pull-quotes, pull-images, so on).

## Money

1. Store up a full years wages
2. Then start to invest small amounts
3. Build up income drips and get f* moving

## Compiler

Currently using a pandoc template, but processing some `.md` files with Marked2 App.
Be consistent, simplify the build script (consider using static site generator?)


[^1]: **Don't be an annoyingly verbose Ai article!** Literally craft your articles as if they were a slide. Reduce the amount of information they have, use imagery to get your point across succinct, and aim for one idea (or sub-idea) per article.
