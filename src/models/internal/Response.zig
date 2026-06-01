const Paging = @import("Paging.zig");

/// A generic response model for API extra specific responses.
pub fn Response(comptime T: type) type {
    return struct {
        items: []T,
        /// Optional because some responses don't support it.
        paging: ?Paging = null,
    };
}
