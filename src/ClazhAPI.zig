const ClazhAPI = @This();
const std = @import("std");
const mem = std.mem;
const http = std.http;

pub const Result = @import("Result.zig").Result;
pub const Player = @import("models/Player.zig");
pub const ClientError = @import("models/ClientError.zig");
pub const UpcomingChests = @import("models/UpcomingChests.zig");
pub const Battle = @import("models/Battle.zig");

const enums = @import("enums.zig");

pub const Rarity = enums.Rarity;
pub const Role = enums.Role;

allocator: mem.Allocator = undefined,
io: std.Io = undefined,
token: []const u8 = undefined,
client: http.Client = undefined,

pub fn init(capi: *ClazhAPI, allocator: mem.Allocator, io: std.Io, token: []const u8) !void {
    const bearer_token = try std.mem.concat(allocator, u8, &.{ "Bearer ", token });

    capi.* = .{
        .allocator = allocator,
        .io = io,
        .token = bearer_token,
        .client = http.Client{ .allocator = allocator, .io = io },
    };
}

pub fn deinit(capi: *ClazhAPI) void {
    capi.client.deinit();
    capi.allocator.free(capi.token);
}

const Players = @import("routes/Players.zig");

/// Same as `/players/{playerTag}`
pub fn getPlayer(capi: *ClazhAPI, tag: []const u8) !Result(Player) {
    return try Players.getPlayer(capi, tag);
}

/// Same as `/players/{playerTag}/upcomingchests`
///
/// Probably something the game doesn't use anymore since it still has
/// references to "Wooden Chest".
pub fn getUpcomingChests(capi: *ClazhAPI, tag: []const u8) !Result(UpcomingChests) {
    return try Players.getUpcomingChests(capi, tag);
}

/// Same as `/players/{playerTag}/battlelog`
pub fn getBattleLog(capi: *ClazhAPI, tag: []const u8) !Result([]Battle) {
    return try Players.getBattleLog(capi, tag);
}
