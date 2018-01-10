//

import Foundation

extension FiniteField {
    public typealias IntegerLiteralType = Int
    public typealias Magnitude = Self.Type

    public static var Zero: Self {
        get {
            return Self(withValue: 0)
        }
    }

    init(_ source: Element) {
        self.init(withValue: source)
    }

    init?<T>(exactly source: T) where T : BinaryInteger {
        let src = Element(exactly: source)
        self.init(withValue: src!)
    }

    var magnitude: Self {
        return Self(withValue: value)
    }

    public var description: String {
        return "\(Self.Type.self): \(value) of F_\(Self.Characteristic)"
    }

    public init(integerLiteral value: Int) {
        self.init(withValue: Element(value))
    }

    public static func +(lhs: Self, rhs: Self) -> Self {
        var (value, overflow) = lhs.value.addingReportingOverflow(rhs.value)
        
        if overflow || value >= Self.Characteristic {
            value -= Self.Characteristic
        }

        return Self(withValue: value)
    }

    public static func +=(lhs: inout Self, rhs: Self) {
        lhs = lhs + rhs
    }

    public static func -(lhs: Self, rhs: Self) -> Self {
        var (value, overflow) = lhs.value.subtractingReportingOverflow(rhs.value)
        
        if overflow {
            (value, overflow) = value.addingReportingOverflow(Self.Characteristic)
        }
        
        return Self(withValue: value)
    }

    public static func -=(lhs: inout Self, rhs: Self) {
        lhs = lhs - rhs
    }

    public static func *(lhs: Self, rhs: Self) -> Self {
        let (high, low) = lhs.value.multipliedFullWidth(by: rhs.value)
        let (_, remainder) = Self.Characteristic.dividingFullWidth((high: high, low: low))
        return Self(withValue: remainder)
    }

    public static func *=(lhs: inout Self, rhs: Self) {
        lhs = lhs * rhs
    }

    public static func /(lhs: Self, rhs: Self) -> Self {
        /// because of fermat's little thereom: base^(p-1) % p == 1
        /// division becomes multiplication:
        /// rhs^(p-1) == 1 -> 1/rhs = rhs^(p-2)
        /// lhs/rhs = lhs * 1/rhs = lhs * rhs^(p-2)
        let exp = rhs ^ Self(withValue: Self.Characteristic - 2)
        let result = lhs * exp
        return result
    }

    public static func /=(lhs: inout Self, rhs: Self) {
        lhs = lhs / rhs
    }

    public static func <(lhs: Self, rhs: Self) -> Bool {
        return lhs.value < rhs.value
    }

    public static func >(lhs: Self, rhs: Self) -> Bool {
        return lhs.value > rhs.value
    }

    /// POW function overloading the XOR operator currently
    ///
    /// - Parameters:
    ///   - lhs: the base number
    ///   - rhs: the exponent
    /// - Returns: the result of the power
    static func ^(lhs: Self, rhs: Self) -> Self {
        /// this is the actual useful exponent, because of
        /// fermat's little thereom: base^(p-1) % p == 1
        var exponent: Element = rhs.value % (Self.Characteristic - 1)

        var currentVal: Self = lhs
        var trail: [Self] = []

        /// construct a trail leading to the highest
        /// non-zero bit of exponent
        let bitLength = exponent.bitWidth - exponent.leadingZeroBitCount
        for _ in 0..<bitLength {
            trail.append(currentVal)
            currentVal = currentVal * currentVal
        }

        var result = Self(withValue: 1)
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
