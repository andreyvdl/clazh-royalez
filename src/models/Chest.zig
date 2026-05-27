pub const Chest = @This();

const IconUrls = @import("IconUrls.zig");

index: i64,
name: []const u8,

iconUrls: ?IconUrls = null,
