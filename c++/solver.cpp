#include <iostream>
#include <vector>
#include <algorithm>
#include <fstream>
#include <map>
using namespace std;

int count(string s, char c) {
    return count(s.begin(), s.end(), c);
}

bool valid(string word, string letters) {
    char c;
    for (int x = 0; x < word.size(); x++) {
        c = word[x];
        if (count(word, c) > count(letters, c)) {
            return false;
        }
    }
    return true;
}

vector<string> generateWords(string letters) {
    vector<string> words;
    string line;
    ifstream file;
    file.open("dictionary.txt");

    while (getline(file, line)) {
        if (valid(line, letters)) {
            words.push_back(line);
        }
    }
    file.close();

    return words;
}

int score(string word) {
    map<char, int> scores;
    string letters = "abcdefghijklmnopqrstuvwxyz";
    int values[26] = {
        1, 3, 3, 2, 1, 4,
        2, 4, 1, 8, 5, 1,
        3, 1, 1, 3, 10, 1,
        1, 1, 1, 4, 4, 8,
        4, 10
    };
    for (int i = 0; i < 26; i++) {
        scores[letters[i]] = values[i];
    }

    int total = 0;
    for (int i = 0; i < word.size(); i++) {
        total += scores[word[i]];
    }

    return total;
}

vector<string> sorted(vector<string> words) {
    sort(words.begin(), words.end(), [](auto &first, auto &second) {
        return score(first) < score(second);
    });
    return words;
}

string display(vector<string> words) {
    string result;
    int index;

    for (int i = words.size(); i > 0; i--) {
        index = words.size() - i;
        result += (to_string(i)  + ". " + words[index] + "\n");
    }
    return result;
}

int main() {
    string letters = "abcdefg";
    //cout << "Letters: ";
    //cin >> letters;
    vector<string> words = generateWords(letters);
    words = sorted(words);
    string result = display(words);
    cout << result;

    //system("pause");
	return 0;
}
