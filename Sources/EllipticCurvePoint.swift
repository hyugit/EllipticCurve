//

import Foundation

public protocol EllipticCurvePoint: EllipticCurve, CustomStringConvertible {
    var x: NumericType { get set }
    var y: NumericType? { get set }

    var isInfinity: Bool { get }

    init(x: NumericType, y: NumericType)
    init(isInfinity: Bool)

    static func +(lhs: Self, rhs: Self) -> Self
    static func *(lhs: NumericType, rhs: Self) -> Self

    static func verifyEquation(forPoint point: Self) -> Bool
}
