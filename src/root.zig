const std = @import("std");
const ClazhAPI = @import("ClazhAPI.zig");
const errors = ClazhAPI.errors;
const Rarity = ClazhAPI.Rarity;
const Role = ClazhAPI.Role;
const Players = ClazhAPI.Players;
const CardsQueryOptions = ClazhAPI.CardsQueryOptions;

test "player route" {
    const allocator = std.testing.allocator;
    const io = std.testing.io;
    var api: ClazhAPI = undefined;

    try api.init(
        allocator,
        io,
        std.testing.environ.getPosix("TOKEN") orelse "",
    );
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

    try api.init(
        allocator,
        io,
        std.testing.environ.getPosix("TOKEN") orelse "",
    );
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

test "player battle log" {
    const allocator = std.testing.allocator;
    const io = std.testing.io;
    var api: ClazhAPI = undefined;

    try api.init(
        allocator,
        io,
        std.testing.environ.getPosix("TOKEN") orelse "",
    );
    defer api.deinit();

    var log = try api.getBattleLog("#VC080GQVP");
    defer log.deinit();

    switch (log) {
        .success => std.debug.print("OK\n", .{}),
        .fail => |e| {
            const err = try e.value.toString(allocator);
            defer allocator.free(err);
            std.debug.print("{s}\n", .{err});
            try std.testing.expect(false);
        },
    }
}

test "cards" {
    const allocator = std.testing.allocator;
    const io = std.testing.io;
    var api: ClazhAPI = undefined;

    try api.init(
        allocator,
        io,
        std.testing.environ.getPosix("TOKEN") orelse "",
    );
    defer api.deinit();

    var cards = try api.getCards();
    defer cards.deinit();

    switch (cards) {
        .success => |c| {
            const items = c.value;
            std.debug.print("items.items.len = {}\n", .{items.items.len});
            std.debug.print("OK\n", .{});
        },
        .fail => |e| {
            const err = try e.value.toString(allocator);
            defer allocator.free(err);
            std.debug.print("{s}\n", .{err});
            try std.testing.expect(false);
        },
    }
}
