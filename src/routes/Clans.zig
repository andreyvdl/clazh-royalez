pub const Clans = @This();

const ClazhAPI = @import("../ClazhAPI.zig");
const Result = ClazhAPI.Result;
const ClientError = ClazhAPI.ClientError;
const Response = ClazhAPI.Response;
const ClansOptions = ClazhAPI.ClansOptions;
const Clan = ClazhAPI.Clan;
const ClanMember = ClazhAPI.ClanMember;
const ClanResponse = Response.Response(Clan);
const ClanMemberResponse = Response.Response(ClanMember);
const PagingOptions = ClazhAPI.PagingOptions;

const std = @import("std");

const route = "https://api.clashroyale.com/v1/clans";

/// Same as `/clans`
pub fn getClans(
    capi: *ClazhAPI,
    options: ClansOptions,
) !Result.Result(ClanResponse) {
    const url = try ClazhAPI.url.buildQuery(
        capi.gpa,
        ClansOptions,
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
            ClanResponse,
            try ClientError.fromJSON(capi.gpa, body.written()),
        );
    }

    return Result.unmountJSON(ClanResponse, capi.gpa, body.written());
}

/// Same as `/clans/{clanTag}`
pub fn getClanByTag(capi: *ClazhAPI, tag: []const u8) !Result.Result(Clan) {
    const base_url = route ++ "/";
    const modded_tag = try ClazhAPI.url.modTag(capi.gpa, tag);
    defer capi.gpa.free(modded_tag);
    const url = try std.mem.concat(capi.gpa, u8, &.{ base_url, modded_tag });
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
            Clan,
            try ClientError.fromJSON(capi.gpa, body.written()),
        );
    }

    return Result.unmountJSON(Clan, capi.gpa, body.written());
}

/// Same as `/clans/{clanTag}/members`
pub fn getClanMembers(
    capi: *ClazhAPI,
    tag: []const u8,
    opts: PagingOptions,
) !Result.Result(ClanMemberResponse) {
    const base_url = route ++ "/";
    const modded_tag = try ClazhAPI.url.modTag(capi.gpa, tag);
    defer capi.gpa.free(modded_tag);
    const url_tagged = try std.mem.concat(
        capi.gpa,
        u8,
        &.{ base_url, modded_tag, "/members" },
    );
    defer capi.gpa.free(url_tagged);
    const url = try ClazhAPI.url.buildQuery(
        capi.gpa,
        PagingOptions,
        opts,
        url_tagged,
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
            ClanMemberResponse,
            try ClientError.fromJSON(capi.gpa, body.written()),
        );
    }

    return Result.unmountJSON(ClanMemberResponse, capi.gpa, body.written());
}

/// Same as `/clans/{clanTag}/warlog`
/// Same as `/clans/{clanTag}/riverracelog`
/// Same as `/clans/{clanTag}/currentwar`
/// Same as `/clans/{clanTag}/currentriverrace`
pub fn voider() void {}
