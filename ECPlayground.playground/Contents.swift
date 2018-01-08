//: Playground - noun: a place where people can play

import Foundation
@testable import EllipticCurve

let p: UInt8 = 223

struct FFInt: FiniteFieldInteger {
    typealias ValueType = UInt8
    typealias Multiplier = FFInt

    static var Characteristic: ValueType = p
    static var Order: ValueType = p // all 0..<p are included

    var value: ValueType

    init(_ source: ValueType) {
        value = source % p
    }
}

let a: FFInt = 0
a.description

