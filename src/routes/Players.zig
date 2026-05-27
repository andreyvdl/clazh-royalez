pub const Players = @This();

const ClazhAPI = @import("../ClazhAPI.zig");
const Result = @import("../Result.zig");
const Player = ClazhAPI.Player;
const ClientError = ClazhAPI.ClientError;
const std = @import("std");

const route = "https://api.clashroyale.com/v1/players/";
const hashtag = "%23";

/// Same as `/v1/players/{playerTag}`
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

/// Free valid return.
fn modTag(allocator: std.mem.Allocator, tag: []const u8) ![]const u8 {
    if (tag[0] == '#') {
        return try std.mem.concat(allocator, u8, &.{ hashtag, tag[1..] });
    } else if (std.ascii.isAlphanumeric(tag[0])) {
        return try std.mem.concat(allocator, u8, &.{ hashtag, tag });
    }
    return error.InvalidTag;
}
