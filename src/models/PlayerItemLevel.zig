pub const PlayerItemLevel = @This();

const IconUrls = @import("IconUrls.zig");
const Rarity = @import("../enums.zig").Rarity;

id: i32,
/// original is string
rarity: Rarity,
count: i32,
level: i32,
star_level: i32,
evolution_level: i32,
used: bool,
name: []const u8,
max_level: i32,
elixir_cost: i32,
max_evolution_level: i32,
iconUrls: IconUrls,
