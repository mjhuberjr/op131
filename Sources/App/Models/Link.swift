import Foundation
import Vapor

final class Link: Publishable {
    var id: Node?
    var exists: Bool = false
    
    var isPublished: Bool
    var title: String
    var url: String
    
    var sectionID: Node?
    
    init(isPublished: Bool, title: String, url: String, sectionID: Node? = nil) {
        self.isPublished = isPublished
        self.title = title
        self.url = url
        self.sectionID = sectionID
    }
    
    init(node: Node, in context: Context) throws {
        id = try node.extract(LinkKeys.id.rawValue)
        
        isPublished = try node.extract(LinkKeys.isPublished.rawValue)
        title = try node.extract(LinkKeys.title.rawValue)
        url = try node.extract(LinkKeys.url.rawValue)
        sectionID = try node.extract(LinkKeys.sectionID.rawValue)
    }
}

extension Link: Model {
    func makeNode(context: Context) throws -> Node {
        return try Node(node: [
            LinkKeys.id.rawValue: id,
            LinkKeys.isPublished.rawValue: isPublished,
            LinkKeys.title.rawValue: title,
            LinkKeys.url.rawValue: url,
            LinkKeys.sectionID.rawValue: sectionID
        ])
    }
    
    static func prepare(_ database: Database) throws {
        try database.create(LinkKeys.links.rawValue) { links in
            links.id()
            
            links.bool(LinkKeys.isPublished.rawValue)
            links.string(LinkKeys.title.rawValue)
            links.string(LinkKeys.url.rawValue)
            links.parent(Block.self, optional: false)
        }
    }
    
    static func revert(_ database: Database) throws {
        try database.delete(LinkKeys.links.rawValue)
    }
}
