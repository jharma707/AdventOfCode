use std::fs;

fn main() {
    let content = fs::read_to_string("input2.txt").expect("Expected file");
    let digit_count = content.lines().next().map(|line| line.len()).unwrap();
    let mut num_of_ones: Vec<i32> = vec![0; digit_count];
    let mut total_lines = 0;

    for line in content.lines() {
        total_lines += 1;
        for (i, digit) in line.chars().enumerate() {
            if digit == '1' {
                num_of_ones[i] += 1;
            }
        }
    }

    let mut gamma_rate = 0;
    for ones_count in num_of_ones {
        let zeros_count = total_lines - ones_count;
        if ones_count > zeros_count {
            gamma_rate |= 1;
        }
        gamma_rate <<= 1;
    }
    gamma_rate >>= 1;

    let mask = (1_u32 << digit_count) - 1;
    let epsilon_rate = !gamma_rate & mask;
    println!("{}", gamma_rate * epsilon_rate);
}
