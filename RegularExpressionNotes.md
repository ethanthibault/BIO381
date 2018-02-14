#### Use of literal searches

- "escape" a metacharacter with a slash "\"

#### Wildcards

`.` any character or space other than an end-of-line
`\w` a single word character[letter, number, or _]
`\d` is a single number character[0-9]
`\t` a single tab space
`\s` a single space, tab, or line break
`\n` a single line break (or `\r`)

#### Quantifiers
`\w+` one or more consecutive word characters
`w*` zero or more consecutive word characters
`\w{3}` exactly three consecutiv characters
`w{3,}` find 3 or more consecutive word characters
`w{3,5}` find 3, 4, or 5 consecutive word characters

#### Using a zero or more `*` quantifier

#### Using `.*` for "all the rest" in a line

#### Use () to "capture" elements of the text for replacement

#### Specify consecutive capture elements with `\1,\2,` etc in the replacement string

#### In replacement string, mix captured text with literal text

#### Dealing with genus and species names

#### Create custom character sets

`\[A,C,T,G]` Find a single nucleotide
`\[A,C,T,G]+` Find a sequence of nucleotides
`\[^A,C,T,G]+` Find a string that is NOT a sequence

#### R package `stringr()`
