import Vapor

final class Section: Model {
    var id: Node?
    var exists: Bool = false
    
    var title: String
    var isPublished: Bool
    var jumbo: Block
    var blocks: [Block]
    
    init(title: String, isPublished: Bool, jumbo: Block, blocks: [Block]) {
        self.id = nil
        self.title = title
        self.isPublished = isPublished
        self.jumbo = jumbo
        self.blocks = blocks
    }
}
