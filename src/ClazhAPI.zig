const ClazhAPI = @This();
const std = @import("std");
const mem = std.mem;
const http = std.http;

pub const Arena = @import("models/Arena.zig");
pub const Battle = @import("models/Battle.zig");
pub const BattleRound = @import("models/BattleRound.zig");
pub const Chest = @import("models/Chest.zig");
pub const Clan = @import("models/Clan.zig");
pub const ClanMember = @import("models/ClanMember.zig");
pub const ClientError = @import("models/ClientError.zig");
pub const CurrentRiverRace = @import("models/CurrentRiverRace.zig");
pub const GameMode = @import("models/GameMode.zig");
pub const IconUrls = @import("models/IconUrls.zig");
pub const Item = @import("models/Item.zig");
pub const ItemList = @import("models/ItemList.zig");
pub const LadderTournament = @import("models/LadderTournament.zig");
pub const LadderTournamentList = @import("models/LadderTournamentList.zig");
pub const Leaderboard = @import("models/Leaderboard.zig");
pub const LeaderboardList = @import("models/LeaderboardList.zig");
pub const LeagueSeasonResult = @import("models/LeagueSeasonResult.zig");
pub const Location = @import("models/Location.zig");
pub const PathOfLegendSeasonResult =
    @import("models/PathOfLegendSeasonResult.zig");
pub const PeriodLog = @import("models/PeriodLog.zig");
pub const PeriodLogEntry = @import("models/PeriodLogEntry.zig");
pub const PeriodLogEntryClan = @import("models/PeriodLogEntryClan.zig");
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
pub const PlayerRanking = @import("models/PlayerRanking.zig");
pub const PlayerRankingClan = @import("models/PlayerRanking.zig");
pub const RiverRaceClan = @import("models/RiverRaceClan.zig");
pub const RiverRaceLogEntry = @import("models/RiverRaceLogEntry.zig");
pub const RiverRaceParticipant = @import("models/RiverRaceParticipant.zig");
pub const RiverRaceStanding = @import("models/RiverRaceStanding.zig");
pub const Tournament = @import("models/Tournament.zig");
pub const TournamentHeader = @import("models/TournamentHeader.zig");
pub const TournamentMember = @import("models/TournamentMember.zig");
pub const TrailEvent = @import("models/TrailEvent.zig");

pub const Result = @import("Result.zig");
pub const Response = @import("models/internal/Response.zig");
pub const url = @import("url.zig");

const enums = @import("enums.zig");
pub const BattleType = enums.BattleType;
pub const Card = enums.Card;
pub const DeckSelection = enums.DeckSelection;
pub const ItemType = enums.ItemType;
pub const Rarity = enums.Rarity;
pub const Resource = enums.Resource;
pub const RiverRacePeriodType = enums.RiverRacePeriodType;
pub const RiverRaceState = enums.RiverRaceState;
pub const Role = enums.Role;

const options = @import("options.zig");
pub const TournamentsOptions = options.TournamentsOptions;
pub const ClansOptions = options.ClansOptions;
pub const PagingOptions = options.PagingOptions;

gpa: mem.Allocator = undefined,
io: std.Io = undefined,
token: []const u8 = undefined,
client: http.Client = undefined,

pub fn init(
    capi: *ClazhAPI,
    gpa: mem.Allocator,
    io: std.Io,
    token: []const u8,
) !void {
    const bearer_token = try std.mem.concat(
        gpa,
        u8,
        &.{ "Bearer ", token },
    );

    capi.* = .{
        .gpa = gpa,
        .io = io,
        .token = bearer_token,
        .client = .{
            .allocator = gpa,
            .io = io,
        },
    };
}

