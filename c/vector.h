struct Vector {
  char** data;
  size_t count;
  size_t size;
};

void init(struct Vector* v, size_t size) {
  v->data = malloc(size * sizeof(char*));
  v->count = 0;
  v->size = size;
}

void append(struct Vector* v, char* item) {
  if (v->count == v->size) {
    v->size *= 2;
    v->data = realloc(v->data, v->size * sizeof(char*));
  }

  v->data[v->count++] = item;
}