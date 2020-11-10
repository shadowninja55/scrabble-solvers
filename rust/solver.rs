#[macro_use]
extern crate lazy_static;

use std::fs::File;
use std::io::{BufRead, BufReader};
use std::collections::HashMap;

fn is_valid(word: &str) -> bool {
   for c in word.chars() {
       if word.matches(c).count() > LETTERS.matches(c).count() {
           return false;
       }
   }

   return true;
}

fn load_valid_words() -> Vec<String> {
    let mut words: Vec<String> = vec![];

    let file = File::open("dictionary.txt").unwrap();
    let reader = BufReader::new(file);

    for line in reader.lines() {
        let word = line.unwrap();

        if is_valid(&word) {
            words.push(word);
        }
    }

    return words;
}

lazy_static! {
    static ref SCORES: HashMap<char, u32> = [
        ('a', 1) , ('b', 3) , ('c', 3), ('d', 2),
        ('e', 1) , ('f', 4) , ('g', 2), ('h', 4),
        ('i', 1) , ('j', 8) , ('k', 5), ('l', 1),
        ('m', 3) , ('n', 1) , ('o', 1), ('p', 3),
        ('q', 10), ('r', 1) , ('s', 1), ('t', 1),
        ('u', 1) , ('v', 4) , ('w', 4), ('x', 8),
        ('y', 4) , ('z', 10)
    ].iter().cloned().collect();

    static ref LETTERS: String = String::from("abcdefg");
}

fn score(word: &str) -> u32 {
    let mut total = 0;

    for c in word.chars() {
        total += SCORES.get(&c).unwrap();
    }

    return total;
}

fn display_words(words: Vec<String>) {
    let length = words.len();

    for i in (1..length+1).rev() {
        let index = length - i;
        println!("{}. {}", i, words[index]);
    }
}

fn main() {
    let mut words = load_valid_words();
    words.sort_by(|a, b| score(a).cmp(&score(b)));
    display_words(words);
}
