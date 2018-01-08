//

import Foundation
import UInt256

enum CommonCurves {
    case secp256k1
    
    /// The characteristic of the finite field domain that secp256k1 uses
    public var p: UInt256 {
        switch self {
        case .secp256k1:
            return UInt256([UInt64.max, UInt64.max, UInt64.max, 0xfffffffefffffc2f])
        }
    }
    
    public var a: UInt256 {
        switch self {
        case .secp256k1: return UInt256(0)
        }
    }
    
    public var b: UInt256 {
        switch self {
        case .secp256k1: return UInt256(7)
        }
    }
    
    public var G: (x: UInt256, y: UInt256) {
        switch self {
        case .secp256k1:
            return (
                x: UInt256([
                    0x79be667ef9dcbbac,
                    0x55a06295ce870b07,
                    0x029bfcdb2dce28d9,
                    0x59f2815b16f81798
                ]),
                y: UInt256([
                    0x483ada7726a3c465,
                    0x5da4fbfc0e1108a8,
                    0xfd17b448a6855419,
                    0x9c47d08ffb10d4b8
                ])
            )
        }
    }
    
    public var n: UInt256 {
        switch self {
        case .secp256k1:
            return UInt256([UInt64.max, UInt64.max - 1, 0xbaaedce6af48a03b, 0xbfd25e8cd0364141])
        }
    }
    
    public var h: UInt256 {
        switch self {
        case .secp256k1: return UInt256(1)
        }
    }
}
