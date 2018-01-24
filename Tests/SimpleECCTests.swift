//

import Foundation
import XCTest
@testable import EllipticCurve

fileprivate let P: UInt8 = 7

extension UInt8: BasicArithmeticOperations {}

class ECCTests: XCTestCase {

    struct FFInt7: FiniteFieldInteger {
        static var Characteristic = P
        var value: UInt8

        init() {
            value = 0
        }
    }

    struct MyECC: EllipticCurve {
        static var a: FFInt7 = 6
        static var b: FFInt7 = 1

        var x: FFInt7
        var y: FFInt7?

        init() {
            x = 0
            y = nil
        }
    }

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


    /// find all the points on the curve
    ///
    /// the result is: (0, 1), (0, 6),
    /// (1, 1), (1, 6), (2, 0), (3, 2),
    /// (3, 5), (5, 3), (5, 4), (6, 1),
    /// (6, 6)
    ///
    /// confirm the result with http://graui.de/code/elliptic2/
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
    }

    func testMultiplication() {
        let a = MyECC(x: 6, y: 1)
        for i in 0..<100 {
            switch i % 6 {
            case 1: XCTAssertEqual(i * a, a)
            case 2: XCTAssertEqual(i * a, MyECC(x: 3, y: 2))
            case 3: XCTAssertEqual(i * a, MyECC(x: 2, y: 0))
            case 4: XCTAssertEqual(i * a, MyECC(x: 3, y: 5))
            case 5: XCTAssertEqual(i * a, MyECC(x: 6, y: 6))
            default: XCTAssertEqual(i * a, MyECC.Infinity)
            }
        }
    }
}
