//

import XCTest
@testable import EllipticCurve

class Secp256k1Tests: XCTestCase {
    func testInit() {
        XCTAssertNotNil(Secp256k1())
        XCTAssertNotNil(Secp256k1.Generator)
    }
}
