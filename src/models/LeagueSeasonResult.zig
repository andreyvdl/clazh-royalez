pub const LeagueSeasonResult = @This();

trophies: i32,
rank: i32,
best_trophies: i32,
/// Probably uuid, most ids in game are integers
id: []const u8,
