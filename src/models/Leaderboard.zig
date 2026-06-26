pub const Leaderboard = @This();

const std = @import("std");

const LeaderboardClan = @import("LeaderboardClan.zig");

id: ?i64 = null,
rank: ?i64 = null,
score: ?i64 = null,

name: ?[]const u8 = null,
tag: ?[]const u8 = null,

clan: ?LeaderboardClan = null,
