#include "git.h"
/**
 * main - main function
 * return: 0
 */
int main()
{
    char *commit_message = NULL;
    size_t size = 0;

    /*Check if the current directory is a git repository*/
    checkgit();
    /*Get the commit message from the user*/
    getInput(&commit_message, &size);

    /* Call the commiting function with the commit message*/
    gitcmt(commit_message);
    execute(commands[3]);
    execute(commands[5]);
    printf(CYAN "Commit and push successful!\n" NC);
    printf(YELLOW "GOODBYE! KING\n" NC);
    /* Cleanup*/
    free(commit_message);

    return 0;
}
