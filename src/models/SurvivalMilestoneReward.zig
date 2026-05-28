pub const SurvivalMilestoneReward = @This();

const Item = @import("Item.zig");
const enums = @import("../enums.zig");
const Rarity = enums.Rarity;
const Resource = enums.Resource;
const ItemType = enums.ItemType;

rarity: Rarity,
chest: []const u8,
resource: Resource,
type: ItemType,
amount: i64,
card: Item,
consumableName: []const u8,
wins: i64,
