#include <iostream>
#include <vector>
#include <algorithm>
#include <fstream>
using namespace std;

const string letters = "abcdefg";

bool is_valid(string word) {
  for (auto c : word) 
    if (count(word.begin(), word.end(), c) > count(letters.begin(), letters.end(), c)) 
      return false;
  
  return true;
}

vector<string> generate_words() {
  vector<string> words;

  ifstream file("dictionary.txt");
  string word;

  while (getline(file, word)) 
    if (is_valid(word)) 
      words.push_back(word);
  
  return words;
}

const int scores[26] = {1, 3, 3, 2, 1, 4, 2, 4, 1, 8, 5, 1, 3, 1, 1, 3, 10, 1, 1, 1,
  1, 4, 4, 8, 4, 10};

int get_score(string word) {
  int total = 0;

  for (auto c : word) 
    total += scores[c - 97];

  return total;
}

void sort_words(vector<string> &words) {
  sort(words.begin(), words.end(), [](auto a, auto b) {
    return get_score(a) < get_score(b);
  });
}

void display_words(vector<string> words) {
  for (int i = words.size(); i > 0; i--) 
    cout << i << ". " << words[words.size() - i] << endl;
}

int main() {
  vector<string> words = generate_words();
  sort_words(words);
  display_words(words);
}
