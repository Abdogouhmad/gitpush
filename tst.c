#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// Function to check if Git is properly set up
void checkgit(void) {
    if (system("git rev-parse --is-inside-work-tree > /dev/null 2>&1") != 0) {
        fprintf(stderr, "Git repository not detected. Use 'git init' to create a git repository\n");
        exit(EXIT_FAILURE);
    }
}

// Function to perform the Git commit and push operations
void commitAndPush(const char *commit_message) {
    char command[512];

    // Add all changes to the staging area (index)
    system("git add -A");

    // Commit with the provided message
    sprintf(command, "git commit -m \"%s\"", commit_message);
    if (system(command) != 0) {
        fprintf(stderr, "Failed to commit changes\n");
        exit(EXIT_FAILURE);
    }

    // Push the changes to the remote
    system("git push");

    printf("Commit and push successful!\n");
}

// Function to get the commit message from the user
void getCommitMessage(char *message, size_t size) {
    printf("Enter the commit message (or leave empty for 'update'): ");
    if (getline(&message, &size, stdin) == -1) {
        fprintf(stderr, "Error reading input\n");
        exit(EXIT_FAILURE);
    }

    // Remove trailing newline character
    message[strcspn(message, "\n")] = '\0';
}

int main() {
    char commit_message[256] = "update"; // Default commit message
    size_t size = sizeof(commit_message);

    // Check if Git is properly set up
    checkgit();

    // Get the commit message from the user
    getCommitMessage(commit_message, size);

    // Perform Git commit and push
    commitAndPush(commit_message);

    return 0;
}

