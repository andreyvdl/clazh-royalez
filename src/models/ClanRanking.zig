pub const ClanRanking = @This();

const std = @import("std");

const Location = @import("Location.zig");

badgeId: i64,
clanScore: i64,
members: i64,
previousRank: i64,
rank: i64,

badgeUrls: ?std.json.Value = null,
location: Location,

name: []const u8,
tag: []const u8,
