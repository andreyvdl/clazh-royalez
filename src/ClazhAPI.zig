const ClazhAPI = @This();

const std = @import("std");
const mem = std.mem;
const http = std.http;

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
        .client = http.Client{ .allocator = allocator, .io = io, .write_buffer_size = 16 * 1024 },
    };
}

pub fn deinit(capi: *ClazhAPI) void {
    capi.client.deinit();
    capi.allocator.free(capi.token);
}

pub const Result = @import("Result.zig").Result;
pub const Player = @import("models/Player.zig");
pub const ClientError = @import("models/ClientError.zig");
pub const common = @import("common.zig");

const enums = @import("enums.zig");

pub const Rarity = enums.Rarity;
pub const Role = enums.Role;

const Players = @import("routes/Players.zig");

pub fn getPlayer(capi: *ClazhAPI, tag: []const u8) Result(Player) {
    return Players.getPlayer(capi, tag);
}
