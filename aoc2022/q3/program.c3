import std::io, std::math, std::collections::set;

const int GROUP_SIZE = 3;

<*
  @require ascii::is_alpha(item)
*>
fn sz to_priority(char item) @inline => 
  ascii::is_lower(item) 
    ? (sz) item - 96 
    : (sz) item - 38;

fn char intersection3(HashSet{char} set1, HashSet{char} set2, HashSet{char} set3) {
  switch { 
    case set1.len() < set2.len() && set1.len() < set3.len(): return set1.get_intersection(set2, set3);
    case set2.len() < set1.len() && set2.len() < set3.len(): return set2.get_intersection(set1, set3);
    default: return set3.get_intersection(set2, set1);
  }
}

fn char HashSet.get_intersection(&shortest, HashSet{char} other1, HashSet{char} other2) {
  shortest.@each(;char c) {
    if (other1.contains(c) && other2.contains(c)) return c;
  };

  unreachable();
}

fn void main(String[] args) {
  File f = file::open(args[1], "r")!!;
  defer f.close();

  sz accumulator;
  String[GROUP_SIZE] elf_group;
  int group_count;

  while (try line = io::treadline(&f)) {
    elf_group[group_count++] = line;
    if (group_count < GROUP_SIZE) {
      continue;
    }

    assert(group_count == GROUP_SIZE);
    group_count = 0;

    @pool() {
      HashSet{char} elf1_items; elf1_items.tinit_from_values(elf_group[0]);
      HashSet{char} elf2_items; elf2_items.tinit_from_values(elf_group[1]);
      HashSet{char} elf3_items; elf3_items.tinit_from_values(elf_group[2]);

      accumulator += to_priority(intersection3(elf1_items, elf2_items, elf3_items));
    };
  }

  assert(group_count == 0);
  io::printn(accumulator);
}
