pub const Item = @This();

const IconUrls = @import("IconUrls.zig");
const Rarity = @import("../enums.zig").Rarity;

elixirCost: ?i64 = null,
id: i64,
/// bitwise variable
///
/// - 01 = have evolution
/// - 10 = have hero
maxEvolutionLevel: ?i64 = null,
maxLevel: i64,

iconUrls: IconUrls,
rarity: Rarity,

name: []const u8,
