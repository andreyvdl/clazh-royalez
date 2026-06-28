pub const Clan = @This();

const ClanMember = @import("ClanMember.zig");
const Location = @import("Location.zig");

const enums = @import("../enums.zig");
const ClanChestStatus = enums.ClanChestStatus;
const ClanType = enums.ClanType;

const std = @import("std");

badgeId: i64,
clanChestLevel: i64,
clanChestMaxLevel: i64,
clanChestPoints: ?i64 = null,
clanScore: i64,
clanWarTrophies: i64,
donationsPerWeek: i64,
members: i64,
requiredTrophies: i64,

clanChestStatus: ?ClanChestStatus = null,
location: Location,
memberList: ?[]ClanMember = null,
type: ClanType,

description: ?[]const u8 = null,
name: []const u8,
tag: []const u8,
