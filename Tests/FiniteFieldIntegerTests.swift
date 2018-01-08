//

import XCTest
@testable import EllipticCurve

// for test purposes, use a small prime number
let p: UInt256 = 31

struct FFInt: FiniteFieldInteger {
    typealias Multiplier = FFInt

    var value: UInt256
    
    init(_ source: UInt256) {
        value = source % p
    }

    public static var Characteristic: UInt256 {
        get {
            return UInt256(p)
        }
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

    func testUnarySubtraction() {
        let a = FFInt(14)
        let c = -a
        XCTAssertEqual(c.value, 17)
    }
    
    func testMultiplication() {
        let a = FFInt(24)
        let b = FFInt(19)
        let c = a * b
        XCTAssertEqual(c.value, 22)
    }
    
    func testPow() {
        let a = FFInt(17)
        let b = FFInt(3)
        let c = a ^ b
        XCTAssertEqual(c.value, 15)
    }
}
