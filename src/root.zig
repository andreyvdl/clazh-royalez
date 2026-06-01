const std = @import("std");
const ClazhAPI = @import("ClazhAPI.zig");

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
        else => try std.testing.expect(false),
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
        else => try std.testing.expect(false),
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
        else => try std.testing.expect(false),
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
            std.debug.print("cards len = {d} ", .{items.items.len});
            std.debug.print("OK\n", .{});
        },
        else => try std.testing.expect(false),
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
            std.debug.print("events len = {d} ", .{items.len});
            std.debug.print("OK\n", .{});
        },
        else => try std.testing.expect(false),
    }
}

test "global tournaments" {
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
    var tournaments = try api.getGlobalTournaments();
    const end = std.Io.Clock.awake.now(io);
    defer tournaments.deinit();
    const elapsed = @divTrunc(
        (end.nanoseconds - now.nanoseconds),
        std.time.ns_per_ms,
    );

    std.debug.print("elapsed: {}ms ", .{elapsed});
    switch (tournaments) {
        .success => |t| {
            const items = t.value;
            std.debug.print(
                "global tournaments len = {d} ",
                .{items.items.?.len},
            );
            std.debug.print("OK\n", .{});
        },
        else => try std.testing.expect(false),
    }
}

test "leaderboards" {
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
    var leaderboards = try api.getLeaderboards();
    const end = std.Io.Clock.awake.now(io);
    defer leaderboards.deinit();
    const elapsed = @divTrunc(
        (end.nanoseconds - now.nanoseconds),
        std.time.ns_per_ms,
    );

    std.debug.print("elapsed: {}ms ", .{elapsed});
    switch (leaderboards) {
        .success => |l| {
            const items = l.value;
            std.debug.print(
                "leaderboards len = {d} ",
                .{items.items.len},
            );
            std.debug.print("OK\n", .{});
        },
        else => try std.testing.expect(false),
    }
}

test "leaderboards by id" {
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
    var leaderboards = api.getLeaderboardsById("502514") catch |e| {
        switch (e) {
            error.UnexpectedEndOfInput => {
                std.debug.print("Expected error! shitty api\n", .{});
                return;
            },
            else => return e,
        }
    };
    const end = std.Io.Clock.awake.now(io);
    defer leaderboards.deinit();
    const elapsed = @divTrunc(
        (end.nanoseconds - now.nanoseconds),
        std.time.ns_per_ms,
    );

    std.debug.print("elapsed: {}ms ", .{elapsed});
    switch (leaderboards) {
        .success => |l| {
            const items = l.value;
            std.debug.print(
                "leaderboardsId len = {d} ",
                .{items.items.len},
            );
            std.debug.print("OK\n", .{});
        },
        else => try std.testing.expect(false),
    }
}

test "tournaments" {
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
    var tournaments = try api.getTournaments("Tor", null, null, null);
    const end = std.Io.Clock.awake.now(io);
    defer tournaments.deinit();
    const elapsed = @divTrunc(
        (end.nanoseconds - now.nanoseconds),
        std.time.ns_per_ms,
    );

    std.debug.print("elapsed: {}ms ", .{elapsed});
    switch (tournaments) {
        .success => |t| {
            std.debug.print(
                "tournaments len = {d} ",
                .{t.value.items.len},
            );
            std.debug.print("OK\n", .{});
        },
        else => try std.testing.expect(false),
    }
}

test "tournament by tag" {
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
    var tournament = try api.getTournamentFromTag("#2R00GRV2");
    const end = std.Io.Clock.awake.now(io);
    defer tournament.deinit();
    const elapsed = @divTrunc(
        (end.nanoseconds - now.nanoseconds),
        std.time.ns_per_ms,
    );

    std.debug.print("elapsed: {}ms ", .{elapsed});
    switch (tournament) {
        .success => std.debug.print("OK\n", .{}),
        else => try std.testing.expect(false),
    }
}
