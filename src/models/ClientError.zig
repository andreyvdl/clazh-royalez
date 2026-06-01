pub const ClientError = @This();

message: []const u8,
reason: []const u8,
type: ?[]const u8 = null,

const std = @import("std");

/// User responsible for freeing.
pub fn toString(
    ce: *const ClientError,
    allocator: std.mem.Allocator,
) ![]const u8 {
    return try std.fmt.allocPrint(
        allocator,
        "reason: {s},\nmsg: {s},\ntype: {any}\n",
        .{
            ce.reason, ce.message, ce.type,
        },
    );
}

pub fn make(
    reason: []const u8,
    message: []const u8,
    @"type": ?[]const u8,
) ClientError {
    return .{
        .reason = reason,
        .message = message,
        .type = @"type",
    };
}

pub fn fromJSON(
    allocator: std.mem.Allocator,
    json: []const u8,
) !std.json.Parsed(ClientError) {
    const parsed = try std.json.parseFromSlice(
        ClientError,
        allocator,
        json,
        .{ .allocate = .alloc_always },
    );

    return parsed;
}
