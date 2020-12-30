use std::fs::read_to_string;
use std::time::Instant;

static LETTERS: &str = "abcdefg";

fn is_valid(word: &str) -> bool {
  for c in word.chars() {
    if word.matches(c).count() > LETTERS.matches(c).count() {
      return false;
    }
  }

  true
}

fn load_valid_words() -> Vec<String> {
  let content = read_to_string("dictionary.txt").unwrap();

  content.split("\r\n").filter(
    |word| is_valid(word)
  ).map(
    |word| word.to_string()
  ).collect()
}

static SCORES: [u8; 26] = [1, 3, 3, 2, 1, 4, 2, 4, 1, 8, 5, 1, 3, 1, 1, 3, 
  10, 1, 1, 1, 1, 4, 4, 8, 4, 10];

fn score(word: &str) -> u8 {
  word.chars().map(
    |c| SCORES[c as usize - 97]
  ).sum()
}

fn sort_words(words: &mut Vec<String>) {
  words.sort_by(
    |a, b| score(a).cmp(&score(b))
  );
}

fn display_words(words: &Vec<String>) {
  for i in (1..words.len() + 1).rev() {
    println!("{}. {}", i, words[words.len() - i]);
  }
}

fn main() {
  let start = Instant::now();

  let mut words = load_valid_words();
  sort_words(&mut words);
  display_words(&words);

  println!("{}", start.elapsed().as_millis());
}
