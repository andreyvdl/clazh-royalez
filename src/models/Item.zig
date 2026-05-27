pub const Item = @This();

const IconUrls = @import("IconUrls.zig");
const Rarity = @import("../enums.zig").Rarity;

name: []const u8,
id: i64,
maxLevel: i64,
iconUrls: IconUrls,
rarity: Rarity,

elixirCost: ?i64 = null,
/// bitwise variable
///
/// - 01 = have evolution
/// - 10 = have hero
maxEvolutionLevel: ?i64 = null,
