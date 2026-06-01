pub const PlayerItemLevel = @This();

const IconUrls = @import("IconUrls.zig");
const Rarity = @import("../enums.zig").Rarity;

count: ?i64 = null,
elixirCost: ?i64 = null,
/// bitwise variable
///
/// - 01 = unlocked evolution
/// - 10 = unlocked hero
evolutionLevel: ?i64 = null,
id: i64,
level: i64,
/// Bitwise variable
///
/// - 01 = can be evolution
/// - 10 = can be hero
maxEvolutionLevel: ?i64 = null,
maxLevel: i64,
starLevel: ?i64 = null,

iconUrls: IconUrls,
rarity: Rarity,

name: []const u8,

used: ?bool = null,
