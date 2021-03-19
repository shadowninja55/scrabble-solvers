LETTERS = "abcdefg"

def valid(word)
  word.each_char do |char|
    if word.count(char) > LETTERS.count(char)
      return false
    end
  end
  true
end

def load_valid_words
  valid_words = [] of String
  content = File.read("dictionary.txt")
  content.each_line do |line|
    if valid(line)
      valid_words << line
    end
  end
  valid_words
end

SCORES = [1, 3, 3, 2, 1, 4, 2, 4, 1, 8, 5, 1, 3, 1, 1, 3, 10, 1, 1, 1, 11, 4, 4, 8, 4, 10]

def get_score(word)
  total = 0
  word.each_char do |char|
    total += SCORES[char.ord - 97]
  end
  total
end

def sort_words(words)
  return words.sort { |a, b| get_score(a) - get_score(b) }
end

def display_words(words)
  words.size.downto(1) do |idx|
    puts "#{idx}. #{words[words.size - idx]}"
  end
end

words = load_valid_words
words = sort_words(words)
display_words(words)