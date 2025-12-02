const std = @import("std");

pub fn build(b: *std.Build) void {
    // Standard optimize options allow the person running `zig build` to select
    // between Debug, ReleaseSafe, ReleaseFast, and ReleaseSmall.
    const optimize = b.standardOptimizeOption(.{});
    const target = b.standardTargetOptions(.{});

    const root_module = b.createModule(.{
        .root_source_file = b.path("src/zignite.zig"),
        .target = target,
        .optimize = optimize,
    });

    const lib = b.addLibrary(.{
        .name = "zignite",
        .root_module = root_module,
        .linkage = .static,
    });
    b.installArtifact(lib);

    const test_module = b.createModule(.{
        .root_source_file = b.path("src/zignite.zig"),
        .target = target,
        .optimize = optimize,
    });

    const main_tests = b.addTest(.{
        .root_module = test_module,
    });

    const test_step = b.step("test", "Run library tests");
    test_step.dependOn(&main_tests.step);
}
