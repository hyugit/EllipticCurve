//

import Foundation
import UInt256

public extension FiniteField {
    public static var Characteristic: UInt256 {
        get {
            return EllipticCurve.secp256k1.p
        }
    }
}
