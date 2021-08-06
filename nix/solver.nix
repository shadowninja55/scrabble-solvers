let isValid = word: letters: builtins.all (
  letter: length (builtins.filter (c: c == letter) word) <= length (builtins.filter (c: c == letter) letters)
) word; in {
   
}
