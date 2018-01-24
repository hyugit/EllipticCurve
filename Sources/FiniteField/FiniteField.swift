//

import Foundation
@_exported import UInt256

public protocol FiniteField: CustomStringConvertible {
    associatedtype Element: UnsignedInteger, FixedWidthInteger

    static var Characteristic: Element { get }
    static var Order: Element { get }
    static var Zero: Self { get }
    static var One: Self { get }

    // these variabled could be precomputed and used to speed up the operations
    static var InverseCharacteristic: (high: Element, low: Element)? { get }
    static var InverseOrder: (high: Element, low: Element)? { get }

    init()
}
