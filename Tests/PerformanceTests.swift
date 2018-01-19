//

import XCTest
import UInt256
@testable import EllipticCurve

class PerformanceTests: XCTestCase {
    func testMultiplicationPerf1() {
        self.measure {
            let privkey = UInt256(1) << 1
            let _ = privkey * Secp256k1.Generator
        }
    }

    func testMultiplicationPerf2() {
        self.measure {
            let privkey = UInt256(1) << 64
            let _ = privkey * Secp256k1.Generator
        }
    }
}
