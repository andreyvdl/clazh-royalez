pub const RiverRaceLogEntry = @This();

const RiverRaceStanding = @import("RiverRaceStanding.zig");

createdDate: []const u8,

seasonId: i64,
sectionIndex: i64,

standings: []RiverRaceStanding,
