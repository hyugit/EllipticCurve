//

import Foundation

extension EllipticCurveOverFiniteField {

    public typealias Element = Self.Coordinate.Element

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

    public var value: Element? {
        get {
            return _value
        }
        set {
            guard newValue != nil else {
                _value = nil
                x = 0
                y = nil
                return
            }

            guard Self.Element(0) < newValue! && newValue! <= Self.Order else {
                _value = nil
                x = 0
                y = nil
                return
            }

            _value = newValue!
            let P = newValue! * Self.Generator
            x = P.x
            y = P.y
        }
    }

    public init(withCoordinates coord: (x: Element, y: Element)) {
        self.init(x: Coordinate(withValue: coord.x), y: Coordinate(withValue: coord.y))
    }

    public init?(withValue source: Element) {
        guard 0 < source && source <= Self.Order else {
            return nil
        }
        self.init()
        self.value = source
    }

    public init?(_ source: Element) {
        self.init(withValue: source)
    }
}
