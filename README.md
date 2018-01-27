# EllipticCurve

[![Build Status](https://travis-ci.org/mryu87/EllipticCurve.svg?branch=master)](https://travis-ci.org/mryu87/EllipticCurve)
[![Language](https://img.shields.io/badge/swift-4-orange.svg)](https://swift.org)
[![Platform](https://img.shields.io/badge/platform-ios%20|%20macos-lightgrey.svg)](https://github.com/mryu87/EllipticCurve)
[![Carthage Compatible](https://img.shields.io/badge/Carthage-compatible-green.svg?style=flat)](https://github.com/Carthage/Carthage)


An elliptic curve library written in Swift 4

## Features

- [x] ECDSA
- [x] secp256k1
- [x] provide your own hashing functions
- [x] FiniteFieldInteger protocol to create your own finite field integers
- [x] EllipticCurve protocol to create your own elliptic curves
- [x] generic signing and signature verifying
- [x] secp192k1, secp192r1, secp224k1, secp224r1, secp256k1, secp256r1

#### CREATE YOUR OWN ELLIPTIC CURVES! :smiley:

This Library provides the necessary scaffoldings for you 
to easily create elliptic curves. 

The library includes several SEC-2 curves,
among which is the `secp256k1`, the most
popular curve at the moment. On top of the curves, a generic 
ECDSA struct is included for signing and verifying.

## Protocol oriented architecture 

All the protocols are **generic**, which means none of them is
tied to a certain curve or a specific UInt family member. It is
very straight forward to create a specific finite field with a
specific prime number as its order, or to create a specific 
elliptic curve of Double precision or Float80 precision. Please
see to the playground for demonstrations. 

The top level protocol for creating elliptic curve 
cryptography is **EllipticCurveOverFiniteField**. It is constructed from two basic protocols: **FiniteFieldInteger**
and **EllipticCurve**, the former of which is based on **FiniteField**. The diagram of protocol inheritance is as follows:

~~~~
                                                                    
 +--------------------------+                                       
 |                          |                                       
 |        FiniteField       |-----+                                 
 |                          |     |                                 
 +-------------|------------+     |Conformance                      
               |                  |                                 
               |Conformance       |                                 
               |                  |                                 
 +-------------v------------+     |    +---------------------------+
 |                          |     |    |                           |
 |    FiniteFieldInteger    |     |    |        EllipticCurve      |
 |                          |     |    |                           |
 +-------------|------------+     |    +-------------|-------------+
               |                  |                  |              
               |                  |                  |              
 As Coordinates|  +------------------------------+   |Conformance   
               |  |                              |   |              
               +--- EllipticCurveOverFiniteField <---+              
                  |                              |                  
                  +---------------|--------------+                  
                                  |                                 
                                  |As T                             
                                  |                                 
                  +---------------|--------------+                  
                  |                              |                  
                  |           ECDSA<T>           |                  
                  |                              |                  
                  +------------------------------+                                              
~~~~

### FiniteField

FiniteField is the base protocol. 
It defines several basic properties like `Zero`,
`One`, `Characteristic`, and etc. It is not meant
to be used directly, but you can use it to create
finite fields.

### FiniteFieldInteger

FiniteFieldInteger defines the basic scaffolding
and provides most of the default implementations
for any finite field integer. Example:

```swift

let p: UInt8 = 223

struct MyFFInt: FiniteFieldInteger {
    static var Characteristic = p

    var value: UInt8

    init() {
        value = 0
    }
}

let a: MyFFInt = 1
let b: MyFFInt = 500
print(a + b)

```

This will create a finite field integer of F_223,
and then you can use the basic +, -, *, / on it.

### EllipticCurve

EllipticCurve is also generic. You can create an
elliptic curve on real domain like this:

```swift

struct MyECPoint: EllipticCurve {
    static var a: Double = -1
    static var b: Double = 1

    var x: Double
    var y: Double?

    init() {
        x = 0
    }
}

let p: MyECPoint = MyECPoint(x: 1, y: 1)
print(p.description)

```

### EllipticCurveOverFiniteField

This is the top level protocol to use, if you want to
create an ECC of your own:

```swift

let P: UInt8 = 223

struct FFInt223: FiniteFieldInteger {
    static var Characteristic: UInt8 = P
    var value: UInt8

    init() {
        value = 0
    }
}

struct MyECFF: EllipticCurveOverFiniteField {

    static var Order: UInt8 = 212

    static var a: FFInt223 = 2
    static var b: FFInt223 = 7

    var x: FFInt223
    var y: FFInt223?

    static var Generator: MyECFF = MyECFF(x: 16, y: 11)

    init() {
        x = 0
    }
}

```

## Requirements

* iOS 8.0+ / macOS 10.10+
* Xcode 9.2+
* Swift 4

## Installation

### Carthage

Currently, only carthage package installation is tested.

- install Carthage: `brew install carthage`
- add this line to your Cartfile: `github "mryu87/EllipticCurve"`
- run `carthage update` under your project directory

### Swift Package Manager

```
dependencies: [
    .package(url: "https://github.com/mryu87/EllipticCurve.git", from: "0.3.0")
]
```

## Communication

If you have a bug report or a feature request, please open an issue here on GitHub. Any contribution is welcome. :smiley:

## License

EllipticCurve is released under MIT license. [See LICENSE](./LICENSE) for details.
