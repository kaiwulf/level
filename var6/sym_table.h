/*
 *	Symbol table for level interpreter
 */

struct hash_table {
    char *name;
    struct hash_table hash_table *next;
};

typedef struct hash_table hash_table;
hash_table *hash_table = NULL;
hash_table *put_sym();
hash_table *get_sym();

void put_sym(struct hash_table *table, char *sym_name) {
    table = (hash_table *) malloc(sizeof(hash_table));
    table->name = malloc(strlen(sym_name)+1);
    strcpy(table->name, sym_name);
    table->next = (struct hash_table *) hash_table;
    hash_table = ptr;
}

hash_table *get_sym(char *sym_name) {
    hash_table *ptr;
    for(ptr = hash_table; ptr != NULL; ptr = (hash_table *) ptr->next) {
        if(strcmp(ptr->name, sym_name) == 0)
            return ptr;
    }
    return 0;
}