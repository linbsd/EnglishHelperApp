// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CommomLibrary",
    defaultLocalization: "en",
    platforms: [.iOS(.v15),.macCatalyst(.v15)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "CommomLibrary",
            targets: ["CommomLibrary"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(url: "https://github.com/onevcat/Kingfisher.git", from: "7.2.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "CommomLibrary",
            dependencies: ["Kingfisher"],
            resources: [
                .process("CoreDataModel/example.json")
            ]
        ),
        .testTarget(
            name: "CommomLibraryTests",
            dependencies: ["CommomLibrary"]),
    ]
)
