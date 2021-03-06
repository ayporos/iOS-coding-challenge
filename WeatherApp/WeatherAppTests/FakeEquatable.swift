// @copyright German Autolabs Assignment

import Foundation

protocol FakeEquatable: Equatable {
    var fakeValue: String { get }
}

extension FakeEquatable {
    var fakeValue: String {
        return String(describing: self)
    }
    
    static func ==(lhs: Self, rhs: Self) -> Bool {
        return lhs.fakeValue == rhs.fakeValue
    }
}
