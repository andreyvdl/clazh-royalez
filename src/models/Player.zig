pub const Player = @This();

const PlayerClan = @import("PlayerClan.zig");
const PlayerItemLevel = @import("PlayerItemLevel.zig");
const Arena = @import("Arena.zig");
const Role = @import("../enums.zig").Role;
const PlayerLeagueStatistics = @import("PlayerLeagueStatistics.zig");
const Item = @import("Item.zig");
const PlayerAchievementBadge = @import("PlayerAchievementBadge.zig");
const PlayerAchievementProgress = @import("PlayerAchievementProgress.zig");
const PathOfLegendSeasonResult = @import("PathOfLegendSeasonResult.zig");
const Result = @import("../Result.zig").Result;

const std = @import("std");

achievements: []PlayerAchievementProgress,
arena: Arena,
badges: []PlayerAchievementBadge,
bestPathOfLegendSeasonResult: ?PathOfLegendSeasonResult = null,
cards: []PlayerItemLevel,
clan: ?PlayerClan = null,
currentDeck: []PlayerItemLevel,
currentDeckSupportCards: []PlayerItemLevel,
currentPathOfLegendSeasonResult: ?PathOfLegendSeasonResult = null,
currentFavouriteCard: Item,
lastPathOfLegendSeasonResult: ?PathOfLegendSeasonResult = null,
leagueStatistics: ?PlayerLeagueStatistics = null,
role: ?Role = null,
supportCards: []PlayerItemLevel,

battleCount: i64,
bestTrophies: i64,
challengeCardsWon: i64,
challengeMaxWins: i64,
clanCardsCollected: i64,
currentWinLoseStreak: i64,
donations: i64,
donationsReceived: i64,
expLevel: i64,
expPoints: i64,
legacyTrophyRoadHighScore: ?i64 = null,
losses: i64,
starPoints: i64,
threeCrownWins: i64,
totalDonations: i64,
totalExpPoints: i64,
tournamentBattleCount: i64,
tournamentCardsWon: i64,
trophies: i64,
warDayWins: i64,
wins: i64,

name: []const u8,
tag: []const u8,

/// Anon object
///
/// Contains info about the player's progress in game modes, but is not a
/// structured object.
///
/// If you want to use it, get the names from `progress.object.keys()`.
progress: std.json.Value,
