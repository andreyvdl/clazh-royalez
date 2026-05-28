pub const Cards = @This();

const ClazhAPI = @import("../ClazhAPI.zig");
const Result = ClazhAPI.Result;
const Items = ClazhAPI.Items;
const CardsQueryOptions = ClazhAPI.CardsQueryOptions;
const ClientError = ClazhAPI.ClientError;
const std = @import("std");

const route = "https://api.clashroyale.com/v1/cards";

/// Same as `/cards`
pub fn getCards(capi: *ClazhAPI) !Result.Result(Items) {
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
        Items,
        try ClientError.fromJSON(capi.allocator, body.written()),
    );

    return Result.unmountJSON(Items, capi.allocator, body.written());
}
