pub const CardsQueryOptions = @This();

limit: ?u64 = null,
after: ?[]const u8 = null,
before: ?[]const u8 = null,
