pub const PlayerBattleData = @This();

const PlayerItemLevel = @import("PlayerItemLevel.zig");
const PlayerClan = @import("PlayerClan.zig");
const BattleRound = @import("BattleRound.zig");

tag: []const u8,
name: []const u8,
crowns: i64,
kingTowerHitPoints: i64,
cards: []PlayerItemLevel,
supportCards: []PlayerItemLevel,
elixirLeaked: f64,

trophyChange: ?i64 = null,
princessTowersHitPoints: ?[]i64 = null,
globalRank: ?i64 = null,
clan: ?PlayerClan = null,
rounds: ?[]BattleRound = null,
startingTrophies: ?i64 = null,
