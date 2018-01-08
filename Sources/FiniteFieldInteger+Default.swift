//

import Foundation

extension FiniteFieldInteger {
    public typealias Multiplier = Self.Type
    public typealias IntegerLiteralType = Int

    public static var Zero: Self {
        get {
            return Self(0)
        }
    }

    public var description: String {
        return "\(Self.Type.self): \(value) of F_\(Self.Characteristic)"
    }

    public init(integerLiteral value: Int) {
        self.init(ValueType(value))
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
            (value, overflow) = value.addingReportingOverflow(Self.Characteristic)
        }
        
        return Self(value % Self.Characteristic)
    }
    
    public static func *(lhs: Self, rhs: Self) -> Self {
        let (high, low) = lhs.value.multipliedFullWidth(by: rhs.value)
        let (_, remainder) = Self.Characteristic.dividingFullWidth((high: high, low: low))
        return Self(remainder)
    }

    public static func /(lhs: Self, rhs: Self) -> Self {
        /// because of fermat's little thereom: base^(p-1) % p == 1
        /// division becomes multiplication:
        /// rhs^(p-1) == 1 -> 1/rhs = rhs^(p-2)
        /// lhs/rhs = lhs * 1/rhs = lhs * rhs^(p-2)
        let exp = rhs ^ Self(Self.Characteristic - 2)
        let result = lhs * exp
        return result
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
        /// this is the actual useful exponent, because of
        /// fermat's little thereom: base^(p-1) % p == 1
        var exponent: ValueType = rhs.value % (Self.Characteristic - 1)

        var currentVal: Self = lhs
        var trail: [Self] = []

        /// construct a trail leading to the highest
        /// non-zero bit of exponent
        let bitLength = exponent.bitWidth - exponent.leadingZeroBitCount
        for _ in 0..<bitLength {
            trail.append(currentVal)
            currentVal = currentVal * currentVal
        }

        var result = Self(1)
        for (index, val) in trail.enumerated().reversed() {
            if (exponent >> index) & 0b1 == 1 {
                result = result * val
                exponent -= 0b1 << index
            }
        }
        
        return result
    }
    
    public static func ==(lhs: Self, rhs: Self) -> Bool {
        return lhs.value == rhs.value
    }
}
