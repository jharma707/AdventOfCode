import std;

const sz MAX_FILE_SIZE = 100_000;

fn String[]? get_command_arg(File* f) {
  String line = io::treadline(f)!;
  String[] command = line.tsplit(delimiter: " ");
  return command;
}

String[] command_line = {};
sz total_size;

fn sz file_sizes(File* f, String directory) => @pool() {
  command_line = get_command_arg(f)!!;
  sz count;

  while (true) {
    String command = command_line[1];

    if (command == "cd") {
      String arg = command_line[2];
      if (arg == "..") {
        command_line = get_command_arg(f)!!;
        return count;
      }

      sz dir_size = file_sizes(f, arg);
      count += dir_size;

      if (dir_size <= MAX_FILE_SIZE) {
        total_size += dir_size;
      }
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

  command_line = get_command_arg(&f)!!;
  sz sizes = file_sizes(&f, "/");
  io::printn(total_size);
}
