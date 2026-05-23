pub const Players = @This();

const ClazhAPI = @import("../ClazhAPI.zig");
const Result = @import("../Result.zig");
const Player = ClazhAPI.Player;
const ClientError = ClazhAPI.ClientError;
const std = @import("std");

const route = "/players/";
const hashtag = "%23";

// {
//   "progress": {
//     "": {
//       "arena": {
//         "id": 168000050,
//         "name": "Bronze I",
//         "rawName": "AutoChessArena1_2025_Oct"
//       },
//       "trophies": 0,
//       "bestTrophies": 0
//     },
//     "AutoChess_2026_Season_8": {
//       "arena": {
//         "id": 168000133,
//         "name": "Bronze I",
//         "rawName": "AutoChessArena1_2026_Season_8"
//       },
//       "trophies": 0,
//       "bestTrophies": 0
//     }
//   },
// }

/// Same as `/v1/players/{playerTag}`
pub fn getPlayer(capi: *ClazhAPI, tag: []const u8) Result.Result(Player) {
    const modded_tag = modTag(capi.allocator, tag) catch |err| {
        return .{ .fail = switch (err) {
            error.InvalidTag => ClientError.make("InvalidTag", "The tag is invalid", "InputError"),
            else => ClientError.make("Editing tag error", "An unknown error occurred while editing the tag", "InternalServerError"),
        } };
    };
    defer capi.allocator.free(modded_tag);

    var body = std.Io.Writer.Allocating.init(capi.allocator);

    defer body.deinit();

    const url = std.mem.concat(capi.allocator, u8, &.{ ClazhAPI.common.base_url, route, modded_tag }) catch {
        return Result.Failed(Player, ClientError.make("Out of memory", "Not enough memory", "OutOfMemory"));
    };

    defer capi.allocator.free(url);

    const res = capi.client.fetch(.{
        .method = .GET,
        .location = .{ .url = url },
        .headers = .{
            .authorization = .{ .override = capi.token },
        },
        .response_writer = &body.writer,
    }) catch {
        return Result.Failed(Player, ClientError.make("Fetch failed", "An unknown error occurred while fetching the api", "InternalServerError"));
    };

    if (res.status != .ok) {
        return Result.Failed(Player, ClientError.fromJSON(capi.allocator, body.written()));
    }

    return Result.unmountJSON(Player, capi.allocator, body.written());
}

fn modTag(allocator: std.mem.Allocator, tag: []const u8) ![]const u8 {
    if (tag[0] == '#') {
        return try std.mem.concat(allocator, u8, &.{ hashtag, tag[1..] });
    } else if (std.ascii.isAlphanumeric(tag[0])) {
        return try std.mem.concat(allocator, u8, &.{ hashtag, tag });
    }
    return error.InvalidTag;
}
