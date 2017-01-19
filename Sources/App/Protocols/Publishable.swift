import Foundation

protocol Publishable {
    var isPublished: Bool { get set }
    var title: String { get set }
}

extension Publishable {
    mutating func setPublished(_ isPublished: Bool) {
        self.isPublished = isPublished
    }
}
