//

import Foundation

public protocol EllipticCurve: Equatable {
    associatedtype NumericType: UnsignedInteger
    static var a: NumericType { get }
    static var b: NumericType { get }
}
