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
    coLeader,
    elder,

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

pub const World = enum(u32) {
    Europe = 57000000,
    North_America = 57000001,
    South_America = 57000002,
    Asia = 57000003,
    Oceania = 57000004,
    Africa = 57000005,
    International = 57000006,
    Afghanistan = 57000007,
    @"Åland Islands" = 57000008,
    Albania = 57000009,
    Algeria = 57000010,
    American_Samoa = 57000011,
    Andorra = 57000012,
    Angola = 57000013,
    Anguilla = 57000014,
    Antarctica = 57000015,
    Antigua_and_Barbuda = 57000016,
    Argentina = 57000017,
    Armenia = 57000018,
    Aruba = 57000019,
    Ascension_Island = 57000020,
    Australia = 57000021,
    Austria = 57000022,
    Azerbaijan = 57000023,
    Bahamas = 57000024,
    Bahrain = 57000025,
    Bangladesh = 57000026,
    Barbados = 57000027,
    Belarus = 57000028,
    Belgium = 57000029,
    Belize = 57000030,
    Benin = 57000031,
    Bermuda = 57000032,
    Bhutan = 57000033,
    Bolivia = 57000034,
    Bosnia_and_Herzegovina = 57000035,
    Botswana = 57000036,
    Bouvet_Island = 57000037,
    Brazil = 57000038,
    British_Indian_Ocean_Territory = 57000039,
    British_Virgin_Islands = 57000040,
    Brunei = 57000041,
    Bulgaria = 57000042,
    Burkina_Faso = 57000043,
    Burundi = 57000044,
    Cambodia = 57000045,
    Cameroon = 57000046,
    Canada = 57000047,
    Canary_Islands = 57000048,
    Cape_Verde = 57000049,
    Caribbean_Netherlands = 57000050,
    Cayman_Islands = 57000051,
    Central_African_Republic = 57000052,
    Ceuta_and_Melilla = 57000053,
    Chad = 57000054,
    Chile = 57000055,
    China = 57000056,
    Christmas_Island = 57000057,
    @"Cocos (Keeling) Islands" = 57000058,
    Colombia = 57000059,
    Comoros = 57000060,
    @"Congo (DRC)" = 57000061,
    @"Congo (Republic)" = 57000062,
    Cook_Islands = 57000063,
    Costa_Rica = 57000064,
    @"Côte d’Ivoire" = 57000065,
    Croatia = 57000066,
    Cuba = 57000067,
    @"Curaçao" = 57000068,
    Cyprus = 57000069,
    Czech_Republic = 57000070,
    Denmark = 57000071,
    Diego_Garcia = 57000072,
    Djibouti = 57000073,
    Dominica = 57000074,
    Dominican_Republic = 57000075,
    Ecuador = 57000076,
    Egypt = 57000077,
    El_Salvador = 57000078,
    Equatorial_Guinea = 57000079,
    Eritrea = 57000080,
    Estonia = 57000081,
    Ethiopia = 57000082,
    Falkland_Islands = 57000083,
    Faroe_Islands = 57000084,
    Fiji = 57000085,
    Finland = 57000086,
    France = 57000087,
    French_Guiana = 57000088,
    French_Polynesia = 57000089,
    French_Southern_Territories = 57000090,
    Gabon = 57000091,
    Gambia = 57000092,
    Georgia = 57000093,
    Germany = 57000094,
    Ghana = 57000095,
    Gibraltar = 57000096,
    Greece = 57000097,
    Greenland = 57000098,
    Grenada = 57000099,
    Guadeloupe = 57000100,
    Guam = 57000101,
    Guatemala = 57000102,
    Guernsey = 57000103,
    Guinea = 57000104,
    @"Guinea-Bissau" = 57000105,
    Guyana = 57000106,
    Haiti = 57000107,
    @"Heard & McDonald Islands" = 57000108,
    Honduras = 57000109,
    Hong_Kong = 57000110,
    Hungary = 57000111,
    Iceland = 57000112,
    India = 57000113,
    Indonesia = 57000114,
    Iran = 57000115,
    Iraq = 57000116,
    Ireland = 57000117,
    Isle_of_Man = 57000118,
    Israel = 57000119,
    Italy = 57000120,
    Jamaica = 57000121,
    Japan = 57000122,
    Jersey = 57000123,
    Jordan = 57000124,
    Kazakhstan = 57000125,
    Kenya = 57000126,
    Kiribati = 57000127,
    Kosovo = 57000128,
    Kuwait = 57000129,
    Kyrgyzstan = 57000130,
    Laos = 57000131,
    Latvia = 57000132,
    Lebanon = 57000133,
    Lesotho = 57000134,
    Liberia = 57000135,
    Libya = 57000136,
    Liechtenstein = 57000137,
    Lithuania = 57000138,
    Luxembourg = 57000139,
    Macau = 57000140,
    @"Macedonia (FYROM)" = 57000141,
    Madagascar = 57000142,
    Malawi = 57000143,
    Malaysia = 57000144,
    Maldives = 57000145,
    Mali = 57000146,
    Malta = 57000147,
    Marshall_Islands = 57000148,
    Martinique = 57000149,
    Mauritania = 57000150,
    Mauritius = 57000151,
    Mayotte = 57000152,
    Mexico = 57000153,
    Micronesia = 57000154,
    Moldova = 57000155,
    Monaco = 57000156,
    Mongolia = 57000157,
    Montenegro = 57000158,
    Montserrat = 57000159,
    Morocco = 57000160,
    Mozambique = 57000161,
    @"Myanmar (Burma)" = 57000162,
    Namibia = 57000163,
    Nauru = 57000164,
    Nepal = 57000165,
    Netherlands = 57000166,
    New_Caledonia = 57000167,
    New_Zealand = 57000168,
    Nicaragua = 57000169,
    Niger = 57000170,
    Nigeria = 57000171,
    Niue = 57000172,
    Norfolk_Island = 57000173,
    North_Korea = 57000174,
    Northern_Mariana_Islands = 57000175,
    Norway = 57000176,
    Oman = 57000177,
    Pakistan = 57000178,
    Palau = 57000179,
    Palestine = 57000180,
    Panama = 57000181,
    Papua_New_Guinea = 57000182,
    Paraguay = 57000183,
    Peru = 57000184,
    Philippines = 57000185,
    Pitcairn_Islands = 57000186,
    Poland = 57000187,
    Portugal = 57000188,
    Puerto_Rico = 57000189,
    Qatar = 57000190,
    @"Réunion" = 57000191,
    Romania = 57000192,
    Russia = 57000193,
    Rwanda = 57000194,
    @"Saint Barthélemy" = 57000195,
    Saint_Helena = 57000196,
    Saint_Kitts_and_Nevis = 57000197,
    Saint_Lucia = 57000198,
    Saint_Martin = 57000199,
    Saint_Pierre_and_Miquelon = 57000200,
    Samoa = 57000201,
    San_Marino = 57000202,
    @"São Tomé and Príncipe" = 57000203,
    Saudi_Arabia = 57000204,
    Senegal = 57000205,
    Serbia = 57000206,
    Seychelles = 57000207,
    Sierra_Leone = 57000208,
    Singapore = 57000209,
    Sint_Maarten = 57000210,
    Slovakia = 57000211,
    Slovenia = 57000212,
    Solomon_Islands = 57000213,
    Somalia = 57000214,
    South_Africa = 57000215,
    South_Korea = 57000216,
    South_Sudan = 57000217,
    Spain = 57000218,
    Sri_Lanka = 57000219,
    @"St. Vincent & Grenadines" = 57000220,
    Sudan = 57000221,
    Suriname = 57000222,
    Svalbard_and_Jan_Mayen = 57000223,
    Swaziland = 57000224,
    Sweden = 57000225,
    Switzerland = 57000226,
    Syria = 57000227,
    Taiwan = 57000228,
    Tajikistan = 57000229,
    Tanzania = 57000230,
    Thailand = 57000231,
    @"Timor-Leste" = 57000232,
    Togo = 57000233,
    Tokelau = 57000234,
    Tonga = 57000235,
    Trinidad_and_Tobago = 57000236,
    Tristan_da_Cunha = 57000237,
    Tunisia = 57000238,
    Turkey = 57000239,
    Turkmenistan = 57000240,
    Turks_and_Caicos_Islands = 57000241,
    Tuvalu = 57000242,
    @"U.S. Outlying Islands" = 57000243,
    @"U.S. Virgin Islands" = 57000244,
    Uganda = 57000245,
    Ukraine = 57000246,
    United_Arab_Emirates = 57000247,
    United_Kingdom = 57000248,
    United_States = 57000249,
    Uruguay = 57000250,
    Uzbekistan = 57000251,
    Vanuatu = 57000252,
    Vatican_City = 57000253,
    Venezuela = 57000254,
    Vietnam = 57000255,
    Wallis_and_Futuna = 57000256,
    Western_Sahara = 57000257,
    Yemen = 57000258,
    Zambia = 57000259,
    Zimbabwe = 57000260,
    Unknown = 57000261,
};
