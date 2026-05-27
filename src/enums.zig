pub const enums = @This();

const std = @import("std");

pub const Rarity = enum {
    common,
    rare,
    epic,
    legendary,
    champion,

    pub fn fromString(str: []const u8) ?Rarity {
        return std.meta.stringToEnum(Rarity, str);
    }

    pub fn toString(value: Rarity) []const u8 {
        return @tagName(value);
    }
};

pub const Role = enum {
    notMember,
    member,
    leader,
    admin,
    coleader,

    pub fn fromString(str: []const u8) ?Role {
        return std.meta.stringToEnum(Role, str);
    }

    pub fn toString(value: Role) []const u8 {
        return @tagName(value);
    }
};

pub const BattleType = enum {
    PvP,
    PvE,
    clanmate,
    tournament,
    friendly,
    survival,
    PvP2v2,
    clanmate2v2,
    challenge2v2,
    clanwarCollectionDay,
    clanwarWarDay,
    casual1v1,
    casual2v2,
    boatBattle,
    boatBattlePractice,
    riverRacePvP,
    riverRaceDuel,
    riverRaceDuelColosseum,
    tutorial,
    pathOfLegend,
    seasonalBattle,
    practice,
    trail,
    unknown,

    pub fn fromString(str: []const u8) ?BattleType {
        return std.meta.stringToEnum(BattleType, str);
    }

    pub fn toString(value: BattleType) []const u8 {
        return @tagName(value);
    }
};

pub const DeckSelection = enum {
    collection,
    draft,
    draftCompetitive,
    predefined,
    eventDeck,
    pick,
    wardeckPick,
    quaddeckPick,
    unknown,

    pub fn fromString(str: []const u8) ?DeckSelection {
        return std.meta.stringToEnum(DeckSelection, str);
    }

    pub fn toString(value: DeckSelection) []const u8 {
        return @tagName(value);
    }
};
