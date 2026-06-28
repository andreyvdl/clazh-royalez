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

    std.debug.print("[Player-getPlayer]: {}ms ", .{elapsed});
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

    std.debug.print("[Player-getUpcomingChests]: {}ms ", .{elapsed});
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

    std.debug.print("[Player-getBattleLog]: {}ms ", .{elapsed});
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

    std.debug.print("[Cards-getCards]: {}ms ", .{elapsed});
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

    std.debug.print("[Events-getEvents]: {}ms ", .{elapsed});
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

    std.debug.print(
        "[GlobalTournaments-getGlobalTournaments]: {}ms ",
        .{elapsed},
    );
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

    std.debug.print(
        "[Leaderboards-getLeaderboards]: {}ms ",
        .{elapsed},
    );
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

test "leaderboard by id" {
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
    var leaderboard = try api.getLeaderboardById("502514", null, null, null);
    const end = std.Io.Clock.awake.now(io);
    defer leaderboard.deinit();
    const elapsed = @divTrunc(
        (end.nanoseconds - now.nanoseconds),
        std.time.ns_per_ms,
    );

    std.debug.print(
        "[Leaderboards-getLeaderboardById]: {}ms ",
        .{elapsed},
    );
    switch (leaderboard) {
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

    std.debug.print(
        "[Tournaments-getTournaments]: {}ms ",
        .{elapsed},
    );
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

    std.debug.print(
        "[Tournaments-getTournamentFromTag]: {}ms ",
        .{elapsed},
    );
    switch (tournament) {
        .success => std.debug.print("OK\n", .{}),
        else => try std.testing.expect(false),
    }
}

test "get clan" {
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
    var clan_list = try api.getClans("Jesus", 0, 0, 0, 0, 5, null, null);
    const end = std.Io.Clock.awake.now(io);
    defer clan_list.deinit();
    const elapsed = @divTrunc(
        (end.nanoseconds - now.nanoseconds),
        std.time.ns_per_ms,
    );

    std.debug.print("[Clans-getClans]: {}ms ", .{elapsed});
    switch (clan_list) {
        .success => |c| {
            std.debug.print(
                "clans len = {d}  ",
                .{c.value.items.len},
            );
            std.debug.print("OK\n", .{});
        },
        else => try std.testing.expect(false),
    }
}

test "get clan by tag" {
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
    var clan = try api.getClanByTag("#RYGVVU29");
    const end = std.Io.Clock.awake.now(io);
    defer clan.deinit();
    const elapsed = @divTrunc(
        (end.nanoseconds - now.nanoseconds),
        std.time.ns_per_ms,
    );

    std.debug.print("[Clans-getClanByTag]: {}ms ", .{elapsed});
    switch (clan) {
        .success => std.debug.print("OK\n", .{}),
        else => try std.testing.expect(false),
    }
}

test "get clan members" {
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
    var members = try api.getClanMembers("#RYGVVU29", null, null, null);
    const end = std.Io.Clock.awake.now(io);
    defer members.deinit();
    const elapsed = @divTrunc(
        (end.nanoseconds - now.nanoseconds),
        std.time.ns_per_ms,
    );

    std.debug.print("[Clans-getClanMembers]: {}ms ", .{elapsed});
    switch (members) {
        .success => |m| {
            std.debug.print("members len = {d} ", .{m.value.items.len});
            std.debug.print("OK\n", .{});
        },
        else => try std.testing.expect(false),
    }
}

test "get clan river race log" {
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
    var log = try api.getClanRiverRaceLog("#RYGVVU29", null, null, null);
    const end = std.Io.Clock.awake.now(io);
    defer log.deinit();
    const elapsed = @divTrunc(
        (end.nanoseconds - now.nanoseconds),
        std.time.ns_per_ms,
    );

    std.debug.print("[Clans-getClanRiverRaceLog]: {}ms ", .{elapsed});
    switch (log) {
        .success => |l| {
            std.debug.print("log len = {d} ", .{l.value.items.len});
            std.debug.print("OK\n", .{});
        },
        else => try std.testing.expect(false),
    }
}

test "get clan current river race" {
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
    var race = try api.getClanCurrentRiverRace("#RYGVVU29");
    const end = std.Io.Clock.awake.now(io);
    defer race.deinit();
    const elapsed = @divTrunc(
        (end.nanoseconds - now.nanoseconds),
        std.time.ns_per_ms,
    );

    std.debug.print("[Clans-getClanCurrentRiverRace]: {}ms ", .{elapsed});
    switch (race) {
        .success => |r| {
            std.debug.print("race log len = {d} ", .{r.value.periodLogs.len});
            std.debug.print("OK\n", .{});
        },
        else => try std.testing.expect(false),
    }
}

test "get location" {
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
    var locations = try api.getLocations(null, null, null);
    const end = std.Io.Clock.awake.now(io);
    defer locations.deinit();
    const elapsed = @divTrunc(
        (end.nanoseconds - now.nanoseconds),
        std.time.ns_per_ms,
    );

    std.debug.print("[Locations-getLocations]: {}ms ", .{elapsed});
    switch (locations) {
        .success => |l| {
            std.debug.print("Location len = {d} ", .{l.value.items.len});
            std.debug.print("OK\n", .{});
        },
        else => try std.testing.expect(false),
    }
}

test "get location by id" {
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
    var location = try api.getLocationById(57000002);
    const end = std.Io.Clock.awake.now(io);
    defer location.deinit();
    const elapsed = @divTrunc(
        (end.nanoseconds - now.nanoseconds),
        std.time.ns_per_ms,
    );

    std.debug.print("[Locations-getLocationById]: {}ms ", .{elapsed});
    switch (location) {
        .success => |l| {
            std.debug.print("Location name = {s} ", .{l.value.name});
            std.debug.print("OK\n", .{});
        },
        else => try std.testing.expect(false),
    }
}

test "get location players ranking by id" {
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
    var rankings = try api.getPlayersRankingsByLocation(
        57000047,
        null,
        null,
        null,
    );
    const end = std.Io.Clock.awake.now(io);
    defer rankings.deinit();
    const elapsed = @divTrunc(
        (end.nanoseconds - now.nanoseconds),
        std.time.ns_per_ms,
    );

    std.debug.print(
        "[Locations-getPlayersRankingsByLocation]: {}ms ",
        .{elapsed},
    );
    switch (rankings) {
        .success => |r| {
            std.debug.print("Rankings len = {d} ", .{r.value.items.len});
            std.debug.print("OK\n", .{});
        },
        else => try std.testing.expect(false),
    }
}

test "get location clans ranking by id" {
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
    var rankings = try api.getClansRankingsByLocation(
        57000002,
        null,
        null,
        null,
    );
    const end = std.Io.Clock.awake.now(io);
    defer rankings.deinit();
    const elapsed = @divTrunc(
        (end.nanoseconds - now.nanoseconds),
        std.time.ns_per_ms,
    );

    std.debug.print(
        "[Locations-getClansRankingsByLocation]: {}ms ",
        .{elapsed},
    );
    switch (rankings) {
        .success => |r| {
            std.debug.print("Rankings len = {d} ", .{r.value.items.len});
            std.debug.print("OK\n", .{});
        },
        else => try std.testing.expect(false),
    }
}

test "get location clan wars ranking by id" {
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
    var rankings = try api.getClanWarsRankingsByLocation(
        57000047,
        null,
        null,
        null,
    );
    const end = std.Io.Clock.awake.now(io);
    defer rankings.deinit();
    const elapsed = @divTrunc(
        (end.nanoseconds - now.nanoseconds),
        std.time.ns_per_ms,
    );

    std.debug.print(
        "[Locations-getClanWarsRankingsByLocation]: {}ms ",
        .{elapsed},
    );
    switch (rankings) {
        .success => |r| {
            std.debug.print("Rankings len = {d} ", .{r.value.items.len});
            std.debug.print("OK\n", .{});
        },
        else => try std.testing.expect(false),
    }
}

test "get location players path of legend ranking by id" {
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
    var rankings = try api.getPlayersPathOfLegendRankingsByLocation(
        57000047,
        null,
        null,
        null,
    );
    const end = std.Io.Clock.awake.now(io);
    defer rankings.deinit();
    const elapsed = @divTrunc(
        (end.nanoseconds - now.nanoseconds),
        std.time.ns_per_ms,
    );

    std.debug.print(
        "[Locations-getPlayersPathOfLegendRankingsByLocation]: {}ms ",
        .{elapsed},
    );
    switch (rankings) {
        .success => |r| {
            std.debug.print("Rankings len = {d} ", .{r.value.items.len});
            std.debug.print("OK\n", .{});
        },
        else => try std.testing.expect(false),
    }
}

test "get location global seasons V1" {
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
    var seasons = try api.getGlobalSeasonsV1();
    const end = std.Io.Clock.awake.now(io);
    defer seasons.deinit();
    const elapsed = @divTrunc(
        (end.nanoseconds - now.nanoseconds),
        std.time.ns_per_ms,
    );

    std.debug.print("[Locations-getGlobalSeasonsV1]: {}ms ", .{elapsed});
    switch (seasons) {
        .success => |s| {
            std.debug.print("Seasons len = {d} ", .{s.value.items.len});
            std.debug.print("OK\n", .{});
        },
        else => try std.testing.expect(false),
    }
}

test "get location global seasons V2" {
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
    var seasons = try api.getGlobalSeasonsV2();
    const end = std.Io.Clock.awake.now(io);
    defer seasons.deinit();
    const elapsed = @divTrunc(
        (end.nanoseconds - now.nanoseconds),
        std.time.ns_per_ms,
    );

    std.debug.print("[Locations-getGlobalSeasonsV2]: {}ms ", .{elapsed});
    switch (seasons) {
        .success => |s| {
            std.debug.print("Seasons len = {d} ", .{s.value.items.len});
            std.debug.print("OK\n", .{});
        },
        else => try std.testing.expect(false),
    }
}

test "get location season by season id" {
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
    var season = try api.getSeasonBySeasonId("2022-02");
    const end = std.Io.Clock.awake.now(io);
    defer season.deinit();
    const elapsed = @divTrunc(
        (end.nanoseconds - now.nanoseconds),
        std.time.ns_per_ms,
    );

    std.debug.print("[Locations-getSeasonBySeasonId]: {}ms ", .{elapsed});
    switch (season) {
        .success => |s| {
            std.debug.print("Season id = {s} ", .{s.value.id.?});
            std.debug.print("OK\n", .{});
        },
        else => try std.testing.expect(false),
    }
}

