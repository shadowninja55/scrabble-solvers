package main

import (
	"bufio"
	"fmt"
	"strings"
	"sort"
	"io/ioutil"
)

var letters string = "abcdefg";
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
	bytes, _ := ioutil.ReadFile("dictionary.txt")
	content := string(bytes)
	scanner := bufio.NewScanner(strings.NewReader(content))

	for scanner.Scan() {
		if isValid(scanner.Text()) {
			words = append(words, scanner.Text())
		}
	}
}

var scores [26]int = [26]int {1, 3, 3, 2, 1, 4, 2, 4, 1, 8, 5, 1, 3, 1, 1, 3, 10, 1, 1, 1, 1, 4, 4, 8, 4, 10}

func getScore(word string) int {
	total := 0

	for _, char := range word  {
		total += scores[int(char) - 97]
	}
	
	return total
}

func sortWords() {
	sort.Slice(words, func(lower int, higher int) bool {
		return getScore(words[lower]) < getScore(words[higher])
	})
}

func displayWords() {
  for i := len(words); i > 0; i-- {
    fmt.Println(i, ". ", words[len(words) - i]);
	}
}
func main() {
  loadValidWords()
  sortWords()
  displayWords()
}
