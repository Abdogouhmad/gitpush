#ifndef GIT_H
#define GIT_H
/*Header*/
#include <stdio.h>
#include <unistd.h>
#include <string.h>
#include <stdlib.h>
#define MAX_COMMANDS 5
#define MAX_INPUT 1024
/*prototypes*/
void commitAndPush(const char *commit_message);
void checkgit(void);
void getCommitMessage(char *message, size_t size);
/*WORKING ON*/
void getInput(char **commit, size_t *commtlen);
void gitcmt(const char *commit_message, size_t lencmt);
void execute(const char *command);
#endif
