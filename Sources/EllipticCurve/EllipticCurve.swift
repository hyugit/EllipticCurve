//

import Foundation

public protocol EllipticCurve: Equatable, CustomStringConvertible {
    associatedtype Coordinate: BasicArithmeticOperations

    static var a: Coordinate { get }
    static var b: Coordinate { get }

    var x: Coordinate { get set }
    var y: Coordinate? { get set }

    static var Infinity: Self { get }
    var isInfinity: Bool { get }
    var isOnCurve: Bool { get }

    init()
    init(x: Coordinate, y: Coordinate)
    init(isInfinity: Bool)

    static func +(lhs: Self, rhs: Self) -> Self
    static func *<T>(lhs: T, rhs: Self) -> Self where T: FixedWidthInteger

    static func verifyEquation(forPoint point: Self) -> Bool
}
