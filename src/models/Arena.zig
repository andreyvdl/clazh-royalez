pub const Arena = @This();

const IconUrls = @import("IconUrls.zig");

id: i64,
name: []const u8,
rawName: []const u8,

iconUrls: ?IconUrls = null,
