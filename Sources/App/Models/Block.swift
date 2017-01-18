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
    var imagePath: String
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
    
    init(node: Node, in context: Context) throws {
        id = try node.extract(BlockKeys.id.rawValue)
        
        isPublished = try node.extract(BlockKeys.isPublished.rawValue)
        title = try node.extract(BlockKeys.title.rawValue)
        subtitle = try node.extract(BlockKeys.subtitle.rawValue)
        description = try node.extract(BlockKeys.description.rawValue)
        isReleased = try node.extract(BlockKeys.isReleased.rawValue)
        image = try node.extract(BlockKeys.image.rawValue)
        url = try node.extract(BlockKeys.url.rawValue)
        links = try node.extract(BlockKeys.links.rawValue)
    }
    
    func makeNode(context: Context) throws -> Node {
        return try Node(node: [
            BlockKeys.id.rawValue: id,
            BlockKeys.isPublished: isPublished,
            BlockKeys.title: title,
            BlockKeys.subtitle: subtitle,
            BlockKeys.description: description,
            BlockKeys.isReleased.rawValue: isReleased,
            BlockKeys.image.rawValue: image,
            BlockKeys.url: url,
            BlockKeys.links: links
        ])
    }
    
    static func prepare(_ database: Database) throws {
        try database.create(BlockKeys.blocks.rawValue) { blocks in
            blocks.id()
            
            blocks.bool(BlockKeys.isPublished.rawValue)
            blocks.string(BlockKeys.title.rawValue)
            blocks.string(BlockKeys.subtitle.rawValue)
            blocks.string(BlockKeys.description.rawValue)
            blocks.bool(BlockKeys.isReleased.rawValue)
            blocks.data(BlockKeys.image.rawValue)
            blocks.string(BlockKeys.url.rawValue)
            blocks.string(BlockKeys.links.rawValue)
            
            // TODO: Implement Parent here since this will need to belong to a Section...
        }
    }
    
    static func revert(_ database: Database) throws {
        try database.delete(BlockKeys.blocks.rawValue)
    }
}
