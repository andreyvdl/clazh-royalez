pub const Battle = @This();

const enums = @import("../enums.zig");
const BattleType = enums.BattleType;
const Arena = @import("Arena.zig");
const GameMode = @import("GameMode.zig");
const DeckSelection = enums.DeckSelection;
const PlayerBattleData = @import("PlayerBattleData.zig");
const PlayerBattleAugment = @import("PlayerBattleAugment.zig");

type: BattleType,
battleTime: []const u8,
isLadderTournament: bool,
arena: Arena,
gameMode: GameMode,
deckSelection: DeckSelection,
team: []PlayerBattleData,
opponent: []PlayerBattleData,
isHostedMatch: bool,
leagueNumber: i64,

eventTag: ?[]const u8 = null,
prevTowersDestroyed: ?i64 = null,
challengeWinCountBefore: ?i64 = null,
boatBattleSide: ?[]const u8 = null,
boatBattleWon: ?bool = null,
newTowersDestroyed: ?i64 = null,
remainingTowers: ?i64 = null,
challengeId: ?i64 = null,
tournamentTag: ?[]const u8 = null,
challengeTitle: ?[]const u8 = null,
modifiers: ?[]PlayerBattleAugment = null,
