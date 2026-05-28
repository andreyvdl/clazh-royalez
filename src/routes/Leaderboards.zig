pub const Leaderboards = @This();

const ClazhAPI = @import("../ClazhAPI.zig");
const Result = ClazhAPI.Result;
const ClientError = ClazhAPI.ClientError;
const LeaderboardList = ClazhAPI.LeaderboardList;

const std = @import("std");

const route = "https://api.clashroyale.com/v1/leaderboards";

/// Same as `/leaderboards`
pub fn getLeaderboards(
    capi: *ClazhAPI,
) !Result.Result(LeaderboardList) {
    var body = std.Io.Writer.Allocating.init(capi.allocator);
    defer body.deinit();

    const res = try capi.client.fetch(.{
        .method = .GET,
        .location = .{ .url = route },
        .headers = .{
            .authorization = .{ .override = capi.token },
        },
        .response_writer = &body.writer,
        .keep_alive = false,
    });

    if (res.status != .ok) return Result.Failed(
        LeaderboardList,
        try ClientError.fromJSON(capi.allocator, body.written()),
    );

    return Result.unmountJSON(LeaderboardList, capi.allocator, body.written());
}

/// Same as `/leaderboards/{leaderboardId}`
pub fn getLeaderboardsById(
    capi: *ClazhAPI,
    id: []const u8,
) !Result.Result(LeaderboardList) {
    const url = try std.mem.concat(capi.allocator, u8, &.{ route, "/", id });
    defer capi.allocator.free(url);
    var body = std.Io.Writer.Allocating.init(capi.allocator);
    defer body.deinit();

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
        LeaderboardList,
        try ClientError.fromJSON(capi.allocator, body.written()),
    );

    return Result.unmountJSON(LeaderboardList, capi.allocator, body.written());
}
