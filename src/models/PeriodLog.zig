pub const PeriodLog = @This();

const PeriodLogEntry = @import("PeriodLogEntry.zig");

items: []PeriodLogEntry,

periodIndex: i64,
