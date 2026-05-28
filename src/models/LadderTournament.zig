pub const LadderTournament = @This();

const GameMode = @import("GameMode.zig");
const SurvivalMilestoneReward = @import("SurvivalMilestoneReward.zig");

maxLosses: i64,
gameMode: GameMode,
minExpLevel: i64,
tournamentLevel: i64,
milestoneRewards: []SurvivalMilestoneReward,
freeTierRewards: []SurvivalMilestoneReward,
tag: []const u8,
title: []const u8,
startTime: []const u8,
endTime: []const u8,
topRankReward: []SurvivalMilestoneReward,
maxTopRewardRank: i64,
