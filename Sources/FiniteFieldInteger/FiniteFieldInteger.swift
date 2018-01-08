//

import Foundation
@_exported import UInt256

public protocol FiniteFieldInteger: FiniteField, ExpressibleByIntegerLiteral {
    
    var value: UInt256 { get set }

    init(_ source: UInt256)

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

    static func ==(lhs: Self, rhs: Self) -> Bool
}
