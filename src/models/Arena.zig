pub const Arena = @This();

const IconUrls = @import("IconUrls.zig");

id: i32,
name: []const u8,
raw_name: []const u8,
icon_urls: IconUrls,
