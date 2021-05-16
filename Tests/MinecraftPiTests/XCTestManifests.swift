import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(Vec2Tests.allTests),
        testCase(Vec3Tests.allTests),
    ]
}
#endif
