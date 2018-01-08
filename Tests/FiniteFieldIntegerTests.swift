//

import XCTest
@testable import EllipticCurve

class FiniteFieldIntegerTests: XCTestCase {
    func testInit() {
        let a: FFInt = 1
        let b = FFInt(1)
        let c = FiniteFieldInteger(primeOrder: CommonCurves.secp256k1.p, value: 1)
        XCTAssertEqual(a, b)
        XCTAssertEqual(b, c)
    }

    func testAddition() {
        let a = FFInt(primeOrder: 31, value: 2)
        let b = FFInt(primeOrder: 31, value: 15)
        let c = a + b
        XCTAssertEqual(c.value, 17)
    }

    func testAddition1() {
        let a = FFInt(primeOrder: 31, value: 17)
        let b = FFInt(primeOrder: 31, value: 21)
        let c = a + b
        XCTAssertEqual(c.value, 7)
    }

    func testSubtraction() {
        let a = FFInt(primeOrder: 31, value: 29)
        let b = FFInt(primeOrder: 31, value: 4)
        let c = a - b
        XCTAssertEqual(c.value, 25)
    }

    func testSubtraction1() {
        let a = FFInt(primeOrder: 31, value: 15)
        let b = FFInt(primeOrder: 31, value: 30)
        let c = a - b
        XCTAssertEqual(c.value, 16)
    }
    
    func testMultiplication() {
        let a = FFInt(primeOrder: 31, value: 24)
        let b = FFInt(primeOrder: 31, value: 19)
        let c = a * b
        XCTAssertEqual(c.value, 22)
    }
    
    func testPow() {
        let a = FFInt(primeOrder: 31, value: 17)
        let b = FFInt(primeOrder: 31, value: 3)
        let c = a ^ b
        XCTAssertEqual(c.value, 15)
    }
}
