import java.util.*;
import java.io.*;

class Solver {
    static int count(String word, char letter) {
        String character = Character.toString(letter);
        return word.length() - word.replaceAll(character, "").length();
    }

    static boolean valid(String word, String letters) {
        for (int i = 0; i < word.length(); i++) {
            char c = word.charAt(i);
            if (count(word, c) > count(letters, c)) {
                return false;
            }
        }
        return true;
    }

    static ArrayList<String> generateWords(String letters) {
        ArrayList<String> words = new ArrayList<String>();
        try (BufferedReader reader = new BufferedReader(new FileReader("dictionary.txt"))) {
            String line = reader.readLine();
            while (line != null) {
                if (valid(line, letters)) {
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

    static HashMap<Character, Integer> scores = new HashMap<Character, Integer>();

    static void constructScores() {
        String letters = "abcdefghijklmnopqrstuvwxyz";
        int values[] = {
            1, 3, 3, 2, 1, 4,
            2, 4, 1, 8, 5, 1,
            3, 1, 1, 3, 10, 1,
            1, 1, 1, 4, 4, 8,
            4, 10
        };
        for (int i = 0; i < 26; i++) {
            scores.put(letters.charAt(i), values[i]);
        }
    }

    static int score(String word) {
        int total = 0;
        for (int i = 0; i < word.length(); i++) {
            char c = word.charAt(i);
            total += scores.get(c);
        }

        return total;
    }

    static ArrayList<String> sorted(ArrayList<String> words) {
        words.sort(new Comparator<String>() {
            @Override
            public int compare(String first, String second) {
                return score(first) - score(second);
            }
        });
        return words;
    }

    static String display(ArrayList<String> words) {
        String result = "";
        int index;

        for (int i = words.size(); i > 0; i--) {
            index = words.size() - i;
            result += (i + ". " + words.get(index) + "\n");
        }
        return result;
    }

    public static void main(String args[]) {
        Scanner input = new Scanner(System.in);
        System.out.print("Letters: ");
        String letters = input.nextLine();
        ArrayList<String> words = generateWords(letters);
        constructScores();
        words = sorted(words);
        String result = display(words);
        System.out.println(result);
    }
}
