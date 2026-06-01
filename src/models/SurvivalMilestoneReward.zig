pub const SurvivalMilestoneReward = @This();

const Item = @import("Item.zig");
const enums = @import("../enums.zig");
const Rarity = enums.Rarity;
const Resource = enums.Resource;
const ItemType = enums.ItemType;

amount: i64,
wins: i64,

card: Item,
rarity: Rarity,
resource: Resource,
type: ItemType,

chest: []const u8,
consumableName: []const u8,
