pub const TournamentHeader = @This();

const GameMode = @import("GameMode.zig");
const enums = @import("../enums.zig");
const TournamentStatus = enums.TournamentStatus;
const TournamentType = enums.TournamentType;

capacity: i64,
duration: i64,
firstPlaceCardPrize: i64,
levelCap: i64,
maxCapacity: i64,
preparationDuration: i64,

createdTime: []const u8,
creatorTag: []const u8,
description: ?[]const u8 = null,
name: []const u8,
tag: []const u8,

gameMode: GameMode,
status: TournamentStatus,
type: TournamentType,
