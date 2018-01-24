//

import Foundation
import UInt256

public struct ECDSA<Point: EllipticCurveOverFiniteField> {
    public typealias Element = Point.Element
    public typealias Signature = (r: Element, s: Element)
    public typealias Hashing = (_ msg: Data) -> Element

    private struct IsomorphicField: FiniteFieldInteger {
        public static var Characteristic: Element {
            return Point.Order
        }
        public static var InverseCharacteristic: (high: Element, low: Element)? {
            return Point.InverseOrder
        }

        public var value: Element

        public init() {
            value = 0
        }
    }

    public static func sign(message: Data, signedBy key: Element, hashedBy closure: Hashing) -> Signature {

        let hash: Element = closure(message)
        var r: IsomorphicField = 0
        var s: IsomorphicField = 0
        while s == 0 {
            // reset to 0, so it gets regenerated
            r = 0
            var k: IsomorphicField = 0

            // calculate r
            while r == 0 {
                var random: Element = 0
                while random < 1 || random == key {
                    random = arc4random_uniform(Point.Order - 1) + 1
                }
                k = IsomorphicField(withValue: random)
                let Q = k.value * Point.Generator
                r = IsomorphicField(withValue: Q.x.value)
            }

            // calculate s
            let z = IsomorphicField(withValue: hash)
            let d = IsomorphicField(withValue: key)
            s = (z + r * d) / k
        }

        return (r: r.value, s: s.value)
    }

    public static func verify(signature: Signature, withPoint p: Point, forMessage msg: Data, hashedBy closure: Hashing) -> Bool {

        guard !p.isInfinity else {
            return false
        }

        guard p.isOnCurve else {
            return false
        }

//        // this part never gets executed unless there is an error
//        // with that multiplication, which should be caught by a
//        // test where the multiplication is implemented
//        guard Point.Order * p == Point.Infinity else {
//            fatalError("not infinity!? something is horribly wrong")
//            return false
//        }

        guard 0 < signature.r && signature.r < Point.Order else {
            return false
        }

        guard 0 < signature.s && signature.s < Point.Order else {
            return false
        }

        let h: Element = closure(msg)
        let r = IsomorphicField(withValue: signature.r)
        let s = IsomorphicField(withValue: signature.s)
        let z = IsomorphicField(withValue: h)
        let u = z / s
        let v = r / s
        let P = u.value * Point.Generator + v.value * p

        return P.x.value == signature.r
    }
}
