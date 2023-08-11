mod git;
use git::{git_check, git_add, committed};
fn main()
{
    let msg_commit = String::new();
    let cmd = msg_commit.to_string();
    committed(cmd);
    // check if the folder connected to git!
   git_check();
   // add the changes
   git_add();
   // commit the changes
}
