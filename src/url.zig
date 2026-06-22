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
    OptionsType: type,
    options: OptionsType,
    url: []const u8,
) ![]const u8 {
    const query_marker = '?';
    const and_marker = '&';
    var buf = std.ArrayList(u8).empty;
    defer buf.deinit(allocator);
    var first = true;

    try buf.appendSlice(allocator, url);

    if (@hasField(OptionsType, "name") and options.name.len > 0) {
        if (first) {
            try buf.append(allocator, query_marker);
            first = false;
        } else {
            try buf.append(allocator, and_marker);
        }
        try buf.appendSlice(allocator, "name=");
        try buf.appendSlice(allocator, options.name);
    }

    if (@hasField(OptionsType, "limit") and options.limit.len > 0) {
        if (first) {
            try buf.append(allocator, query_marker);
            first = false;
        } else {
            try buf.append(allocator, and_marker);
        }
        try buf.appendSlice(allocator, "limit=");
        try buf.appendSlice(allocator, options.limit);
    }

    if (@hasField(OptionsType, "after") and options.after.len > 0) {
        if (first) {
            try buf.append(allocator, query_marker);
            first = false;
        } else {
            try buf.append(allocator, and_marker);
        }
        try buf.appendSlice(allocator, "after=");
        try buf.appendSlice(allocator, options.after);
    }

    if (@hasField(OptionsType, "before") and options.before.len > 0) {
        if (first) {
            try buf.append(allocator, query_marker);
            first = false;
        } else {
            try buf.append(allocator, and_marker);
        }
        try buf.appendSlice(allocator, "before=");
        try buf.appendSlice(allocator, options.before);
    }

    if (@hasField(OptionsType, "location_id") and options.location_id.len > 0) {
        if (first) {
            try buf.append(allocator, query_marker);
            first = false;
        } else {
            try buf.append(allocator, and_marker);
        }
        try buf.appendSlice(allocator, "locationId=");
        try buf.appendSlice(allocator, options.location_id);
    }

    if (@hasField(OptionsType, "min_members") and options.min_members.len > 0) {
        if (first) {
            try buf.append(allocator, query_marker);
            first = false;
        } else {
            try buf.append(allocator, and_marker);
        }
        try buf.appendSlice(allocator, "minMembers=");
        try buf.appendSlice(allocator, options.min_members);
    }

    if (@hasField(OptionsType, "max_members") and options.max_members.len > 0) {
        if (first) {
            try buf.append(allocator, query_marker);
            first = false;
        } else {
            try buf.append(allocator, and_marker);
        }
        try buf.appendSlice(allocator, "maxMembers=");
        try buf.appendSlice(allocator, options.max_members);
    }

    if (@hasField(OptionsType, "min_score") and options.min_score.len > 0) {
        if (first) {
            try buf.append(allocator, query_marker);
            first = false;
        } else {
            try buf.append(allocator, and_marker);
        }
        try buf.appendSlice(allocator, "minScore=");
        try buf.appendSlice(allocator, options.min_score);
    }

    return try buf.toOwnedSlice(allocator);
}
