pub const Item = @This();

const IconUrls = @import("IconUrls.zig");
const Rarity = @import("../enums.zig").Rarity;

icon_urls: IconUrls,
name: []const u8,
id: i32,
rarity: Rarity,
max_level: i32,
elixir_cost: i32,
max_evolution_level: i32,
