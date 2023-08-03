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
    fprintf(stderr, RED "[!] Git repository not detected. Use 'git init' to create a git repository\n" NC);
    exit(EXIT_FAILURE);
  }
}

/**
 * execute - Execute a command
 * @const char *command: Command to execute
 * Returns: void
 */
void execute(const char *command)
{
  int output = system(command);
  if (output != 0)
  {
    fprintf(stderr, RED "[?]Failed to execute '%s'\n" NC, command);
    exit(EXIT_FAILURE);
  }
  if (command[0] != '\0' && command == NULL)
    return;
}

/**
 * getInput - Get the commit message from the user
 * @commit: Commit message
 * @commtlen: Commit message size
 * Return: void
 */
void getInput(char **commit, size_t *commtlen)
{
  printf(GREEN "[*]Enter the commit message (or leave empty for 'update'): " NC);
  if (getline(commit, commtlen, stdin) == -1)
  {
    fprintf(stderr, YELLOW "[!]Error reading input\n" NC);
    exit(EXIT_FAILURE);
  }
  (*commit)[strcspn(*commit, "\n")] = '\0';

  if ((*commit)[0] == '\0')
  {
    free(*commit);
    *commit = strdup("update");
    *commtlen = strlen(*commit);
  }
}

/**
 * gitcmt - Commit the changes
 * @commit_message: Commit message
 * Return: void
 */
void gitcmt(const char *commit_message)
{
  char git_command[MAX_INPUT];
  snprintf(git_command, sizeof(git_command), "%s \"%s\"", commands[1], commit_message);
  /*add all changes*/
  execute(commands[0]);
  /*commite the changes*/
  execute(git_command);
}

/**
 * push - Push the changes to the remote repository
 * @void
 * Return: void
 */
void push(void)
{
  /*push the changes*/
  execute(commands[2]);
  /*clean the prcess and print sweet msgs*/
  execute(commands[5]);
  printf(CYAN "Commit and push successful!\n" NC);
  printf(YELLOW "GOODBYE! KING\n" NC);
}

void gitaddfile(__attribute__((unused)) const char *file_name, int *yn)
{

  printf(GREEN "[*]Do you want to add a specific file to repo? [y/n]: " NC);
  while ((yn = getchar()) != '\n' && yn != EOF);
    ;
  yn = getchar();
  if (yn == 'y' || yn == 'Y')
  {
    printf(GREEN "[*]Enter the file name: " NC);
  }
  return;
}
