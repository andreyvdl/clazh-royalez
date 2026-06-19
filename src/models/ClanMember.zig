pub const ClanMember = @This();

const Arena = @import("Arena.zig");

const enums = @import("../enums.zig");
const Role = enums.Role;

arena: Arena,
role: Role,

clanChestPoints: i64,
clanRank: i64,
donations: i64,
donationsReceived: i64,
expLevel: i64,
previousClanRank: i64,
trophies: i64,

lastSeen: []const u8,
name: []const u8,
tag: []const u8,
