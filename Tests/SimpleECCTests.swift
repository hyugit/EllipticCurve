//

import Foundation
import XCTest
@testable import EllipticCurve

fileprivate let P: UInt8 = 7

extension UInt8: NumericWithDivision {}

struct FFInt7: FiniteField {
    typealias Element = UInt8

    static var Characteristic: UInt8 = P

    var value: UInt8

    init() {
        value = 0
    }
}

struct MyECC: EllipticCurve {
    typealias Coordinate = FFInt7

    static var a: Coordinate = FFInt7(P-1)
    static var b: Coordinate = 1

    var x: Coordinate
    var y: Coordinate?

    init() {
        x = 0
        y = nil
    }
}

class ECCTests: XCTestCase {
    func testInit() {
        XCTAssertNotNil(MyECC())
    }

    func testAddition() {
        let a = MyECC(x: 0, y: 1)
        var b = MyECC.Infinity
        b = b + a
        XCTAssertEqual(b, a)
        b = b + a
        XCTAssertEqual(b, MyECC(x: 2, y: 0))
        b = b + a
        XCTAssertEqual(b, MyECC(x: 0, y: 6))
        b = b + a
        XCTAssertEqual(b, MyECC.Infinity)
    }


    func testVerifyEquation() {
        var points = [MyECC]()
        for i in 0..<P {
            for j in 0..<P {
                let x = FFInt7(i)
                let y = FFInt7(j)
                let point = MyECC(x: x, y: y)
                if MyECC.verifyEquation(forPoint: point) {
                    points.append(point)
                }
            }
        }
        XCTAssertEqual(points.count, 11)
        // the points are: (0, 1), (0, 6),
        // (1, 1), (1, 6), (2, 0), (3, 2),
        // (3, 5), (5, 3), (5, 4), (6, 1),
        // (6, 6)
    }

    func testMultiplication() {
        let a = MyECC(x: 6, y: 1)
        XCTAssertEqual(2 * a, MyECC(x: 3, y: 2))
        XCTAssertEqual(3 * a, MyECC(x: 2, y: 0))
        XCTAssertEqual(4 * a, MyECC(x: 3, y: 5))
        XCTAssertEqual(5 * a, MyECC(x: 6, y: 6))
        XCTAssertEqual(6 * a, MyECC.Infinity)
    }
}