pub fn deinit(capi: *ClazhAPI) void {
    capi.client.deinit();
    capi.gpa.free(capi.token);
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

/// Same as `/leaderboard/{leaderboardId}`
pub fn getLeaderboardById(
    capi: *ClazhAPI,
    id: []const u8,
    limit: ?u32,
    after: ?[]const u8,
    before: ?[]const u8,
) !Result.Result(Response.Response(Leaderboard)) {
    if (id.len == 0) return error.InvalidId;

    var opts = PagingOptions{};
    var buf: [16]u8 = undefined;

    if (limit) |l| {
        opts.limit = try std.fmt.bufPrint(&buf, "{d}", .{l});
    }
    opts.after = after orelse "";
    opts.before = before orelse "";
    return try Leaderboards.getLeaderboardById(capi, id, opts);
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

    var opts = TournamentsOptions{ .name = name };
    var buf: [16]u8 = undefined;

    if (limit) |l| {
        opts.limit = try std.fmt.bufPrint(&buf, "{d}", .{l});
    }
    opts.after = after orelse "";
    opts.before = before orelse "";
    return try Tournaments.getTournaments(capi, opts);
}

/// Same as `/tournaments/{tournamentTag}`
pub fn getTournamentFromTag(
    capi: *ClazhAPI,
    tag: []const u8,
) !Result.Result(Tournament) {
    if (tag.len == 0) return error.InvalidTag;
    return try Tournaments.getTournamentFromTag(capi, tag);
}

const Clans = @import("routes/Clans.zig");

/// Same as `/clans`
pub fn getClans(
    capi: *ClazhAPI,
    name: []const u8,
    location_id: u64,
    min_members: u64,
    max_members: u64,
    min_score: u64,
    limit: ?u32,
    after: ?[]const u8,
    before: ?[]const u8,
) !Result.Result(Response.Response(Clan)) {
    var opts = ClansOptions{};
    var id_buf: [16]u8 = undefined;
    var min_buf: [16]u8 = undefined;
    var max_buf: [16]u8 = undefined;
    var score_buf: [16]u8 = undefined;

    opts.name = if (name.len > 0) name else "";
    if (location_id != 0) {
        opts.location_id = try std.fmt.bufPrint(
            &id_buf,
            "{d}",
            .{location_id},
        );
    }
    if (min_members != 0) {
        opts.min_members = try std.fmt.bufPrint(
            &min_buf,
            "{d}",
            .{min_members},
        );
    }
    if (max_members != 0) {
        opts.max_members = try std.fmt.bufPrint(
            &max_buf,
            "{d}",
            .{max_members},
        );
    }
    if (min_score != 0) {
        opts.min_score = try std.fmt.bufPrint(
            &score_buf,
            "{d}",
            .{min_score},
        );
    }

    if (opts.name.len == 0 and opts.location_id.len == 0 and
        opts.min_members.len == 0 and opts.max_members.len == 0 and
        opts.min_score.len == 0)
    {
        return error.AllMustOptionsMissing;
    }

    var buf: [16]u8 = undefined;
    if (limit) |l| {
        opts.limit = try std.fmt.bufPrint(&buf, "{d}", .{l});
    }
    opts.after = after orelse "";
    opts.before = before orelse "";

    return try Clans.getClans(capi, opts);
}

/// Same as `/clans/{clanTag}`
pub fn getClanByTag(capi: *ClazhAPI, tag: []const u8) !Result.Result(Clan) {
    if (tag.len == 0) return error.InvalidTag;
    return try Clans.getClanByTag(capi, tag);
}

/// Same as `/clans/{clanTag}/members`
pub fn getClanMembers(
    capi: *ClazhAPI,
    tag: []const u8,
    limit: ?u32,
    after: ?[]const u8,
    before: ?[]const u8,
) !Result.Result(Response.Response(ClanMember)) {
    if (tag.len == 0) return error.InvalidTag;

    var opts = PagingOptions{};
    var buf: [16]u8 = undefined;

    if (limit) |l| {
        opts.limit = try std.fmt.bufPrint(&buf, "{d}", .{l});
    }
    opts.after = after orelse "";
    opts.before = before orelse "";
    return try Clans.getClanMembers(capi, tag, opts);
}

/// Same as `/clans/{clanTag}/riverracelog`
pub fn getClanRiverRaceLog(
    capi: *ClazhAPI,
    tag: []const u8,
    limit: ?u32,
    after: ?[]const u8,
    before: ?[]const u8,
) !Result.Result(Response.Response(RiverRaceLogEntry)) {
    if (tag.len == 0) return error.InvalidTag;

    var opts = PagingOptions{};
    var buf: [16]u8 = undefined;

    if (limit) |l| {
        opts.limit = try std.fmt.bufPrint(&buf, "{d}", .{l});
    }
    opts.after = after orelse "";
    opts.before = before orelse "";
    return try Clans.getClanRiverRaceLog(capi, tag, opts);
}

/// Same as `/clans/{clanTag}/currentriverrace`
pub fn getClanCurrentRiverRace(
    capi: *ClazhAPI,
    tag: []const u8,
) !Result.Result(CurrentRiverRace) {
    if (tag.len == 0) return error.InvalidTag;
    return try Clans.getClanCurrentRiverRace(capi, tag);
}

const Locations = @import("routes/Locations.zig");

/// Same as `/locations`
pub fn getLocations(
    capi: *ClazhAPI,
    limit: ?u32,
    after: ?[]const u8,
    before: ?[]const u8,
) !Result.Result(Response.Response(Location)) {
    var opts = PagingOptions{};
    var buf: [16]u8 = undefined;

    if (limit) |l| {
        opts.limit = try std.fmt.bufPrint(&buf, "{d}", .{l});
    }
    opts.after = after orelse "";
    opts.before = before orelse "";
    return try Locations.getLocations(capi, opts);
}

/// Same as `/locations/{locationId}`
pub fn getLocationById(
    capi: *ClazhAPI,
    location_id: u32,
) !Result.Result(Location) {
    var buf: [16]u8 = undefined;
    const li = try std.fmt.bufPrint(&buf, "{d}", .{location_id});

    return try Locations.getLocationById(capi, li);
}

/// Same as `/locations/{locationId}/rankings/players`
///
/// Seems to work best when used with country location IDs.
pub fn getPlayersRankingsByLocation(
    capi: *ClazhAPI,
    location_id: u32,
    limit: ?u32,
    after: ?[]const u8,
    before: ?[]const u8,
) !Result.Result(Response.Response(PlayerRanking)) {
    var opts = PagingOptions{};
    var location_buf: [16]u8 = undefined;
    var buf: [16]u8 = undefined;

    const li = try std.fmt.bufPrint(&location_buf, "{d}", .{location_id});
    if (limit) |l| {
        opts.limit = try std.fmt.bufPrint(&buf, "{d}", .{l});
    }
    opts.after = after orelse "";
    opts.before = before orelse "";
    return try Locations.getPlayersRankingsByLocation(capi, li, opts);
}
