//

import Foundation
import UInt256

extension FiniteFieldInteger {
    public typealias Multiplier = Self.Type
    public typealias IntegerLiteralType = Int

    public static var Zero: Self {
        get {
            return Self(0)
        }
    }

    public init(integerLiteral value: Int) {
        self.init(UInt256(value))
    }

    public static func +(lhs: Self, rhs: Self) -> Self {
        var (value, overflow) = lhs.value.addingReportingOverflow(rhs.value)
        
        if overflow || value >= Self.Characteristic {
            value -= Self.Characteristic
        }

        return Self(value)
    }
    
    public static prefix func -(lhs: Self) -> Self {
        return Self.Zero - lhs
    }
    
    public static func -(lhs: Self, rhs: Self) -> Self {
        var (value, overflow) = lhs.value.subtractingReportingOverflow(rhs.value)
        
        if overflow {
            value += Self.Characteristic
        }
        
        return Self(value % Self.Characteristic)
    }
    
    public static func *(lhs: Self, rhs: Self) -> Self {
        let (high, low) = lhs.value.multipliedFullWidth(by: rhs.value)
        let (_, remainder) = Self.Characteristic.dividingFullWidth((high: high, low: low))
        return Self(remainder)
    }
    
    public static func /(lhs: Self, rhs: Self) -> Self {
        let quotient = lhs.value / rhs.value
        return Self(quotient)
    }
    
    public static func %(lhs: Self, rhs: Self) -> Self {
        let remainder = lhs.value % rhs.value
        return Self(remainder)
    }

    /// POW function overloading the XOR operator currently
    ///
    /// - Parameters:
    ///   - lhs: FiniteFieldInteger, the base number
    ///   - rhs: FiniteFieldInteger, the exponent
    /// - Returns: FiniteFieldInteger, the result of the power
    public static func ^(lhs: Self, rhs: Self) -> Self {
        /// this is the useful exponent, due to
        /// fermat's little thereom: base^(p-1) % p == 1
        var exponent: UInt256 = rhs.value % (Self.Characteristic - 1)
        
        var currentExp: UInt256 = 1
        var currentVal: Self = lhs
        var trail: [(UInt256, Self)] = [(currentExp, currentVal)]
        
        /// construct a trail leading to the highest
        /// non-zero bit of exponent
        while exponent - currentExp >= currentExp {
            currentExp <<= 1
            currentVal = currentVal * currentVal
            trail.append((currentExp, currentVal))
        }

        var result = Self(1)
        for (exp, val) in trail.reversed() {
            if exponent >= exp {
                exponent -= exp
            }
            result = result * val
        }
        
        return result
    }
    
    public static func ==(lhs: Self, rhs: Self) -> Bool {
        return lhs.value == rhs.value
    }
}
