pub const RiverRaceClan = @This();

const RiverRaceParticipant = @import("RiverRaceParticipant.zig");

badgeId: i64,
clanScore: i64,
fame: i64,
periodPoints: i64,
repairPoints: i64,

finishTime: ?[]const u8 = null,
name: []const u8,
tag: []const u8,

participants: []RiverRaceParticipant,
