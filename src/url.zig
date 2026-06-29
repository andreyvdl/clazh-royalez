const std = @import("std");

pub fn modTag(allocator: std.mem.Allocator, tag: []const u8) ![]const u8 {
    if (tag[0] == '#') {
        return try std.mem.concat(allocator, u8, &.{ "%23", tag[1..] });
    } else {
        return try std.mem.concat(allocator, u8, &.{ "%23", tag });
    }
    return error.InvalidTag;
}

const map = std.StaticStringMap([]const u8).initComptime(.{
    .{ "location_id", "locationId" },
    .{ "min_members", "minMembers" },
    .{ "max_members", "maxMembers" },
    .{ "min_score", "minScore" },
});

pub fn buildQuery(
    allocator: std.mem.Allocator,
    comptime OptionsType: type,
    options: OptionsType,
    url: []const u8,
) ![]const u8 {
    const query_marker = '?';
    const and_marker = '&';
    var first = true;
    var buf = std.ArrayList(u8).empty;
    defer buf.deinit(allocator);

    try buf.appendSlice(allocator, url);

    inline for (comptime std.meta.fieldNames(OptionsType)) |field| {
        const value = @field(options, field);

        if (value.len > 0) {
            if (first) {
                try buf.append(allocator, query_marker);
                first = false;
            } else {
                try buf.append(allocator, and_marker);
            }
            try buf.appendSlice(
                allocator,
                map.get(field) orelse field,
            );
            try buf.append(allocator, '=');
            try buf.appendSlice(allocator, value);
        }
    }

    return try buf.toOwnedSlice(allocator);
}

const ClazhAPI = @import("ClazhAPI.zig");
const Result = ClazhAPI.Result;
const ClientError = ClazhAPI.ClientError;

pub fn fetch(
    comptime T: type,
    capi: *ClazhAPI,
    url: []const u8,
    body: *std.Io.Writer.Allocating,
) !Result.Result(T) {
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
            T,
            try ClientError.fromJSON(capi.gpa, body.written()),
        );
    }

    return Result.unmountJSON(T, capi.gpa, body.written());
}
