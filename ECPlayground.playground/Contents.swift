//: Playground - noun: a place where people can play

import Foundation
@testable import EllipticCurve

let p: UInt8 = 223

struct FFInt: FiniteFieldInteger {
    typealias Element = UInt8

    static var Characteristic: Element = p

    var value: Element

    init() {
        value = 0
    }
}

let a: FFInt = 59
print(a.description)

struct ECPoint: EllipticCurve {
    typealias Coordinate = FFInt

    static var a: Coordinate = 2
    static var b: Coordinate = 7

    var x: Coordinate
    var y: Coordinate?

    init() {
        x = 0
        y = nil
    }
}

let b = ECPoint(x: 16, y: 11) // Generator point
var next = ECPoint.Infinity
for _ in 0..<212 {
    next = next + b
    print(next.description)
}
