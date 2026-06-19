pub const Location = @This();

countryCode: ?[]const u8 = null,
localizedName: ?[]const u8 = null,
name: []const u8,

id: i64,

isCountry: bool,
