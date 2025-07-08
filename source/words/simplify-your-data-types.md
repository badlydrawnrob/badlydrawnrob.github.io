---
title: "Wait: Stop Coding! Check your data first!"
subtitle: 
body-id: words
intro: >-
    **Often I’ll find myself coding before properly thinking through the problem;** ending up with over-engineered, messy, or complex code. I have to look through that code. I’ll look back on that code. It’ll confuse me, or give me brain farts. It has to be maintained. Who wants that? 
---

<!-- # Wait: Stop coding! Check your data first! -->

<!-- > Often I’ll find myself coding before properly thinking through the problem; ending up with over-engineered, messy, or complex code. I have to look through that code. I’ll look back on that code. It’ll confuse me, or give me brain farts. It has to be maintained. Who wants that? -->

<!-- #! Requires a better intro, such as a BlockQuote style -->

Now I’m not the best of coders; I’m good to an educational level but I don’t have much experience (yet) building big things. I don’t code often enough. This results in lots of forgotten syntax, sifting through code becomes a chore, or I simply can’t fit it all in my head and see the flow of the code. This happens often.

I once was told “if you’re not coding 12 hours a day, you’re going to struggle”. That sounds about right — unless you’ve built up your muscle memory and trained your brain into a finely-tuned code killing machine by doing it day in, day out, you’re going to come unstuck. That’s a given. But it doesn’t mean you can’t help yourself out by reducing complexity and producing clean code that’s sense-making.

In a recent attempt at doing form validation, which can be difficult, I stumbled upon a few good lessons. It’s mostly focused on functional, but it serves for any code you might write:

1. Start with the simplest thing possible …
2. Write it down! Sketch it out!
3. What data types do you need?
4. What are your function inputs? It’s outputs?
5. What, exactly, do the functions need to do?
6. Write them down too! Any gotchas?
7. Now follow the “5 steps to reduce your code”.
8. Rewrite your code to the simplest thing possible.
9. How does that code look now?

