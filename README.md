# badlydrawnrob.github.io

## ☝️ TL;DR

> 🎯 20% big levers only! (80/20 principle).
> ⛔️ RRR risk and aim for higher ticket offers.

Don't worry about "nice to have" features and prototype rapidly with Ai where possible. Ideas are cheap: ship and validate quickly. CSS is a ballache so remove from your life.

1. 👁 on sales funnels (ppc, email, etc)
2. 👩‍🏫 user-test and validate the prototype
3. 📖 thema styles with Ai-assists

Depending on the project a ready-made framework may be easier. Your (`print-first-css`) repo should focus on the absolute essentials of typography and design. A/B testing and marketing is more important than style. For example, an offer page should be simple:

- A title
- A description
- A simple form
- A key point list
- Testimonials

You can then rapidly test the advert, offer, etc, making minor changes. You've got 5 seconds to grab attention and most people won't read properly. Be brutalist! Customer job, pain points, sales calls, user testing, all doing the "just-enough" thing. Your learning frame should be tiny.

Art is extra; a luxury.



## My story

> What do I want to say about me?

1. Simple learning frame (Elm, Python, SQLite)
2. Prototype, owner, education (my own tools)
3. Simple educational courses (for kids? Adults?)
4. Lead magnets (for flashcard app)
5. Writing (evergreen articles and newsletter)



## 💾 Compiler

