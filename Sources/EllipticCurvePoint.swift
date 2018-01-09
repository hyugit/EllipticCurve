//

import Foundation

public protocol EllipticCurvePoint: EllipticCurve, CustomStringConvertible {
    var x: NumericType { get set }
    var y: NumericType? { get set }

    static var Infinity: Self { get }
    var isInfinity: Bool { get }

    init(x: NumericType, y: NumericType)
    init(isInfinity: Bool)

    static func +(lhs: Self, rhs: Self) -> Self
    static func *<T>(lhs: T, rhs: Self) -> Self where T: FixedWidthInteger

    static func verifyEquation(forPoint point: Self) -> Bool
}

public protocol EllipticCurveOverFiniteField: FiniteField {
    associatedtype Point where Point: EllipticCurvePoint
    static var G: Point { get }
}
