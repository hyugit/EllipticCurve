//

import Foundation
import UInt256

public protocol FiniteField: Equatable {
    associatedtype Multiplier where Multiplier: FiniteField

    static var Characteristic: UInt256 { get }
    static var Zero: Self { get }

    static func ==(lhs: Self, rhs: Self) -> Bool
    static func +(lhs: Self, rhs: Self) -> Self
    static func *(lhs: Multiplier, rhs: Self) -> Self
}
