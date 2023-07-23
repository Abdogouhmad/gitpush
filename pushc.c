#include "git.h"

int main(void)
{
    char *cmd[MAX_COMMANDS] = {
        "git status --short",
        "git add .",
        "git commit -m 'updated'",
        "git push origin master",
        "sleep 2",
        "clear",
        "echo -e 'Happy coding King' ",
    };
    char *input = NULL, *commit = NULL;
    int cmdlen, i;

    /* handling the github errors */
    githuberror();
    
    /* count the size of command */
    cmdlen = sizeof(cmd) / sizeof(cmd[0]);

    /* loop over the Git commands */
    for (i = 0; i < 3; i++)
    {
        input = getInput();
        if (strlen(input) > 0)
        {
            free(commit); /*Free the previous commit memory*/
            commit = malloc(strlen(input) + strlen("git commit -m ''") + 1);
            sprintf(commit, "git commit -m '%s'", input);
            cmd[i] = commit;
        }
        /*execute the commands*/
        executeCommand(cmd[i]);
        free(input);
    }

    /* Free the additional commands */
    for (i = 3; i < cmdlen; i++)
    {
        free(cmd[i]);
    }

    /* Free the commands */
    freeCommandsAndInputs(cmd, commit);

    return 0;
}
