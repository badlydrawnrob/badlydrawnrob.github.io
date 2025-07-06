---
title: Golden rules for css stylesheets
subtitle: 
body-id: words
intro: >-
    **The following article is mainly geared around CSS and HTML,** but a lot of these “rules” could be written about a lot of things, be it design, programming, or writing a lesson plan. 
---

<!-- #! Fix footnotes -->


<!-- # Golden rules for CSS stylesheets -->

<!-- Writing Styleguide: book titles, italics, bold, when to and not to 
I REALLY need to write another thing about really thinking up-front about
your choices of data, process, user interface, etc .. for example, trying
to split a float string and run checks on it takes A LOT MORE EFFORT than
simply using two ints for `minutes` and `seconds` fields. You might even
have to deal with `time` in that instance. Proper programming is HARD. -->

The general gist is: keep it as simple as possible, while doing just enough to solve the problem. Sometimes that might mean making it _more_ complex, before simplifying it again. It’s a delicate balance to design and code a user-interface, to arrive at a solution that’s pleasant to walk around, maintainable, and good code. 

For my own needs, I rarely want to build anything with more complexity than you might find in a Kindle or Kobo user-interface; for many things, basic text-elements are just fine. To write with brevity and concision is in general my preference, for writing and CSS. I’m not sure if this article will come across that way, but I hope so!

## CSS sucks and I don’t want to write it

> Start from a position of a lazy coder, and limit the amount of code you have to write. This works hand-in-hand with a lazy designer!

Basic CSS is pretty easy, but it can get complex quickly, and there’s quite a bit of it that’s not particularly obvious. It’s not like regular programming where there’s often one way to do it (the Python way); layouts are infinitely flexible and subjective. The language that combines visual with logic can be far more difficult than the same design using software. Take `line-height` for example, and a `.baseline-grid`. It’s trivial in InDesign to align all text to a baseline grid, making slight alterations for smaller font sizes. As the user-interface becomes more visually complex, this becomes harder to achieve, and it’s _far_ easier to stick to a simple line-height with CSS.

Add in the different states of your UI, the variety of HTML elements you, or the user might provide, and the `x-height` of fonts (which isn’t the same), and CSS frameworks are going to fall down eventually. Browsers are far more reliable these days, and one will generally render the same as another, but slight visual differences can become large changes in code.

