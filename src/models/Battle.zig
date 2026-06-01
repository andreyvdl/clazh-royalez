pub const Battle = @This();

const enums = @import("../enums.zig");
const BattleType = enums.BattleType;
const Arena = @import("Arena.zig");
const GameMode = @import("GameMode.zig");
const DeckSelection = enums.DeckSelection;
const PlayerBattleData = @import("PlayerBattleData.zig");
const PlayerBattleAugment = @import("PlayerBattleAugment.zig");

arena: Arena,
deckSelection: DeckSelection,
gameMode: GameMode,
modifiers: ?[]PlayerBattleAugment = null,
opponent: []PlayerBattleData,
team: []PlayerBattleData,
type: BattleType,

battleTime: []const u8,
boatBattleSide: ?[]const u8 = null,
challengeTitle: ?[]const u8 = null,
eventTag: ?[]const u8 = null,
tournamentTag: ?[]const u8 = null,

boatBattleWon: ?bool = null,
isHostedMatch: bool,
isLadderTournament: bool,

challengeId: ?i64 = null,
challengeWinCountBefore: ?i64 = null,
leagueNumber: i64,
newTowersDestroyed: ?i64 = null,
prevTowersDestroyed: ?i64 = null,
remainingTowers: ?i64 = null,
