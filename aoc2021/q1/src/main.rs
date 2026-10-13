use std::fs;
use itertools::Itertools;

fn main() {
    let contents = fs::read_to_string("./input2.txt")
        .expect("Couldn't open file");

    let result = contents.lines()
        .map(|line| line.parse::<i32>().unwrap())
        .tuple_windows::<(_, _, _, _)>()
        .filter(|(a, _, _, d)| d > a)
        .count();

    println!("{result}");
}
