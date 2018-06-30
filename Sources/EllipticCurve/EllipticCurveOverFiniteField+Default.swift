//

import Foundation

extension EllipticCurveOverFiniteField {

    public static var Zero: Self {
        get {
            return Self.Infinity
        }
    }

    public static var One: Self {
        get {
            return Self.Generator
        }
    }

    public static var Characteristic: Element {
        get {
            return Self.Coordinate.Characteristic
        }
    }

    public static var InverseCharacteristic: (high: Element, low: Element)? {
        get {
            return Self.Coordinate.InverseCharacteristic
        }
    }

    public static var InverseOrder: (high: Element, low: Element)? {
        get {
            return nil
        }
    }

    public init(withCoordinates coord: (x: Element, y: Element)) {
        self.init(x: Coordinate(withValue: coord.x), y: Coordinate(withValue: coord.y))
    }

    public init?(withSeed value: Element) {
        guard 0 <= value && value < Self.Order else {
            return nil
        }
        self.init()
        let P = value * Self.Generator
        self.x = P.x
        self.y = P.y
    }

    public init?(_ source: Element) {
        self.init(withSeed: source)
    }
}
