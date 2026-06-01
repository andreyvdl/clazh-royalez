pub const PlayerBattleAugment = @This();

const std = @import("std");

modifiers: []std.json.Value,

tag: []const u8,
