//: Playground - noun: a place where people can play

import Foundation
@testable import EllipticCurve

let p: UInt8 = 223

struct FFInt: FiniteFieldInteger {
    typealias Element = UInt8
    typealias Multiplier = FFInt

    static var Characteristic: Element = p
    static var Order: Element = p // all 0..<p are included

    var value: Element

    init(_ source: Element) {
        value = source % p
    }
}

let a: FFInt = 0
a.description

