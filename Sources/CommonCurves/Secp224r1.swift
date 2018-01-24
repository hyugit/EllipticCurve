//

import Foundation
//

import Foundation
import UInt256

fileprivate let Parameters = (
    P: UInt256([0xFFFFFFFF, UInt64.max, 0xFFFFFFFF00000000, 1]),

    a: UInt256([0xFFFFFFFF, UInt64.max, 0xFFFFFFFEFFFFFFFF, 0xFFFFFFFFFFFFFFFE]),
    b: UInt256([0xB4050A85, 0x0C04B3ABF5413256, 0x5044B0B7D7BFD8BA, 0x270B39432355FFB4]),

    G: (
        x: UInt256([0xB70E0CBD, 0x6BB4BF7F321390B9, 0x4A03C1D356C21122, 0x343280D6115C1D21]),
        y: UInt256([0xBD376388, 0xB5F723FB4C22DFE6, 0xCD4375A05A074764, 0x44D5819985007E34])
    ),

    n: UInt256([0xFFFFFFFF, UInt64.max, 0xFFFF16A2E0B8F03E, 0x13DD29455C5C2A3D])
)

public struct Secp224r1: EllipticCurveOverFiniteField {

    public struct FFInt: FiniteFieldInteger {
        public static var Characteristic: UInt256 = Parameters.P
        public var value: UInt256

        public init() {
            value = 0
        }
    }

    public static var Generator = Secp224r1(withCoordinates: Parameters.G)
    public static var Order: UInt256 = Parameters.n

    public static var a = FFInt(Parameters.a)
    public static var b = FFInt(Parameters.b)

    public var x: FFInt
    public var y: FFInt?

    public init() {
        x = 0
    }
}




