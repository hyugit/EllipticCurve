//

import Foundation
import UInt256

/// FiniteFieldInteger: a finite field with an integer as element type.
/// Arithmetic are implemented by default for UInt family members that
/// follow UnsignedInteger & FixedWidthInteger protocols
public protocol FiniteFieldInteger: FiniteField, BasicArithmeticOperations where Element: FixedWidthIntegerWithBarrettDivision, IntegerLiteralType == Int, Magnitude == Self {

    var value: Element { get set }

    init(withValue source: Element)
    init(_ source: Element)
}
