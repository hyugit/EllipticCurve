//

import XCTest
import UInt256
@testable import EllipticCurve

fileprivate var P: UInt8 = 7

class ECDSATests: XCTestCase {

    struct FFInt7: FiniteFieldInteger {
        static var Characteristic = P
        var value: UInt8

        init() {
            value = 0
        }
    }

    struct MyECFF: EllipticCurveOverFiniteField {
        static var Order: UInt8 = 6
        static var Generator: MyECFF = MyECFF(x: 6, y: 1)

        static var a: FFInt7 = 6
        static var b: FFInt7 = 1

        var x: FFInt7
        var y: FFInt7?

        init() {
            x = 0
        }
    }

    func testInit() {
        let e = ECDSA<MyECFF>()
        XCTAssertNil(FFInt7.InverseOrder)
        XCTAssertNil(FFInt7.InverseCharacteristic)
        XCTAssertNil(MyECFF.InverseOrder)
        XCTAssertNil(MyECFF.InverseCharacteristic)
        XCTAssertNotNil(e)
    }

    func testVerify() {
        let d = Data()
        func f(m: Data) -> UInt8 { return 1 }
        XCTAssertFalse(ECDSA<MyECFF>.verify(signature: (3, 4), withPoint: MyECFF.Infinity, forMessage: d, hashedBy: f))
        XCTAssertFalse(ECDSA<MyECFF>.verify(signature: (3, 4), withPoint: MyECFF(x: 0, y: 2), forMessage: d, hashedBy: f))
        XCTAssertFalse(ECDSA<MyECFF>.verify(signature: (0, 1), withPoint: MyECFF(x: 6, y: 1), forMessage: d, hashedBy: f))
        XCTAssertFalse(ECDSA<MyECFF>.verify(signature: (1, 0), withPoint: MyECFF(x: 6, y: 1), forMessage: d, hashedBy: f))
    }

    func testSignAndVerify() {
        // skip certain conbinations as they tend to create loops,
        // this is due to the fact that this field has very limited
        // choices of parameters
        for (h, k) in [(1, 1), (1, 2), (1, 3), (1, 4), (1, 5), (2, 1), (2, 2), (2, 4), (2, 5)] {
            let data = Data()
            func f(m: Data) -> UInt8 { return UInt8(h) }
            let key = UInt8(truncatingIfNeeded: k)
            let signature = ECDSA<MyECFF>.sign(message: data, signedBy: key, hashedBy: f)
            let address = key * MyECFF.Generator
            let verified = ECDSA<MyECFF>.verify(signature: signature, withPoint: address, forMessage: data, hashedBy: f)
            XCTAssertTrue(verified)
            sleep(1)
        }
    }
}
