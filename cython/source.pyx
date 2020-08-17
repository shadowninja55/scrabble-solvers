def generate_words(letters):
    cdef str word
    cdef str letter

    new_words = []
    with open('dictionary.txt') as f:
        dictionary = f.read().split('\n')

    for word in dictionary:
        if all(word.count(letter) <= letters.count(letter) for letter in word):
            new_words.append(word)

    return new_words

def score(str word):
    scores = {
         "a": 1 , "b": 3 , "c": 3 , "d": 2 ,
         "e": 1 , "f": 4 , "g": 2 , "h": 4 ,
         "i": 1 , "j": 8 , "k": 5 , "l": 1 ,
         "m": 3 , "n": 1 , "o": 1 , "p": 3 ,
         "q": 10, "r": 1 , "s": 1 , "t": 1 ,
         "u": 1 , "v": 4 , "w": 4 , "x": 8 ,
         "y": 4 , "z": 10
    }

    cdef str c
    return sum(scores[c] for c in word)

def sort(words, letters):
    return sorted(words, key=score, reverse=True)

def display(words):
    cdef int c
    cdef str word
    words = list(reversed([f'{c}. {word}' for c, word in enumerate(words, 1)]))
    return '\n'.join(words)

def main():
    letters = 'abcdefg' # input('Letters: ')
    words = generate_words(letters)
    words = sort(words, letters)
    words = display(words)
    print(words)
    return 0

main()
