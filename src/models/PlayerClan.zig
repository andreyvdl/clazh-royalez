pub const PlayerClan = @This();

const std = @import("std");

badge_id: i32,
tag: []const u8,
name: []const u8,
/// TODO! @ BadgeUrls.zig
badge_urls: std.json.Value = .null,
