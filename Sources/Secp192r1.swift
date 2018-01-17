//

import Foundation
//

import Foundation
import UInt256

fileprivate let Parameters = (
    P: UInt256([0, UInt64.max,  UInt64.max - 1, UInt64.max]),

    a: UInt256([0, UInt64.max, UInt64.max - 1, UInt64.max - 3]),
    b: UInt256([0, 0x64210519E59C80E7, 0x0FA7E9AB72243049, 0xFEB8DEECC146B9B1]),

    G: (
        x: UInt256([0, 0x188DA80EB03090F6, 0x7CBF20EB43A18800, 0xF4FF0AFD82FF1012]),
        y: UInt256([0, 0x07192B95FFC8DA78, 0x631011ED6B24CDD5, 0x73F977A11E794811])
    ),

    n: UInt256([0, UInt64.max, 0xFFFFFFFF99DEF836, 0x146BC9B1B4D22831])
)

public struct Secp192r1: EllipticCurveOverFiniteField {

    public struct FFInt: FiniteFieldInteger {
        public static var Characteristic: UInt256 = Parameters.P
        public var value: UInt256

        public init() {
            value = 0
        }
    }

    public static var Generator = Secp192r1(withCoordinates: Parameters.G)
    public static var Order: UInt256 = Parameters.n

    public static var a = FFInt(Parameters.a)
    public static var b = FFInt(Parameters.b)

    public var x: FFInt
    public var y: FFInt?

    public init() {
        x = 0
    }
}



