//

import XCTest
@testable import EllipticCurve

fileprivate let P: UInt8 = 223

class ECOverFFTests: XCTestCase {

    struct FFInt223: FiniteFieldInteger {
        static var Characteristic: UInt8 = P
        var value: UInt8

        init() {
            value = 0
        }
    }

    struct MyECFF: EllipticCurveOverFiniteField {

        static var Order: UInt8 = 212

        static var a: FFInt223 = 2
        static var b: FFInt223 = 7

        var x: FFInt223
        var y: FFInt223?

        static var Generator: MyECFF = MyECFF(x: 16, y: 11)

        init() {
            x = 0
        }
    }

    func testInit() {
        XCTAssertNotNil(MyECFF.Zero)
        XCTAssertNotNil(MyECFF.Infinity)
        XCTAssertNotNil(MyECFF.One)
        XCTAssertNotNil(MyECFF.Generator)
        XCTAssertEqual(MyECFF.Zero, MyECFF.Infinity)
        XCTAssertEqual(MyECFF.One, MyECFF.Generator)
        XCTAssertEqual(MyECFF.Infinity, MyECFF.Order * MyECFF.Generator)

        XCTAssertEqual(MyECFF(0), MyECFF.Infinity)
        XCTAssertNotNil(MyECFF(1))
        XCTAssertNotNil(MyECFF(211))
        XCTAssertNil(MyECFF(212))
        XCTAssertNil(MyECFF(withSeed: 212))
        XCTAssertNil(MyECFF(isInfinity: true).y)
        XCTAssertNotNil(MyECFF(withCoordinates: (x: 16, y: 11)))
    }

    func testProperties() {
        XCTAssertNil(MyECFF.Infinity.y)
        XCTAssertEqual(MyECFF.Characteristic, P)
        XCTAssertEqual(MyECFF.Order, 212)
    }
}
