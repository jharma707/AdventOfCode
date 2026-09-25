import std::io, std::collections::set;

const MARKER_COUNT = 14;

fn void main(String[] args) {
  File f = file::open(args[1], "r")!!;
  defer f.close();

  while (try line = io::treadline(&f)) {
    @pool() {
      HashSet{char} chars; chars.tinit(capacity: line.len);

      sz i; sz begin;
      while (i < line.len && chars.len() < MARKER_COUNT) {
        while (chars.contains(line[i])) {
          chars.remove(line[begin++]);
        }
        chars.add(line[i++]);
      }
      
      io::printn(i);
    };
  }
}
