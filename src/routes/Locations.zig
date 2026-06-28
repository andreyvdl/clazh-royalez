pub const Locations = @This();

const ClazhAPI = @import("../ClazhAPI.zig");
const PagingOptions = ClazhAPI.PagingOptions;
const Response = ClazhAPI.Response;
const Result = ClazhAPI.Result;
const Location = ClazhAPI.Location;
const PlayerRanking = ClazhAPI.PlayerRanking;
const ClanRanking = ClazhAPI.ClanRanking;
const PlayerPathOfLegendRanking = ClazhAPI.PlayerPathOfLegendRanking;
const LeagueSeason = ClazhAPI.LeagueSeason;
const LocationResponse = Response.Response(Location);
const PlayerRankingResponse = Response.Response(PlayerRanking);
const ClanRankingResponse = Response.Response(ClanRanking);
const PlayerPathOfLegendRankingResponse =
    Response.Response(PlayerPathOfLegendRanking);
const LeagueSeasonResponse = Response.Response(LeagueSeason);
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

/// Same as `/locations/{locationId}/rankings/clanwars`
///
/// Seems to work best when used with country location IDs.
pub fn getClanWarsRankingsByLocation(
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
            "/rankings/clanwars",
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

/// Same as `/locations/{locationId}/pathoflegend/players`
///
/// Seems to work best when used with country location IDs.
pub fn getPlayersPathOfLegendRankingsByLocation(
    capi: *ClazhAPI,
    location_id: []const u8,
    options: PagingOptions,
) !Result.Result(PlayerPathOfLegendRankingResponse) {
    const base_url = try std.mem.concat(
        capi.gpa,
        u8,
        &.{
            route,
            "/",
            location_id,
            "/pathoflegend/players",
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
            PlayerPathOfLegendRankingResponse,
            try ClientError.fromJSON(capi.gpa, body.written()),
        );
    }

    return Result.unmountJSON(
        PlayerPathOfLegendRankingResponse,
        capi.gpa,
        body.written(),
    );
}

/// Same as `/locations/global/seasons`
pub fn getGlobalSeasonsV1(
    capi: *ClazhAPI,
) !Result.Result(LeagueSeasonResponse) {
    const url = try std.mem.concat(
        capi.gpa,
        u8,
        &.{ route, "/global/seasons" },
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
            LeagueSeasonResponse,
            try ClientError.fromJSON(capi.gpa, body.written()),
        );
    }

    return Result.unmountJSON(LeagueSeasonResponse, capi.gpa, body.written());
}

/// Same as `/locations/global/seasonsV2`
///
/// This route only returns null values, use V1 instead.
pub fn getGlobalSeasonsV2(
    capi: *ClazhAPI,
) !Result.Result(LeagueSeasonResponse) {
    const url = try std.mem.concat(
        capi.gpa,
        u8,
        &.{ route, "/global/seasonsV2" },
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
            LeagueSeasonResponse,
            try ClientError.fromJSON(capi.gpa, body.written()),
        );
    }

    return Result.unmountJSON(LeagueSeasonResponse, capi.gpa, body.written());
}

/// Same as `/locations/global/seasons/{seasonId}`
///
/// Returned season is in V1 style.
pub fn getSeasonBySeasonId(
    capi: *ClazhAPI,
    season_id: []const u8,
) !Result.Result(LeagueSeason) {
    const url = try std.mem.concat(
        capi.gpa,
        u8,
        &.{ route, "/global/seasons/", season_id },
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
            LeagueSeason,
            try ClientError.fromJSON(capi.gpa, body.written()),
        );
    }

    return Result.unmountJSON(LeagueSeason, capi.gpa, body.written());
}

/// Same as `/locations/global/pathoflegend/{seasonId}/rankings/players`
pub fn getPlayersPathOfLegendRankingsBySeasonId(
    capi: *ClazhAPI,
    season_id: []const u8,
    options: PagingOptions,
) !Result.Result(PlayerPathOfLegendRankingResponse) {
    const base_url = try std.mem.concat(
        capi.gpa,
        u8,
        &.{
            route,
            "/global/pathoflegend/",
            season_id,
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
            PlayerPathOfLegendRankingResponse,
            try ClientError.fromJSON(capi.gpa, body.written()),
        );
    }

    return Result.unmountJSON(
        PlayerPathOfLegendRankingResponse,
        capi.gpa,
        body.written(),
    );
}

/// Same as `/locations/global/seasons/{seasonId}/rankings/players`
pub fn getPlayersSeasonRankingsBySeasonId(
    capi: *ClazhAPI,
    season_id: []const u8,
    options: PagingOptions,
) !Result.Result(PlayerRankingResponse) {
    const base_url = try std.mem.concat(
        capi.gpa,
        u8,
        &.{
            route,
            "/global/seasons/",
            season_id,
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

/// Same as `/locations/global/rankings/tournaments/{tournamentTag}`
fn @"void"() void {}
