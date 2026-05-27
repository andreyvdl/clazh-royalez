pub const PlayerBattleAugment = @This();

const std = @import("std");

tag: []const u8,
modifiers: []std.json.Value,
