pub const PlayerAchievementBadge = @This();

const IconUrls = @import("IconUrls.zig");

name: []const u8,
level: i64,
maxLevel: i64,
progress: i64,
target: i64,
iconUrls: IconUrls,
