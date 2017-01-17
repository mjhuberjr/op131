import Vapor
import HTTP

final class Section: Model {
    var id: Node?
    var exists: Bool = false
    
    var isPublished: Bool
    var title: String
    var jumbo: Block?
    var blocks: [Block]?
    
    init(isPublished: Bool, title: String, jumbo: Block? = nil, blocks: [Block]? = nil) {
        self.id = nil
        self.isPublished = isPublished
        self.title = title
        self.jumbo = jumbo
        self.blocks = blocks
    }
    
    init(node: Node, in context: Context) throws {
        id = try node.extract(SectionKeys.id.rawValue)
        
        isPublished = try node.extract(SectionKeys.isPublished.rawValue)
        title = try node.extract(SectionKeys.title.rawValue)
        jumbo = try node.extract(SectionKeys.jumbo.rawValue)
        blocks = try node.extract(SectionKeys.blocks.rawValue)
    }
    
    func makeNode(context: Context) throws -> Node {
        return try Node(node:[
            SectionKeys.id.rawValue: id,
            SectionKeys.isPublished.rawValue: isPublished,
            SectionKeys.title.rawValue: title,
            SectionKeys.jumbo.rawValue: jumbo,
            SectionKeys.blocks.rawValue: blocks
        ])
    }
}
