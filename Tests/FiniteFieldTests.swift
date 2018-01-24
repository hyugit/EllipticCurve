//

import XCTest
@testable import EllipticCurve

// for test purposes, use a small prime number
fileprivate let p: UInt8 = 31

class FiniteFieldTests: XCTestCase {
    // for test purposes, use a small prime number

    struct FFInt: FiniteFieldInteger {
        static var Characteristic = p

        var value: UInt8

        init() {
            value = 0
        }
    }

    func testInit() {
        let a: FFInt = 1
        let b = FFInt(1)
        let c = FFInt(1)
        let d: FFInt = -1
        let e = FFInt(exactly: UInt8(1))
        let f = FFInt(exactly: UInt64.max)
        XCTAssertEqual(a, b)
        XCTAssertEqual(b, c)
        XCTAssertEqual(d, FFInt(UInt8.max))
        XCTAssertEqual(e, 1)
        XCTAssertEqual(f, nil)
    }

    func testProperties() {
        XCTAssertEqual(FFInt.Zero, FFInt(0))
        XCTAssertEqual(FFInt.One, FFInt(1))
        XCTAssertEqual(FFInt.Order, FFInt.Characteristic) // default order
        XCTAssertEqual(FFInt(2).magnitude, FFInt(2))
        XCTAssertEqual(FFInt(3).description, "Element 3 of F_31")
    }

    func testAddition() {
        let a = FFInt(2)
        let b = FFInt(15)
        let c = a + b
        XCTAssertEqual(c, 17)
    }

    func testAddition1() {
        var a = FFInt(17)
        let b = FFInt(21)
        a += b
        XCTAssertEqual(a.value, 7)
    }

    func testSubtraction() {
        let a = FFInt(29)
        let b = FFInt(4)
        let c = a - b
        XCTAssertEqual(c.value, 25)
    }

    func testSubtraction1() {
        var a = FFInt(15)
        let b = FFInt(30)
        a -= b
        XCTAssertEqual(a, 16)
    }

    func testMultiplication() {
        let a = FFInt(24)
        let b = FFInt(19)
        let c = a * b
        XCTAssertEqual(c.value, 22)
        var d = a
        d *= b
        XCTAssertEqual(d, c)
    }

    func testDivision() {
        let a = FFInt(3)
        let b = FFInt(24)
        XCTAssertEqual(4 as FFInt, a / b)
        var c = a
        c /= b
        XCTAssertEqual(4 as FFInt, c)
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

    func testComparison() {
        let a = FFInt(1)
        let b = FFInt(2)
        XCTAssertFalse(a > b)
        XCTAssertTrue(a < b)
    }
}
