pub const PlayerRankingClan = @This();

const std = @import("std");

badgeId: i64,

badgeUrls: ?std.json.Value = null,

name: []const u8,
tag: []const u8,
