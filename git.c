#include "git.h"
/**
 * executeCommand - execute a command
 * @command: command to execute
 * Return: void
 */
void executeCommand(const char *command)
{
    if (command == NULL)
        return;
    system(command);
}
/**
 * getInput - get the input from the user
 * @input: buffer to store the input
 * @size: size of the buffer
 * Return: void
 */
void getInput(char *input, size_t size)
{
    if (input == NULL || size <= 0)
        return;
    printf("Enter the commit name (or leave empty for 'update'): ");
    getline(&input, &size, stdin);

    /* Remove trailing newline character */
    input[strcspn(input, "\n")] = '\0';
}


/**
 * freeCommandsAndInputs - free the commands and the input
 * @commands: the commands
 * @commit: the commit message
 * Return: void
 */
void freeCommandsAndInputs(char **commands, char *commit)
{
    int i = 0;
    if (commands == NULL || commit == NULL)
        return;
    
    for (; i < MAX_COMMANDS; i++)
    {
        free(commands[i]);
    }
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
