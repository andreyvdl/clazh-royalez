pub const PlayerLeagueStatistics = @This();

const LeagueSeasonResult = @import("LeagueSeasonResult.zig");

currentSeason: LeagueSeasonResult,
bestSeason: LeagueSeasonResult,
previousSeason: LeagueSeasonResult,
