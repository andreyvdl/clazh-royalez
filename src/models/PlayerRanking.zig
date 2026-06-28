pub const PlayerRaking = @This();

const Arena = @import("Arena.zig");
const PlayerRankingClan = @import("PlayerRankingClan.zig");

arena: ?Arena = null,
clan: ?PlayerRankingClan = null,

expLevel: i64,
previousRank: ?i64 = null,
rank: i64,
trophies: i64,

name: []const u8,
tag: []const u8,
