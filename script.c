#include <stdio.h>
#include <stdlib.h>
#include <string.h>
/**
 * this script that made by div-styl
 * designed to facilitate the process of pushing to github
 * + the ability to enter the name of commit incase you didn't the name would updated
*/

int main ()
{   
char command[3][1024] = {"git add .", "git commit -m 'updated'", "git push"};
int loop = 3, i = 0;
char input [1024];

for (; i < loop; i++){

   if (i == 1)
   {
      printf("please enter the name of commit incase y didn't the cmt would be 'updated': ");
      scanf("%1024[^\n]s", input);

      if (strlen(input) > 0)
      {
      snprintf(command[1], 1024, "git commit -m '%s'", input);
      }
   }

   system(command[i]);
}
   return 0;
} 
