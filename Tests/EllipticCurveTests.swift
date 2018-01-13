//

import XCTest
@testable import EllipticCurve

extension Double: BasicArithmeticOperations {}

fileprivate struct ECPoint: EllipticCurve {
    static var a: Double = -1
    static var b: Double = 1

    var x: Double
    var y: Double?

    init() {
        x = 0
        y = 0
    }
}

class EllipticCurveTests: XCTestCase {
    func testProperties() {
        let a = ECPoint.Infinity
        XCTAssertTrue(a.isInfinity)
        XCTAssertEqual(a.description, "Point Infinity")
        XCTAssertFalse(a.isOnCurve)
        let b = ECPoint(x: 0, y: 1)
        XCTAssertFalse(b.isInfinity)
        XCTAssertTrue(b.isOnCurve)
        XCTAssertEqual(b.description, "Point (0.0, 1.0) on Curve y^2 = x^3 + (-1.0)*x + (1.0)")
        let c = ECPoint(x: 0, y: 2)
        XCTAssertFalse(c.isInfinity)
        XCTAssertFalse(c.isOnCurve)
        XCTAssertEqual(c.description, "Point (0.0, 2.0) NOT on Curve y^2 = x^3 + (-1.0)*x + (1.0)")
    }

    func testVerifyEquation() {
        var a = ECPoint(x: 0, y: 1)
        XCTAssertTrue(ECPoint.verifyEquation(forPoint: a))
        a = ECPoint(x: 0, y: -1)
        XCTAssertTrue(ECPoint.verifyEquation(forPoint: a))
    }

    func testAddition() {
        let a = ECPoint(x: 0, y: 1)
        let b = ECPoint(x: 0, y: -1)
        let c = a + b
        XCTAssertEqual(c, ECPoint.Infinity)
    }

    func testAddition1() {
        let a = ECPoint.Infinity
        let b = ECPoint(x: 0, y: -1)
        let c = a + b
        XCTAssertEqual(c, b)
    }

    func testAddition2() {
        let a = ECPoint(x: 0, y: 1)
        let b = ECPoint(x: 0.25, y: 0.875)
        XCTAssertEqual(a + b, ECPoint(x: 0, y: -1))
    }

    func testMultiplication() {
        let a = ECPoint(x: 0, y: -1)
        XCTAssertEqual(0 * a, ECPoint.Infinity)
        XCTAssertEqual(2 * a, ECPoint(x: 0.25, y: 0.875))
        XCTAssertEqual(3 * a, ECPoint(x: 56, y: -419))
    }
}
