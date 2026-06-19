pub const Cards = @This();

const ClazhAPI = @import("../ClazhAPI.zig");
const Result = ClazhAPI.Result;
const ItemList = ClazhAPI.ItemList;
const ClientError = ClazhAPI.ClientError;
const std = @import("std");

const route = "https://api.clashroyale.com/v1/cards";

/// Same as `/cards`
pub fn getCards(capi: *ClazhAPI) !Result.Result(ItemList) {
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
        ItemList,
        try ClientError.fromJSON(capi.gpa, body.written()),
    );

    return Result.unmountJSON(ItemList, capi.gpa, body.written());
}
