import XCTest
@testable import MinecraftPi

final class MinecraftPiTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(MinecraftPi().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
