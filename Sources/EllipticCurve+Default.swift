//

import Foundation

// MARK: - Default implementation of Elliptic Curve protocol
// 
extension EllipticCurve {

    public static var Infinity: Self {
        get {
            return Self(isInfinity: true)
        }
    }

    public var isInfinity: Bool {
        get {
            return y == nil
        }
    }

    public init(x: Coordinate, y: Coordinate) {
        self.init()
        self.x = x
        self.y = y
    }

    public init(isInfinity: Bool) {
        self.init(x: 0, y: 0)
        self.y = nil
    }

    public var description: String {
        guard y != nil else {
            return "Point Infinity"
        }

        return "Point (\(x), \(y!)) on Curve y^2 = x^3 + \(Self.a)*x + \(Self.b)"
    }

    public static func verifyEquation(forPoint point: Self) -> Bool {
        if point.y == nil {
            return false
        }
        let lhs: Coordinate = point.y! * point.y!
        let rhs: Coordinate = point.x * point.x * point.x + Self.a * point.x + Self.b

        return lhs == rhs
    }

    public static func ==(lhs: Self, rhs: Self) -> Bool {
        if lhs.y == nil {
            return rhs.y == nil
        }
        return lhs.x == rhs.x && lhs.y == rhs.y
    }

    public static func +(lhs: Self, rhs: Self) -> Self {
        if lhs.y == nil {
            return rhs
        }
        if rhs.y == nil {
            return lhs
        }
        if lhs.x == rhs.x && lhs.y != rhs.y {
            return Self(isInfinity: true)
        }

        let s: Coordinate

        // when two points are the same point on the curve
        // we calculate the tangential, and use it
        // as the slope
        if lhs == rhs {
            s = (3 * (lhs.x * lhs.x) + Self.a) / (2 * lhs.y!)
        } else {
            s = (rhs.y! - lhs.y!) / (rhs.x - lhs.x)
        }

        let newX = s * s - lhs.x - rhs.x
        let newY = s * (lhs.x - newX) - lhs.y!

        return Self(x: newX, y: newY)
    }

    public static func *<T>(lhs: T, rhs: Self) -> Self where T: FixedWidthInteger {
        var coefficient = lhs
        let bitLength = coefficient.bitWidth - coefficient.leadingZeroBitCount
        var partialCoefficient: T = 1
        var partialResult: Self = rhs
        var trail: [(T, Self)] = []

        for _ in 0..<bitLength {
            trail.append((partialCoefficient, partialResult))
            partialCoefficient <<= 1
            partialResult = partialResult + partialResult
        }

        var result = Self.Infinity

        for (coef, res) in trail.reversed() {
            if coefficient >= coef {
                coefficient = coefficient - coef
                result = result + res
            }
        }

        return result
    }
}
