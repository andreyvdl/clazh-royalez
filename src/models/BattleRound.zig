pub const BattleRound = @This();

const PlayerItemLevel = @import("PlayerItemLevel.zig");

cards: []PlayerItemLevel,
elixirLeaked: f64,
crowns: i64,
kingTowerHitPoints: i64,
princessTowersHitPoints: ?[]i64 = null,
