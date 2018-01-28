//

import Foundation
import UInt256

extension UInt256: BasicArithmeticOperations {}

fileprivate let Parameters = (
    P: UInt256([UInt64.max, UInt64.max, UInt64.max, 0xFFFFFFFEFFFFFC2F]),
    InverseP: (
        high: UInt256(1),
        low: UInt256([0, 0, 0, 0x1000003d1])
    ),

    a: UInt256(0),
    b: UInt256(7),

    G: (
        x: UInt256([0x79BE667EF9DCBBAC, 0x55A06295CE870B07, 0x029BFCDB2DCE28D9, 0x59F2815B16F81798]),
        y: UInt256([0x483ADA7726A3C465, 0x5DA4FBFC0E1108A8, 0xFD17B448A6855419, 0x9C47D08FFB10D4B8])
    ),

    N: UInt256([UInt64.max, 0xFFFFFFFFFFFFFFFE, 0xBAAEDCE6AF48A03B, 0xBFD25E8CD0364141]),
    InverseN: (
        high: UInt256(1),
        low: UInt256([0, 1, 0x4551231950b75fc4, 0x402da1732fc9bec0])
    )
)

public struct Secp256k1: EllipticCurveOverFiniteField {
    public struct FFInt: FiniteFieldInteger {
        public static var Characteristic: UInt256 = Parameters.P
        public static var InverseCharacteristic: (high: UInt256, low: UInt256)? = Parameters.InverseP
        public var value: UInt256

        public init() {
            value = 0
        }
    }

    public static var Generator = Secp256k1(withCoordinates: Parameters.G)
    public static var Order: UInt256 = Parameters.N
    public static var InverseOrder: (high: UInt256, low: UInt256)? = Parameters.InverseN

    public static var a = FFInt(Parameters.a)
    public static var b = FFInt(Parameters.b)

    public var x: FFInt
    public var y: FFInt?

    public init() {
        x = 0
    }
}
