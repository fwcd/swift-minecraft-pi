import XCTest
@testable import MinecraftPi

final class Vec2Tests: XCTestCase {
    static var allTests = [
        ("testArithmetic", testArithmetic),
    ]

    func testArithmetic() {
        XCTAssertEqual(vec(3, 4) + vec(2, -1), vec(5, 3))
        XCTAssertEqual(vec(0, 9) - vec(3, -8), vec(-3, 17))
        XCTAssertEqual(vec(2, 4) * 3, vec(6, 12))
        XCTAssertEqual(3 * vec(2, 4), vec(6, 12))
        XCTAssertEqual(vec(2, 4) / 2, vec(1, 2))
        XCTAssertEqual(-vec(2, 4), vec(-2, -4))
    }

    private func vec(_ x: Int, _ z: Int) -> Vec2<Int> {
        Vec2(x: x, z: z)
    }
}
