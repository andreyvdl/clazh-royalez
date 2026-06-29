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

    return try ClazhAPI.url.fetch(ItemList, capi, route, &body);
}
