//

import XCTest
@testable import EllipticCurve

class Secp256k1Tests: XCTestCase {
    func testInit() {
        XCTAssertNotNil(ECPoint())
        XCTAssertNotNil(ECPoint.Generator)
    }
}
