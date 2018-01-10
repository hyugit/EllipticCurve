//

import XCTest
@testable import EllipticCurve

extension Double: NumericWithDivision {}

struct ECPoint: EllipticCurve {
    typealias Coordinate = Double

    static var a: Coordinate = -1
    static var b: Coordinate = 1

    var x: Coordinate
    var y: Coordinate?

    init(x xVal: Coordinate, y yVal: Coordinate) {
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
        var a = ECPoint(x: 0, y: 1)
        XCTAssertTrue(ECPoint.verifyEquation(forPoint: a))
        a = ECPoint(x: 0, y: -1)
        XCTAssertTrue(ECPoint.verifyEquation(forPoint: a))
    }
}
