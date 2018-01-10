//

import Foundation
import UInt256

public protocol FiniteField: NumericWithDivision, Comparable, CustomStringConvertible {
    associatedtype Element: UnsignedInteger, FixedWidthInteger

    static var Characteristic: Element { get }
    static var Order: Element { get }
    static var Zero: Self { get }

    var value: Element { get set }

    init()
    init(withValue source: Element)
    init(_ source: Element)
}
