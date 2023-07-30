#include "git.h"
/**
 * main - main function
 * return: 0
 */
int main(void)
{
    char commit_message[256] = "update"; /*Default commit message*/
    size_t size = sizeof(commit_message);

    /* Check if Git is properly set up*/
    checkgit();

    /* Get the commit message from the user*/
    getCommitMessage(commit_message, size);

    /*Perform Git commit and push*/
    commitAndPush(commit_message);

    return 0;
}

