//

import Foundation
import UInt256

public protocol ElementOfFiniteField: Equatable, CustomStringConvertible {
    associatedtype ValueType: UnsignedInteger, FixedWidthInteger
    associatedtype Multiplier where Multiplier: ElementOfFiniteField

    static var Characteristic: ValueType { get }
    static var Order: ValueType { get }
    static var Zero: Self { get }

    static func ==(lhs: Self, rhs: Self) -> Bool
    static func +(lhs: Self, rhs: Self) -> Self
    static func *(lhs: Multiplier, rhs: Self) -> Self
}
