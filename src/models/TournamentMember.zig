pub const TournamentMember = @This();

const PlayerClan = @import("PlayerClan.zig");

clan: ?PlayerClan = null,

name: []const u8,
tag: []const u8,

previousRank: ?i64 = null,
rank: i64,
score: i64,
