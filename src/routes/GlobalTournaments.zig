pub const GlobalTournaments = @This();

const ClazhAPI = @import("../ClazhAPI.zig");
const Result = ClazhAPI.Result;
const LadderTournamentList = ClazhAPI.LadderTournamentList;
const ClientError = ClazhAPI.ClientError;

const std = @import("std");

const route = "https://api.clashroyale.com/v1/globaltournaments";

/// Same as `/globaltournaments`
pub fn getGlobalTournaments(
    capi: *ClazhAPI,
) !Result.Result(LadderTournamentList) {
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
        LadderTournamentList,
        try ClientError.fromJSON(capi.allocator, body.written()),
    );

    return Result.unmountJSON(
        LadderTournamentList,
        capi.allocator,
        body.written(),
    );
}
