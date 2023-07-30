#include "git.h"
/**
 * checkgit - Check if Git is properly set up
 * @void
 * Returns: void
 */
void checkgit(void)
{
    if (system("git rev-parse --is-inside-work-tree > /dev/null 2>&1") != 0)
    {
        fprintf(stderr, "Git repository not detected. Use 'git init' to create a git repository\n");
        exit(EXIT_FAILURE);
    }
}

/**
 * commitAndPush - Perform the Git commit and push operations
 * @const char *commit_message: Commit message
 * Returns: void
 * */
void commitAndPush(const char *commit_message)
{
    char command[512];

    /*Add all changes to the staging area (index)*/
    system("git add -A");

    /*Commit with the provided message*/
    sprintf(command, "git commit -m \"%s\"", commit_message);
    if (system(command) != 0)
    {
        fprintf(stderr, "Failed to commit changes\n");
        exit(EXIT_FAILURE);
    }

    /*Push the changes to the remote*/
    system("git push");

    printf("Commit and push successful!\n");
}
/**
 * getCommitMessage - Get the commit message from the user
 * @char *message: Commit message
 * @size_t size: Commit message size
 * Returns: void
 * */

void getCommitMessage(char *message, size_t size) 
{
    printf("Enter the commit message (or leave empty for 'update'): ");
    if (getline(&message, &size, stdin) == -1)
    {
        fprintf(stderr, "Error reading input\n");
        exit(EXIT_FAILURE);
    }

    /*Remove trailing newline character*/
    message[strcspn(message, "\n")] = '\0';
}

