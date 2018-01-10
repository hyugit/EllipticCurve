//

import Foundation

public protocol NumericWithDivision: Numeric {
    static func /(lhs: Self, rhs: Self) -> Self
    static func /=(lhs: inout Self, rhs: Self)
}
