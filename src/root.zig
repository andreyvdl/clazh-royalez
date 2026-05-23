const std = @import("std");
const ClazhAPI = @import("ClazhAPI.zig");
const errors = ClazhAPI.errors;
const Rarity = ClazhAPI.Rarity;
const Role = ClazhAPI.Role;
const Players = ClazhAPI.Players;

test "Rarity toString" {
    const cases = [_]struct { Rarity, []const u8 }{
        .{ Rarity.common, "common" },
        .{ Rarity.rare, "rare" },
        .{ Rarity.epic, "epic" },
        .{ Rarity.legendary, "legendary" },
        .{ Rarity.champion, "champion" },
    };

    for (cases) |case| {
        const str = Rarity.toString(case.@"0");
        try std.testing.expectEqualStrings(case.@"1", str);
    }
    std.debug.print("1Ok\n", .{});
}

test "Rarity fromString" {
    const cases = [_]struct { []const u8, ?Rarity }{
        .{ "common", Rarity.common },
        .{ "rare", Rarity.rare },
        .{ "epic", Rarity.epic },
        .{ "legendary", Rarity.legendary },
        .{ "champion", Rarity.champion },
    };

    for (cases) |case| {
        const rarity = Rarity.fromString(case.@"0");
        try std.testing.expectEqual(case.@"1", rarity);
    }
    std.debug.print("2Ok\n", .{});
}

test "Role toString" {
    const cases = [_]struct { Role, []const u8 }{
        .{ Role.not_member, "not_member" },
        .{ Role.member, "member" },
        .{ Role.leader, "leader" },
        .{ Role.coleader, "coleader" },
        .{ Role.admin, "admin" },
    };

    for (cases) |case| {
        const str = Role.toString(case.@"0");
        try std.testing.expectEqualStrings(case.@"1", str);
    }
    std.debug.print("3Ok\n", .{});
}

test "Role fromString" {
    const cases = [_]struct { []const u8, ?Role }{
        .{ "not_member", Role.not_member },
        .{ "member", Role.member },
        .{ "leader", Role.leader },
        .{ "coleader", Role.coleader },
        .{ "admin", Role.admin },
    };

    for (cases) |case| {
        const role = Role.fromString(case.@"0");
        try std.testing.expectEqual(case.@"1", role);
    }
    std.debug.print("4Ok\n", .{});
}

test "player route" {
    const allocator = std.heap.page_allocator;
    var threaded = std.Io.Threaded.init(allocator, .{});

    defer threaded.deinit();

    const io = threaded.io();
    var api: ClazhAPI = undefined;

    try api.init(allocator, io, std.testing.environ.getPosix("TOKEN") orelse "");
    defer api.deinit();

    const player = api.getPlayer("#VC080GQVP");

    switch (player) {
        .success => |p| std.debug.print("{any}\n", .{p}),
        .fail => |e| std.debug.print("{any}\n", .{e}),
    }
    std.debug.print("5Ok\n", .{});
}
