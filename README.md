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

The library includes several SEC-2 recommended curves,
the foremost of among which is the `secp256k1`, the most
popular curve at the moment. On top of the curves, a generic 
ECDSA struct is included for signing and verifying.

## Protocol oriented architecture 

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
