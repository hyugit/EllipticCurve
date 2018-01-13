//

import Foundation
//

import Foundation
import UInt256

fileprivate let Parameters = (
    P: UInt256([0xFFFFFFFF, UInt64.max, UInt64.max, 0xFFFFFFFEFFFFE56D]),

    a: UInt256(0),
    b: UInt256(5),

    G: (
        x: UInt256([0xA1455B33, 0x4DF099DF30FC28A1, 0x69A467E9E47075A9, 0x0F7E650EB6B7A45C]),
        y: UInt256([0x7E089FED, 0x7FBA344282CAFBD6, 0xF7E319F7C0B0BD59, 0xE2CA4BDB556D61A5])
    ),

    n: UInt256([0x100000000, 0, 0x0001DCE8D2EC6184, 0xCAF0A971769FB1F7])
)

public struct FFInt_secp224k1: FiniteFieldInteger {
    public static var Characteristic: UInt256 = Parameters.P
    public var value: UInt256

    public init() {
        value = 0
    }
}

public struct Secp224k1: EllipticCurveOverFiniteField {
    public static var Generator = Secp224k1(withCoordinates: Parameters.G)
    public static var Order: UInt256 = Parameters.n

    public static var a = FFInt_secp224k1(Parameters.a)
    public static var b = FFInt_secp224k1(Parameters.b)

    public var x: FFInt_secp224k1
    public var y: FFInt_secp224k1?

    public init() {
        x = 0
    }
}



