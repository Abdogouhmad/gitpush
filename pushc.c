#include "git.h"
/**
 * main - 
 * 
*/
int main(void)
{
    char *input;
    const char *cmd = NULL;
    int cmdlen;
    /*heandling errors that presented by the github*/
    githuberror();

    cmd [MAX_COMMANDS] = {
        "gss",
        "git add -A -f",
        "git commit -m 'update",
        "git push",
        "sleep 3",
        "clear",
    };
    /*count the size of the command line*/
    cmdlen = sizeof(cmd) / sizeof(cmd[0]);
    printf("%d\n", cmdlen);

return (0);
}