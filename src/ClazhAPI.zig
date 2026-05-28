const ClazhAPI = @This();
const std = @import("std");
const mem = std.mem;
const http = std.http;

pub const Arena = @import("models/Arena.zig");
pub const Battle = @import("models/Battle.zig");
pub const BattleRound = @import("models/BattleRound.zig");
pub const Chest = @import("models/Chest.zig");
pub const ClientError = @import("models/ClientError.zig");
pub const GameMode = @import("models/GameMode.zig");
pub const IconUrls = @import("models/IconUrls.zig");
pub const Item = @import("models/Item.zig");
pub const ItemList = @import("models/ItemList.zig");
pub const LadderTournament = @import("models/LadderTournament.zig");
pub const LadderTournamentList = @import("models/LadderTournamentList.zig");
pub const LeagueSeasonResult = @import("models/LeagueSeasonResult.zig");
pub const PathOfLegendSeasonResult =
    @import("models/PathOfLegendSeasonResult.zig");
pub const Player = @import("models/Player.zig");
pub const PlayerAchievementBadge =
    @import("models/PlayerAchievementBadge.zig");
pub const PlayerAchievementProgress =
    @import("models/PlayerAchievementProgress.zig");
pub const PlayerBattleAugment = @import("models/PlayerBattleAugment.zig");
pub const PlayerBattleData = @import("models/PlayerBattleData.zig");
pub const PlayerClan = @import("models/PlayerClan.zig");
pub const PlayerItemLevel = @import("models/PlayerItemLevel.zig");
pub const PlayerLeagueStatistics =
    @import("models/PlayerLeagueStatistics.zig");
pub const TrailEvent = @import("models/TrailEvent.zig");
pub const UpcomingChests = @import("models/UpcomingChests.zig");

pub const Result = @import("Result.zig");

const enums = @import("enums.zig");
pub const BattleType = enums.BattleType;
pub const DeckSelection = enums.DeckSelection;
pub const ItemType = enums.ItemType;
pub const Rarity = enums.Rarity;
pub const Resource = enums.Resource;
pub const Role = enums.Role;

allocator: mem.Allocator = undefined,
io: std.Io = undefined,
token: []const u8 = undefined,
client: http.Client = undefined,

pub fn init(
    capi: *ClazhAPI,
    allocator: mem.Allocator,
    io: std.Io,
    token: []const u8,
) !void {
    const bearer_token = try std.mem.concat(
        allocator,
        u8,
        &.{ "Bearer ", token },
    );

    capi.* = .{
        .allocator = allocator,
        .io = io,
        .token = bearer_token,
        .client = .{
            .allocator = allocator,
            .io = io,
        },
    };
}

pub fn deinit(capi: *ClazhAPI) void {
    capi.client.deinit();
    capi.allocator.free(capi.token);
}

const Players = @import("routes/Players.zig");

/// Same as `/players/{playerTag}`
pub fn getPlayer(capi: *ClazhAPI, tag: []const u8) !Result.Result(Player) {
    return try Players.getPlayer(capi, tag);
}

/// Same as `/players/{playerTag}/upcomingchests`
///
/// Probably something the game doesn't use anymore since it still has
/// references to "Wooden Chest".
pub fn getUpcomingChests(
    capi: *ClazhAPI,
    tag: []const u8,
) !Result.Result(UpcomingChests) {
    return try Players.getUpcomingChests(capi, tag);
}

/// Same as `/players/{playerTag}/battlelog`
pub fn getBattleLog(capi: *ClazhAPI, tag: []const u8) !Result.Result([]Battle) {
    return try Players.getBattleLog(capi, tag);
}

const Cards = @import("routes/Cards.zig");

/// Same as `/cards`
pub fn getCards(capi: *ClazhAPI) !Result.Result(ItemList) {
    return try Cards.getCards(capi);
}

const Events = @import("routes/Events.zig");

/// Same as `/events`
pub fn getEvents(capi: *ClazhAPI) !Result.Result([]TrailEvent) {
    return try Events.getEvents(capi);
}

const GlobalTournaments = @import("routes/GlobalTournaments.zig");

/// Same as `/globaltournaments`
pub fn getGlobalTournaments(
    capi: *ClazhAPI,
) !Result.Result(LadderTournamentList) {
    return try GlobalTournaments.getGlobalTournaments(capi);
}
