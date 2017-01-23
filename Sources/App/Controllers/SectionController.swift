import Vapor
import HTTP
import VaporMySQL

final class SectionController {
    func addRoutes(droplet: Droplet) {
        drop.get(String.self, handler: section)
    }
    
    func section(request: Request, sectionName: String) throws -> ResponseRepresentable {
        guard let section = try Section.query().filter("title", sectionName).all().first else { throw Abort.notFound }
        let blocks = try section.children(nil, Block.self).all().makeNode()
        let links = try self.links(section: section).makeNode()
        
        let parameters = try Node(node: [
            "blocks": blocks,
            "links": links
        ])
        
        return try drop.view.make("section", parameters)
    }
    
    func links(section: Section) throws -> [Link] {
        guard let sectionID = section.id, let block = try Block.find(sectionID) else { throw Abort.notFound }
        let links = try block.children(nil, Link.self).all()
        return links
    }
}
