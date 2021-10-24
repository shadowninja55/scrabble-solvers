letters←'abcdefg'
dict←⊃⎕NGET'dictionary.txt'1
Valid←{
  Counts←{word←⍵⋄{+/⍵=word}¨⎕C⎕A}
  ∧/(Counts ⍵)≤Counts letters
}
words←dict/⍨Valid¨dict
Score←{+/1 3 3 2 1 4 2 4 1 8 5 1 3 1 1 3 10 1 1 1 1 4 4 8 4 10[⍵⍳⍨⎕C⎕A]}
sorted←words[⍋Score¨words]
(⊣,(⎕UCS 10),⊢)/{(⍕(⌽sorted)⍳⊂⍵),'. ',⍵}¨sorted