//

import Foundation
import UInt256

public struct Parameters {
    public static var P = UInt256([UInt64.max, UInt64.max, UInt64.max, 0xFFFFFFFEFFFFFC2F])

    public static var a = FFInt(0)
    public static var b = FFInt(7)

    static var Gx = UInt256([0x79BE667EF9DCBBAC, 0x55A06295CE870B07, 0x029BFCDB2DCE28D9, 0x59F2815B16F81798])
    static var Gy = UInt256([0x483ADA7726A3C465, 0x5DA4FBFC0E1108A8, 0xFD17B448A6855419, 0x9C47D08FFB10D4B8])

    public static var G = ECPoint(x: FFInt(Gx), y: FFInt(Gy))

    public static var n = UInt256([UInt64.max, 0xFFFFFFFFFFFFFFFE, 0xBAAEDCE6AF48A03B, 0xBFD25E8CD0364141])
}

public struct FFInt: FiniteField {
    public typealias Element = UInt256
    public static var Characteristic: UInt256 = Parameters.P
    public static var Order: UInt256 = Parameters.n
    public var value: UInt256

    public init() {
        value = 0
    }
}

public struct ECPoint: EllipticCurve {
    public typealias Coordinate = FFInt

    public static var a: Coordinate = Parameters.a
    public static var b: Coordinate = Parameters.b

    public var x: Coordinate
    public var y: Coordinate?

    public init() {
        x = 0
        y = nil
    }
}
