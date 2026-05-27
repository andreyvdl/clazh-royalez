pub const PlayerItemLevel = @This();

const IconUrls = @import("IconUrls.zig");
const Rarity = @import("../enums.zig").Rarity;

name: []const u8,
id: i64,
level: i64,
maxLevel: i64,
rarity: Rarity,
iconUrls: IconUrls,

count: ?i64 = null,
/// Bitwise variable
///
/// - 01 = can be evolution
/// - 10 = can be hero
maxEvolutionLevel: ?i64 = null,
/// bitwise variable
///
/// - 01 = unlocked evolution
/// - 10 = unlocked hero
evolutionLevel: ?i64 = null,
elixirCost: ?i64 = null,
starLevel: ?i64 = null,
used: ?bool = null,
