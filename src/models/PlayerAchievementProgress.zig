pub const PlayerAchievementProgress = @This();

name: []const u8,
stars: i64,
value: i64,
target: i64,
info: []const u8,

completionInfo: ?[]const u8 = null,
