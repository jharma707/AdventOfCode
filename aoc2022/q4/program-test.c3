import std::io, std::collections::range;

fn bool have_overlap(Range{int} range1, Range{int} range2) {
  if (range1.start <= range2.start && range1.end >= range2.end) {
    return true;
  } else if (range2.start <= range1.start && range2.end >= range1.end) {
    return true;
  }
  return false;
}
  
  // range1.len() >= range2.len()
  //   ? range1.start <= range2.start && range1.end >= range2.end
  //   : range2.start <= range1.start && range2.end >= range1.end;

fn void main(String[] args) {
  File f = file::open(args[1], "r")!!;
  defer f.close();

  sz count;
  while (try line = io::treadline(&f)) {
    @pool() {
      String[] range_strs = line.tsplit(",");
      assert(range_strs.len == 2);

      Range{int}[2] ranges;
      foreach (i, range_str : range_strs) {
        String[] nums = range_str.tsplit("-");
        assert(nums.len == 2);

        ranges[i] = {
          .start = nums[0].to_int()!!,
          .end   = nums[1].to_int()!!,
        };
      }

      if (have_overlap(...ranges)) count++;
    };
  }

  io::printn(count);
}
