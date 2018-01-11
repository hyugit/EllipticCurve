//: Playground - noun: a place where people can play

import Foundation
@testable import EllipticCurve

let p: UInt8 = 223

struct FFInt: FiniteField {
    typealias Element = UInt8

    static var Characteristic: Element = p
    static var Order: Element = p // all 0..<p are included

    var value: Element

    init() {
        value = 0
    }
}

let a: FFInt = 59
print(a.description)

