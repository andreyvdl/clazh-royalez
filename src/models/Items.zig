//! Items is different from Item
//!
//! [Item](Item.zig) is a struct that represents a
//! [PlayerItemLevel](PlayerItemLevel.zig).
//!
//! Items is a struct that represents the two kind of items in the game:
//! cards and support cards (tower cards).
pub const Items = @This();

const Item = @import("Item.zig");

items: []Item,
supportItems: []Item,
