def valid word, letters
    for c in word.split ''
      if word.count(c) > letters.count(c)
          return false
      end
    end
    return true
end

def generate_words letters 
    new_words = []
    f = File.open("dictionary.txt")
    contents = f.read
    words = contents.split "\n"
    for word in words
        if valid(word, letters)
            new_words.append word
        end
    end
    return new_words
end

def score word
    scores = {
        "a": 1 , "b": 3 , "c": 3 , "d": 2 ,
        "e": 1 , "f": 4 , "g": 2 , "h": 4 ,
        "i": 1 , "j": 8 , "k": 5 , "l": 1 ,
        "m": 3 , "n": 1 , "o": 1 , "p": 3 ,
        "q": 10, "r": 1 , "s": 1 , "t": 1 ,
        "u": 1 , "v": 4 , "w": 4 , "x": 8 ,
        "y": 4 , "z": 10
    }
    score = 0
    for c in word.split('')
        score += scores[:"#{c}"]
    end
    return score
end

def sort_words words
    words.sort_by { |w| score w }
end

def display words
    result = ""
    wlen = words.length
    words.each_with_index do |word,i|
        result += "#{wlen-i}. #{word}\n" 
    end
    return result
end

def main
    letters = "abcdefg"
    words = generate_words letters
    words = sort_words words
    puts display words
end

main
