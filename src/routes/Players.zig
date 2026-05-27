pub const Players = @This();

const ClazhAPI = @import("../ClazhAPI.zig");
const Result = @import("../Result.zig");
const Player = ClazhAPI.Player;
const ClientError = ClazhAPI.ClientError;
const UpcomingChests = ClazhAPI.UpcomingChests;
const Battle = ClazhAPI.Battle;
const std = @import("std");
const route = "https://api.clashroyale.com/v1/players/";
const hashtag = "%23";

/// Same as `/players/{playerTag}`
pub fn getPlayer(capi: *ClazhAPI, tag: []const u8) !Result.Result(Player) {
    const modded_tag = try modTag(capi.allocator, tag);
    defer capi.allocator.free(modded_tag);

    var body = std.Io.Writer.Allocating.init(capi.allocator);
    defer body.deinit();
    const url = try std.mem.concat(capi.allocator, u8, &.{ route, modded_tag });
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

    if (res.status != .ok) return Result.Failed(Player, try ClientError.fromJSON(capi.allocator, body.written()));

    return Result.unmountJSON(Player, capi.allocator, body.written());
}

/// Same as `/players/{playerTag}/upcomingchests`
///
/// Probably something the game doesn't use anymore since it still has
/// references to "Wooden Chest".
pub fn getUpcomingChests(capi: *ClazhAPI, tag: []const u8) !Result.Result(UpcomingChests) {
    const modded_tag = try modTag(capi.allocator, tag);
    defer capi.allocator.free(modded_tag);

    var body = std.Io.Writer.Allocating.init(capi.allocator);
    defer body.deinit();
    const url = try std.mem.concat(capi.allocator, u8, &.{ route, modded_tag, "/upcomingchests" });
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

    if (res.status != .ok) return Result.Failed(UpcomingChests, try ClientError.fromJSON(capi.allocator, body.written()));

    return Result.unmountJSON(UpcomingChests, capi.allocator, body.written());
}

/// Same as `/players/{playerTag}/battlelog`
pub fn getBattleLog(capi: *ClazhAPI, tag: []const u8) !Result.Result([]Battle) {
    const modded_tag = try modTag(capi.allocator, tag);
    defer capi.allocator.free(modded_tag);

    const f = try std.Io.Dir.createFile(.cwd(), capi.io, "output.json", .{});
    defer f.close(capi.io);

    var body = std.Io.Writer.Allocating.init(capi.allocator);
    defer body.deinit();
    const url = try std.mem.concat(capi.allocator, u8, &.{ route, modded_tag, "/battlelog" });
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

    try f.writeStreamingAll(capi.io, body.written());

    if (res.status != .ok) return Result.Failed([]Battle, try ClientError.fromJSON(capi.allocator, body.written()));

    return Result.unmountJSON([]Battle, capi.allocator, body.written());
}

fn modTag(allocator: std.mem.Allocator, tag: []const u8) ![]const u8 {
    if (tag[0] == '#') {
        return try std.mem.concat(allocator, u8, &.{ hashtag, tag[1..] });
    } else if (std.ascii.isAlphanumeric(tag[0])) {
        return try std.mem.concat(allocator, u8, &.{ hashtag, tag });
    }
    return error.InvalidTag;
}
