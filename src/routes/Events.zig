pub const Events = @This();

const ClazhAPI = @import("../ClazhAPI.zig");
const Result = ClazhAPI.Result;
const TrailEvent = ClazhAPI.TrailEvent;
const ClientError = ClazhAPI.ClientError;

const std = @import("std");

const route = "https://api.clashroyale.com/v1/events";

/// Same as `/events`
pub fn getEvents(capi: *ClazhAPI) !Result.Result([]TrailEvent) {
    var body = std.Io.Writer.Allocating.init(capi.gpa);
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
        []TrailEvent,
        try ClientError.fromJSON(capi.gpa, body.written()),
    );

    return Result.unmountJSON([]TrailEvent, capi.gpa, body.written());
}
