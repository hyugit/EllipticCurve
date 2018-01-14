//

import Foundation

/// FiniteFieldInteger: a finite field with an integer as element type.
/// Arithmetic are implemented by default for UInt family members that
/// follow UnsignedInteger & FixedWidthInteger protocols
public protocol FiniteFieldInteger: FiniteField, BasicArithmeticOperations {

    var value: Element { get set }

    init(withValue source: Element)
    init(_ source: Element)
}
