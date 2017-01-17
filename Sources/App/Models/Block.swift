import Foundation
import Vapor

final class Block: Model {
    var id: Node?
    var exists: Bool = false
    
    var isPublished: Bool
    var title: String
    var subtitle: String
    var description: String
    var isReleased: Bool
    var image: Data
    var url: String?
    var links: [String]?
    
    init(isPublished: Bool, title: String, subtitle: String, description: String, isReleased: Bool, image: Data, url: String? = nil, links: [String]? = nil) {
        self.id = nil
        
        self.title = title
        self.subtitle = subtitle
        self.description = description
        self.isReleased = isReleased
        self.image = image
        self.url = url
        self.links = links
    }
}
