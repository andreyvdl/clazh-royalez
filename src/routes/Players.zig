pub const Players = @This();

const ClazhAPI = @import("../ClazhAPI.zig");
const Battle = ClazhAPI.Battle;
const ClientError = ClazhAPI.ClientError;
const Player = ClazhAPI.Player;
const Result = ClazhAPI.Result;
const Response = ClazhAPI.Response;
const Chest = ClazhAPI.Chest;
const ChestResponse = Response.Response(Chest);
const std = @import("std");
const aux = @import("../aux.zig");

const route = "https://api.clashroyale.com/v1/players/";

/// Same as `/players/{playerTag}`
pub fn getPlayer(capi: *ClazhAPI, tag: []const u8) !Result.Result(Player) {
    const modded_tag = try aux.modTag(capi.allocator, tag);
    defer capi.allocator.free(modded_tag);

    var body = std.Io.Writer.Allocating.init(capi.allocator);
    defer body.deinit();
    const url = try std.mem.concat(
        capi.allocator,
        u8,
        &.{ route, modded_tag },
    );
    defer capi.allocator.free(url);

    const res = try capi.client.fetch(.{
        .method = .GET,
        .location = .{ .url = url },
        .headers = .{
            .authorization = .{ .override = capi.token },
        },
        .response_writer = &body.writer,
        .keep_alive = false,
    });

    if (res.status != .ok) return Result.Failed(
        Player,
        try ClientError.fromJSON(capi.allocator, body.written()),
    );

    return Result.unmountJSON(Player, capi.allocator, body.written());
}

/// Same as `/players/{playerTag}/upcomingchests`
///
/// Probably something the game doesn't use anymore since it still has
/// references to "Wooden Chest".
pub fn getUpcomingChests(
    capi: *ClazhAPI,
    tag: []const u8,
) !Result.Result(ChestResponse) {
    const modded_tag = try aux.modTag(capi.allocator, tag);
    defer capi.allocator.free(modded_tag);

    var body = std.Io.Writer.Allocating.init(capi.allocator);
    defer body.deinit();
    const url = try std.mem.concat(
        capi.allocator,
        u8,
        &.{ route, modded_tag, "/upcomingchests" },
    );
    defer capi.allocator.free(url);

    const res = try capi.client.fetch(.{
        .method = .GET,
        .location = .{ .url = url },
        .headers = .{
            .authorization = .{ .override = capi.token },
        },
        .response_writer = &body.writer,
        .keep_alive = false,
    });

    if (res.status != .ok) return Result.Failed(
        ChestResponse,
        try ClientError.fromJSON(capi.allocator, body.written()),
    );

    return Result.unmountJSON(ChestResponse, capi.allocator, body.written());
}

/// Same as `/players/{playerTag}/battlelog`
pub fn getBattleLog(
    capi: *ClazhAPI,
    tag: []const u8,
) !Result.Result([]Battle) {
    const modded_tag = try aux.modTag(capi.allocator, tag);
    defer capi.allocator.free(modded_tag);
    var body = std.Io.Writer.Allocating.init(capi.allocator);
    defer body.deinit();
    const url = try std.mem.concat(
        capi.allocator,
        u8,
        &.{ route, modded_tag, "/battlelog" },
    );
    defer capi.allocator.free(url);

    const res = try capi.client.fetch(.{
        .method = .GET,
        .location = .{ .url = url },
        .headers = .{
            .authorization = .{ .override = capi.token },
        },
        .response_writer = &body.writer,
        .keep_alive = false,
    });

    if (res.status != .ok) return Result.Failed(
        []Battle,
        try ClientError.fromJSON(capi.allocator, body.written()),
    );

    return Result.unmountJSON([]Battle, capi.allocator, body.written());
}
