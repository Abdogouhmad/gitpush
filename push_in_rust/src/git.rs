#[allow(dead_code)]
#[allow(unused_imports)]
#[allow(unused_variables)]
use std::process;
use color_print::cprintln;
// use colored::*;
// use std::io;
static CMD: [&str; 7] = [
    "git rev-parse --is-inside-work-tree > /dev/null 2>&1",
    "git add -A",
    "git commit -m",
    "git push origin main",
    "git clean",
    "git status --short",
    "clear",
];

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
 * TODO: add commit message
 * ! it should allocate memory for the commit message
 * ? maybe use a vector to store the commit message
 * @param: string varaible
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
        cprintln!("<red>[{}]failed to commit changes</red>", warning);
    }
}