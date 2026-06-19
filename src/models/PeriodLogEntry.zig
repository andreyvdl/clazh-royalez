pub const PeriodLogEntry = @This();

const PeriodLogEntryClan = @import("PeriodLogEntryClan.zig");

clan: PeriodLogEntryClan,

endOfDayRank: i64,
numOfDefensesRemaining: i64,
pointsEarned: i64,
progressEarned: i64,
progressEarnedFromDefenses: i64,
progressEndOfDay: i64,
progressStartOfDay: i64,
