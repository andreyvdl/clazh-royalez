pub const PlayerItemLevel = @This();

const IconUrls = @import("IconUrls.zig");
const Rarity = @import("../enums.zig").Rarity;

name: []const u8,
id: i64,
level: i64,
maxLevel: i64,
rarity: Rarity,
count: i64,
iconUrls: IconUrls,

/// Bitwise variable
///
/// - 01 = have evolution
/// - 10 = have hero
maxEvolutionLevel: ?i64 = null,
elixirCost: ?i64 = null,
starLevel: ?i64 = null,
evolutionLevel: ?i64 = null,
used: ?bool = null,
