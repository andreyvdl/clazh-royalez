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
pub const Leaderboard = @import("models/Leaderboard.zig");
pub const LeaderboardList = @import("models/LeaderboardList.zig");
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
pub const Tournament = @import("models/Tournament.zig");
pub const TournamentHeader = @import("models/TournamentHeader.zig");
pub const TournamentMember = @import("models/TournamentMember.zig");
pub const TrailEvent = @import("models/TrailEvent.zig");

pub const Result = @import("Result.zig");
pub const Response = @import("models/internal/Response.zig");

const enums = @import("enums.zig");
pub const BattleType = enums.BattleType;
pub const Card = enums.Card;
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
    if (tag.len == 0) return error.InvalidTag;
    return try Players.getPlayer(capi, tag);
}

/// Same as `/players/{playerTag}/upcomingchests`
///
/// Probably something the game doesn't use anymore since it still has
/// references to "Wooden Chest".
pub fn getUpcomingChests(
    capi: *ClazhAPI,
    tag: []const u8,
) !Result.Result(Response.Response(Chest)) {
    if (tag.len == 0) return error.InvalidTag;
    return try Players.getUpcomingChests(capi, tag);
}

/// Same as `/players/{playerTag}/battlelog`
pub fn getBattleLog(capi: *ClazhAPI, tag: []const u8) !Result.Result([]Battle) {
    if (tag.len == 0) return error.InvalidTag;
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

const Leaderboards = @import("routes/Leaderboards.zig");

/// Same as `/leaderboards`
pub fn getLeaderboards(capi: *ClazhAPI) !Result.Result(LeaderboardList) {
    return try Leaderboards.getLeaderboards(capi);
}

/// Same as `/leaderboards/{leaderboardId}`
///
/// It is broken, recommended to use catch and filter for
/// `error.UnexpectedEndOfInput` just like in tests.
pub fn getLeaderboardsById(
    capi: *ClazhAPI,
    id: []const u8,
) !Result.Result(LeaderboardList) {
    if (id.len == 0) return error.InvalidId;
    return try Leaderboards.getLeaderboardsById(capi, id);
}

pub const Tournaments = @import("routes/Tournaments.zig");

/// Same as `/tournaments?name={name}[&limit=int&after=str&before=str]`
///
/// Name should be at least 3 characters long.
pub fn getTournaments(
    capi: *ClazhAPI,
    name: []const u8,
    limit: ?u32,
    after: ?[]const u8,
    before: ?[]const u8,
) !Result.Result(Response.Response(TournamentHeader)) {
    if (name.len < 3) return error.NameLessThanThreeCharacters;

    var buf: [65]u8 = undefined;
    const l_str = if (limit) |l| try std.fmt.bufPrint(&buf, "{d}", .{l}) else "";

    return try Tournaments.getTournaments(
        capi,
        name,
        l_str,
        after orelse "",
        before orelse "",
    );
}

/// Same as `/tournaments/{tournamentTag}`
pub fn getTournamentFromTag(
    capi: *ClazhAPI,
    tag: []const u8,
) !Result.Result(Tournament) {
    if (tag.len == 0) return error.InvalidTag;
    return try Tournaments.getTournamentFromTag(capi, tag);
}
