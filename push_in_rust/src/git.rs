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
  let warning = emojis::get("⚠️").unwrap();
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
        cprintln!("<red>[{}]not inside git repo</red>", warning);
    }
}
