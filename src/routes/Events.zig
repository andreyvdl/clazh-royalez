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

    return try ClazhAPI.url.fetch([]TrailEvent, capi, route, &body);
}
