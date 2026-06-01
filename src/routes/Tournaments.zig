pub const Tournaments = @This();

const ClazhAPI = @import("../ClazhAPI.zig");
const Result = ClazhAPI.Result;
const TournamentHeader = ClazhAPI.TournamentHeader;
const ClientError = ClazhAPI.ClientError;
const Response = ClazhAPI.Response;
const TournamentHeaderResponse = Response.Response(TournamentHeader);
const Tournament = ClazhAPI.Tournament;

const aux = @import("../aux.zig");
const std = @import("std");

const route = "https://api.clashroyale.com/v1/tournaments";
const query_route = route ++ "?name=";

/// Same as `/tournaments?name={name}[&limit=int&after=str&before=str]`
///
/// Name should be at least 3 characters long.
pub fn getTournaments(
    capi: *ClazhAPI,
    name: []const u8,
    limit: []const u8,
    after: []const u8,
    before: []const u8,
) !Result.Result(TournamentHeaderResponse) {
    const url = try aux.setupUrl(capi.allocator, name, limit, after, before);
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

    if (res.status != .ok) {
        return Result.Failed(
            TournamentHeaderResponse,
            try ClientError.fromJSON(capi.allocator, body.written()),
        );
    }

    return Result.unmountJSON(
        TournamentHeaderResponse,
        capi.allocator,
        body.written(),
    );
}

/// Same as `/tournaments/{tournamentTag}`
pub fn getTournamentFromTag(
    capi: *ClazhAPI,
    tag: []const u8,
) !Result.Result(Tournament) {
    const modded_tag = try aux.modTag(capi.allocator, tag);
    defer capi.allocator.free(modded_tag);
    const url = try std.mem.concat(capi.allocator, u8, &.{ route, "/", modded_tag });
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

    if (res.status != .ok) {
        return Result.Failed(
            Tournament,
            try ClientError.fromJSON(capi.allocator, body.written()),
        );
    }

    return Result.unmountJSON(
        Tournament,
        capi.allocator,
        body.written(),
    );
}
