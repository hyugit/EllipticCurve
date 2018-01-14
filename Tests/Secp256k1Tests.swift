//

import XCTest
@testable import EllipticCurve

class Secp256k1Tests: XCTestCase {
    func testInit() {
        XCTAssertNotNil(Secp256k1())
        XCTAssertNotNil(Secp256k1.Generator)
    }
}

class Secp256r1Tests: XCTestCase {
    func testInit() {
        XCTAssertNotNil(Secp256r1())
        XCTAssertNotNil(Secp256r1.Generator)
    }
}

class Secp224k1Tests: XCTestCase {
    func testInit() {
        XCTAssertNotNil(Secp224k1())
        XCTAssertNotNil(Secp224k1.Generator)
    }
}

class Secp224r1Tests: XCTestCase {
    func testInit() {
        XCTAssertNotNil(Secp224r1())
        XCTAssertNotNil(Secp224r1.Generator)
    }
}

class Secp192k1Tests: XCTestCase {
    func testInit() {
        XCTAssertNotNil(Secp192k1())
        XCTAssertNotNil(Secp192k1.Generator)
    }
}

class Secp192r1Tests: XCTestCase {
    func testInit() {
        XCTAssertNotNil(Secp192r1())
        XCTAssertNotNil(Secp192r1.Generator)
    }
}

