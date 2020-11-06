package main

import (
	"bufio"
	"fmt"
	"os"
	"strings"
	"sort"
)

var letters string;
var words[] string;

func isValid(word string) bool {
	for _, char := range word {
		letter := string(char)
		if strings.Count(word, letter) > strings.Count(letters, letter) {
			return false
		}
	}

	return true
}

func loadValidWords() {
	file, _ := os.Open("dictionary.txt")
	var word string

	defer file.Close()
	
	reader := bufio.NewScanner(file)
	for reader.Scan() {
		word = reader.Text()
		if isValid(word) {
			words = append(words, word)
		}
	}
}

var scores map[rune]int = map[rune]int {
	'a': 1, 'b': 3, 'c': 3, 'd': 2,
	'e': 1, 'f': 4, 'g': 2, 'h': 4,
	'i': 1, 'j': 8, 'k': 5, 'l': 1,
	'm': 3, 'n': 1, 'o': 1, 'p': 3,
	'q': 10, 'r': 1, 's': 1, 't': 1,
	'u': 1, 'v': 4, 'w': 4, 'x': 8,
	'y': 4, 'z': 10}

func getScore(word string) int {
	total := 0

	for _, char := range word  {
		total += scores[char]
	}
	
	return total
}

func sortWords() {
	sort.Slice(words, func(lower int, higher int) bool {
		return getScore(words[lower]) < getScore(words[higher])
	})
}

func displayWords() {
	result := ""
	length := len(words)

    for i := length; i > 0; i-- {
        index := length - i;
        result += fmt.Sprint(i, ". ", words[index], "\n");
	}
	
    fmt.Println(result)
}
func main() {
    fmt.Print("Letters: )
    letters = fmt.Scanln()
    loadValidWords()
    sortWords()
    displayWords()
    fmt.scanLn()
}
