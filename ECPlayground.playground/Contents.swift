//: Playground - noun: a place where people can play

import Foundation
@testable import EllipticCurve

let p: UInt8 = 223

struct MyFFInt: FiniteFieldInteger {
    static var Characteristic = p

    var value: UInt8

    init() {
        value = 0
    }
}

let a: MyFFInt = 59
print(a.description)

struct MyECPoint: EllipticCurve {
    static var a: MyFFInt = 2
    static var b: MyFFInt = 7

    var x: MyFFInt
    var y: MyFFInt?

    init() {
        x = 0
        y = nil
    }
}

let b = MyECPoint(x: 16, y: 11) // Generator point
var next = MyECPoint.Infinity
for i in [0, 1, 211, 212] {
    print(i * b)
}
