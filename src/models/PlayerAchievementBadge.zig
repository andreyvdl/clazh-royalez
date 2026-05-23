pub const PlayerAchievementBadge = @This();

const IconUrls = @import("IconUrls.zig");

icon_urls: IconUrls,
max_level: i32,
progress: i32,
level: i32,
target: i32,
name: []const u8,
