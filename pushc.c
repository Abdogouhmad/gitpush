#include "git.h"

int main(void)
{
    char *cmd[MAX_COMMANDS] = {
        "git status --short",
		"git add .",
        "git commit -am 'updated'",
        "git push",
    };
    char input[MAX_INPUT]; /*Allocate input buffer in the main functio*/
    char *commit = NULL;
    int i, cmdlen;

    /* handling the github errors */
    githuberror();
    
    /* count the size of command */
    cmdlen = sizeof(cmd) / sizeof(cmd[0]);

    /* loop over the Git commands */
    for (i = 0; i < 4; i++)
    {
        getInput(input, sizeof(input)); /*Pass the input buffer to getInput*/

        if (strlen(input) > 0)
        {
            free(commit); /* Free the previous commit memory */
            commit = malloc(strlen(input) + strlen("git commit -m ''") + 1);
            sprintf(commit, "git commit -am '%s'", input);
            cmd[i] = commit;
        }

        /* execute the commands */
        executeCommand(cmd[i]);
    }

    /* Free the commands (no need to free commit again, as it's already freed inside freeCommandsAndInputs) */
    freeCommandsAndInputs(cmd, commit);

    return 0;
}
