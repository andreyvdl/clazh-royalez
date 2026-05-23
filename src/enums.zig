pub const enums = @This();

const std = @import("std");

pub const Rarity = enum {
    common,
    rare,
    epic,
    legendary,
    champion,

    pub fn fromString(str: []const u8) ?Rarity {
        return std.meta.stringToEnum(Rarity, str);
    }

    pub fn toString(value: Rarity) []const u8 {
        return @tagName(value);
    }
};

pub const Role = enum {
    not_member,
    /// TODO! Check if the api returns with/out underline
    // @"not member",
    member,
    leader,
    admin,
    coleader,

    pub fn fromString(str: []const u8) ?Role {
        return std.meta.stringToEnum(Role, str);
    }

    pub fn toString(value: Role) []const u8 {
        return @tagName(value);
    }
};
