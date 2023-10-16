#[allow(dead_code)]
#[allow(unused_imports)]
#[allow(unused_variables)]
use std::process;
use color_print::{cprintln, cprint};
// use colored::*;
use std::io::{self, Write};
static CMD: [&str; 7] = [
    "git rev-parse --is-inside-work-tree > /dev/null 2>&1",
    "git add -A",
    "git commit -m",
    "git push origin",
    "git status --short",
    "clear",
    "git rev-parse --abbrev-ref HEAD"
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

pub fn git_input_cmt(_msg: String) {
    cprint!("<yellow><bold>Enter commit message(or leave it empty for 'update' as commit): ");
    io::stdout().flush().expect("Failed to flush stdout");
    let mut input = String::new();
    io::stdin()
        .read_line(&mut input)
        .expect("Failed to read line");
    let mut msg = input.trim().to_string();
    if msg.is_empty() {
        msg = "update".to_string();
    }
    committed(msg);
}



/**
 * *git_commit - commit all changes to git
 * @arguements: msg: String
 * @return: none
*/
/**
 * *git_commit - commit all changes to git
 * @arguements: msg: String
 * @return: none
*/
/**
 * *git_commit - commit all changes to git
 * @arguements: msg: String
 * @return: none
*/
pub fn committed(msg: String) {
    let done_sc = emojis::get("😄").unwrap();
    let warning = emojis::get("❎").unwrap();
    
    let mut cmd = process::Command::new(if cfg!(target_os = "windows") { "cmd" } else { "sh" });
    cmd.arg("-c").arg(format!("{} '{}'", CMD[2], msg));

    let output = cmd
        .stderr(std::process::Stdio::piped()) // Capture stderr
        .output()
        .expect("failed to execute process");

    if output.status.success() {
        cprintln!("<green><bold>[{}]committed changes", done_sc);
    } else {
        cprintln!("<red><bold>[{}]failed to commit changes", warning);
        
        if let Err(utf8_err) = String::from_utf8(output.stderr.clone()) {
            cprintln!("<red><bold>Error decoding UTF-8 output: {}", utf8_err);
        } else if let Ok(stderr) = String::from_utf8(output.stderr) {
            if !stderr.is_empty() {
                cprintln!("<red><bold>Git Error Message:\n{}", stderr);
            }
        }
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

    let branch = if cfg!(target_os = "windows") {
        process::Command::new("cmd")
            .args(&["/C", CMD[6]])
            .output()
            .expect("failed to execute process")
    }
    else {
        process::Command::new("sh")
            .args(&["-c", CMD[6]])
            .output()
            .expect("failed to execute process")
    };

    // * get the output of the branch and work on it
    if branch.status.success() {
        if let Ok(branch_name) = String::from_utf8(branch.stdout) {
            let branch_name = branch_name.trim();
            
            let push_cmd = if cfg!(target_os = "windows") {
                format!("{} {}", CMD[3], branch_name)
            } else {
                format!("{} {}:{}", CMD[3], branch_name, branch_name)
            };

            println!("{}", push_cmd);
            let push_output = if cfg!(target_os = "windows") {
                process::Command::new("cmd")
                    .args(&["/C", &push_cmd])
                    .output()
                    .expect("failed to execute process")
            } else {
                process::Command::new("sh")
                    .args(&["-c", &push_cmd])
                    .output()
                    .expect("failed to execute process")
            };

            if push_output.status.success() {
                cprintln!("<green><bold>[{}]pushed changes to branch: {}", done_sc, branch_name);
            } else {
                cprintln!("<red><bold>[{}]failed to push changes to branch: {} [{}]", warning, branch_name, push_output.status);
            }
        }
    } else {
        cprintln!("<red><bold>[{}]failed to get current branch", warning);
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