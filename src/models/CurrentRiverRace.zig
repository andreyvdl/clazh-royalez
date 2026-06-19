pub const CurrentRiverRace = @This();

const RiverRaceClan = @import("RiverRaceClan.zig");
const PeriodLog = @import("PeriodLog.zig");
const enums = @import("../enums.zig");
const RiverRaceState = enums.RiverRaceState;
const RiverRacePeriodType = enums.RiverRacePeriodType;

clan: RiverRaceClan,
clans: []RiverRaceClan,
periodLogs: []PeriodLog,
periodType: RiverRacePeriodType,
state: RiverRaceState,

collectionEndTime: []const u8,
warEndTime: []const u8,

periodIndex: i64,
sectionIndex: i64,
