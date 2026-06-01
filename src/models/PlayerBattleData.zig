pub const PlayerBattleData = @This();

const PlayerItemLevel = @import("PlayerItemLevel.zig");
const PlayerClan = @import("PlayerClan.zig");
const BattleRound = @import("BattleRound.zig");

cards: []PlayerItemLevel,
clan: ?PlayerClan = null,
rounds: ?[]BattleRound = null,
supportCards: []PlayerItemLevel,

crowns: i64,
globalRank: ?i64 = null,
kingTowerHitPoints: i64,
princessTowersHitPoints: ?[]i64 = null,
startingTrophies: ?i64 = null,
trophyChange: ?i64 = null,

elixirLeaked: f64,

name: []const u8,
tag: []const u8,
