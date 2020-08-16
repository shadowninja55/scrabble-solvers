import json

def load_dictionary():
    with open('dictionary.txt') as f:
        return f.read().split('\n')

def generate_words(letters, dictionary):
    new_words = []
    for word in dictionary:
        if all(word.count(letter) <= letters.count(letter) for letter in word):
            new_words.append(word)

    return new_words

def score(word):
    scores = {
         "a": 1 , "b": 3 , "c": 3 , "d": 2 ,
         "e": 1 , "f": 4 , "g": 2 , "h": 4 ,
         "i": 1 , "j": 8 , "k": 5 , "l": 1 ,
         "m": 3 , "n": 1 , "o": 1 , "p": 3 ,
         "q": 10, "r": 1 , "s": 1 , "t": 1 ,
         "u": 1 , "v": 4 , "w": 4 , "x": 8 ,
         "y": 4 , "z": 10
    }

    return sum(scores[c] for c in word)

def sort(words, letters, dictionary):
    return sorted(words, key=score, reverse=True)

def display(words):
    words = reversed([f'{c}. {word}' for c, word in enumerate(words, 1)])
    return '\n'.join(words)

def main():
    dictionary = load_dictionary()
    letters = input('Letters: ')
    words = generate_words(letters, dictionary)
    words = sort(words, letters, dictionary)
    words = display(words)
    print(words)

main()
