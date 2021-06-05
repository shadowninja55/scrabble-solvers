const std = @import("std");
const print = std.debug.print;
var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
const allocator = &arena.allocator;
const letters: []const u8 = "abcdefg";

fn count(word: []const u8, query: u8) u8 {
  var result: u8 = 0;

  for (word) |byte| {
    if (byte == query) {
      result += 1;
    }
  }

  return result;
}

fn isValid(word: []const u8) bool {
  for (word) |byte| 
    if (count(word, byte) > count(letters, byte)) 
      return false;

  return true;
}

fn loadValidWords() ![][]const u8 {
  const file = try std.fs.cwd().openFile("dictionary.txt", .{});
  defer file.close();

  var words = std.ArrayList([]const u8).init(allocator);
  defer words.deinit();

  const content = try file.readToEndAlloc(allocator, 500_000);
  var lines = std.mem.split(content, "\r\n");

  while (lines.next()) |word| {
    if (isValid(word)) {
      try words.append(word);
    }
  }

  return words.toOwnedSlice();
}

fn getScore(word: []const u8) u8 {
  const scores = [_]u8 {1, 3, 3, 2, 1, 4, 2, 4, 1, 8, 5, 1, 3, 1, 1, 3, 10, 1, 
    1, 1, 11, 4, 4, 8, 4, 10};
  var score: u8 = 0;

  for (word) |byte|
    score += scores[byte - 97];
  
  return score;
}

fn cmp(comptime T: type, a: []const u8, b: []const u8) bool {
  return getScore(a) < getScore(b);
}

fn sortWords(words: [][]const u8) void {
  std.sort.sort([]const u8, words, void, comptime cmp);
}

fn displayWords(words: [][]const u8) void {
  const length = words.len;
  var i = length;

  while (i > 0) {
    print("{}. {}\n", .{i, words[length - i]});
    i -= 1;
  }
}

pub fn main() !void {
  var words = try loadValidWords();
  defer allocator.free(words);
  sortWords(words);
  displayWords(words);
}
