//

import Foundation

/// A top level protocol for elliptic curve crypto
///
/// elliptic curve over finite field itself is a finite
/// field of points, with Infinity being Zero, Generator
/// being One.
///
/// The Coordinate typealias from EllipticCurve
/// is the determining factor of the types, as can be seen from
/// protocol requirements.
///
/// The protocol also has an optional value property which is
/// used to represent the "index" from which the coordinates
/// can be calculated:
///
/// coordinates = index * Generator
///
public protocol EllipticCurveOverFiniteField: EllipticCurve, FiniteField where
    Self.Coordinate: FiniteFieldInteger,
    Self.Element == Self.Coordinate.Element
{
    static var Generator: Self { get }

    init()
    init?(withSeed value: Element)
    init?(_ source: Element)
    init(withCoordinates coord: (x: Element, y: Element))
}
