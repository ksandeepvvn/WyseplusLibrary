import XCTest
@testable import Wyseplus

final class WyseplusTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(Wyseplus().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
