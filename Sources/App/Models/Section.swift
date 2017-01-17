import Vapor

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
}
