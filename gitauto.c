#include "git.h"
/**
 * main - main function
 * return: 0
 */
int main(void)
{
    char *cmd[MAX_COMMANDS] = {
        "git status --short",
        "git add -A",
        "git commit -am 'updated'",
        "git push",
    };

    /* check pre-required gits */
    checkgit();

    /* count the size of command */
    cmdlen = sizeof(cmd) / sizeof(cmd[0]);

    /* loop over the Git commands for user-define argument/variables */
    for (i = 0; i < MAX_COMMANDS; i++)
    {
        if (i == 2)
        {
            //if (system("output=$(git add --dry-run -A) if [ $output ]; then exit 0; else exit 1; fi"))
            //{
                char *input = NULL;
                while (input != "y" && input != "yes" && input != "n" && input != "no")
                {
                    nghfilesInput(input, sizeof(input)); /*Pass the input buffer to getInput*/
                }
                if (strlen(input) > 0)
                {
                    free(nghfiles); /* Free the previous commit memory */
                    if (input == "n" || input == "no")
                    {
                        cmd[i] = "";
                    }
                }
            //}
        }
        else if (i == 3)
        {
            commitInput(input, sizeof(input)); /*Pass the input buffer to getInput*/

            if (strlen(input) > 0)
            {
                free(commit); /* Free the previous commit memory */
                commit = malloc(strlen(input) + strlen("git commit -m ''") + 1);
                sprintf(commit, "git commit -am '%s'", input);
                cmd[i] = commit;
            }
        }

        /* execute the commands */
        executeCommand(cmd[i]);
    }

    /* Free the commands (no need to free commit again, as it's already freed inside freeCommandsAndInputs) */
    freeCommandsAndInputs(cmd, commit);

    return 0;
}
