mod git;
mod push_file;
use git::{git_check, git_add, git_push, clear_term, git_input_cmt};
use push_file::push_f;
fn main()
{
    let msg_commit = String::new();
    let cmd = msg_commit.to_string();

// check if the folder connected to git!
    git_check();
// push file that user choose
    push_f();
// add the changes
    git_add();
// git message commit
    git_input_cmt(cmd.clone());
// commit the changes
    //committed(cmd);
// push the changes
    git_push();
// clear term
    clear_term();
}
