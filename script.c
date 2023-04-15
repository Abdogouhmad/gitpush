#include <stdio.h>
#include <stdlib.h>
#include <string.h>
/**
 * this script that made by div-styl
 * designed to facilitate the process of pushing to github
 * + the ability to enter the name of commit incase you didn't the name would updated
*/

int main (void)
{   
char command[4][1024] = {"git add .", "git commit -m 'updated'", "git push", "clear"}; // change here the name of the commit.
int loop = 4, i = 0;
char input [1024];

for (; i < loop; i++)
  {

   if (i == 1)
   {
      printf("enter the name commit if you don't "update" is your commit: ");
      scanf("%1024[^\n]s", input);

      if (strlen(input) > 0)
      {
         sprintf(command[i], "git commit -m '%s' ", input);
      }
   }
   system(command[i]);
}
   return 0;
} 
