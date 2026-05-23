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

const std = @import("std");

achievements: []PlayerAchievementProgress,
arena: Arena,
badges: []PlayerAchievementBadge,
battle_count: i32,
best_path_of_legend_season_result: PathOfLegendSeasonResult,
best_trophies: i32,
cards: []PlayerItemLevel,
challenge_cards_won: i32,
challenge_max_wins: i32,
clan: PlayerClan,
clan_cards_collected: i32,
current_deck: []PlayerItemLevel,
current_deck_support_cards: []PlayerItemLevel,
current_favourite_card: Item,
current_path_of_legend_season_result: PathOfLegendSeasonResult,
current_win_lose_streak: i32,
donations: i32,
donations_received: i32,
exp_level: i32,
exp_points: i32,
last_path_of_legend_season_result: PathOfLegendSeasonResult,
league_statistics: PlayerLeagueStatistics,
legacy_trophy_road_high_score: i32,
losses: i32,
name: []const u8,
// TODO! @ Progress.zig
progress: std.json.Value = .null,
role: Role,
star_points: i32,
support_cards: []PlayerItemLevel,
tag: []const u8,
three_crown_wins: i32,
total_donations: i32,
total_exp_points: i32,
tournament_battle_count: i32,
tournament_cards_won: i32,
trophies: i32,
war_day_wins: i32,
wins: i32,
