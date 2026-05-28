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

    const now = std.Io.Clock.awake.now(io);
    var player = try api.getPlayer("#VC080GQVP");
    const end = std.Io.Clock.awake.now(io);
    defer player.deinit();
    const elapsed = @divTrunc(
        (end.nanoseconds - now.nanoseconds),
        std.time.ns_per_ms,
    );

    std.debug.print("elapsed: {}ms ", .{elapsed});
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

    const now = std.Io.Clock.awake.now(io);
    var chests = try api.getUpcomingChests("#VC080GQVP");
    const end = std.Io.Clock.awake.now(io);
    defer chests.deinit();
    const elapsed = @divTrunc(
        (end.nanoseconds - now.nanoseconds),
        std.time.ns_per_ms,
    );

    std.debug.print("elapsed: {}ms ", .{elapsed});
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

    const now = std.Io.Clock.awake.now(io);
    var log = try api.getBattleLog("#VC080GQVP");
    const end = std.Io.Clock.awake.now(io);
    defer log.deinit();
    const elapsed = @divTrunc(
        (end.nanoseconds - now.nanoseconds),
        std.time.ns_per_ms,
    );

    std.debug.print("elapsed: {}ms ", .{elapsed});
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

    const now = std.Io.Clock.awake.now(io);
    var cards = try api.getCards();
    const end = std.Io.Clock.awake.now(io);
    defer cards.deinit();
    const elapsed = @divTrunc(
        (end.nanoseconds - now.nanoseconds),
        std.time.ns_per_ms,
    );

    std.debug.print("elapsed: {}ms ", .{elapsed});
    switch (cards) {
        .success => |c| {
            const items = c.value;
            std.debug.print("cards len = {} ", .{items.items.len});
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

test "events" {
    const allocator = std.testing.allocator;
    const io = std.testing.io;
    var api: ClazhAPI = undefined;

    try api.init(
        allocator,
        io,
        std.testing.environ.getPosix("TOKEN") orelse "",
    );
    defer api.deinit();

    const now = std.Io.Clock.awake.now(io);
    var events = try api.getEvents();
    const end = std.Io.Clock.awake.now(io);
    defer events.deinit();
    const elapsed = @divTrunc(
        (end.nanoseconds - now.nanoseconds),
        std.time.ns_per_ms,
    );

    std.debug.print("elapsed: {}ms ", .{elapsed});
    switch (events) {
        .success => |e| {
            const items = e.value;
            std.debug.print("events len = {} ", .{items.len});
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

test "gloabal tournaments" {
    const allocator = std.testing.allocator;
    const io = std.testing.io;
    var api: ClazhAPI = undefined;

    try api.init(
        allocator,
        io,
        std.testing.environ.getPosix("TOKEN") orelse "",
    );
    defer api.deinit();

    const now = std.Io.Clock.awake.now(io);
    var events = try api.getGlobalTournaments();
    const end = std.Io.Clock.awake.now(io);
    defer events.deinit();
    const elapsed = @divTrunc(
        (end.nanoseconds - now.nanoseconds),
        std.time.ns_per_ms,
    );

    std.debug.print("elapsed: {}ms ", .{elapsed});
    switch (events) {
        .success => |e| {
            const items = e.value;
            std.debug.print(
                "global tournaments len = {} ",
                .{items.items.?.len},
            );
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
