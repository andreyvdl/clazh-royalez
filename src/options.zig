pub const TournamentsOptions = struct {
    must_have: struct {
        /// Minimum 3 chars
        name: []const u8,
    },
    optional: struct {
        limit: []const u8 = "",
        after: []const u8 = "",
        before: []const u8 = "",
    } = .{},
};

/// At least one `must_have` needs to be specified
pub const ClansOptions = struct {
    must_have: struct {
        /// Minimum 3 chars
        name: []const u8,
        location_id: []const u8,
        min_members: []const u8,
        max_members: []const u8,
        min_score: []const u8,
    },
    optional: struct {
        limit: []const u8 = "",
        after: []const u8 = "",
        before: []const u8 = "",
    } = .{},
};

pub const PagingOptions = struct {
    limit: []const u8 = "",
    after: []const u8 = "",
    before: []const u8 = "",
};
