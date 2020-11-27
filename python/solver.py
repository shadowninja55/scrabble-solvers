def generate_words():
    with open('dictionary.txt') as f:
        for word in f.read().split('\n'):
            if all(word.count(letter) <= letters.count(letter) for letter in word):
                words.append(word)

scores = {
    "a": 1 , "b": 3 , "c": 3 , "d": 2 ,
    "e": 1 , "f": 4 , "g": 2 , "h": 4 ,
    "i": 1 , "j": 8 , "k": 5 , "l": 1 ,
    "m": 3 , "n": 1 , "o": 1 , "p": 3 ,
    "q": 10, "r": 1 , "s": 1 , "t": 1 ,
    "u": 1 , "v": 4 , "w": 4 , "x": 8 ,
    "y": 4 , "z": 10
}

def score(word):
    return sum(scores[c] for c in word)

def display_words():
    length = len(words)
    for i in reversed(range(1, length + 1)):
        print(f'{i}. {words[length - i]}')

letters = "abcdefg"
words = []

def main():
    generate_words()
    words.sort(key=score)
    display_words()

main()
