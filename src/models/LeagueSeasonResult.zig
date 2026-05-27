pub const LeagueSeasonResult = @This();

trophies: i64,
rank: i64,
bestTrophies: i64,
/// Probably uuid, most ids in game are integers
id: []const u8,
