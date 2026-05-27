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

tag: []const u8,
name: []const u8,
expLevel: i64,
trophies: i64,
bestTrophies: i64,
wins: i64,
losses: i64,
battleCount: i64,
threeCrownWins: i64,
challengeCardsWon: i64,
challengeMaxWins: i64,
tournamentCardsWon: i64,
tournamentBattleCount: i64,
currentWinLoseStreak: i64,
donations: i64,
donationsReceived: i64,
totalDonations: i64,
warDayWins: i64,
clanCardsCollected: i64,
arena: Arena,
badges: []PlayerAchievementBadge,
achievements: []PlayerAchievementProgress,
cards: []PlayerItemLevel,
supportCards: []PlayerItemLevel,
currentDeck: []PlayerItemLevel,
currentDeckSupportCards: []PlayerItemLevel,
currentFavouriteCard: Item,
starPoints: i64,
expPoints: i64,
/// Anon object
///
/// Contains info about the player's progress in game modes, but is not a
/// structured object.
///
/// If you want to use it, get the names from `progress.object.keys()`.
progress: std.json.Value,
totalExpPoints: i64,

clan: ?PlayerClan = null,
leagueStatistics: ?PlayerLeagueStatistics = null,
role: ?Role = null,
legacyTrophyRoadHighScore: ?i64 = null,
currentPathOfLegendSeasonResult: ?PathOfLegendSeasonResult = null,
lastPathOfLegendSeasonResult: ?PathOfLegendSeasonResult = null,
bestPathOfLegendSeasonResult: ?PathOfLegendSeasonResult = null,
