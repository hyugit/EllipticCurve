//

import XCTest
@testable import EllipticCurve

fileprivate let P: UInt8 = 223

fileprivate struct FFInt223: FiniteFieldInteger {
    static var Characteristic: UInt8 = P
    var value: UInt8

    init() {
        value = 0
    }
}

fileprivate struct MyECFF: EllipticCurveOverFiniteField {

    static var Order: UInt8 = 211

    static var a: FFInt223 = 2
    static var b: FFInt223 = 7

    var _value: UInt8?
    var x: FFInt223
    var y: FFInt223?

    static var Generator: MyECFF = MyECFF(x: 16, y: 11)

    init() {
        x = 0
    }

    public static func +=(lhs: inout MyECFF, rhs: MyECFF) {
        if let lVal = lhs.value, let rVal = rhs.value {
            lhs = MyECFF(lVal + rVal) ?? MyECFF.Infinity
        } else {
            lhs = lhs + rhs
        }
    }
}

class ECOverFFTests: XCTestCase {
    func testInit() {
        XCTAssertNotNil(MyECFF.Zero)
        XCTAssertNotNil(MyECFF.Infinity)
        XCTAssertNotNil(MyECFF.One)
        XCTAssertNotNil(MyECFF.Generator)
        XCTAssertEqual(MyECFF.Zero, MyECFF.Infinity)
        XCTAssertEqual(MyECFF.One, MyECFF.Generator)

        XCTAssertNil(MyECFF(0))
        XCTAssertNotNil(MyECFF(1))
        XCTAssertNotNil(MyECFF(211))
        XCTAssertNil(MyECFF(212))
        XCTAssertNil(MyECFF(withValue: 212))
        XCTAssertNil(MyECFF(isInfinity: true).y)
        XCTAssertNotNil(MyECFF(withCoordinates: (x: 16, y: 11)))
    }

    func testProperties() {
        XCTAssertNil(MyECFF.Infinity.value)
        XCTAssertEqual(MyECFF.Characteristic, P)
        XCTAssertEqual(MyECFF.Order, 211)
        var a = MyECFF.Infinity
        a.value = 1
        XCTAssertEqual(a, MyECFF.Generator)
        a.value = 0
        XCTAssertEqual(a, MyECFF.Zero)
        a.value = 1
        XCTAssertEqual(a, MyECFF.One)
        a.value = nil
        XCTAssertEqual(a, MyECFF.Infinity)
    }

    func testAddAcc() {
        var a = MyECFF(1)!
        a += a
        XCTAssertEqual(a.value, 2)
    }
}
