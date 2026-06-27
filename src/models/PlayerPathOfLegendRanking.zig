pub const PlayerPathOfLegendRanking = @This();

const PlayerRankingClan = @import("PlayerRankingClan.zig");

clan: ?PlayerRankingClan = null,

eloRating: i64,
expLevel: i64,
rank: i64,

name: []const u8,
tag: []const u8,
