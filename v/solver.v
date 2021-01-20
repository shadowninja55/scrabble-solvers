import os

const letters = "abcdefg"

fn count(word string, target rune) int {
	mut total := 0

	for letter in word {
		if letter == target {
			total++
		}
	}

	return total
}

fn is_valid(word string) bool {
	for letter in word {
		if count(word, letter) > count(letters, letter) {
			return false
		}
	}

	return true
}

fn load_valid_words() []string {
	mut words := []string{}
	contents := os.read_file("dictionary.txt") or { panic(err) }

	for word in contents.split("\r\n") {
		if is_valid(word) {
			words << word
		}
	}

	return words
}

const scores = [1, 3, 3, 2, 1, 4, 2, 4, 1, 8, 5, 1, 3, 1, 1, 3, 10, 1, 
  1, 1, 11, 4, 4, 8, 4, 10]

fn get_score(word string) int {
	mut total := 0

	for letter in word {
		total += scores[int(letter) - 97]
	}

	return total
}

fn sort_words(mut words []string) {
	words.sort(get_score(a) < get_score(b))
}

fn display_words(words []string) {
	for i := words.len; i >= 1; i-- {
		println("${i}. ${words[words.len - i]}")
	}
}

fn main() {
	mut words := load_valid_words()
	sort_words(mut words)
	display_words(words)
}