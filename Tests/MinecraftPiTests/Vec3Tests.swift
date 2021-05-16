import XCTest
@testable import MinecraftPi

final class Vec3Tests: XCTestCase {
    static var allTests = [
        ("testArithmetic", testArithmetic),
    ]

    func testArithmetic() {
        XCTAssertEqual(vec(1, 2, 3) + vec(-2, 9, 3), vec(-1, 11, 6))
        XCTAssertEqual(vec(1, 2, 3) - vec(-2, 9, 3), vec(3, -7, 0))
        XCTAssertEqual(vec(3, 4, 5) * 2, vec(6, 8, 10))
        XCTAssertEqual(2 * vec(3, 4, 5), vec(6, 8, 10))
        XCTAssertEqual(vec(6, -8, 10) / 2, vec(3, -4, 5))
        XCTAssertEqual(-vec(2, -9, 1), vec(-2, 9, -1))
    }

    private func vec(_ x: Int, _ y: Int, _ z: Int) -> Vec3<Int> {
        Vec3(x: x, y: y, z: z)
    }
}
