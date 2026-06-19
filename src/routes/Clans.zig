pub const Clans = @This();

const ClazhAPI = @import("../ClazhAPI.zig");
const Result = ClazhAPI.Result;
const ClientError = ClazhAPI.ClientError;
const Response = ClazhAPI.Response;
const ClansOptions = ClazhAPI.ClansOptions;
const Clan = ClazhAPI.Clan;
const ClanResponse = Response.Response(Clan);

const std = @import("std");

/// Same as `/clans/{clanTag}/warlog`
/// Same as `/clans`
pub fn getClans(
    capi: *ClazhAPI,
    options: ClansOptions,
) !Result.Result(ClanResponse) {
    const url = try setupUrl(capi.gpa, options);
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

/// Same as `/clans/{clanTag}/riverracelog`
/// Same as `/clans/{clanTag}/currentwar`
/// Same as `/clans/{clanTag}`
/// Same as `/clans/{clanTag}/members`
/// Same as `/clans/{clanTag}/currentriverrace`
pub fn voider() void {}

const route = "https://api.clashroyale.com/v1/clans?";

fn setupUrl(
    allocator: std.mem.Allocator,
    options: ClansOptions,
) ![]const u8 {
    const mh = options.must_have;
    const op = options.optional;
    const n = "&name=";
    const lid = "&locationId=";
    const min = "&minMembers=";
    const max = "&maxMembers=";
    const s = "&minScore=";
    const l = "&limit=";
    const a = "&after=";
    const b = "&before=";
    var buf = std.ArrayList(u8).empty;
    defer buf.deinit(allocator);
    var first = true;

    try buf.appendSlice(allocator, route);

    if (mh.name.len > 0) {
        if (first) {
            try buf.appendSlice(allocator, n[1..]);
            first = false;
        } else {
            try buf.appendSlice(allocator, n);
        }
        try buf.appendSlice(allocator, mh.name);
    }
    if (mh.location_id.len > 0) {
        if (first) {
            try buf.appendSlice(allocator, lid[1..]);
            first = false;
        } else {
            try buf.appendSlice(allocator, lid);
        }
        try buf.appendSlice(allocator, mh.location_id);
    }
    if (mh.max_members.len > 0) {
        if (first) {
            try buf.appendSlice(allocator, max[1..]);
            first = false;
        } else {
            try buf.appendSlice(allocator, max);
        }
        try buf.appendSlice(allocator, mh.max_members);
    }
    if (mh.min_members.len > 0) {
        if (first) {
            try buf.appendSlice(allocator, min[1..]);
            first = false;
        } else {
            try buf.appendSlice(allocator, min);
        }
        try buf.appendSlice(allocator, mh.min_members);
    }
    if (mh.min_score.len > 0) {
        if (first) {
            try buf.appendSlice(allocator, s[1..]);
            first = false;
        } else {
            try buf.appendSlice(allocator, s);
        }
        try buf.appendSlice(allocator, mh.min_score);
    }

    if (op.limit.len != 0) {
        try buf.appendSlice(allocator, l);
        try buf.appendSlice(allocator, op.limit);
    }
    if (op.after.len != 0) {
        try buf.appendSlice(allocator, a);
        try buf.appendSlice(allocator, op.after);
    }
    if (op.before.len != 0) {
        try buf.appendSlice(allocator, b);
        try buf.appendSlice(allocator, op.before);
    }
    return try buf.toOwnedSlice(allocator);
}
