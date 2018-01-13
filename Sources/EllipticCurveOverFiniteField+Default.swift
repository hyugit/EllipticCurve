//

import Foundation

extension EllipticCurveOverFiniteField {

    public typealias Element = Self.Coordinate.Element

    static var Zero: Self {
        get {
            return Self.Infinity
        }
    }

    static var One: Self {
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
            return value
        }
        set {
            guard newValue != nil else {
                value = nil
                x = 0
                y = nil
                return
            }

            guard Self.Element(0) < newValue! && newValue! <= Self.Order else {
                value = nil
                x = 0
                y = nil
                return
            }

            value = newValue!
            let P = newValue! * Self.Generator
            x = P.x
            y = P.y
        }
    }

    public init(withPoint point: (x: Element, y: Element)) {
        self.init()
        self.x = x
        self.y = y
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
