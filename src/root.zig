const std = @import("std");
const ClazhAPI = @import("ClazhAPI.zig");
const errors = ClazhAPI.errors;
const Rarity = ClazhAPI.Rarity;
const Role = ClazhAPI.Role;
const Players = ClazhAPI.Players;

test "player route" {
    const allocator = std.testing.allocator;
    const io = std.testing.io;
    var api: ClazhAPI = undefined;

    try api.init(allocator, io, std.testing.environ.getPosix("TOKEN") orelse "");
    defer api.deinit();

    var player = try api.getPlayer("#VC080GQVP");
    defer player.deinit();

    switch (player) {
        .success => std.debug.print("OK\n", .{}),
        .fail => |e| {
            const err = try e.value.toString(allocator);
            defer allocator.free(err);
            std.debug.print("{s}\n", .{err});
            try std.testing.expect(false);
        },
    }
}

test "player upcoming chests" {
    const allocator = std.testing.allocator;
    const io = std.testing.io;
    var api: ClazhAPI = undefined;

    try api.init(allocator, io, std.testing.environ.getPosix("TOKEN") orelse "");
    defer api.deinit();

    var chests = try api.getUpcomingChests("#VC080GQVP");
    defer chests.deinit();

    switch (chests) {
        .success => std.debug.print("OK\n", .{}),
        .fail => |e| {
            const err = try e.value.toString(allocator);
            defer allocator.free(err);
            std.debug.print("{s}\n", .{err});
            try std.testing.expect(false);
        },
    }
}
