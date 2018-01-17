//

import Foundation
import UInt256

public struct ECDSA<Point: EllipticCurveOverFiniteField> {
    public typealias Element = Point.Element
    public typealias Signature = (r: Element, s: Element)

    private struct IsomorphicField: FiniteFieldInteger {
        public static var Characteristic: Element {
            return Point.Order
        }

        public var value: Element

        public init() {
            value = 0
        }
    }

    init() {}

    static func sign(hash: Element, withKey key: Element) -> (signature: Signature, point: Point) {

        // calculate r
        let d = IsomorphicField(withValue: key)
        let Q = d.value * Point.Generator
        let r = IsomorphicField(withValue: Q.x.value)

        // calculate s
        var random = arc4random_uniform(Point.Order)
        while random < 1 || random == key {
            random = arc4random_uniform(Point.Order)
        }
        let k = IsomorphicField(withValue: random)
        let z = IsomorphicField(withValue: hash)
        let s = (z + r * d) / k

        return (
            signature: (r: r.value, s: s.value),
            point: Q
        )
    }

    static func verify(signature: Signature, of hash: Element, for point: Point) -> Bool {
        guard !point.isInfinity else {
            return false
        }

        guard point.isOnCurve else {
            return false
        }

        guard Point.Order * point == Point.Infinity else {
            print("not infinity!? something is horribly wrong")
            return false
        }

        guard 0 < signature.r && signature.r < Point.Order else {
            return false
        }

        guard 0 < signature.s && signature.s < Point.Order else {
            return false
        }

        let r = IsomorphicField(withValue: signature.r)
        let s = IsomorphicField(withValue: signature.s)
        let z = IsomorphicField(withValue: hash)
        let u = z / s
        let v = r / s
        let P = u.value * Point.Generator + v.value * point

        return P.x.value == signature.r
    }
}
