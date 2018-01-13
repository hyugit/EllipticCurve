//

import Foundation
import UInt256

extension FFInt256: BasicArithmeticOperations {}

public struct FFInt256: FiniteFieldInteger {
    public static var Characteristic: UInt256 = Parameters.P
    public var value: UInt256

    public init() {
        value = 0
    }
}
