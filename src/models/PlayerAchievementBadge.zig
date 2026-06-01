pub const PlayerAchievementBadge = @This();

const IconUrls = @import("IconUrls.zig");

iconUrls: IconUrls,

level: i64,
maxLevel: i64,
progress: i64,
target: i64,

name: []const u8,
