using System;
using System.IO;
using System.Collections.Generic;

class Solver {
    const string letters = "abcdefg";
    static List<string> words = new List<string>();

    static bool Valid(string word, string letters) {
        foreach (char letter in word) {
            if (word.Split(letter).Length > letters.Split(letter).Length) {
                return false;
            }
        }
        return true;
    }

    static void GenerateWords() { 
        foreach (string line in File.ReadLines("dictionary.txt"))
            if (Valid(line, letters)) {
                words.Add(line);
            }
        }
    }

    static Dictionary<char, int> scores = new Dictionary<char, int> {
        {'a', 1}, {'b', 3}, {'c', 3}, {'d', 2},
        {'e', 1}, {'f', 4}, {'g', 2}, {'h', 4},
        {'i', 1}, {'j', 8}, {'k', 5}, {'l', 1},
        {'m', 3}, {'n', 1}, {'o', 1}, {'p', 3},
        {'q', 10},{'r', 1}, {'s', 1}, {'t', 1},
        {'u', 1}, {'v', 4}, {'w', 4}, {'x', 8},
        {'y', 4}, {'z', 10}
    };

    static int Score(string word) {
        int total = 0;
        foreach (char letter in word) 
            total += scores[letter];
        
        return total;
    }

    class Comparer : IComparer<string> {
        public int Compare(string x, string y) {
            return Score(x) - Score(y);
        }
    }

    static void DisplayWords() {
        for (int i = words.Count; i > 0; i--) {
            int index = words.Count - i;
            Console.WriteLine(String.Format("{0}. {1}", i, words[index]));
        }
    }

    public static void Main(string[] args) {
        GenerateWords();
        words.Sort(new Comparer());
        DisplayWords();
    }
}
