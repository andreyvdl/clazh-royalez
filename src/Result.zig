const ClientError = @import("models/ClientError.zig");

pub fn Result(comptime T: type) type {
    return union(enum) {
        success: T,
        fail: ClientError,
    };
}

pub fn Failed(comptime T: type, ce: ClientError) Result(T) {
    return Result(T){ .fail = ce };
}

pub fn Success(comptime T: type, value: T) Result(T) {
    return Result(T){ .success = value };
}

const std = @import("std");

pub fn unmountJSON(comptime T: type, allocator: std.mem.Allocator, json: []const u8) Result(T) {
    const parsed = std.json.parseFromSlice(T, allocator, json, .{}) catch {
        return Failed(T, ClientError.make("Out of memory", "Not enough memory", "OutOfMemory"));
    };

    defer parsed.deinit();
    return Success(T, parsed.value);
}
