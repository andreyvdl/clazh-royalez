const std = @import("std");

const hashtag = "%23";

pub fn modTag(allocator: std.mem.Allocator, tag: []const u8) ![]const u8 {
    if (tag[0] == '#') {
        return try std.mem.concat(allocator, u8, &.{ hashtag, tag[1..] });
    } else if (std.ascii.isAlphanumeric(tag[0])) {
        return try std.mem.concat(allocator, u8, &.{ hashtag, tag });
    }
    return error.InvalidTag;
}

const query_route = "https://api.clashroyale.com/v1/tournaments?name=";

pub fn setupUrl(
    allocator: std.mem.Allocator,
    name: []const u8,
    limit: []const u8,
    after: []const u8,
    before: []const u8,
) ![]const u8 {
    // I think this first case is impossible, but... the clash api is shit,
    // so i will not be surprised if it is necessary.
    if (limit.len != 0 and after.len != 0 and before.len != 0) {
        return std.fmt.allocPrint(
            allocator,
            "{s}{s}&limit={s}&after={s}&before={s}",
            .{ query_route, name, limit, after, before },
        );
    } else if (limit.len != 0 and after.len != 0) {
        return std.fmt.allocPrint(
            allocator,
            "{s}{s}&limit={s}&after={s}",
            .{ query_route, name, limit, after },
        );
    } else if (limit.len != 0 and before.len != 0) {
        return std.fmt.allocPrint(
            allocator,
            "{s}{s}&limit={s}&before={s}",
            .{ query_route, name, limit, before },
        );
    } else if (limit.len != 0) {
        return std.fmt.allocPrint(
            allocator,
            "{s}{s}&limit={s}",
            .{ query_route, name, limit },
        );
    } else if (after.len != 0 and before.len != 0) {
        // Also this one
        return std.fmt.allocPrint(
            allocator,
            "{s}{s}&after={s}&before={s}",
            .{ query_route, name, after, before },
        );
    } else if (after.len != 0) {
        return std.fmt.allocPrint(
            allocator,
            "{s}{s}&after={s}",
            .{ query_route, name, after },
        );
    } else if (before.len != 0) {
        return std.fmt.allocPrint(
            allocator,
            "{s}{s}&before={s}",
            .{ query_route, name, before },
        );
    } else {
        return std.fmt.allocPrint(allocator, "{s}{s}", .{ query_route, name });
    }
}
