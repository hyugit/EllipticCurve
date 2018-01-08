//

import Foundation

public protocol FiniteFieldInteger: ElementOfFiniteField, ExpressibleByIntegerLiteral {
    
    var value: ValueType { get set }

    init(_ source: ValueType)

    static prefix func -(lhs: Self) -> Self

    static func +(lhs: Self, rhs: Self) -> Self
    static func -(lhs: Self, rhs: Self) -> Self
    static func *(lhs: Self, rhs: Self) -> Self
    static func /(lhs: Self, rhs: Self) -> Self
    static func %(lhs: Self, rhs: Self) -> Self

    /// POW function currently overloading the XOR operator
    ///
    /// - Parameters:
    ///   - lhs: FiniteFieldInteger, the base number
    ///   - rhs: FiniteFieldInteger, the exponent
    /// - Returns: FiniteFieldInteger, the result of the power
    static func ^(lhs: Self, rhs: Self) -> Self
}
