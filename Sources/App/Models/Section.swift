import Vapor
import HTTP

final class Section: Model {
    var id: Node?
    var exists: Bool = false
    
    var isPublished: Bool
    var title: String
    
    init(isPublished: Bool, title: String) {
        self.id = nil
        self.isPublished = isPublished
        self.title = title
    }
    
    init(node: Node, in context: Context) throws {
        id = try node.extract(SectionKeys.id.rawValue)
        
        isPublished = try node.extract(SectionKeys.isPublished.rawValue)
        title = try node.extract(SectionKeys.title.rawValue)
    }
    
    func makeNode(context: Context) throws -> Node {
        return try Node(node:[
            SectionKeys.id.rawValue: id,
            SectionKeys.isPublished.rawValue: isPublished,
            SectionKeys.title.rawValue: title
        ])
    }
    
    static func prepare(_ database: Database) throws {
        try database.create(SectionKeys.sections.rawValue) { sections in
            sections.id()
            sections.bool(SectionKeys.isPublished.rawValue)
            sections.string(SectionKeys.title.rawValue)
        }
    }
    
    static func revert(_ database: Database) throws {
        try database.delete(SectionKeys.sections.rawValue)
    }
}
