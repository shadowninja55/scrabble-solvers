import java.util.*;
import java.io.*;

class Solver {
    static String letters;

    static int count(String word, char letter) {
        return (int) word.chars().filter(c -> c == letter).count();
    }

    static boolean valid(String word) {
        for (int i = 0; i < word.length(); i++) {
            char c = word.charAt(i);

            if (count(word, c) > count(letters, c)) {
                return false;
            }
        }

        return true;
    }

    static List<String> generateWords() {
        List<String> words = new ArrayList<>();

        try (BufferedReader reader = new BufferedReader(new FileReader("dictionary.txt"))) {
            String line = reader.readLine();

            while (line != null) {
                if (valid(line)) {
                    words.add(line);
                }

                line = reader.readLine();
            }
            reader.close();
        } catch (IOException e) {
            e.printStackTrace();
        }

        return words;
    }

    static Map<Character, Integer> scores = new HashMap<Character, Integer>() {{
        put('a', 1); put('b', 3); put('c', 3); put('d', 2);
        put('e', 1); put('f', 4); put('g', 2); put('h', 4);
        put('i', 1); put('j', 8); put('k', 5); put('l', 1);
        put('m', 3); put('n', 1); put('o', 1); put('p', 3);
        put('q', 10); put('r', 1); put('s', 1); put('t', 1);
        put('u', 1); put('v', 4); put('w', 4); put('x', 8);
        put('y', 4); put('z', 10);
    }};

    static int score(String word) {
        int result = 0;

        for (int i = 0; i < word.length(); i++) {
            result += scores.get(word.charAt(i));
        }

        return result;
    }

    static List<String> sortWords(List<String> words) {
        words.sort(new Comparator<String>() {
            @Override
            public int compare(String first, String second) {
                return score(first) - score(second);
            }
        });

        return words;
    }

    static void displayWords(List<String> words) {
        int length = words.size();

        for (int i = length; i > 0; i--) {
            System.out.println(i + ". " + words.get(length - i));
        }
    }

    public static void main(String args[]) {
        letters = "abcdefg";
        List<String> words = generateWords();
        words = sortWords(words);
        displayWords(words);
    }
}
