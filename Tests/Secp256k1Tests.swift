//

import XCTest
import UInt256
@testable import EllipticCurve

class Secp256k1Tests: XCTestCase {
    func testInit() {
        XCTAssertNotNil(Secp256k1())
        XCTAssertNotNil(Secp256k1.Generator)
        XCTAssertNotNil(Secp256k1.InverseOrder)
        XCTAssertNotNil(Secp256k1.InverseCharacteristic)
    }

    func testPubPoint0() {
        let privkey = UInt256(2)
        let x = UInt256([0xc6047f9441ed7d6d, 0x3045406e95c07cd8, 0x5c778e4b8cef3ca7, 0xabac09b95c709ee5])
        let y = UInt256([0x1ae168fea63dc339, 0xa3c58419466ceaee, 0xf7f632653266d0e1, 0x236431a950cfe52a])
        let point = privkey * Secp256k1.Generator
        XCTAssertEqual(Secp256k1(withCoordinates: (x, y)), point)
    }

    func testPubPoint1() {
        let privkey = UInt256(7)
        let x = UInt256([0x5cbdf0646e5db4ea, 0xa398f365f2ea7a0e, 0x3d419b7e0330e39c, 0xe92bddedcac4f9bc])
        let y = UInt256([0x6aebca40ba255960, 0xa3178d6d861a54db, 0xa813d0b813fde7b5, 0xa5082628087264da])
        let point = privkey * Secp256k1.Generator
        XCTAssertEqual(Secp256k1(withCoordinates: (x, y)), point)
    }

/*  the following tests take too long to run, improvement on performance is necessary

    func testPubPoint2() {
        let privkey = UInt256(1485)
        let x = UInt256([0xc982196a7466fbbb, 0xb0e27a940b6af926, 0xc1a74d5ad07128c8, 0x2824a11b5398afda])
        let y = UInt256([0x7a91f9eae64438af, 0xb9ce6448a1c133db, 0x2d8fb9254e4546b6, 0xf001637d50901f55])
        let point = privkey * Secp256k1.Generator
        XCTAssertEqual(Secp256k1(withCoordinates: (x, y)), point)
    }

    func testPubPoint3() {
        let privkey = UInt256([0, 1, 0, 0])
        let x = UInt256([0x8f68b9d2f63b5f33, 0x9239c1ad981f162e, 0xe88c5678723ea335, 0x1b7b444c9ec4c0da])
        let y = UInt256([0x662a9f2dba063986, 0xde1d90c2b6be215d, 0xbbea2cfe95510bfd, 0xf23cbf79501fff82])
        let point = privkey * Secp256k1.Generator
        XCTAssertEqual(Secp256k1(withCoordinates: (x, y)), point)
    }

    func testPubPoint4() {
        let privkey = UInt256([0x1000000000000, 0, 0, 0x80000000])
        let x = UInt256([0x9577ff57c8234558, 0xf293df502ca4f09c, 0xbc65a6572c842b39, 0xb366f21717945116])
        let y = UInt256([0x10b49c67fa9365ad, 0x7b90dab070be339a, 0x1daf9052373ec30f, 0xfae4f72d5e66d053])
        let point = privkey * Secp256k1.One
        XCTAssertEqual(Secp256k1(withCoordinates: (x, y)), point)
    }

    func testSigning() {
        let x = Secp256k1.FFInt(UInt256([
            0x887387e452b8eacc, 0x4acfde10d9aaf7f6, 0xd9a0f975aabb10d0, 0x06e4da568744d06c
        ]))
        let y = Secp256k1.FFInt(UInt256([
            0x61de6d95231cd890, 0x26e286df3b6ae4a8, 0x94a3378e393e93a0, 0xf45b666329a0ae34
        ]))
        let p = Secp256k1(x: x, y: y)
        let z = UInt256([0xec208baa0fc1c19f, 0x708a9ca96fdeff3a, 0xc3f230bb4a7ba4ae, 0xde4942ad003c0f60])
        let r = UInt256([0xac8d1c87e51d0d44, 0x1be8b3dd5b05c879, 0x5b48875dffe00b7f, 0xfcfac23010d3a395])
        let s = UInt256([0x068342ceff8935ed, 0xedd102dd876ffd6b, 0xa72d6a427a3edb13, 0xd26eb0781cb423c4])
        func hashingFunc(m: Data) -> UInt256 {
            return z
        }

        let result = ECDSA<Secp256k1>.verify(signature: (r, s), withPoint: p, forMessage: Data(), hashedBy: hashingFunc)
        XCTAssertTrue(result)
    }

*/

    func testSigningSimple() {
        let privkey: UInt256 = 1
        let point = privkey * Secp256k1.One
        func hashFunc(m: Data) -> UInt256 {
            return UInt256(1234567890)
        }

        let sig = ECDSA<Secp256k1>.sign(message: Data(), signedBy: privkey, hashedBy: hashFunc)
        let ver = ECDSA<Secp256k1>.verify(signature: sig, withPoint: point, forMessage: Data(), hashedBy: hashFunc)
        XCTAssertTrue(ver)
    }

    func testEverythingElse() {
        XCTAssertNotNil(Secp256r1())
        XCTAssertNotNil(Secp224k1())
        XCTAssertNotNil(Secp224r1())
        XCTAssertNotNil(Secp192k1())
        XCTAssertNotNil(Secp192r1())
    }
}