On top of that, there’s specificity, inheritance, server-side template languages, browser adoption, and so much more that your design software just doesn’t need to consider. A beautiful and fancy design can _feel_ nice, but coding that up might be a real chore. Take a quick look at the [mountain of classes](https://tailwindflex.com/@lukas-muller/book-appointment-form-2) Tailwind uses to get an idea of how much CSS _you could use_ if you so desired.

So TL;DR, write for your lazy future self, creating a visual experience that’s pleasing to the eye, but easily maintainable.

### Explain it like I’m five

> After a break of 5 years, can you still understand it?

There’s [a great forum on Reddit](https://www.reddit.com/r/explainlikeimfive/) where people try to explain things in the most simplistic style possible, hence the name ELi5 (explain it like I’m five). This was also 📖 [Richard Feyneman’s](https://archive.org/details/Surely-youre-joking-mr.-feynman/mode/2up) creed and he once said “if you can’t explain something in simple terms, you don’t understand it”, or something along those lines.

Not only should you start with the simplest thing possible (a [specimen file](https://typespecimens.xyz/)), the code’s purpose should be crystal clear. What was that `.cryptic-Class` named for? Why isn’t the `.box` class in your design-system file? Why use a javascript plugin when `<details>` does everything you need, and is more descriptive?

CSS and HTML will evolve, as well as the programming languages that compliment them, so changes are inevitable. But as much as possible, your code, templates, design-system, etc, shouldn’t break in 5 years time, and should be well organised and  `<!— commented -->` so it’s meaning is clear.

## 5 steps to reduce your code

> Code like you’d write. Have a good editor!

A good writer is in need of a good editor. I’m a fan of Terry Pratchett, but boy, some of his later works could’ve done with a harsher critic, creating better cohesion and stronger cuts. Some of that is personal opinion, but other works, such as some programming books I’ve read could be cut down and simplified (with academic words culled). There was a (now defunct?) website called “[Cut Code Down](https://web.archive.org/web/20240303075120/https://cutcodedown.com/article/minimalist_semantic_markup)” which is _very_ opinionated, but the sentiment I’d agree with. That, alongside [Brutalist](https://brutalist-web.design/) design (as in, architecture), point towards a style whereby a great number of sites need only the absolute basics of HTML: text, links, images, lists, blockquotes — and that’s about it!

Elon Musk has a 5 step plan for engineering (or editing), which we can steal from!

1. **Make the requirements less dumb.**
   - Who gave them? Are they clear enough? Concrete enough?
   - Should these requirements even exist? Bin first.
   - What exactly, are the essentials? Are they [well shaped](https://basecamp.com/shapeup)?
2. **Delete the part or process step.**
   - What item, feature, or step can be removed?
   - Can we reduce the amount of time spent on a process?
3. **Simplify or optimize.**
   - Should a thing even exist?
   - If it should exist, can it be optimized?
4. **Accelerate cycle time.**
   - Make sure you’ve done (1), (2), and (3) first.
   - Only if it’s shaped, necessary, and efficient …
   - Be lean. Be agile. Speed it up.
5. **Automate it.**
   - Use tooling to compile (like a [`.less`](https://www.npmjs.com/package/less) compiler).
   - Use AI where it makes sense.

## A distaste of state. Seriously. Cut it out.

> State is anything that deals with movement, elements changing, memory, data updating, and so on. It’s one of areas that adds great complexity if you aren’t careful.

I personally have an aversion to state. I wouldn’t seriously call myself a programmer, but I’ve done it enough to know that, for instance, gaming is a seriously time-consuming thing to code. There’s so much state, and especially if it’s functional, a lot of code to write. CSS animations, user-interface changes, `-variations`, menu hover states, or any “nice-to-have” functionality, are all extra things to consider when building and maintaining your app or website.

Unless you like this sort of thing (which I really don’t), keep your state simple. Forms are a great example. Relying on one field’s answer to inform the next field requires memory and logic. The more “state” (logic or memory) the form needs to remember and keep updated, the harder that becomes to reason about. Relying on 2-3 field’s inputs and having them determine what a user sees next can become confusing to manage, quickly.

So aim for simplicity. Wherever there’s an animation, a reliance on memory, or template logic, try [5 steps to reduce your code](#5-steps-to-reduce-your-code) and see if you can’t make life easier for yourself.

## Don’t get complected.

> Complected is a beautiful word with a deadly sting.
> To join by weaving: for code to become “complected”.

Just like functional programming aims to split out functions and abstract similar ones, you should avoid weaving and interlacing your CSS code too much. Isolate your styles with reasonable names, so your `.gl-PullQuote` relies on nothing but itself. A `.child-of-parent` class should only depend on it’s parent and your base styles (your specimen file). Nothing more.

Adding needless complexity and dependence, such as using Less CSS [functions](https://lesscss.org/functions/) or [mixins](https://lesscss.org/#mixins), however useful they might be, creates a coupling (to that framework) that you don’t really need. Adding a dependancy on a class that’s unrelated to the job at hand, or inheriting one class from another, also creates complected code. If you only rely on browser-supported CSS, and if every class isolates the problem _within_ itself, you can be assured it’s not going to break. The only time I’d lean on Less is where functionality [isn’t allowed](https://css-tricks.com/nested-media-queries/) in regular CSS, but is handy, such as:

```css
.wrapper {
	margin: 20px;

	@media screen and (orientation: portrait) {
		margin: 0 auto; /* CSS won't allow nested `@media` queries yet */
	}
}
```

So this is a very _light_ dependency, but it’s still a minor _complected_ one. I could just as well stick to using regular  `@media` queries and nesting the `.class` inside them. So, however you structure your code, if you can’t be confident your HTML and CSS will work in 5—10 years, reduce the amount of complexity — and rarely complect!


# Here’s some more golden rules to follow

> In an ideal world, there should be one way (and only one way) to write your CSS. Whichever style you adopt, it’s best to stay consistent and keep it as simple as possible! we don’t have oodles of `.class` names where an `ul` will do, and we won’t add cognitive load when we come back to our stylesheets 5 years later.

1. Don’t repeat yourself.
2. Avoid complexity and state.
3. Add in sensible defaults with a design-system
4. Similar does not mean the same.
5. Be concise and explicit.
6. Be careful of inheritance. Isolate.
7. Keep it simple stupid!
8. Don’t make me think!

### 1. Don’t repeat yourself

ECSS was a big proponent of extreme isolation. If a style was the same in two different places, styles were duplicated and unique class-names given to each component. Scoping your css as [`.simple-Card_KeyPoint`](https://github.com/badlydrawnrob/anki/blob/3b8a3bc3b1e11f4719adfacb9fc006cd99819fe0/source/themes/cards/simple/simple-front.mustache) and [`.missing-Card_KeyPoint`](https://github.com/badlydrawnrob/anki/blob/3b8a3bc3b1e11f4719adfacb9fc006cd99819fe0/source/themes/cards/missing/missing-front.mustache) creates absolute certainty that one can never influence the other, but at the cost of lots of repetition of code. [GPS](https://medium.com/@jescalan/bem-is-terrible-f421495d093a), on the other hand, aims to reduce code duplication to a bare minimum, while generating reusable styles for components, and scoping unique `#page` level css with `#sections` of content and non-reusable classes.

DRY code isn’t always possible (or even desirable in some instances), but it’s a good place to start. If you find yourself needing to reuse a `#section` on a different page, it should be moved up a notch to a `.gl`obal element. Conversely, if a global element needs adapting for a particular page, you might consider converting it into a `-variable` or `#section`.

TL;DR: You want as much of your styles as possible to be together in a single location, as simple as possible, in as few lines of code as possible.

### 2. Avoid complexity and state

> It’s so important I’ve listed it twice!
> Where things can be removed or simplified, do so.

Simplify, simplify, simplify. There’s the tendency to _over_ design when you’re starting out, spending long periods and many revisions getting things “perfect”. Great art and technique is something to admire, and some like to layer it on thick. I’ve never been that way inclined, most of my work leaning towards the minimal. [Bauhaus](https://en.wikipedia.org/wiki/Bauhaus), [Barnbrook](https://barnbrook.net/work/david-bowie-heathen/), [Brian Eno](https://www.brian-eno.net/), [Hockney](https://www.hockney.com/home),  [Swiss-style design](https://en.wikipedia.org/wiki/Swiss_Style_(design)), [Warhol](https://en.wikipedia.org/wiki/Andy_Warhol), [Zen Architecture](https://www.bbc.com/culture/article/20221206-japans-most-zen-like-minimalist-interiors),  and the [artist’s grid](https://monoskop.org/images/a/a4/Mueller-Brockmann_Josef_Grid_Systems_in_Graphic_Design_Raster_Systeme_fuer_die_Visuele_Gestaltung_English_German_no_OCR.pdf) (which [Piet Mondrian](https://en.wikipedia.org/wiki/Piet_Mondrian) made great use of) are all great examples of design that’s also simple.

As with music, good design is as much about what you _take out_ as what you _add_. Take, for example, [advertising](https://www.youtube.com/watch?v=Zt336MYMY2c). At the time of writing, advertising has become massively simplified, often using a short phrase, sentence or word, with well-placed imagery to evoke a mood, a memorable idea, or appeal to a demographic or archetype. The world is noisy. Cut through it.

Your CSS should be no different to those ads. The more state, animations or layers you add, the more code needs to be generated and tested to see that idea to life. I’ve been from top to bottom, learning design for print, digital, and eventually frontend (and backend) code. I’m definitely no Picasso when it comes to coding, but I understand what happens when you add complexity. It’s harder to manage, harder to test, harder to maintain. Unless you’ve got a large team and money/time to burn, keep it simple, stupid!

You can start with the _[5 steps to reduce your code](#5-steps-to-reduce-your-code)_ and follow it up with the themes of simplicity our art and music references provide. As you go, add simple layers to your design, abstracting where possible, cutting as much out as possible.

### 3. Add in sensible defaults with a design-system

This can be as simple as a `.gl-Box`, `.gl-Image-large`, and a `.gl-PullQuote` or as complex as Apple’s latest Macbook release page. I’d heavily advise against anything as complicated as Material Design — it’s a very commendable effort to bring together apps with a unified layout — but it’s HUGE. Too big. The first time I saw it back in 2016 it made me want to weep. Granted, things have moved on a lot since I started Graphic Design, and static print-based layouts might seem a bit old-hat these days, but I dare you to finish [Grid Raster Systems](..) and not marvel at the beauty of simple (but varied) Swiss design.

A good place to start for understanding design is _[The Design of Everyday Things](https://www.google.com/url?sa=t&source=web&rct=j&opi=89978449&url=https://en.wikipedia.org/wiki/The_Design_of_Everyday_Things&ved=2ahUKEwjgoduzjZiIAxXr1wIHHSqQDwQQFnoECAYQAQ&usg=AOvVaw2vukYZ7Ah08_2XWoqyCfv1) (Donald Norman)_. Take a look at the _[A Book Apart](https://abookapart.com/)_range of books while you still can — there’s some great wisdom in those. Go find some simple design-systems, such as [Pico CSS](https://picocss.com/), but beware of big company designs as they tend to be quite bloated.

### 4. Similar does not mean the same

> You have a few options here: _[The Tao of stylesheets](/words/css-the-tao-of-stylesheets)_ explains them better.
> - Create a `-variant` and add in changes,[^2]
> - Self-isolating children with a `.gl-Parent` or `-Standalone` style,[^3]
> - ~~Adapting styles within the `#page` or `#section` it’s in~~,[^4]
> - Create a brand new (similar but different) `.gl-` class
> - Create a `#page > #section` that’s unique.[^5]

There’ll come a time, possibly often, where you’ve got a layout that is _exactly_ the same, but for a few minor differences. There’s a [great talk](https://www.youtube.com/watch?v=XpDsk374LDE) by Evan Czaplicki (the creator of Elm Lang) on programming two widgets which _seem_ the same, but are actually very different. In the video, he explains assuming the same approach for both may not work. Now, while css is a lot simpler than functional programming, that video outlines a sensible approach. If you try and shoehorn in changes, you can add complexity to the component, which is less preferable sometimes than creating a new one.

The best advice is to try and keep the code [DRY](#1-don't-repeat-yourself) until it starts getting complected or hard to understand at-a-glance. You can then try one of the above options to simplify the code base.

### 5. Be concise and explicit

> Can you easily reason about your `.class` names?
> Aim to use raw HTML base-level elements wherever possible, but …
> _Explicit is better than implicit_. Don’t make me think!

Always have a parent `.gl-ClassName` or `.pg-ItemClassName`. Use HTML child elements where you can, but if their meaning isn’t clear, be explicit in your `/* comments */` — what, exactly, does this element do? What’s it’s reason for being there?

Where HTML elements are weak,[^6] such as a `div`,  `p`, or `span`, consider adding a meaningful name (a good example is syntax highlighting, i.e: `span.op` for operator). GPS doesn’t advocate using a `.scope` class name (such as `.gl-` or `.pg-`) outside of globals, but sometimes they help too. If it’s scoped clearly to the `#view` or `#page` than a forms meaning should be clear. In general though, forms should be a set-once-and-forget-about-it job. Don’t over-engineer, but as _[The Zen of Python](https://peps.python.org/pep-0020/)_ explains: _explicit is better than implicit_.

- `#faq details summary` is self-explanatory, but `#faq ul li h3` isn’t.
- `#blog .advert .buy-link` is much better than `aside p > a`.

Write the simplest, most descriptive, most appropriate name you can. You’ll thank me later when you’re knee deep in a refactor.

### 6. Be careful of inheritance. Isolate.

Inheritance can be a chore, which is why many of these CSS frameworks aim to isolate or reuse styles wherever possible. Just try styling a `<button>` element with plain CSS to see how quickly you reach for a framework that does it all for you! These days, I like to keep my websites simple, available to print with `@media print` styles, then reduced and distilled into a tight package which loads quickly in the browser. That might not suit all projects, especially if you’re visualising a lot of data, but for reading and simple customer journeys, it serves.

The more CSS you write, the more chance that somehow, somewhere, you’ve overridden a style that shouldn’t have been, or adding complexity that needn’t be there. If you’re writing styles like `h2 > p + p > span a:hover` you’re asking for trouble; what if I have more than one paragraph? How do I remember _exactly_ what goes where in my HTML? What’s the `<span>` tag for? Why is _this_ `:hover` state different from the `/base/html` hover state? Is that necessary? Is that easy to understand? Will it break something?

If you have a big team, multiply that risk by 10, and you’ll soon land yourself in trouble. Limit how many colours you’ve got, limit the amount of `+` and `>` you’re using, make your CSS concise, descriptive, and explicit. Prefer a global design-system over random `:hover` states. Make use of unique `#page` and `#section` IDs. Isolate styles for each component.

Before you reach for your toolbox of CSS selectors or add another design element — stop and think. As a rule I start with NO. That’s NO to that new design element. NO to complexity. NO to fancy CSS that I’ll forget how to write in 2 years. NO to a complicated stylesheet that I’ll have to maintain. Aim for simplicity, actively reduce the amount of code, sensibly add in constraints, which can often make design _more_ attractive.

That’s an ideal world and sometimes you have to please clients, but do _try_.

### 7. Keep it simple, stupid!

> A quote from some wise person.
> Write for your stupid future self.

I forget code _all the time_. I don’t pretend to be an expert, and I most definitely don’t know it all. CSS is an endless void that can suck you up without great care. The quicksand of complexity is really something that can’t be stated enough.

If you’re like me and you want to write as little CSS as possible, then write for your stupid future self. I’m not a Google employee writing thousands of lines of code everyday, which means if I leave a project alone for a few months, there’ll be a few things I either don’t understand or have forgotten the purpose of — even if I’ve followed all my own rules! Keep your `.class` names explicit, simple; add some carefully placed and well-worded comments.

Add links to documentation or articles. You’ll need them in future, believe me. I once wrote a [`.gl-BaselineGrid`](https://github.com/badlydrawnrob/print-first-css/blob/fea925978558329112859e94f9525dd96c552882/source/style/globals/baseline-grid.less) class and I can count on one hand how many times I’ve used the `linear-gradient` feature of CSS. Which order do I write the `deg`ree direction, the colours, the `start` and `stop` of each colour? How in the hell did I do that `background-size` thing? I can’t remember, I’d have to look it up. I have 41 lines of comments in my `baseline-grid.less` file. How to use it, how I learned it, how to `toggle()` it on and off, so on. Ideally, I want to write it once and forget about it — forever.

And on the topic of using a preprocessor — be it SASS or Less — I’d advise “DON’T DO IT!”, don’t treat CSS like a programming language; it isn’t one! Well, not really. The only reason I use `.less` files now is to simplify my codebase, so each file is focused on one thing: `text-elements.less` for example, or `horizontal-rules.less` to get more granular. It’s also pretty handy for `npm watch`ing changes in my stylesheets, so I can render that in the browser in real-time. Then I can minify and uglify or whatever.

For anything else (and I mean ANYTHING) just use plain old CSS. Heck, even [nesting and `&`](https://developer.mozilla.org/en-US/docs/Web/CSS/CSS_nesting) is in the latest version of CSS. That’s great! And if you’re just starting out, please, _please_ at least learn the basics first before using Tailwind. If something breaks, you’ll be lost.

### 8. Don’t make me think!

> _Don’t Make Me Think!_ is a book by [Steve Krug](https://sensible.com/dont-make-me-think/).
> Read it. Read it again. Engrave it on your brain box.
> It’s worth the money and it’s worth reading.

Usability, the customer journey, onboarding, articles, design systems, forms, `:visited` states, light and dark themes, whatever it may be, for the love of the seven _Don’t Make Me Think!_ I’ve covered already why your own codebase should follow that rule, so why on earth would you make life difficult for your end-user; your customer. Y’know, the one who’s paying you hard currency.

I once had the worst experience with a mobile provider in the UK (EE) and their onboarding was _terrible_. Seriously the worst experience I’ve had with onboarding. They supposedly have the best connectivity in the UK, but it’s likely I’ll never use them again. Here’s how the story goes:

1. **I bought a sim at a local store.**
   - Their UX and UI is _awful_. Impossible to figure out how to link that sim.
   - When I finally managed to, the deal on the sim wasn’t the deal I could get.
   - So I chose a sim on their online store with a cool package. Something went wrong and I needed to contact customer service to cancel that package …
2. **During the sign-up process, they asked for sensitive details:** my date of birth.
   - I purposefully submitted the _wrong_ date of birth so it’s not stored in the ether.
   - It’s _nowhere_ to be seen in my online profile. Gone. Nada. Nixt.
3. **Customer service continuously ask for said details** which _I can’t view or edit_ online.
   - Their automated telephone service _says_ you can edit it by phone …
   - But it gave no options I could find, so I gave up on that route …
   - Three times I attempted to cancel my ordered sim …
   - It simply can’t be done without your date of birth …
   - And there’s no way around this. _Even though_ they can send a passcode to my mobile to verify it’s really me.
4. **I gave up.** It pissed me off so much, it’s unlikely I’ll use their service again.

Ever had an experience like that? At a restaurant or a store? There is a big long list of _what not to do_. You’d think a company so large would’ve got their user experience sorted out, but anyway. The moral of that tail is somone had a great idea that date of birth is the go-to security method, but they neglected to tell their dev-team. Don’t put your readers or your customers through that.

Needless complexity and obfuscation is a frustrating chore and if you allow that on your watch you _deserve_ to lose customers.




[^1]: This is where I feel GPS gets a bit wishy washy. _“All page-specific styles should be scoped under this `#page` ID”_ and _“Any CSS that you write that is not global should always be scoped under a page or view’s ID”_. A `#section` is a unique bit of the page, but if _“later on you notice that the same style is actually used elsewhere on the same page, you can pull it up to a page-specific style”_, and then on up the chain until you hit `global` elements, site-wide. This is heavily leaning towards _nested_ CSS and I’m not sure that I like that.

[^2]: This is the simplest option. If your design has slight differences, such as the colour of a heading, you can add a `.gl-Parent-red header` variant. This assumes that the code order is the same; if the order of the code is in question, such as a `margin-bottom` change because the `header` is in a different position, better change it into a `gl-Standalone` element, or at least set the header’s margin dependant on it’s `-variant` and not it’s position.

[^3]: Self isolating means to split out the code as you might do a function. It’s _within_ a `.gl-Component` but it looks _exactly_ the same on it’s own _outside_ the component. If the self-isolated element itself contains children, it’s converted to a `.gl-Parent` element. If it lives on it’s own, its ` .gl-Standalone` element (no children). For example, `.gl-Image` contains a `.figcaption`, but `gl-PullQuote` lives on it’s own.

[^4]: I don’t advocate for this option, as it relies on _inheritance_, rather than a `.gl-Component-variant`. You _could_ use this method to nest the page ID inside our element, like `.gl-Component { #page & { ... } }`. This will render our styles when `.gl-Component` is a child of `#page`. The downside of this approach is we have to remember, and search for, our `#page` element’s styles outside it’s main chunk of code, or file. Better to keep all styles together where possible.

[^5]: If there’s an element that’s shared between the `.gl-` style and the `#section` style, you could always split out it’s children to be shared between both. For example, a `.gl-Card` and a `#section .card` that both have a child `.full-width-image` within.

[^6]: By weak I mean an element that isn’t descriptive enough in its meaning, or use. A good example would be a `<span>`. Is it purely used for visual styling, or does it have meaning? If there’s no better alternative (such as `abbr` or some other accessible element), consider adding a more meaningful class.

[^7]: I don’t mean _be a lazy person_ and don’t get anything done, I mean treat work with scepticism and as something you don’t really want to do. If a problem can get solved by working smart, or punting that idea downstream until it’s been abstracted enough to solve a few problems at once, or in a way that’s satisfyingly simple, then do that. A list only ever grows!

[^8]: This is very important to note. There’s a lot of issues and discussions that are probably not relevant for my target audience, or at least _they don’t care about them enough_ to respond. Although this is disappointing and makes it difficult to know how to move forward with the tool, it’s also understandable. Beginner programmers need an easy and shallow learning curve to begin with and confusing them with compilers, complicated terminology, and lots of customisation options is at best a distraction, at worst put a beginner off before they’ve even downloaded the tool!
