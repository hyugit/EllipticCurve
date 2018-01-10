//

import Foundation

public protocol EllipticCurveOverFiniteField: FiniteField, EllipticCurve where Coordinate == Element {
    static var G: Self { get }
}
