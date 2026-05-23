pub const ClientError = @This();

reason: []const u8 = undefined,
message: []const u8 = undefined,
type: []const u8 = undefined,

const std = @import("std");

/// User responsible for freeing.
pub fn toString(ce: *const ClientError, allocator: std.mem.Allocator) []const u8 {
    return std.fmt.allocPrint(allocator, "reason: {s},\nmsg: {s},\ntype: {s}\n", .{ ce.reason, ce.message, ce.type }) catch {
        return "Out of memory";
    };
}

pub fn make(reason: []const u8, message: []const u8, @"type": []const u8) ClientError {
    return .{
        .reason = reason,
        .message = message,
        .type = @"type",
    };
}

pub fn fromJSON(allocator: std.mem.Allocator, json: []const u8) ClientError {
    const parsed = std.json.parseFromSlice(ClientError, allocator, json, .{}) catch {
        return make("Out of memory", "Not enough memory", "OutOfMemory");
    };

    defer parsed.deinit();

    return make(parsed.value.reason, parsed.value.message, parsed.value.type);
}
