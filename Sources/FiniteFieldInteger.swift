//

import Foundation

public protocol FiniteFieldInteger: FiniteField, Numeric, Comparable {

    var value: Element { get set }

    init(withValue source: Element)
    init(_ source: Element)

    /// POW function currently overloading the XOR operator
    ///
    /// - Parameters:
    ///   - lhs: FiniteFieldInteger, the base number
    ///   - rhs: FiniteFieldInteger, the exponent
    /// - Returns: FiniteFieldInteger, the result of the power
    static func ^(lhs: Self, rhs: Self) -> Self
}
