const ClientError = @import("models/ClientError.zig");
const std = @import("std");

pub fn Result(comptime T: type) type {
    return union(enum) {
        success: std.json.Parsed(T),
        fail: std.json.Parsed(ClientError),

        pub fn deinit(r: *Result(T)) void {
            switch (r.*) {
                .success => |*t| t.deinit(),
                .fail => |*ce| ce.deinit(),
            }
        }
    };
}

pub fn Failed(comptime T: type, ce: std.json.Parsed(ClientError)) Result(T) {
    return Result(T){ .fail = ce };
}

pub fn Success(comptime T: type, parsed: std.json.Parsed(T)) Result(T) {
    return Result(T){ .success = parsed };
}

pub fn unmountJSON(
    comptime T: type,
    allocator: std.mem.Allocator,
    json: []const u8,
) !Result(T) {
    const parsed = try std.json.parseFromSlice(
        T,
        allocator,
        json,
        .{ .allocate = .alloc_always },
    );

    return Success(T, parsed);
}
