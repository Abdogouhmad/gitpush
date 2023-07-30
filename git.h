#ifndef GIT_H
#define GIT_H
/*Header*/
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#define MAX_COMMANDS 5
#define MAX_INPUT 1024
/*prototypes*/
void commitAndPush(const char *commit_message);
void checkgit(void);
void getCommitMessage(char *message, size_t size);
#endif