Pandoc as our static `/words` blog [compiler](https://app.studyraid.com/en/read/15019/519413/processing-multiple-files-with-wildcards)



## 👨‍🎨 Thema styles

> Shore up and make hard decisions.
> Best bits from ECSS, [GPS](https://medium.com/@jescalan/bem-is-terrible-f421495d093a), and [Thema](https://ns.editeur.org/thema/en).

My personal style:

1. Brutalist, zen, minimal
2. Small teams only (strict by design)
3. Typographic designs only (single-purpose)
4. Specimen styles should cover 80% of design
5. Writing styleguide should be opinionated
6. CSS should be as class-less as possible
7. Predictability trumps variety (concrete)
8. Explicit is better than implicit
9. Tesla — cut code down!

Simple Thema rules:

1. Flat preferable to nested (`.css` file and class names)
2. HTML design without classes 80% of time (your specimen styles)
3. Global elements around 10% of time (`.gl` design system)
4. Unique pages and views the remainder 10% (`#page #section`)
5. Never use a class when you can avoid it
6. Explicit is better than implicit (`.button` not `.btn`)
7. Prefer `.gl-menu li` to `ul .gl-item` (singular parent class)

As design and writing becomes clearer, graduation can occur up (and down) the design system.

- `#section`s that need to be reusable on a page to `.section`
- `#section`s that are needed site-wide can become a `.gl-`obal element
- `.gl-`obal elements now concrete can become raw html elements

Quick column scanning could be achieved by:

- (a) Capitalising the parent (`.gl-Header`)
- (b) Indenting the ` class=` tag in the html


```less
/* -----------------------------------------------------------------------------
 * Brutal, predictable, class-less, explicit, and flat!
 * -----------------------------------------------------------------------------
 * > ECSS was nice but lowercase is more conventional for CSS
 *
 * 🤓 Raw html strongly preferred for elements (or at least child elements).
 * 👨‍🎨 Design, writing, markup ELi5 simple (otherwise just use a framework).
 *
 * 1. Grid separate and class-less (but call a spade a spade)
 * 2. Raw html for 80% of the styling (wherever possible)
 * 3. Never assume styling is needed until it actually happens (YAGNI)
 * 4. Use Thema styles wherever the following is true:
 *     (a) It's hard to grasp what's going on in code without classes
 *     (b) It has parent-child relationships better described with class
 *     (b) It has multiple elements required across the site (`.gl-`)
 *     (c) It has page-specific elements where raw html won't do (`#page #section`)
 *     
 */

.grid         // ⚠️ Ideally site-wide
.grid .left   // More specific than `.col1`
.grid .right  // More specific than `.col2`

header
header h1
header h1 strong
header h1 strong a


// -----------------------------------------------------------------------------
// PRINT first remember!
// -----------------------------------------------------------------------------
// > This won't work for some apps: use Pico etc.
//
// 1. ⚠️ Less styling -> easier printable page
//     - You don't have to ignore or override stuff!

@media print {

}


// -----------------------------------------------------------------------------
// Group classes with comment headings so easy to find
// -----------------------------------------------------------------------------
// 1. ⚠️ Prefer raw html elements wherever possible!
// 2. ⚠️ Prefer adding class to parent-element (rather than children)
// 3. ⚠️ 2 levels deep should be maximum

.gl-nav            // 3-letter names are fine!
.gl-nav header h1  // See (1)
.gl-nav li         // See (2)

.gl-element        // Unique singular short parent name
.gl-el-item        // Child element with Thema naming convention
.gl-element li     // RAW HTML is better if possible            

.gl-element-never-thisdeep // See (3)


// -----------------------------------------------------------------------------
// Page-level elements
// -----------------------------------------------------------------------------
// > #! This needs work as GPS encourages heavy nesting
//
// 1. ⚠️ Both names as short as possible.
// 2. ⚠️ Global design system should never be styled this way
//     - Unless (potentially) a minor edit (`#page .gl-header`)
//     - In which case styles live with `.gl-header` (not the page)

#page section ul li
#page #section .item
#page #animate.  // Class may be preferrable?
#page .sec-item  // May also work

#pageisunlegible #asisthesection  // (1)
#page #shouldnot .gl-override     // (2)


// -----------------------------------------------------------------------------
// Light and dark themes
// -----------------------------------------------------------------------------
// > Use best-practice CSS (not custom class names)

:root { color-scheme: light dark; } // Follows user settings

.light { color-scheme: light; } // User-agent forces light theme

.gl-header { color: light-dark(#000, #FFF); }


// -----------------------------------------------------------------------------
// Variants append (they do not extend) class names
// -----------------------------------------------------------------------------
// > ⚠️ Prefer standardised components to variants (predictability)
//
// 1. Page styles could also hold variants if changes are very minor

.gl-el-item.variant
#page .item-variant  // See (1)


// -----------------------------------------------------------------------------
// Try to avoid complicated layouts
// -----------------------------------------------------------------------------
// > Aim for predictable, brutal, zen, minimal layouts
//
// 1. ⚠️ Can you read and understand the code quickly?
//    - No? It's probably too complicated!

#ozaria figure:has(img.b-left) // (1)
```

An ideal world would just be text and html. If in doubt, leave it out!

```html
<html>
  <body id="home" class="gl-grid">
    <div class="gl-grid-left">
      <nav class="gl-nav">
        <ul>
          <li class="gl-nav-item">
            Class names here aren't ideal (remove)
          </li>
        </ul>
      <nav>
    </div><!-- `.gl-grid-left` -->

    <main class="gl-grid-right">
      <header class="gl-header">
        <h1>
          <span id="animate">
            80% rule: raw html if only one <code>header</code> in website.
          </span>
          <small>Avoid unnecessary markup: small is fine to style here.</small>
        </h1>
      <header>

      <section id="#about">
        <h2>Section is <em>only</em> ever on <code>#home</code> page.</h2>
        <div class=".specific">
          <h3>Content only available on the home page.</h3>
        </div>
      </section>
    </main><!-- `.gl-grid-right` -->
  </body><!-- `.gl-grid` -->
```



## 🐞 Bugs

1. Macbook Air will render typography smaller!
2. Pandoc adds `<p>` tags inside a `<div>` wrapper
3. Improve [analytics](https://conversiontracking.io/blog/tally-forms-conversion-tracking) and user-interaction[^1]
4. Github [file size limit](https://github.com/orgs/community/discussions/49949) for files



## 👨‍🎨 Specimen

> Add some nice typographic touches (ligatures, pull-quotes, pull-images, etc)

1. Easeful `font-size`
2. Evergreen writing
2. ELi5 writing and markup
3. One idea per slide
4. Legible and non-academic
5. Fun and colourful!

### ✍️ Writing styleguide

> **Is all my content "evergreen"?**
> Start simple for now (build later/never)
> Is it fun to look at? (finger painting for adults and kids)

1. **Simplify articles (ONE idea per slide)**[^1]



## 🤖 Tooling

> ⚠️ If it's not up and running in 10 minutes, I don't use it.

Documentation is a real skill. Language design is difficult. But the opportunity cost of spending forever learning some new widget is real. Simple, boring, effective. YAGNI!





[^1]: 1st party data and cookie-less design!
