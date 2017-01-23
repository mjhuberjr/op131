import Vapor
import HTTP
import VaporMySQL

final class SectionController {
    func addRoutes(droplet: Droplet) {
        drop.get(String.self, handler: section)
    }
    
    func section(request: Request, sectionName: String) throws -> ResponseRepresentable {
            guard let section = try Section.query().filter("title", sectionName).all().first else { throw Abort.notFound }
            return try section.children(nil, Block.self).all().makeJSON()
    }
}
