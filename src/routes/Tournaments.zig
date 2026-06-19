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
///
/// Name should be at least 3 characters long.
pub fn getTournaments(
    capi: *ClazhAPI,
    options: TournamentsOptions,
) !Result.Result(TournamentHeaderResponse) {
    const url = try setupUrl(
        capi.gpa,
        options.must_have.name,
        options.optional.limit,
        options.optional.after,
        options.optional.before,
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
            TournamentHeaderResponse,
            try ClientError.fromJSON(capi.gpa, body.written()),
        );
    }

    return Result.unmountJSON(
        TournamentHeaderResponse,
        capi.gpa,
        body.written(),
    );
}

/// Same as `/tournaments/{tournamentTag}`
pub fn getTournamentFromTag(
    capi: *ClazhAPI,
    tag: []const u8,
) !Result.Result(Tournament) {
    const modded_tag = try modTag(capi.gpa, tag);
    defer capi.gpa.free(modded_tag);
    const url = try std.mem.concat(capi.gpa, u8, &.{ route, "/", modded_tag });
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
            Tournament,
            try ClientError.fromJSON(capi.gpa, body.written()),
        );
    }

    return Result.unmountJSON(
        Tournament,
        capi.gpa,
        body.written(),
    );
}

const query_route = "https://api.clashroyale.com/v1/tournaments?name=";

pub fn setupUrl(
    allocator: std.mem.Allocator,
    name: []const u8,
    limit: []const u8,
    after: []const u8,
    before: []const u8,
) ![]const u8 {
    const l = "&limit=";
    const a = "&after=";
    const b = "&before=";

    var buf = std.ArrayList(u8).empty;
    defer buf.deinit(allocator);

    try buf.appendSlice(allocator, query_route);
    try buf.appendSlice(allocator, name);
    if (limit.len != 0) {
        try buf.appendSlice(allocator, l);
        try buf.appendSlice(allocator, limit);
    }
    if (after.len != 0) {
        try buf.appendSlice(allocator, a);
        try buf.appendSlice(allocator, after);
    }
    if (before.len != 0) {
        try buf.appendSlice(allocator, b);
        try buf.appendSlice(allocator, before);
    }
    return buf.toOwnedSlice(allocator);
}

const hashtag = "%23";

pub fn modTag(allocator: std.mem.Allocator, tag: []const u8) ![]const u8 {
    if (tag[0] == '#') {
        return try std.mem.concat(allocator, u8, &.{ hashtag, tag[1..] });
    } else if (std.ascii.isAlphanumeric(tag[0])) {
        return try std.mem.concat(allocator, u8, &.{ hashtag, tag });
    }
    return error.InvalidTag;
}
