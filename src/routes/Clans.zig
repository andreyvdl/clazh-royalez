pub const Clans = @This();

const ClazhAPI = @import("../ClazhAPI.zig");
const Result = ClazhAPI.Result;
const ClientError = ClazhAPI.ClientError;
const Response = ClazhAPI.Response;
const ClansOptions = ClazhAPI.ClansOptions;
const Clan = ClazhAPI.Clan;
const ClanMember = ClazhAPI.ClanMember;
const RiverRaceLogEntry = ClazhAPI.RiverRaceLogEntry;
const CurrentRiverRace = ClazhAPI.CurrentRiverRace;
const ClanResponse = Response.Response(Clan);
const ClanMemberResponse = Response.Response(ClanMember);
const RiverRaceLogEntryResponse = Response.Response(RiverRaceLogEntry);
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

    return try ClazhAPI.url.fetch(ClanResponse, capi, url, &body);
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

    return try ClazhAPI.url.fetch(Clan, capi, url, &body);
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

    return try ClazhAPI.url.fetch(ClanMemberResponse, capi, url, &body);
}

/// Same as `/clans/{clanTag}/riverracelog`
pub fn getClanRiverRaceLog(
    capi: *ClazhAPI,
    tag: []const u8,
    opts: PagingOptions,
) !Result.Result(RiverRaceLogEntryResponse) {
    const base_url = route ++ "/";
    const modded_tag = try ClazhAPI.url.modTag(capi.gpa, tag);
    defer capi.gpa.free(modded_tag);
    const url_tagged = try std.mem.concat(
        capi.gpa,
        u8,
        &.{ base_url, modded_tag, "/riverracelog" },
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

    return try ClazhAPI.url.fetch(
        RiverRaceLogEntryResponse,
        capi,
        url,
        &body,
    );
}

/// Same as `/clans/{clanTag}/currentriverrace`
pub fn getClanCurrentRiverRace(
    capi: *ClazhAPI,
    tag: []const u8,
) !Result.Result(CurrentRiverRace) {
    const base_url = route ++ "/";
    const modded_tag = try ClazhAPI.url.modTag(capi.gpa, tag);
    defer capi.gpa.free(modded_tag);
    const url = try std.mem.concat(
        capi.gpa,
        u8,
        &.{ base_url, modded_tag, "/currentriverrace" },
    );
    defer capi.gpa.free(url);
    var body = std.Io.Writer.Allocating.init(capi.gpa);
    defer body.deinit();

    return try ClazhAPI.url.fetch(CurrentRiverRace, capi, url, &body);
}

/// Same as `/clans/{clanTag}/warlog`
/// Same as `/clans/{clanTag}/currentwar`
/// None of these endpoints are active.
/// war log is temporary and currentwar is permanently returning 404.
fn @"void"() void {}
