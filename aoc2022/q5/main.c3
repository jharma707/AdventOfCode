import std::io, std::collections::deque;

const MAX_PILES = 9;

alias Piles = Deque{char}[MAX_PILES];

fn void parse_stack_elements(String line, Piles* piles) {
  int element_pos;
  for (sz i; i < line.len; i += 4) {
    if (line[i] == ' ') {
      element_pos++;
    } else {
      piles.[element_pos++].push(line[i + 1]);
    }
  }
}

fn void process_move(String line, Piles* piles) {
  String[] moves = line.tsplit(" ");
  int amount = moves[1].to_int()!!;
  int origin = moves[3].to_int()!! - 1;
  int dest = moves[5].to_int()!! - 1;

  assert(piles.[origin].len() >= amount);
  for (int i = amount - 1; i >= 0; i--) {
    piles.[dest].push_front(piles.[origin].get(i));
  }
  for (int i; i < amount; i++) {
    piles.[origin].pop_first()!!;
  }
}

fn void main(String[] args) {
  File f = file::open(args[1], "r")!!;
  defer f.close();

  Piles piles;
  foreach (&pile : piles) {
    pile.tinit();
  }

  bool in_stack_construction = true;
  while (try line = io::treadline(&f)) {
    @pool() {
      if (line == "" || line[1] == '1') {
        in_stack_construction = false;
      } else if (in_stack_construction) {
        parse_stack_elements(line, &piles);
      } else {
        process_move(line, &piles);
      }
    };
  }

  foreach (&pile : piles) {
    if (!pile.is_empty()) {
      io::printf("%c", pile.first());
    }
  }
  io::printn();
}
