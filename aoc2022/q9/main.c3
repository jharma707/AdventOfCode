import std, std::collections::map, std::collections::pair;

alias Cell = HashMap{int, bool};
alias Grid = HashMap{int, Cell};

struct Positions {
  Pair{int, int} tail_pos;
  Pair{int, int} head_pos;
}

fn void Grid.traverse(&self, String direction, int amount, Positions* old_positions) {
  switch (direction) {
    case "R": {
      for (int i; i < amount; ++i) {
        Pair{int, int} old_pos = old_positions.head_pos;
        Pair{int, int} new_pos = { old_pos.first, old_pos.second + 1 };

        old_positions.head_pos = new_pos;
        if (old_positions.tail_pos.second == old_pos.second - 1) {
          old_positions.tail_pos = old_pos;
          self.[old_positions.tail_pos.first][old_positions.tail_pos.second] = true;
        }
      }
    }
    case "L": {
      for (int i; i < amount; ++i) {
        Pair{int, int} old_pos = old_positions.head_pos;
        Pair{int, int} new_pos = { old_pos.first, old_pos.second - 1 };

        old_positions.head_pos = new_pos;
        if (old_positions.tail_pos.second == old_pos.second + 1) {
          old_positions.tail_pos = old_pos;
          self.[old_positions.tail_pos.first][old_positions.tail_pos.second] = true;
        }
      }
    }
    case "U": {
      for (int i; i < amount; ++i) {
        Pair{int, int} old_pos = old_positions.head_pos;
        Pair{int, int} new_pos = { old_pos.first + 1, old_pos.second };

        old_positions.head_pos = new_pos;
        if (old_positions.tail_pos.first == old_pos.first - 1) {
          old_positions.tail_pos = old_pos;
          self.[old_positions.tail_pos.first][old_positions.tail_pos.second] = true;
        }
      }
    }
    case "D": {
      for (int i; i < amount; ++i) {
        Pair{int, int} old_pos = old_positions.head_pos;
        Pair{int, int} new_pos = { old_pos.first - 1, old_pos.second };

        old_positions.head_pos = new_pos;
        if (old_positions.tail_pos.first == old_pos.first + 1) {
          old_positions.tail_pos = old_pos;
          self.[old_positions.tail_pos.first][old_positions.tail_pos.second] = true;
        }
      }
    }
    default: unreachable();
  }
}

fn void main(String[] args) {
  File f = file::open(args[1], "r")!!;

  Grid visited_cells; visited_cells.tinit();
  Positions positions = {
    .tail_pos = { 0, 0 },
    .head_pos = { 0, 0 }
  };

  while (try line = io::treadline(&f)) {
    String[] dir_amount = line.tsplit(" ");
    assert(dir_amount.len == 2);

    String direction = dir_amount[0];
    int amount = dir_amount[1].to_int()!!;

    visited_cells.traverse(direction, amount, &positions);
  }

  sz result;
  foreach (cell : visited_cells.value_iter()) {
    result += cell.len();
  }

  io::printn(result + 1);
}
