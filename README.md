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

I don't like two `#id#ids` together. Feels weird. `#id .id-scoped` better?
I quite like using flat styles like we were in ECSS, not nesting too heavily.
Thema book categories `CODE` is detatched from the title name, we try to attach it.

```css
/* examples */

.animate .animate-words .animate-w-hidden
.animate .animate-static
```


## To Do

1. **Simplify articles (ONE idea per slide)**[^1]
2. Lead magnets (teaching, flashcards, etc)
3. Thema CSS and GPS style (and simplify code where possible)
4. Remove EVERYTHING that's ECSS style (model-first, not components first)
4. Build it with Elm Lang (using `json` data and markdown)

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
