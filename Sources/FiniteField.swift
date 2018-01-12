//

import Foundation
import UInt256

public protocol FiniteField: CustomStringConvertible {
    associatedtype Element: UnsignedInteger, FixedWidthInteger

    static var Characteristic: Element { get }
    static var Order: Element { get }
    static var Zero: Self { get }
    static var One: Self { get }

    init()
}
