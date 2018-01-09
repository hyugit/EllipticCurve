//

import Foundation
import UInt256

public protocol FiniteField: Equatable, CustomStringConvertible {
    associatedtype Element: UnsignedInteger, FixedWidthInteger

    static var Characteristic: Element { get }
    static var Order: Element { get }
    static var Zero: Self { get }

    static func +(lhs: Self, rhs: Self) -> Self
    static func *<T>(lhs: T, rhs: Self) -> Self where T: Numeric
}
