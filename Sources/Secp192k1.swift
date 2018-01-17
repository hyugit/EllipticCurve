//

import Foundation
//

import Foundation
import UInt256

fileprivate let Parameters = (
    P: UInt256([0, UInt64.max, UInt64.max, 0xFFFFFFFEFFFFEE37]),

    a: UInt256(0),
    b: UInt256(3),

    G: (
        x: UInt256([0, 0xDB4FF10EC057E9AE, 0x26B07D0280B7F434, 0x1DA5D1B1EAE06C7D]),
        y: UInt256([0, 0x9B2F2F6D9C5628A7, 0x844163D015BE8634, 0x4082AA88D95E2F9D])
    ),

    n: UInt256([0, UInt64.max, 0xFFFFFFFE26F2FC17, 0x0F69466A74DEFD8D])
)

public struct Secp192k1: EllipticCurveOverFiniteField {

    public struct FFInt: FiniteFieldInteger {
        public static var Characteristic: UInt256 = Parameters.P
        public var value: UInt256

        public init() {
            value = 0
        }
    }

    public static var Generator = Secp192k1(withCoordinates: Parameters.G)
    public static var Order: UInt256 = Parameters.n

    public static var a = FFInt(Parameters.a)
    public static var b = FFInt(Parameters.b)

    public var x: FFInt
    public var y: FFInt?

    public init() {
        x = 0
    }
}


