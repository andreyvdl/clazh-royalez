pub const TournamentsOptions = struct {
    name: []const u8 = "",
    limit: []const u8 = "",
    after: []const u8 = "",
    before: []const u8 = "",
};

pub const ClansOptions = struct {
    name: []const u8 = "",
    location_id: []const u8 = "",
    min_members: []const u8 = "",
    max_members: []const u8 = "",
    min_score: []const u8 = "",
    limit: []const u8 = "",
    after: []const u8 = "",
    before: []const u8 = "",
};

pub const PagingOptions = struct {
    limit: []const u8 = "",
    after: []const u8 = "",
    before: []const u8 = "",
};
