//

import Foundation
import XCTest
@testable import EllipticCurve

fileprivate let P: UInt8 = 223

struct FFInt223: FiniteField {
    typealias Element = UInt8
    static var Characteristic: UInt8 = P
    var value: UInt8

    init() {
        value = 0
    }
}

struct AnotherECC: EllipticCurve {
    typealias Coordinate = FFInt223

    static var a: Coordinate = 2
    static var b: Coordinate = 7

    var x: Coordinate
    var y: Coordinate?

    init() {
        x = 0
        y = nil
    }
}

class AnotherECCTests: XCTestCase {
    func testInit() {
        XCTAssertNotNil(AnotherECC())
    }

    func testAddition() {
        let point = AnotherECC(x: 16, y: 11)
        var next = point
        for _ in 0..<211 { // maximum order
            XCTAssertTrue(next.isOnCurve)
            XCTAssertFalse(next.isInfinity)
            next = next + point
        }
        XCTAssertTrue(next.isInfinity)
    }

    func testMultiplication() {
        let point = AnotherECC(x: 16, y: 11)
        for i in 1..<211 {
            XCTAssertFalse((i * point).isInfinity)
        }
        XCTAssertTrue((212 * point).isInfinity)
    }

    /* get all the valid points on curve
    func testVerifyEquation() {
        self.measure {
            var result = [AnotherECC]()
            for i in 0..<P {
                for j in 0..<P {
                    let x = FFInt223(i)
                    let y = FFInt223(j)
                    let point = AnotherECC(x: x, y: y)
                    if AnotherECC.verifyEquation(forPoint: point) {
                        var k: UInt8 = 0
                        var next = AnotherECC.Infinity
                        while k < P {
                            next = next + point

                            if !next.isInfinity {
                                k = k + 1
                                continue
                            }
                            if k < 200 {
                                break
                            }

                            print(k, point.description)
                            result.append(point)
                        }
                    }
                }
            }
        }
    }
    */
}
