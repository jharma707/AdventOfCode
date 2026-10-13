import std, std::collections::list;

const sz MAX_FILE_SIZE = 100_000;
const sz TOTAL_DISK_SPACE = 70_000_000;
const sz NEEDED_UNUSED_SPACE = 30_000_000;

fn String[]? get_command_arg(File* f) {
  String line = io::treadline(f)!;
  String[] command = line.tsplit(delimiter: " ");
  return command;
}

String[] command_line = {};

fn sz file_sizes(File* f, List{sz}* sizes) => @pool() {
  command_line = get_command_arg(f)!!;
  sz count;

  defer {
    sizes.push(count);
  }

  while (true) {
    String command = command_line[1];

    if (command == "cd") {
      String arg = command_line[2];
      if (arg == "..") {
        command_line = get_command_arg(f)!!;
        return count;
      }

      sz dir_size = file_sizes(f, sizes);
      count += dir_size;
      if (f.eof()) return count;
    } else if (command == "ls") {
      while (try lineStrs = get_command_arg(f)) {
        command_line = lineStrs[..];
        if (command_line[0] == "$") {
          break;
        }

        if (command_line[0] != "dir") { // is a text file
          count += (sz) command_line[0].to_int()!!;;
        }
      }

      if (f.eof()) return count;
    }
  }
}

fn void main(String[] args) {
  File f = file::open(args[1], "r")!!;
  defer f.close();

  List{sz} sizes; sizes.tinit();
  command_line = get_command_arg(&f)!!;

  sz used_space = file_sizes(&f, &sizes);
  sz unused_space = TOTAL_DISK_SPACE - used_space;
  sz space_to_remove = NEEDED_UNUSED_SPACE - unused_space;
  if (space_to_remove <= 0) {
    io::printn(unused_space);
    return;
  }

  sz min_size_to_delete = sz::max;
  foreach (dir_size : sizes) {
    if (dir_size >= space_to_remove && dir_size < min_size_to_delete) {
      min_size_to_delete = dir_size;
    }
  }

  io::printn(min_size_to_delete);
}
