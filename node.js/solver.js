const fs = require('fs');

var letters = "abcdefg";
var words = [];

function count(word, letter) {
    return word.split(letter).length - 1;
}

function valid(word) {
    for (letter of word) {
        if (count(word, letter) > count(letters, letter)) {
            return false;
        }
    }

    return true;
}

function generateWords() {
    let dictionary = fs.readFileSync('dictionary.txt').toString().split('\r\n');

    for (word of dictionary) {
        if (valid(word)) {
            words.push(word);
        }
    }
}

const scores = {
    "a": 1 , "b": 3 , "c": 3 , "d": 2 ,
    "e": 1 , "f": 4 , "g": 2 , "h": 4 ,
    "i": 1 , "j": 8 , "k": 5 , "l": 1 ,
    "m": 3 , "n": 1 , "o": 1 , "p": 3 ,
    "q": 10, "r": 1 , "s": 1 , "t": 1 ,
    "u": 1 , "v": 4 , "w": 4 , "x": 8 ,
    "y": 4 , "z": 10
};

function score(word) {
    let score = 0;
    for (let i = 0; i < word.length; i++) {
        score += scores[word[i]];
    }

    return score;
}

function sortWords() {
    words.sort((first, second) => score(first) - score(second));
}

function displayWords() {
    for (let i = words.length; i > 0; i--) {
        let index = words.length - i;
        console.log(i + ". " + words[index]);
    }
}

function main() {
    generateWords();
    sortWords();
    displayWords();
}

main()
