pub const Tournaments = @This();

const ClazhAPI = @import("../ClazhAPI.zig");
const Result = ClazhAPI.Result;
const TournamentHeader = ClazhAPI.TournamentHeader;
const ClientError = ClazhAPI.ClientError;
const Response = ClazhAPI.Response;
const TournamentHeaderResponse = Response.Response(TournamentHeader);
const Tournament = ClazhAPI.Tournament;
const TournamentsOptions = ClazhAPI.TournamentsOptions;

const std = @import("std");

const route = "https://api.clashroyale.com/v1/tournaments";

/// Same as `/tournaments?name={name}[&limit=int&after=str&before=str]`
pub fn getTournaments(
    capi: *ClazhAPI,
    options: TournamentsOptions,
) !Result.Result(TournamentHeaderResponse) {
    const url = try ClazhAPI.url.buildQuery(
        capi.gpa,
        TournamentsOptions,
        options,
        route,
    );
    defer capi.gpa.free(url);
    var body = std.Io.Writer.Allocating.init(capi.gpa);
    defer body.deinit();

    return try ClazhAPI.url.fetch(TournamentHeaderResponse, capi, url, &body);
}

/// Same as `/tournaments/{tournamentTag}`
pub fn getTournamentFromTag(
    capi: *ClazhAPI,
    tag: []const u8,
) !Result.Result(Tournament) {
    const modded_tag = try ClazhAPI.url.modTag(capi.gpa, tag);
    defer capi.gpa.free(modded_tag);
    const url = try std.mem.concat(capi.gpa, u8, &.{ route, "/", modded_tag });
    defer capi.gpa.free(url);
    var body = std.Io.Writer.Allocating.init(capi.gpa);
    defer body.deinit();

    return try ClazhAPI.url.fetch(Tournament, capi, url, &body);
}
