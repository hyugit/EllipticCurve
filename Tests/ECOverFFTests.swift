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

    var value: UInt8?
    var x: FFInt223
    var y: FFInt223?

    static var Generator: MyECFF = MyECFF(x: 16, y: 11)

    init() {
        x = 0
        y = nil
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
    }

    func testProperties() {
        XCTAssertEqual(MyECFF.Characteristic, P)
        XCTAssertEqual(MyECFF.Order, 211)
    }
}
