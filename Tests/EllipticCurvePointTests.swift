//

import XCTest
@testable import EllipticCurve

struct ECPoint: EllipticCurvePoint {
    typealias NumericType = UInt8

    static var a: UInt8 = 0
    static var b: UInt8 = 7

    var x: NumericType
    var y: NumericType?

    init(x xVal: UInt8, y yVal: UInt8) {
        x = xVal
        y = yVal
    }

    init(isInfinity: Bool) {
        x = 0
        y = nil
    }
}

class EllipticCurveTests: XCTestCase {
    func testInit() {
        let a = ECPoint(x: 1, y: 2)
        XCTAssertTrue(ECPoint.verifyEquation(forPoint: a))
    }
}
