using Printf

function is_valid(word)
    for letter in word
        if count(c -> (c == letter), word) > count(c -> (c == letter), letters)
            return false
        end
    end

    return true
end

function load_valid_words()
    return [line for line in readlines("dictionary.txt") if is_valid(line)]
end

const global scores = Dict(
	'a' => 1, 'b' => 3, 'c' => 3, 'd' => 2,
	'e' => 1, 'f' => 4, 'g' => 2, 'h' => 4,
	'i' => 1, 'j' => 8, 'k' => 5, 'l' => 1,
	'm' => 3, 'n' => 1, 'o' => 1, 'p' => 3,
	'q' => 10,'r' => 1, 's' => 1, 't' => 1,
	'u' => 1, 'v' => 4, 'w' => 4, 'x' => 8,
    'y' => 4, 'z' => 10
)

function get_score(word)
    return sum(scores[letter] for letter in word)
end

function display_words(words) 
    len = length(words)

    for i = len:-1:1
        index = len - i + 1
        @printf("%i. %s\n", i, words[index])
    end
end

const global letters = "abcdefg"

function main()
    words = load_valid_words()
    sort!(words, by=get_score)
    display_words(words)
end
