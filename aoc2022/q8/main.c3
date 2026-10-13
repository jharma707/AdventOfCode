module std;

alias Row = List{int};
alias Grid = List{Row};

fn sz Grid.max_scenic_score(&grid) {
  sz result;

  foreach (i, &row : grid) {
    foreach (j, tree_height : row) {
      sz tree_scenic_score = 1;

      // check the left
      sz left_idx = j;
      while (left_idx > 0 && row.[--left_idx] < tree_height) {}
      tree_scenic_score *= j - left_idx;

      // check the right
      sz right_idx = j;
      while (right_idx < row.len() - 1 && row.[++right_idx] < tree_height) {}
      tree_scenic_score *= right_idx - j;

      // check the top
      sz top_idx = i;
      while (top_idx > 0 && grid.[--top_idx][j] < tree_height) {}
      tree_scenic_score *= i - top_idx;

      // check the bottom
      sz bottom_idx = i;
      while (bottom_idx < grid.len() - 1 && grid.[++bottom_idx][j] < tree_height) {}
      tree_scenic_score *= bottom_idx - i;

      result = math::max(result, tree_scenic_score);
    }
  }

  return result;
}

fn void main(String[] args) {
  File f = file::open(args[1], "r")!!;
  Grid grid; grid.tinit();

  int i, j;
  while (try line = io::treadline(&f)) {
    Row row; row.tinit();
    grid.push(row);

    foreach (c : line) {
      grid[i].push(c - 48);
    }
    i++;
  }

  io::printn(grid.max_scenic_score());
}
