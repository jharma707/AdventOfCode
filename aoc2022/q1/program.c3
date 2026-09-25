import std::io, std::collections::priorityqueue;

fn void main() {
  File f = file::open("input2.txt", "r")!!;
  defer f.close();

  PriorityQueue{usz} pq; pq.tinit(initial_capacity: 3);
  usz accumulator;
  while (try line = io::treadline(&f)) {
    if (line == "") {
      if (pq.len() == 3 && accumulator > pq.first()!!) {
        pq.pop()!!;
        pq.push(accumulator);
      } else if (pq.len() < 3) {
        pq.push(accumulator);
      }

      accumulator = 0;
    } else {
      accumulator += (usz) line.to_int()!!;
    }
  }

  assert(pq.len() == 3);
  usz result;
  while (try calory_count = pq.pop()) {
    result += calory_count;
  }

  io::printn(result);
}
