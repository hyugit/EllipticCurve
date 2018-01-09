//

import XCTest
@testable import EllipticCurve

// for test purposes, use a small prime number
let p: UInt8 = 31

struct FFInt: FiniteFieldInteger {
    typealias Element = UInt8

    static var Characteristic: UInt8 = p
    static var Order: UInt8 = p // all 0..<p are included

    var value: UInt8

    init(withValue source: UInt8) {
        value = source % p
    }
}

class FiniteFieldIntegerTests: XCTestCase {
    func testInit() {
        let a: FFInt = 1
        let b = FFInt(1)
        let c = FFInt(1)
        XCTAssertEqual(a, b)
        XCTAssertEqual(b, c)
    }

    func testProperties() {
        // TODO: test common properties
    }

    func testAddition() {
        let a = FFInt(2)
        let b = FFInt(15)
        let c = a + b
        XCTAssertEqual(c, 17)
    }

    func testAddition1() {
        let a = FFInt(17)
        let b = FFInt(21)
        let c = a + b
        XCTAssertEqual(c.value, 7)
    }

    func testSubtraction() {
        let a = FFInt(29)
        let b = FFInt(4)
        let c = a - b
        XCTAssertEqual(c.value, 25)
    }

    func testSubtraction1() {
        let a = FFInt(15)
        let b = FFInt(30)
        let c = a - b
        XCTAssertEqual(c.value, 16)
    }

    func testMultiplication() {
        let a = FFInt(24)
        let b = FFInt(19)
        let c = a * b
        XCTAssertEqual(c.value, 22)
    }

    func testDivision() {
        let a = FFInt(3)
        let b = FFInt(24)
        XCTAssertEqual(4 as FFInt, a / b)
    }

    func testPow() {
        let a = FFInt(17)
        let b = FFInt(3)
        let c = a ^ b
        XCTAssertEqual(c.value, 15)
    }

    func testPow1() {
        let a = FFInt(17)
        let b = FFInt(28)
        let c = a ^ b
        XCTAssertEqual(c, 28 as FFInt)
    }
}
