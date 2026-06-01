pub const Arena = @This();

const IconUrls = @import("IconUrls.zig");

iconUrls: ?IconUrls = null,
id: i64,
name: []const u8,
rawName: []const u8,
