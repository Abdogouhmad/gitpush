#include "git.h"
/**
 * executeCommand - execute a command
 * @command: command to execute
 * Return: void
 */
void executeCommand(const char *command)
{
    char *cmd = (char *)malloc(sizeof(char) * strlen(command) + 1);
    strcpy(cmd, command);
    system(cmd);
    free(cmd);
}
/**
 * getInput - get the input from the user
 * Return: the input
 */
char *getInput(void)
{
    char *input = NULL;
    size_t size = 0;

    printf("Enter the commit name (or leave empty for 'update'): ");
    getline(&input, &size, stdin); /*get the input using getline which allocate and free*/

    /*Remove trailing newline character*/
    input[strcspn(input, "\n")] = '\0';

    return input;
}
/**
 * freeCommandsAndInputs - free the commands and the input
 * @commands: the commands
 * @numCommands: the number of commands
 * @input: the input
 * Return: void
 */
void freeCommandsAndInputs(char **commands, int numCommands, char* commit)
{
    int i = 0;
    for (; i < numCommands; i++)
    {
        free(commands[i]);
    }
    free(commands);
    free(commit);
}
/**
 *
 */
void githuberror(void)
{
    if (system("git > /dev/null 2>&1") == 127)
    {
        perror("Git is not detected or not in system path!\n");
        exit(127);
    }
    if (system("git ls-remote > /dev/null 2>&1") == 128) {
        perror("Remote repo is not detected!\n");
        exit(128);
    }
    if (system("git rev-parse --is-inside-work-tree > /dev/null 2>&1") == 1)
    {
        perror("Git repository not dectected, use git init to create a git repository\n");
        exit(128);
    }
}
