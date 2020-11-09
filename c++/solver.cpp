#include <iostream>
#include <vector>
#include <map>
#include <algorithm>
#include <fstream>
using namespace std;

string letters = "abcdefg";
vector<string> words;

bool valid(string word) {
    for (auto c : word) {
        if (count(word.begin(), word.end(), c) > count(letters.begin(), letters.end(), c)) {
            return false;
        }
    }
    return true;
}

void generateWords() {
    string word;
    ifstream file("dictionary.txt");

    while (getline(file, word)) {
        if (valid(word)) {
            words.push_back(word);
        }
    }
}

map<char, int> scores = {
    {'a', 1}, {'b', 3}, {'c', 3}, {'d', 2},
    {'e', 1}, {'f', 4}, {'g', 2}, {'h', 4},
    {'i', 1}, {'j', 8}, {'k', 5}, {'l', 1},
    {'m', 3}, {'n', 1}, {'o', 1}, {'p', 3},
    {'q', 10},{'r', 1}, {'s', 1}, {'t', 1},
    {'u', 1}, {'v', 4}, {'w', 4}, {'x', 8},
    {'y', 4}, {'z', 10}
};

int score(string word) {
    int total = 0;

    for (auto c : word) {
        total += scores[c];
    }

    return total;
}

void sortWords() {
    sort(words.begin(), words.end(), [](auto a, auto b) {
        return score(a) < score(b);
    });
}

void displayWords() {
    int length = words.size();

    for (int i = length; i > 0; i--) {
        int index = length - i;
        cout << i << ". " << words[index] << endl;
    }
}

int main() {
    generateWords();
    sortWords();
    displayWords();
}
