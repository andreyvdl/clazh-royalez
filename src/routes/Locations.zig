pub const Locations = @This();

const ClazhAPI = @import("../ClazhAPI.zig");
const PagingOptions = ClazhAPI.PagingOptions;
const Response = ClazhAPI.Response;
const Result = ClazhAPI.Result;
const Location = ClazhAPI.Location;
const PlayerRanking = ClazhAPI.PlayerRanking;
const ClanRanking = ClazhAPI.ClanRanking;
const LocationResponse = Response.Response(Location);
const PlayerRankingResponse = Response.Response(PlayerRanking);
const ClanRankingResponse = Response.Response(ClanRanking);
const ClientError = ClazhAPI.ClientError;
const std = @import("std");

const route = "https://api.clashroyale.com/v1/locations";

/// Same as `/locations`
pub fn getLocations(
    capi: *ClazhAPI,
    options: PagingOptions,
) !Result.Result(LocationResponse) {
    const url = try ClazhAPI.url.buildQuery(
        capi.gpa,
        PagingOptions,
        options,
        route,
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
            LocationResponse,
            try ClientError.fromJSON(capi.gpa, body.written()),
        );
    }

    return Result.unmountJSON(LocationResponse, capi.gpa, body.written());
}

/// Same as `/locations/{locationId}`
pub fn getLocationById(
    capi: *ClazhAPI,
    location_id: []const u8,
) !Result.Result(Location) {
    const url = try std.mem.concat(capi.gpa, u8, &.{ route, "/", location_id });
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
            Location,
            try ClientError.fromJSON(capi.gpa, body.written()),
        );
    }

    return Result.unmountJSON(Location, capi.gpa, body.written());
}

/// Same as `/locations/{locationId}/rankings/players`
///
/// Seems to work best when used with country location IDs.
pub fn getPlayersRankingsByLocation(
    capi: *ClazhAPI,
    location_id: []const u8,
    options: PagingOptions,
) !Result.Result(PlayerRankingResponse) {
    const base_url = try std.mem.concat(
        capi.gpa,
        u8,
        &.{
            route,
            "/",
            location_id,
            "/rankings/players",
        },
    );
    defer capi.gpa.free(base_url);
    const url = try ClazhAPI.url.buildQuery(
        capi.gpa,
        PagingOptions,
        options,
        base_url,
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
            PlayerRankingResponse,
            try ClientError.fromJSON(capi.gpa, body.written()),
        );
    }

    return Result.unmountJSON(
        PlayerRankingResponse,
        capi.gpa,
        body.written(),
    );
}

/// Same as `/locations/{locationId}/rankings/clans`
pub fn getClansRankingsByLocation(
    capi: *ClazhAPI,
    location_id: []const u8,
    options: PagingOptions,
) !Result.Result(ClanRankingResponse) {
    const base_url = try std.mem.concat(
        capi.gpa,
        u8,
        &.{
            route,
            "/",
            location_id,
            "/rankings/clans",
        },
    );
    defer capi.gpa.free(base_url);
    const url = try ClazhAPI.url.buildQuery(
        capi.gpa,
        PagingOptions,
        options,
        base_url,
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
            ClanRankingResponse,
            try ClientError.fromJSON(capi.gpa, body.written()),
        );
    }

    return Result.unmountJSON(
        ClanRankingResponse,
        capi.gpa,
        body.written(),
    );
}

/// Same as `/locations/global/pathoflegend/{seasonId}/rankings/players`
/// Same as `/locations/global/rankings/tournaments/{tournamentTag}`
/// Same as `/locations/global/seasons/{seasonId}/rankings/players`
/// Same as `/locations/global/seasons/{seasonId}`
/// Same as `/locations/global/seasonsV2`
/// Same as `/locations/global/seasons`
/// Same as `/locations/{locationId}/pathoflegend/players`
/// Same as `/locations/{locationId}/rankings/clanwars`
fn @"void"() void {}
