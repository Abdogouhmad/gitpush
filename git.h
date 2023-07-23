#ifndef git_H
#define git_H
/*Header*/
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#define MAX_COMMANDS 10
#define MAX_INPUT 1024
/*prototypes*/
void executeCommand(const char *command);
void freeCommandsAndInputs(char **commands, char *commit);
void getInput(char *input, size_t size);
void githuberror(void);
#endif
