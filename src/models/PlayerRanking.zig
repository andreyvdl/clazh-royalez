pub const PlayerRaking = @This();

const Arena = @import("Arena.zig");
const PlayerRankingClan = @import("PlayerRankingClan.zig");

arena: Arena,
clan: PlayerRankingClan,

expLevel: i64,
previousRank: i64,
rank: i64,
trophies: i64,

name: []const u8,
tag: []const u8,
