import Foundation
import Vapor

final class Block: Publishable {
    var id: Node?
    var exists: Bool = false
    
    var isPublished: Bool
    var title: String
    var subtitle: String
    var description: String
    var isReleased: Bool
    var imagePath: String
    var url: String
    
    init(isPublished: Bool, title: String, subtitle: String, description: String, isReleased: Bool, imagePath: String, url: String) {
        self.id = nil
        
        self.isPublished = isPublished
        self.title = title
        self.subtitle = subtitle
        self.description = description
        self.isReleased = isReleased
        self.imagePath = imagePath
        self.url = url
    }
    
    init(node: Node, in context: Context) throws {
        id = try node.extract(BlockKeys.id.rawValue)
        
        isPublished = try node.extract(BlockKeys.isPublished.rawValue)
        title = try node.extract(BlockKeys.title.rawValue)
        subtitle = try node.extract(BlockKeys.subtitle.rawValue)
        description = try node.extract(BlockKeys.description.rawValue)
        isReleased = try node.extract(BlockKeys.isReleased.rawValue)
        imagePath = try node.extract(BlockKeys.imagePath.rawValue)
        url = try node.extract(BlockKeys.url.rawValue)
    }
}

// MARK: - Model Implementation

extension Block: Model {
    func makeNode(context: Context) throws -> Node {
        return try Node(node: [
            BlockKeys.id.rawValue: id,
            BlockKeys.isPublished.rawValue: isPublished,
            BlockKeys.title.rawValue: title,
            BlockKeys.subtitle.rawValue: subtitle,
            BlockKeys.description.rawValue: description,
            BlockKeys.isReleased.rawValue: isReleased,
            BlockKeys.imagePath.rawValue: imagePath,
            BlockKeys.url.rawValue: url
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
            blocks.string(BlockKeys.imagePath.rawValue)
            blocks.string(BlockKeys.url.rawValue)
            bloacks.parent(Section.self, optional: false)
        }
    }
    
    static func revert(_ database: Database) throws {
        try database.delete(BlockKeys.blocks.rawValue)
    }
}
