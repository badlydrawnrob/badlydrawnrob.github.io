# Styleguide


## Common Markdown

<<[../../components/markdown/common/blockquote.md]
<<[../../components/markdown/common/figure.md]
<<[../../components/markdown/common/text.md]





## Github Flavoured Markdown

<<[../../components/markdown/github/tasks.md]





## Highlighting importance

- `strong`: [Strong importance seriousness or urgency](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/strong)
    - Does not change the meaning of the sentence
- `em`: Stressed, emphasis on a word or sentence
    - Changes the meaning of the sentence (Cats _are_ cute)
    - A _comparison_ can also be called _compare_
- `q`: Inline quotations ([some examples](https://academiccoachingandwriting.org/academic-writing/resources/citations))
- `blockquote`: Long-form quotations ([some examples](https://academiccoachingandwriting.org/academic-writing/resources/citations))
    - `blockquote` > `mark`:
      - Highlight interesting parts of original text
    - `blockquote` > `i`:
        - Character thoughts, replaced/inserted text
- `cite`: [A book, research paper, essay or reference](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/cite)
    - To reference the source material
    - Can be used within a paragraph or a `blockquote`


### Examples

<<[../../components/markdown/highlights/highlights-default.md]





## Highlighting presentation

1. `b`: [Bring attention to](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/b)
    - Presentational: indicate keywords or highlighted passages
    - <i>Don't use when: indicating stressed importance within a sentence. Use `strong` instead</i>
2. `i`: [Offset from normal text](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/i)
    - Technical details, foreign language phrases, a characters thoughts, names [possibly], places [possibly]
    - <i>Don't use when: indication stress that changes the tone of the sentence. Use `em` instead</i>
3. `mark`: [Highlighted for reference or notation](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/mark)
    - A `q` or `blockquote` to comment or reference a passage
    - In context app use (i.e. search term)
4. `s`, `del`, `ins`: [Changes in relevance, or an edited passage](http://html5doctor.com/ins-del-s/)
5. `span`: Visually change for decoration purposes with css


### Examples

<<[../../components/markdown/highlights/highlights-custom.md]






## Callout blocks

<<[../../components/markdown/callout/callout.md]
<<[../../components/markdown/callout/callout-split.md]
<<[../../components/markdown/callout/callout-triple.md]
