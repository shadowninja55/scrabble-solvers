const fs = require('fs');
const prompt = require('prompt-sync')();

function count(word, letter) {
    return word.split(letter).length - 1;
}

function valid(word, letters) {
    let c;
    for (let i = 0; i < word.length; i++) {
        c = word[i];
        if (count(word, c) > count(letters, c)) {
            return false;
        }
    }
    return true;
}

function generateWords(letters) {
    let words = [];
    let word;

    let dictionary = fs.readFileSync('dictionary.txt').toString().split('\r\n');
    for (let i = 0; i < dictionary.length; i++) {
        word = dictionary[i];
        if (valid(word, letters)) {
            words.push(word);
        }
    }

    return words;
}

function score(word) {
    scores = {
        "a": 1 , "b": 3 , "c": 3 , "d": 2 ,
        "e": 1 , "f": 4 , "g": 2 , "h": 4 ,
        "i": 1 , "j": 8 , "k": 5 , "l": 1 ,
        "m": 3 , "n": 1 , "o": 1 , "p": 3 ,
        "q": 10, "r": 1 , "s": 1 , "t": 1 ,
        "u": 1 , "v": 4 , "w": 4 , "x": 8 ,
        "y": 4 , "z": 10
    };

    let score = 0;
    for (let i = 0; i < word.length; i++) {
        score += scores[word[i]];
    }

    return score;
}

function sorted(words) {
    return words.sort((first, second) => score(first) - score(second));
}

function display(words) {
    let result = "";

    for (let i = words.length; i > 0; i--) {
        let index = words.length - i;
        result += (i  + ". " + words[index] + "\n");
    }
    return result;
}

function main() {
    let letters = prompt('Letters: ');
    let words = generateWords(letters);
    words = sorted(words);
    let result = display(words);
    console.log(result);
}

main()
