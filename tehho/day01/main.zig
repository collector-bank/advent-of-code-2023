const std = @import("std");

pub fn solveA(input: []const u8) !u32 {
    var result = std.ArrayList(u32).init(std.heap.page_allocator);
    defer result.deinit();

    var lines = std.mem.split(u8, input, "\n");

    while (lines.next()) |line| {
        var temp: std.ArrayList(u8) = std.ArrayList(u8).init(std.heap.page_allocator);
        defer temp.deinit();

        for (line) |char| {
            try switch (@as(u8, char)) {
                @as(u8, '0') => temp.append(@as(u8, '0')),
                @as(u8, '1') => temp.append(@as(u8, '1')),
                @as(u8, '2') => temp.append(@as(u8, '2')),
                @as(u8, '3') => temp.append(@as(u8, '3')),
                @as(u8, '4') => temp.append(@as(u8, '4')),
                @as(u8, '5') => temp.append(@as(u8, '5')),
                @as(u8, '6') => temp.append(@as(u8, '6')),
                @as(u8, '7') => temp.append(@as(u8, '7')),
                @as(u8, '8') => temp.append(@as(u8, '8')),
                @as(u8, '9') => temp.append(@as(u8, '9')),
                else => continue,
            };
        }
        var tempArr: [2]u8 = [_]u8{ 0, 0 };
        tempArr[0] = temp.items[0];
        tempArr[1] = temp.items[temp.items.len - 1];
        var value: u32 = std.fmt.parseInt(u32, &tempArr, 10) catch unreachable;

        std.debug.print("temp: {s} value: {any}\n", .{ tempArr, value });

        try result.append(value);
    }

    var sum: u32 = 0;
    for (result.items) |item| {
        sum += item;
    }
    return sum;
}

pub fn replaceB(input: []const u8) ![]const u8 {
    var i: usize = 0;
    var result: std.ArrayList(u8) = std.ArrayList(u8).init(std.heap.page_allocator);
    defer result.deinit();

    while (i < input.len) {
        var range: []const u8 = undefined;
        if (i + 5 <= input.len) {
            range = input[i .. i + 5];
        } else if (i + 4 <= input.len) {
            range = input[i .. i + 4];
        } else if (i + 3 <= input.len) {
            range = input[i .. i + 3];
        } else if (i + 2 <= input.len) {
            range = input[i .. i + 2];
        } else if (i + 1 <= input.len) {
            range = input[i .. i + 1];
        } else {
            range = input[i..i];
        }

        if (std.mem.startsWith(u8, range, "one")) {
            try result.append(@as(u8, '1'));
        } else if (std.mem.startsWith(u8, range, "two")) {
            try result.append(@as(u8, '2'));
        } else if (std.mem.startsWith(u8, range, "three")) {
            try result.append(@as(u8, '3'));
        } else if (std.mem.startsWith(u8, range, "four")) {
            try result.append(@as(u8, '4'));
        } else if (std.mem.startsWith(u8, range, "five")) {
            try result.append(@as(u8, '5'));
        } else if (std.mem.startsWith(u8, range, "six")) {
            try result.append(@as(u8, '6'));
        } else if (std.mem.startsWith(u8, range, "seven")) {
            try result.append(@as(u8, '7'));
        } else if (std.mem.startsWith(u8, range, "eight")) {
            try result.append(@as(u8, '8'));
        } else if (std.mem.startsWith(u8, range, "nine")) {
            try result.append(@as(u8, '9'));
        } else {
            try result.append(input[i]);
        }
        i += 1;
    }
    return result.toOwnedSlice();
}

pub fn main() !void {
    var input = @embedFile("input.txt");

    std.log.info("Result A: {any}\n", .{try solveA(input)});

    var bdata: []const u8 = try replaceB(input);
    std.log.info("Result B: {any}\n", .{try solveA(bdata)});
}

test "test-a" {
    var value: u32 = solveA(@embedFile("test.txt")) catch unreachable;
    try std.testing.expectEqual(@as(u32, 142), value);
}

test "test-b-replace" {
    var data = try replaceB("7seven");
    try std.testing.expectEqualStrings(@as([]const u8, "77"), @as([]const u8, data));
}

test "test-b" {
    var data = @embedFile("testb.txt");
    var value: u32 = try solveA(try replaceB(data));
    try std.testing.expectEqual(@as(u32, 281), value);
}
