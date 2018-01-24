//

import Foundation
//

import Foundation
import UInt256

fileprivate let Parameters = (
    P: UInt256([0xFFFFFFFF00000001, UInt64.min, 0xFFFFFFFF, UInt64.max]),

    a: UInt256([0xFFFFFFFF00000001, UInt64.min, 0xFFFFFFFF, UInt64.max - 4]),
    b: UInt256([0x5AC635D8AA3A93E7, 0xB3EBBD55769886BC, 0x651D06B0CC53B0F6, 0x3BCE3C3E27D2604B]),

    G: (
        x: UInt256([0x6B17D1F2E12C4247, 0xF8BCE6E563A440F2, 0x77037D812DEB33A0, 0xF4A13945D898C296]),
        y: UInt256([0x4FE342E2FE1A7F9B, 0x8EE7EB4A7C0F9E16, 0x2BCE33576B315ECE, 0xCBB6406837BF51F5])
    ),

    n: UInt256([0xFFFFFFFF00000000, UInt64.max, 0xBCE6FAADA7179E84, 0xF3B9CAC2FC632551])
)

public struct Secp256r1: EllipticCurveOverFiniteField {

    public struct FFInt: FiniteFieldInteger {
        public static var Characteristic: UInt256 = Parameters.P
        public var value: UInt256

        public init() {
            value = 0
        }
    }

    public static var Generator = Secp256r1(withCoordinates: Parameters.G)
    public static var Order: UInt256 = Parameters.n

    public static var a = FFInt(Parameters.a)
    public static var b = FFInt(Parameters.b)

    public var x: FFInt
    public var y: FFInt?

    public init() {
        x = 0
    }
}

