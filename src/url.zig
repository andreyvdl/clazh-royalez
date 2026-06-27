const std = @import("std");

pub fn modTag(allocator: std.mem.Allocator, tag: []const u8) ![]const u8 {
    if (tag[0] == '#') {
        return try std.mem.concat(allocator, u8, &.{ "%23", tag[1..] });
    } else {
        return try std.mem.concat(allocator, u8, &.{ "%23", tag });
    }
    return error.InvalidTag;
}

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
                QueryField.snakeCase2CamelCase(field),
            );
            try buf.append(allocator, '=');
            try buf.appendSlice(allocator, value);
        }
    }

    return try buf.toOwnedSlice(allocator);
}

pub const QueryField = enum {
    locationId,
    minMembers,
    maxMembers,
    minScore,
    name,
    limit,
    after,
    before,

    pub fn snakeCase2CamelCase(comptime str: []const u8) []const u8 {
        const strs = [_][]const u8{
            "location_id",
            "min_members",
            "max_members",
            "min_score",
            "name",
            "limit",
            "after",
            "before",
            "",
        };

        for (0..strs.len) |i| {
            if (std.mem.eql(u8, str, strs[i])) {
                return @typeInfo(@This()).@"enum".fields[i].name;
            }
        }
        return strs[strs.len - 1];
    }
};
