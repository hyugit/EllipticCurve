//

import Foundation

/// EXPERIMENTAL
///
/// A top level protocol for elliptic curve crypto
///
/// to have value and point as properties instead of
/// protocol inheritance has certain benefits:
/// - it resembles more closely to ECKeyPairs where
///   value can be seen as the private key, and the
///   point can be seen as the public key
/// - it also allows reusing the default implementations
///   from both protocols -- inheriting would invalidate
///   default functions due to function naming conflicts
public protocol EllipticCurveOverFiniteField {
    associatedtype Value: FiniteField
    associatedtype Point: EllipticCurve where Point.Coordinate == Value

    static var Generator: Point { get }

    var value: Value? { get set }
    var point: Point { get set }

    init()
    init(withValue source: Value)
    init(withPoint source: Point)
}

extension EllipticCurveOverFiniteField {

    public var point: Point {
        get {
            return point
        }

        set {
            point = newValue
            self.value = nil
        }
    }

    init(withPoint source: Point) {
        self.init()
        self.point = source
    }

    init(withValue source: Value) {
        self.init()
        self.value = source
        self.point = source.value * Self.Generator
    }
}
