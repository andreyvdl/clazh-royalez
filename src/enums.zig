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

pub const Resource = enum {
    gold,
    unknown,

    pub fn fromString(str: []const u8) ?Resource {
        return std.meta.stringToEnum(Resource, str);
    }

    pub fn toString(value: Resource) []const u8 {
        return @tagName(value);
    }
};

pub const ItemType = enum {
    none,
    cardStack,
    chest,
    cardStackRandom,
    resource,
    tradeToken,
    consumable,

    pub fn fromString(str: []const u8) ?ItemType {
        return std.meta.stringToEnum(ItemType, str);
    }

    pub fn toString(value: ItemType) []const u8 {
        return @tagName(value);
    }
};

pub const TournamentStatus = enum {
    inPreparation,
    inProgress,
    ended,
    unknown,

    pub fn fromString(str: []const u8) ?TournamentStatus {
        return std.meta.stringToEnum(TournamentStatus, str);
    }

    pub fn toString(value: TournamentStatus) []const u8 {
        return @tagName(value);
    }
};

pub const TournamentType = enum {
    open,
    passwordProtected,
    unknown,

    pub fn fromString(str: []const u8) ?TournamentType {
        return std.meta.stringToEnum(TournamentType, str);
    }

    pub fn toString(value: TournamentType) []const u8 {
        return @tagName(value);
    }
};

pub const RiverRaceState = enum {
    clanNotFound,
    accessDenied,
    matchmaking,
    matched,
    full,
    ended,

    pub fn fromString(str: []const u8) ?RiverRaceState {
        return std.meta.stringToEnum(RiverRaceState, str);
    }

    pub fn toString(value: RiverRaceState) []const u8 {
        return @tagName(value);
    }
};

pub const RiverRacePeriodType = enum {
    training,
    warDay,
    colosseum,

    pub fn fromString(str: []const u8) ?RiverRacePeriodType {
        return std.meta.stringToEnum(RiverRacePeriodType, str);
    }

    pub fn toString(value: RiverRacePeriodType) []const u8 {
        return @tagName(value);
    }
};

pub const ClanChestStatus = enum {
    inactive,
    active,
    completed,
    unknown,

    pub fn fromString(str: []const u8) ?ClanChestStatus {
        return std.meta.stringToEnum(ClanChestStatus, str);
    }

    pub fn toString(value: ClanChestStatus) []const u8 {
        return @tagName(value);
    }
};

pub const ClanType = enum {
    open,
    inviteOnly,
    closed,

    pub fn fromString(str: []const u8) ?ClanType {
        return std.meta.stringToEnum(ClanType, str);
    }

    pub fn toString(value: ClanType) []const u8 {
        return @tagName(value);
    }
};

pub const Card = enum(u32) {
    Knight = 26000000,
    Archers = 26000001,
    Goblins = 26000002,
    Giant = 26000003,
    @"P.E.K.K.A" = 26000004,
    Minions = 26000005,
    Balloon = 26000006,
    Witch = 26000007,
    Barbarians = 26000008,
    Golem = 26000009,
    Skeletons = 26000010,
    Valkyrie = 26000011,
    Skeleton_Army = 26000012,
    Bomber = 26000013,
    Musketeer = 26000014,
    Baby_Dragon = 26000015,
    Prince = 26000016,
    Wizard = 26000017,
    @"Mini_P.E.K.K.A" = 26000018,
    Spear_Goblins = 26000019,
    Giant_Skeleton = 26000020,
    Hog_Rider = 26000021,
    Minion_Horde = 26000022,
    Ice_Wizard = 26000023,
    Royal_Giant = 26000024,
    Guards = 26000025,
    Princess = 26000026,
    Dark_Prince = 26000027,
    Three_Musketeers = 26000028,
    Lava_Hound = 26000029,
    Ice_Spirit = 26000030,
    Fire_Spirit = 26000031,
    Miner = 26000032,
    Sparky = 26000033,
    Bowler = 26000034,
    Lumberjack = 26000035,
    Battle_Ram = 26000036,
    Inferno_Dragon = 26000037,
    Ice_Golem = 26000038,
    Mega_Minion = 26000039,
    Dart_Goblin = 26000040,
    Goblin_Gang = 26000041,
    Electro_Wizard = 26000042,
    Elite_Barbarians = 26000043,
    Hunter = 26000044,
    Executioner = 26000045,
    Bandit = 26000046,
    Royal_Recruits = 26000047,
    Night_Witch = 26000048,
    Bats = 26000049,
    Royal_Ghost = 26000050,
    Ram_Rider = 26000051,
    Zappies = 26000052,
    Rascals = 26000053,
    Cannon_Cart = 26000054,
    Mega_Knight = 26000055,
    Skeleton_Barrel = 26000056,
    Flying_Machine = 26000057,
    Wall_Breakers = 26000058,
    Royal_Hogs = 26000059,
    Goblin_Giant = 26000060,
    Fisherman = 26000061,
    Magic_Archer = 26000062,
    Electro_Dragon = 26000063,
    Firecracker = 26000064,
    Mighty_Miner = 26000065,
    Elixir_Golem = 26000067,
    Battle_Healer = 26000068,
    Skeleton_King = 26000069,
    Archer_Queen = 26000072,
    Golden_Knight = 26000074,
    Monk = 26000077,
    Skeleton_Dragons = 26000080,
    Mother_Witch = 26000083,
    Electro_Spirit = 26000084,
    Electro_Giant = 26000085,
    Phoenix = 26000087,
    Little_Prince = 26000093,
    Goblin_Demolisher = 26000095,
    Goblin_Machine = 26000096,
    Suspicious_Bush = 26000097,
    Goblinstein = 26000099,
    Rune_Giant = 26000101,
    Berserker = 26000102,
    Boss_Bandit = 26000103,
    Cannon = 27000000,
    Goblin_Hut = 27000001,
    Mortar = 27000002,
    Inferno_Tower = 27000003,
    Bomb_Tower = 27000004,
    Barbarian_Hut = 27000005,
    Tesla = 27000006,
    Elixir_Collector = 27000007,
    X_Bow = 27000008,
    Tombstone = 27000009,
    Furnace = 27000010,
    Goblin_Cage = 27000012,
    Goblin_Drill = 27000013,
    Fireball = 28000000,
    Arrows = 28000001,
    Rage = 28000002,
    Rocket = 28000003,
    Goblin_Barrel = 28000004,
    Freeze = 28000005,
    Mirror = 28000006,
    Lightning = 28000007,
    Zap = 28000008,
    Poison = 28000009,
    Graveyard = 28000010,
    The_Log = 28000011,
    Tornado = 28000012,
    Clone = 28000013,
    Earthquake = 28000014,
    Barbarian_Barrel = 28000015,
    Heal_Spirit = 28000016,
    Giant_Snowball = 28000017,
    Royal_Delivery = 28000018,
    Void = 28000023,
    Goblin_Curse = 28000024,
    Spirit_Empress = 28000025,
    Vines = 28000026,
    Tower_Princess = 159000000,
    Cannoneer = 159000001,
    Dagger_Duchess = 159000002,
    Royal_Chef = 159000004,
};
