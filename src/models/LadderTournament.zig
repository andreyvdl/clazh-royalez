pub const LadderTournament = @This();

const GameMode = @import("GameMode.zig");
const SurvivalMilestoneReward = @import("SurvivalMilestoneReward.zig");

endTime: []const u8,
startTime: []const u8,
tag: []const u8,
title: []const u8,

freeTierRewards: []SurvivalMilestoneReward,
gameMode: GameMode,
milestoneRewards: []SurvivalMilestoneReward,
topRankReward: []SurvivalMilestoneReward,

maxLosses: i64,
maxTopRewardRank: i64,
minExpLevel: i64,
tournamentLevel: i64,
