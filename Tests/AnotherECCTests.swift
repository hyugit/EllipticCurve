//

import Foundation
import XCTest
@testable import EllipticCurve

fileprivate let P: UInt8 = 223

class AnotherECCTests: XCTestCase {


    struct FFInt223: FiniteFieldInteger {
        static var Characteristic = P
        var value: UInt8

        init() {
            value = 0
        }
    }

    struct AnotherECC: EllipticCurve {

        static var a: FFInt223 = 2
        static var b: FFInt223 = 7

        var x: FFInt223
        var y: FFInt223?

        init() {
            x = 0
        }
    }

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

        // this finite field of points has 211
        // elements, i.e. order Q == 211
        for i in 1...211 {
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
