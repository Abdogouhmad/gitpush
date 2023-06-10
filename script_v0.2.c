#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_COMMANDS 4

void executeCommand(const char *command)
{
    int result = system(command);
    if (result != 0)
    {
        printf("Error executing command: %s\n", command);
        exit(1);
    }
}

char* getInput()
{
    char* input = NULL;
    size_t size = 0;
    
    printf("Enter the commit name (or leave empty for 'update'): ");
    getline(&input, &size, stdin); /*get the input using getline which allocate and free*/
    
    /*Remove trailing newline character*/
    input[strcspn(input, "\n")] = '\0';
    
    return input;
}

int main(void)
{
    const char *commands[MAX_COMMANDS] =
    {
        "git add .",
        "git commit -m 'updated'",
        "git push",
        "clear"
    };

    int numCommands = sizeof(commands) / sizeof(commands[0]);

    for (int i = 0; i < numCommands; i++)
  {
        if (i == 1)
    {
            char* input = getInput();
            if (strlen(input) > 0) /*check if the user provide the commit name*/
            {
                char* command = malloc(strlen(input) + strlen("git commit -m ''") + 1);
                sprintf(command, "git commit -m '%s'", input);
                commands[i] = command;
                free(input);
            }
    }
        executeCommand(commands[i]);
  }

    return 0;
}

