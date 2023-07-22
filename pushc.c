#include "git.h"
/**
 * main - pushing scrept
 * Retunr 0
 * 
*/
int main(void)
{
    char* cmd [MAX_COMMANDS] = {
        "git status --short",
        "git add .",
        "git commit -m 'updated'",
        "sleep 2",
        "clear",
        "echo -e 'Happy coding King' ",
    };
    char *input = NULL, *commit;
    int cmdlen, i;

    /*handling the github errors*/
    githuberror();
    /*init the cmds*/

    /*count the size of command*/
    cmdlen = sizeof(cmd) / sizeof(cmd[0]);

    /*loop over the size of the array and execute commands*/
    for (i = 0; i < cmdlen; i++)
    {
        input = getInput();
        if (strlen(input) > 0)
        {
            commit = malloc(strlen(input) + strlen("get commit -m ''") + 1);
            sprintf(commit, "git commit -m '%s'", input);
            cmd[i] = commit;
        }
        /*execute the commands*/
        executeCommand(cmd[i]);
        free(input);
    }  
    /*free the commands and input*/
    freeCommandsAndInputs(cmd, cmdlen, commit);
    return (0);
}