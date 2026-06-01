pub const PlayerLeagueStatistics = @This();

const LeagueSeasonResult = @import("LeagueSeasonResult.zig");

bestSeason: LeagueSeasonResult,
currentSeason: LeagueSeasonResult,
previousSeason: LeagueSeasonResult,
