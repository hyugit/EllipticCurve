//

import Foundation
import UInt256

/// maybe should be extension for FiniteFieldIntegers,
/// well... at least those arithmetics are for integers specifically
/// and do not apply to points or other element types
extension FiniteFieldInteger {

    public static var Order: Element {
        get {
            return Self.Characteristic
        }
    }

    public static var InverseCharacteristic: (high: Element, low: Element)? {
        get {
            return nil
        }
    }

    public static var InverseOrder: (high: Element, low: Element)? {
        get {
            return nil
        }
    }

    public static var Zero: Self {
        get {
            return Self(withValue: 0)
        }
    }

    public static var One: Self {
        get {
            return Self(withValue: 1)
        }
    }

    public init(withValue source: Element) {
        self.init()
        let element: Element = source
        self.value = element % Self.Characteristic
    }

    public init(_ source: Element) {
        self.init(withValue: source)
    }

    public init?<T>(exactly source: T) where T : BinaryInteger {
        if let src = Element(exactly: source) {
            self.init(withValue: src)
        } else {
            return nil
        }
    }

    public init(integerLiteral: Int) {
        if integerLiteral >= 0 {
            self.init(withValue: Element(integerLiteral))
        } else {
            self.init(withValue: Element(truncatingIfNeeded: integerLiteral))
        }
    }

    public var magnitude: Self {
        return Self(withValue: value)
    }

    public var description: String {
        return "Element \(value) of F_\(Self.Characteristic)"
    }

    public static func +(lhs: Self, rhs: Self) -> Self {
        var (value, overflow) = lhs.value.addingReportingOverflow(rhs.value)

        if overflow || value >= Self.Characteristic {
            (value, overflow) = value.subtractingReportingOverflow(Self.Characteristic)
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
        let remain: Element
        if let inv = Self.InverseCharacteristic {
            (_, remain) = Self.Characteristic.dividingFullWidth((high, low), withPrecomputedInverse: inv)
        } else {
            (_, remain) = Self.Characteristic.dividingFullWidth((high, low))
        }
        return Self(withValue: remain)
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

        var result = Self(withValue: 1)
        while exponent > 0 {
            if exponent & 0b1 == 1 {
                result = result * currentVal
            }
            exponent = exponent >> 1
            currentVal = currentVal * currentVal
        }

        return result
    }
    
    public static func ==(lhs: Self, rhs: Self) -> Bool {
        return lhs.value == rhs.value
    }
}
