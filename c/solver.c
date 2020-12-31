#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "vector.h"

char* LETTERS = "abcdefg";

int count(char* word, char letter) {
  int result = 0;
  size_t len = strlen(word);

  for (int i = 0; i < len; i++)
    if (word[i] == letter)
      result++;

  return result;
}

char is_valid(char* word) {
  size_t len = strlen(word);

  for (int i = 0; i < len; i++) 
    if (count(word, word[i]) > count(LETTERS, word[i])) 
      return 0;

  return 1;
}

void load_valid_words(struct Vector* words) {
  FILE* file = fopen("dictionary.txt", "r");
  char buffer[9];

  while (fgets(buffer, sizeof(buffer), file)) {
    buffer[strlen(buffer) - 1] = 0;
    
    if (is_valid(buffer)) {
      char* word = strdup(buffer);
      append(words, word);
    }
  }

  fclose(file);
}

const int scores[26] = {1, 3, 3, 2, 1, 4, 2, 4, 1, 8, 5, 1, 3, 1, 1, 3, 10, 1, 
  1, 1, 1, 4, 4, 8, 4, 10};

int get_score(char* word) {
  int total = 0;
  size_t len = strlen(word);

  for (int i = 0; i < len; i++) 
    total += scores[word[i] - 97];
  
  return total;
}

void sort_words(struct Vector* words) {
  int cmp(const void* a, const void* b) {
    return get_score(*(char**) a) - get_score(*(char**) b);
  }

  qsort(words->data, words->count, sizeof(char*), cmp);
}

void display_words(struct Vector words) {
  for (int i = words.count; i > 0; i--) 
    printf("%d. %s\n", i, words.data[words.count - i]);
}

int main(void) {
  struct Vector words;
  init(&words, 8);
  load_valid_words(&words);
  sort_words(&words);
  display_words(words);
}
