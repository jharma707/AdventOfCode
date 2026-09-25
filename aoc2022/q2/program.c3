import std::io;

enum HandShape : uint (uint points) {
  ROCK     { 1 },
  PAPER    { 2 },
  SCISSORS { 3 },
}

fn HandShape map_opponent_code_to_shape(String code) {
  switch (code) {
    case "A": return ROCK;
    case "B": return PAPER;
    case "C": return SCISSORS;
    default: unreachable();
  }
}

fn uint points_for_round(HandShape opponent_shape, String code) {
  switch (code) {
    case "X": return opponent_shape == ROCK
      ? HandShape.SCISSORS.points 
      : opponent_shape.points - 1;
    case "Y": return 3 + opponent_shape.points;
    case "Z": return 6 + opponent_shape.points % 3 + 1;
    default: unreachable();
  }
}

fn void main(String[] args) {
  File f = file::open(args[1], "r")!!;
  defer f.close();

  uint accumulator;
  while (try line = io::treadline(&f)) {
    String[] codes = line.tsplit(delimiter: " ");
    assert(codes.len == 2);

    uint points = points_for_round(
      map_opponent_code_to_shape(codes[0]),
      codes[1],
    );
    accumulator += points;
  }

  io::printn(accumulator);
}
