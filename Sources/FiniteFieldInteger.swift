//

import Foundation
import UInt256

public typealias FFInt = FiniteFieldInteger
private let P = CommonCurves.secp256k1.p

public struct FiniteFieldInteger: ExpressibleByIntegerLiteral, Equatable {
    public typealias IntegerLiteralType = Int

    public let value: UInt256
    public let primeOrder: UInt256

    init(_ value: UInt256) {
        self.init(primeOrder: P, value: value)
    }

    public init(integerLiteral value: Int) {
        self.init(UInt256(value))
    }

    init(primeOrder order: UInt256, value uint256: UInt256) {
        primeOrder = order
        value = uint256 % primeOrder
    }

    public static func +(lhs: FFInt, rhs: FFInt) -> FFInt {
        var (value, overflow) = lhs.value.addingReportingOverflow(rhs.value)

        if overflow || value >= lhs.primeOrder {
           value -= lhs.primeOrder
        }

        return FiniteFieldInteger(
            primeOrder: lhs.primeOrder,
            value: value
        )
    }

    public static func -(lhs: FFInt, rhs: FFInt) -> FFInt {
        var (value, overflow) = lhs.value.subtractingReportingOverflow(rhs.value)

        if overflow {
            value += lhs.primeOrder
        }

        return FiniteFieldInteger(
            primeOrder: lhs.primeOrder,
            value: value % lhs.primeOrder
        )
    }

    public static func *(lhs: FFInt, rhs: FFInt) -> FFInt {
        let (high, low) = lhs.value.multipliedFullWidth(by: rhs.value)
        let (_, remainder) = lhs.primeOrder.dividingFullWidth((high: high, low: low))
        return FiniteFieldInteger(primeOrder: lhs.primeOrder, value: remainder)
    }

    public static func /(lhs: FFInt, rhs: FFInt) -> FFInt {
        let quotient = lhs.value / rhs.value
        return FiniteFieldInteger(primeOrder: lhs.primeOrder, value: quotient)
    }

    public static func %(lhs: FFInt, rhs: FFInt) -> FFInt {
        let remainder = lhs.value % rhs.value
        return FiniteFieldInteger(primeOrder: lhs.primeOrder, value: remainder)
    }

    /// POW function overloading the XOR operator currently
    ///
    /// - Parameters:
    ///   - lhs: FiniteFieldInteger, the base number
    ///   - rhs: FiniteFieldInteger, the exponent
    /// - Returns: FiniteFieldInteger, the result of the power
    public static func ^(lhs: FFInt, rhs: FFInt) -> FFInt {
        /// this is the useful exponent, due to
        /// fermat's little thereom: base^(p-1) % p == 1
        var exponent: UInt256 = rhs.value % (lhs.primeOrder - 1)

        var currentExp: UInt256 = 1
        var currentVal: FFInt = lhs
        var trail: [(UInt256, FFInt)] = [(currentExp, currentVal)]

        /// construct a trail leading to the highest
        /// non-zero bit of exponent
        while exponent - currentExp >= currentExp {
            currentExp <<= 1
            currentVal = currentVal * currentVal
            trail.append((currentExp, currentVal))
        }

        var result = FiniteFieldInteger(
            primeOrder: lhs.primeOrder,
            value: 1
        )
        for (exp, val) in trail.reversed() {
            if exponent >= exp {
                exponent -= exp
            }
            result = result * val
        }

        return result
    }
    
    public static func ==(lhs: FFInt, rhs: FFInt) -> Bool {
        return lhs.value == rhs.value && lhs.primeOrder == rhs.primeOrder
    }
}
