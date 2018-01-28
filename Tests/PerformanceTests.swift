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
            let privkey = UInt256(1) << 2
            let _ = privkey * Secp256k1.Generator
        }
    }

    func testMultiplicationPerf4() {
        self.measure {
            let privkey = UInt256(1) << 4
            let _ = privkey * Secp256k1.Generator
        }
    }

    func testMultiplicationPerf8() {
        self.measure {
            let privkey = UInt256(1) << 8
            let _ = privkey * Secp256k1.Generator
        }
    }

    func testMultiplicationPerf16() {
        self.measure {
            let privkey = UInt256(1) << 16
            let _ = privkey * Secp256k1.Generator
        }
    }

    func testMultiplicationPerf32() {
        self.measure {
            let privkey = UInt256(1) << 32
            let _ = privkey * Secp256k1.Generator
        }
    }

    func testMultiplicationPerf64() {
        self.measure {
            let privkey = UInt256(1) << 64
            let _ = privkey * Secp256k1.Generator
        }
    }

    // make sure the building process does not slow down UInt256
    func testUInt256Multiplication() {
        self.measure {
            for _ in 0..<1000 {
                let a = arc4random_uniform(UInt256.max)
                let b = arc4random_uniform(UInt256.max)
                let _ = UInt256.karatsuba(a, b)
            }
        }
    }

    func testUInt256Division() {
        self.measure {
            for _ in 0..<1000 {
                let h = arc4random_uniform(UInt256.max)
                let l = arc4random_uniform(UInt256.max)
                let a = arc4random_uniform(UInt256.max)
                let _ = a.dividingFullWidth((h, l))
            }
        }
    }

    func testFiniteFieldIntegerPower() {
        self.measure {
            for _ in 0..<10 {
                let a = arc4random_uniform(UInt256.max)
                let b = arc4random_uniform(UInt256.max)
                let _ = Secp256k1.FFInt(a) ^ Secp256k1.FFInt(b)
            }
        }
    }
}
