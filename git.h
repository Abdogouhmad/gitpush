#ifndef GIT_H
#define GIT_H
/*Header*/
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#define MAX_COMMANDS 5
#define MAX_INPUT 1024
/*Variable define*/
char input[MAX_INPUT]; /*Allocate input buffer in the main functio*/
char *commit = NULL;
char *nghfiles = NULL;
int i, cmdlen;
/*prototypes*/
void executeCommand(const char *command);
void freeCommandsAndInputs(char **commands, char *commit);
void commitInput(char *input, size_t size);
void nghfilesInput(char *input, size_t size);
void giterror(void);
#endif
