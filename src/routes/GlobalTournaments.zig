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
    var body = std.Io.Writer.Allocating.init(capi.gpa);
    defer body.deinit();

    return try ClazhAPI.url.fetch(LadderTournamentList, capi, route, &body);
}
