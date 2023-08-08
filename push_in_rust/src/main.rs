mod git;
use git::{git_check, git_add};
fn main()
{
    // check if the folder connected to git!
   git_check();
   // add the changes
   git_add();
   // commit the changes
}
