//

import Foundation

public protocol BasicArithmeticOperations: Numeric, Comparable {
    static func /(lhs: Self, rhs: Self) -> Self
    static func /=(lhs: inout Self, rhs: Self)
}
