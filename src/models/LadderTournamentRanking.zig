pub const LadderTournamentRanking = @This();

const PlayerRankingClan = @import("PlayerRankingClan.zig");

clan: ?PlayerRankingClan = null,

losses: i64,
previousRank: i64,
rank: i64,
wins: i64,

name: []const u8,
tag: []const u8,
