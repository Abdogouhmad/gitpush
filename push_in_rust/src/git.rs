use std::io;

// Check if a string represents a valid number
pub fn is_valid_number(input: &str) -> bool {
    input.trim().parse::<f64>().is_ok()
}

// Check if a string represents a valid operator
pub fn is_valid_operator(input: &str) -> bool {
    let valid_operators = ["+", "-", "*", "/"];
    valid_operators.contains(&input.trim())
}

// Validate input properly
pub fn check_input(num1: &str, num2: &str, operator: &str) -> bool {
    is_valid_number(num1) && is_valid_number(num2) && is_valid_operator(operator)
}

pub fn calculator() {
    println!("1st number: ");
    let mut num1 = String::new();
    io::stdin().read_line(&mut num1).expect("Failed to read line");

    println!("2nd number: ");
    let mut num2 = String::new();
    io::stdin().read_line(&mut num2).expect("Failed to read line");

    println!("operator (+, -, *, or /): ");
    let mut operator = String::new();
    io::stdin().read_line(&mut operator).expect("Failed to read line");

    let num1 = num1.trim();
    let num2 = num2.trim();
    let operator = operator.trim();

    if check_input(num1, num2, operator) {
        // Proceed with calculations using num1, num2, and operator as valid inputs
        let num1: f64 = num1.parse().expect("Invalid number");
        let num2: f64 = num2.parse().expect("Invalid number");
        let result = match operator {
            "+" => num1 + num2,
            "-" => num1 - num2,
            "*" => num1 * num2,
            "/" => num1 / num2,
            _ => {
                println!("Invalid operator");
                return;
            }
        };

        println!("Result: {}", result);
    } else {
        println!("Invalid input");
    }
}
