mod git;
use git::{git_check, git_add, committed, git_push, clear_term};
fn main()
{
    let msg_commit = String::new();
    let cmd = msg_commit.to_string();

// check if the folder connected to git!
    git_check();
// add the changes
    git_add();
// commit the changes
    committed(cmd);
// push the changes
    git_push();
// clear term
    clear_term();
}
