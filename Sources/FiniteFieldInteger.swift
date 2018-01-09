//

import Foundation

public protocol FiniteFieldInteger: FiniteField, Numeric, Comparable {

    var value: Element { get set }

    init(withValue source: Element)
    init(_ source: Element)
}
