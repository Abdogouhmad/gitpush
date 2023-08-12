#[allow(dead_code)]
#[allow(unused_imports)]
#[allow(unused_variables)]
use std::process;
use color_print::cprintln;
// use colored::*;
// use std::io;
static CMD: [&str; 6] = [
    "git rev-parse --is-inside-work-tree > /dev/null 2>&1",
    "git add -A",
    "git commit -m",
    "git push origin main",
    "git status --short",
    "clear",
];


/**
 * *git_check - check if inside git repo
 * @arguements: none
 * @return: none
*/
pub fn git_check() {
    let done_sc = emojis::get("✅").unwrap();
    let warning = emojis::get("❎").unwrap();
    
    let output = if cfg!(target_os = "windows") {
        process::Command::new("cmd")
            .args(&["/C", CMD[0]])
            .output()
            .expect("failed to execute process")
    } else {
        process::Command::new("sh")
            .args(&["-c", CMD[0]])
            .output()
            .expect("failed to execute process")
    };

    // using the output of the cmd to determine if inside git repo
    if output.status.success() {
        cprintln!("<green><bold>[{}]inside git repo", done_sc);

        let gss_output = if cfg!(target_os = "windows") {
            process::Command::new("cmd")
                .args(&["/C", CMD[4]])
                .output()
                .expect("failed to execute process")
        } else {
            process::Command::new("sh")
                .args(&["-c", CMD[4]])
                .output()
                .expect("failed to execute process")
        };

        if gss_output.status.success() {
            if let Ok(gss_stdout) = String::from_utf8(gss_output.stdout) {
                println!("{}", gss_stdout);
            }
        } else {
            cprintln!("<red>[{}]not in repo</red>", warning);
        }
    } else {
        cprintln!("<red>[{}]not inside git repo try to use git init to start</red>", warning);
    }
}


/**
 * *git_add - add all changes to git
 * @arguements: none
 * @return: none
*/
pub fn git_add() {
    let done_sc = emojis::get("😄").unwrap();
    let warning = emojis::get("❎").unwrap();
    let output = if cfg!(target_os = "windows") {
        process::Command::new("cmd")
            .args(&["/C", CMD[1]])
            .output()
            .expect("failed to execute process")
    } else {
        process::Command::new("sh")
            .args(&["-c", CMD[1]])
            .output()
            .expect("failed to execute process")
    };
    if output.status.success() {
        cprintln!("<green><bold>[{}]added all changes", done_sc);
    } else {
        cprintln!("<red>[{}]failed to add changes</red>", warning);
    }
}
/**
 * *git_input_cmt - get input from user for the commit
 * @arguements: msg: String
 * @return: none
 */

pub fn git_input_cmt(msg: String) {
    println!("{}", msg);
}





/**
 * *git_commit - commit all changes to git
 * @arguements: msg: String
 * @return: none
*/

pub fn committed(msg: String) {
    let done_sc = emojis::get("😄").unwrap();
    let warning = emojis::get("❎").unwrap();
    let output = if cfg!(target_os = "windows") {
        process::Command::new("cmd")
            .args(&["/C", CMD[2], &msg])
            .output()
            .expect("failed to execute process")
    } else {
        process::Command::new("sh")
            .args(&["-c", CMD[2], &msg])
            .output()
            .expect("failed to execute process")
    };
    if output.status.success() {
        cprintln!("<green><bold>[{}]committed changes", done_sc);
    } else {
        cprintln!("<red><bold>[{}]failed to commit changes", warning);
        println!("{:?}", msg);
    }
}

/**
 * *git_push - push all changes to git
 * @arguements: none
 * @return: none
*/
pub fn git_push() {
    let done_sc = emojis::get("😄").unwrap();
    let warning = emojis::get("❎").unwrap();
    let output = if cfg!(target_os = "windows") {
        process::Command::new("cmd")
            .args(&["/C", CMD[3]])
            .output()
            .expect("failed to execute process")
    } else {
        process::Command::new("sh")
            .args(&["-c", CMD[3]])
            .output()
            .expect("failed to execute process")
    };
    if output.status.success() {
        cprintln!("<green><bold>[{}]pushed changes", done_sc);
    } else {
        cprintln!("<red><bold>[{}]failed to push changes", warning);
        // ! if push failed try to push again
        let push_fail = if cfg!(target_os = "windows") {
            process::Command::new("cmd")
                .args(&["/C", CMD[3]])
                .output()
                .expect("failed to execute process")
        } else {
            process::Command::new("sh")
                .args(&["-c", CMD[3]])
                .output()
                .expect("failed to execute process")
        };
        if push_fail.status.success() {
            cprintln!("<green><bold>[{}]pushed changes are fixed", done_sc);
        } else {
            cprintln!("<red><bold>[{}]something went wrong check your git!", warning);
        }
    }
}

/**
 * *clear_term - clean all changes to git
 * @arguements: none
 * @return: none
*/
pub fn clear_term() {
    let done_sc = emojis::get("😄").unwrap();
    let warning = emojis::get("❎").unwrap();
    let output = if cfg!(target_os = "windows") {
        process::Command::new("cmd")
            .args(&["/C", CMD[5]])
            .output()
            .expect("failed to execute process")
    } else {
        process::Command::new("sh")
            .args(&["-c", CMD[5]])
            .output()
            .expect("failed to execute process")
    };
    if output.status.success() {
        cprintln!("<green><bold>[{}]Happy coding Bruh!", done_sc);
    } else {
        cprintln!("<red><bold>[{}]failed to clean changes", warning);
    }
}