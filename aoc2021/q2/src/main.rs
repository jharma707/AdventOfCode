use std::fs;

fn main() {
    let contents = fs::read_to_string("input1.txt")
        .expect("Input file was not found");

    let mut horizontal: i32 = 0;
    let mut depth: i32 = 0;
    let mut aim: i32 = 0;

    for line in contents.lines() {
        let info: Vec<&str> = line.split_whitespace().collect();

        if let [direction, magnitude] = info[..] {
            let magnitude = magnitude.parse::<i32>().unwrap();

            match direction {
                "forward" => { 
                    horizontal += magnitude;
                    depth += aim * magnitude;
                },
                "down" => { aim += magnitude; }, 
                "up" => { aim -= magnitude; },
                _ => unreachable!(),
            }
        }
    }

    println!("{}", horizontal * depth);
}
