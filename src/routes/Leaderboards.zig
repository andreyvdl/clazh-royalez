pub const Leaderboards = @This();

const ClazhAPI = @import("../ClazhAPI.zig");
const Result = ClazhAPI.Result;
const Response = ClazhAPI.Response;
const ClientError = ClazhAPI.ClientError;
const LeaderboardList = ClazhAPI.LeaderboardList;
const Leaderboard = ClazhAPI.Leaderboard;
const LeaderboardResponse = Response.Response(Leaderboard);
const PagingOptions = ClazhAPI.PagingOptions;

const std = @import("std");

const route = "https://api.clashroyale.com/v1/leaderboard/";

/// Same as `/leaderboards`
pub fn getLeaderboards(
    capi: *ClazhAPI,
) !Result.Result(LeaderboardList) {
    var body = std.Io.Writer.Allocating.init(capi.gpa);
    defer body.deinit();

    const res = try capi.client.fetch(.{
        .method = .GET,
        .location = .{ .url = "https://api.clashroyale.com/v1/leaderboards" },
        .headers = .{
            .authorization = .{ .override = capi.token },
        },
        .response_writer = &body.writer,
        .keep_alive = false,
    });

    if (res.status != .ok) return Result.Failed(
        LeaderboardList,
        try ClientError.fromJSON(capi.gpa, body.written()),
    );

    return Result.unmountJSON(LeaderboardList, capi.gpa, body.written());
}

/// Same as `/leaderboard/{leaderboardId}`
pub fn getLeaderboardById(
    capi: *ClazhAPI,
    id: []const u8,
    opts: PagingOptions,
) !Result.Result(LeaderboardResponse) {
    const base_url = try std.mem.concat(capi.gpa, u8, &.{ route, id });
    defer capi.gpa.free(base_url);
    const url = try ClazhAPI.url.buildQuery(
        capi.gpa,
        PagingOptions,
        opts,
        base_url,
    );
    defer capi.gpa.free(url);
    var body = std.Io.Writer.Allocating.init(capi.gpa);
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

    if (res.status != .ok) {
        return Result.Failed(
            LeaderboardResponse,
            try ClientError.fromJSON(capi.gpa, body.written()),
        );
    }

    return Result.unmountJSON(LeaderboardResponse, capi.gpa, body.written());
}
