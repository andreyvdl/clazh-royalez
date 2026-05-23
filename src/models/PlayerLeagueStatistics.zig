pub const PlayerLeagueStatistics = @This();

const LeagueSeasonResult = @import("LeagueSeasonResult.zig");

current_season: LeagueSeasonResult,
best_season: LeagueSeasonResult,
previous_season: LeagueSeasonResult,