Too many times I’ve started to attack a problem by writing code first. You can follow the [design recipe](https://htdp.org/2019-02-24/part_preface.html) on this page[^1] but personally, I find it very helpful to write that thing down, sketch it out like a flowchart, boxes, squiggles, comments, whatever it takes to visually represent those inputs, functions, and outputs for a solid representations of _what it’ll take to code_ the damn thing.

## The two routes: one complex, one simple.

> Can you guess which one is simple?

<!-- Image of the two routes -->

There’s A LOT you can learn from doing that. A good example is the form inputs above. To begin with, I only started typing the first route and _didn’t even consider the second route_ until I found out I was unpacking a `Maybe` and converting a `String` in a lot of places. It made sense originally, as I couldn’t find a function in [Elm Lang](https://elm-lang.org/) (based on Haskell) that would help me count the decimal points of a `Float`. Turns out _you can_ [truncate decimal points](https://package.elm-lang.org/packages/myrho/elm-round/latest/) with a package or [some maths](https://stackoverflow.com/a/31952975) (not my strong point) but I didn’t look for those up front and decided to count the number of decimal points instead (with string functions).

So, you have the original data type (a form field input of `String`) and you know the output (a `Float`) and you’ve got a rough idea of how to get there. That’s great, but without considering different routes upfront, you risk writing messy, over-engineered code.

I hate state. HATE it. Functional programming seems to call for endless lines of wrestling, cajoling, smoothing, just to make something move. Take a retro space invaders game, for example.[^2] There’s a lot of state there. Bounding boxes. Moving parts. I can’t begin to imagine how difficult modern gaming is to create. I’m happy enough to follow a tutorial, but I’m not the kind of person who enjoys figuring out how to make games. The less state the better as far as I’m concerned – that goes for user-interfaces and forms too.

Perhaps it stems from my design background, where old-school design was generally fixed visuals without much motion. Everything seems to be motion nowadays. Whatever the reasons, I aim for simplicity and fewer lines of code wherever possible. To me, that’s simpler to deal with, simpler to read in a few months time, and suits my brain which isn’t that logic-oriented (in a computer science way). For my purposes, I’m interested in pragmatic code that helps me build a business or test an idea. I can always hire someone for the tough stuff — I’m not out to save the world with code! That’s just me.

I digress. Back to the problem. So we have:

- An input type of `String` which converts to a `Float`
- This stands for _minutes_ and _seconds_ for time
- Multiple things that could go wrong with that output …
- Which we structure as a `Result` with `Err`ors or an `Ok Float`
- This needs to prompt the user to fix those errors
- And until then, the cycle continues.

Route 1 sounds simple enough, but we need to check for:

- `String` is empty
- `String` is a `Float`
- `String` is a “proper” `Float` (two decimal points)
- Decimal points are within range (`<= 10` minutes and `<= 60` seconds)
- And a few other potential errors (such as negative values)

So you’ll see that our errors compound and our “simple” idea of a text box expecting a `Float` is becoming a bit harder. On top of _that_ functional typed programming adds an extra layer of “difficulty” that Javascript or Python doesn’t. I won’t get into the differences between static and dynamic languages; all you need to know is that code gets compiled (converted from Elm Lang to Javascript) and any errors are checked as it’s compiled. With route 1 you’re going to get a lot of these types of errors:

```elm
update : Maybe String -> String
update ms =
	case ms of
		Nothing     -> ""
		Just string -> string

-- Run the function
update "a little string"
```

```terminal
The 1st argument to `update` is not what I expect:

10|   update "a little string"
             ^^^^^^^^^^^^^^^^^
This argument is a string of type:

    String

But `update` needs the 1st argument to be:

    Maybe String
```

I won’t go into detail what a `Maybe` type is, or what type-safety means, as that isn’t really the point of this article. The point is that anything adding complexity to the code should be met with suspicion. As Elon Musk points out with his “5 steps to reduce code”, requirements can be dumb, and you should always try to delete or simplify the process and resulting code _before_ you reach for anything else. The same can be said for HTML, CSS, design, or just about anything.

So our requirements are already creating A LOT of potential errors, our code has to unpack a lot of `Maybe`s and `Result`s, it falls down in it’s processing of the `String`. My first route also stipulates that:

- A `Float` needs to be tested in many ways
- It needs to be converted from a `String` to a `Float` (at least twice)
- But also needs to be converted from a `String` to two `Int`s in one function
  - To check minutes and seconds are within range
- As well as all that, there’s three `Result` types to be chained together, and if the `String` is `Ok` it needs to change on the very last `Result` to a `Float`.

You see the complexity building up? You don’t need to know how to code to look at all these steps and see that a simple problem is now becoming complex. There’s also the (annoying?) fact that Elm Lang converts a `"2.00"` and a `”2.10”` to `2` and `2.1`. Its type is still a `Float`, but we now have the extra complexity of handling that case if we’d really prefer them to keep their decimal points.

All these extra problems add up, from the top of the stack (front end form) to the bottom (a `json` file that holds the data).

## Counting the steps in the process

You really only need to count the steps in the process, all the handling of data you’d need to do, all the states the end-user would see, as bullet points or sketches to figure out how complex your route _really_ is. You might be surprised!

<!-- Picture of route 2 -->

1. Two `Int` inputs
2. One for minutes and one for seconds
3. Each must be within a certain number range
4. Minutes must be more than zero
5. That’s about it.

Now contrast this with route 2. This is just an example: your problem might have a few routes. Perhaps one route isn’t the best way to do it — perhaps it’s not the fancy, shiny way your user would prefer — but it’s SIMPLE. And simple adds up. Simple reduces the code base down by 80% (in this case). Simple reduces the error states. Simple makes my life a whole lot easier. And _that’s_ what I’m looking for. There’s been a few occasions where I’ve aimed for something smarter, and what’s popped out the other end takes so much more effort to achieve. The data you use _matters_.

Take for example the days of the week. We could represent these as an `Int` for each day, from `0` to `6` (using index style formatting) as does _Beginning Elm_ in it’s [simple method](https://elmprogramming.com/case-expression.html) to turn a bunch of `if`/`else` statements into something our view can use:

```elm
daysOfTheWeek : Int -> String
daysOfTheWeek i =
	case i of
		0 -> "Monday"
		1 -> "Tuesday"
		2 -> "Wednesday"
		_ -> "And so on"
```

So far so simple, but I wasn’t content with this and went on a journey [to use recursion](https://discourse.elm-lang.org/t/a-simple-list-recursion-problem-how-do-i-do-this/9628) (which I won’t go into) and a list of tuples, which looks like `[(0,“Monday”), (2,“Tuesday”), (3,“Wednesday”)]` and so on. Feels somewhat more solid as a data type, but took a considerable amount of time to nail down. I’ve studied plenty of recursion with _How To Design Programs_ by [Matthias Felleisen](https://www.youtube.com/watch?v=ayoofXuKqMY) and Co. —  It’s a great book, perfect for 1st years at Uni/College and just about anyone who wants to _think_ like a programmer — there’s not too much maths, and it’s helpful even if you don’t pursue a career in CompSci.

And yet. All that recursion gets forgotten when you start using `.map`, `.filter`, `.reduce`, and all the other time-saving functions Elm Lang provides. You find you’re spending less time on recursion problems and more time with `List.map` where the hard work is done for you. A great thing! The downside of this is ask me to write a function like `List.sort` from scratch (to alphabetise a list, say) and I’d struggle without tutorials and documentation (to do it _properly_ is no easy task).[^3] I learned recursion in Racket Lang (Lisp) and I’d hazard a guess that recursion in a strongly typed and functional language like Haskell or Elm is that little bit harder to do.

Recursion and typed functional languages take a certain way of thinking — a bit like mathematics (lamda calculus, actually) — it’s not a natural way for a human to think. Especially THIS human. I’m visually, not logically oriented, and if I compare myself to developer friends, we _think_ differently. Some folks can think in code. Some are almost robots.

The gist of these examples is to _learn and do only what you need_ to get a thing done and _keep it simple_ wherever possible. For some, that’s taking it for a weekend drive as a hobby, for others diving deep, deep, into the abyss of Haskell, or throwing it out of a window in a fit of rage. Programming is oft too academic, too dense, too complicated, too frustrating, and I doth my cap at anyone who gets through it. Sometimes you have to go through that pain to learn a simpler way to do it, so use my pain as a learning experience!

## Evaluating the data types, gotchas, `i/o` …

> The simplest thing possible.

Ok, so we’ve realised there’s a problem, figured out a better data type — two `Int`s for _minutes_ and _seconds_ — and figured out that using a `Float` is causing us headaches. We know exactly what our functions have to do: check each `Int` is within range (`<= 60`  minutes for example). We’ve followed the _5 steps to reduce your code_ to chop off all those unnecessary `Maybe` and `String` functions. It took some pain to get there, but we shouldn’t forget that pain, and use it as a positive force for future designs.

How does the code look now?

```elm
-- You can use this function for both minutes and seconds
-- You might still have to deal with `Maybe`, but I've left it out.
checkErrors : String -> Result String Int
checkErrors str =
	let
		number = String.Int str  -- You have to handle `Maybe`
	in
	case checkMinutes (unpack number) of
		True  -> Ok number
		False -> Err "You need number is not in range"

-- Unpack the `Maybe`
unpack : Maybe Int -> Int
unpack i =
	case i of
		Nothing -> 0  -- What exactly do we put here?
		Just num -> num

-- Now for our `Boolean` statements
-- (0, 10] or [0, 60] (intervals)
checkMinutes : Int -> Bool
checkMinutes minutes =
	minutes <= 10 && minutes > 0

checkSeconds : Int -> Bool
checkSeconds seconds =
	seconds <= 60 && minutes >= 0

-- Form, Update, Msg, and View functions go here.
```

It’s missing a check for `Nothing` (is not a `String`), but otherwise looking good!

One final (minor? major?) note is on the topic of `input[type=“number”]`. There’s an interesting article on why the number input is the worst type of input. You can read about it [here](https://stackoverflow.blog/2022/12/26/why-the-number-input-is-the-worst-input/). Always sanitise your inputs!

And I think that’s all there is to it. Route 1 started out as 400 lines of comments, questions and code and we’re down to 20. Twenty! That’s progress.


## Next time …

So the next time I’m thinking about adding a feature, dealing with forms, checking some errors, I’m asking myself — from the customer request, to the shaped problem, the user-interface, right down to the `json` data — how can I reduce as much complexity as possible and make the process a little more joyful? What can I bin? How can I reduce it down?

If it’s a new area of work that I’ve had no experience in, there’s bound to be some pain and uncertainty, new things to learn and people to ask for help. But in problem areas I’ve covered before I should be stacking up stories to teach me a lesson. To never do that dumb thing again. To reduce friction. To ask myself …

What’s the simplest thing possible?




[^1]: The design recipe gets more involved the further into the book you get.

[^2]: I’ve forgotten more than I’ve remembered about _How To Design Programs_ but I do remember that building games (at least games that are fun) takes lots of work and lots of lines of code, scoping out the problem, doing the mental gymnastics (and maybe even physics) necessary for state-change, and the more functional it is seemingly the harder it gets. In my mind anyway. I’m all for type-safety and solidity but it’s all just too much like work to me, I’m not a “have fun building games” type of guy.

[^3]: (Goes away for 30 minutes and tries to sort `List Int` and `List String` and gets stuck!) I know that `”sta” < “str”` in Elm returns `True`, I know you’ve gotta check them in pairs and cycle through the list for each pair — probably sticking the `False` ones on the end of the list until every pair comes up as `True`, but it’s been that long since I’ve written a proper recursive list I’m coming up short!
