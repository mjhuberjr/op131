import Vapor
import HTTP
import VaporMySQL

final class SectionController {
    func addRoutes(droplet: Droplet) {
        drop.get(String.self, handler: section)
    }
    
    func section(request: Request, sectionName: String) throws -> ResponseRepresentable {
        guard let section = try Section.query().filter("title", sectionName).all().first else { throw Abort.notFound }
        let sectionParameters = try paramatersFrom(section: section).makeNode()
        
        let parameters = try Node(node: [
            "section": sectionParameters
        ])
        
        return try drop.view.make("section", parameters)
    }
    
    func paramatersFrom(section: Section) throws -> [Node] {
        let blocks = try section.children(nil, Block.self).all()
        let blocksWithLinks = try blocks.flatMap { block -> Node in
            let links = try block.children(nil, Link.self).all()
            return try Node(node: [
                "block": block.makeNode(), "links": links.makeNode()
            ])
        }
        
        return blocksWithLinks
    }
    
    //    guard let section = try Section.query().filter("title", sectionString).all().first else { throw Abort.notFound }
    //    guard let sectionID = section.id, let block = try Block.find(sectionID) else { throw Abort.notFound }
    //    let blocks = try section.children(nil, Block.self).all()
    //    let blocksWithLinks = try blocks.flatMap { (block) -> JSON in
    //        return try JSON(node: [
    //            "block": block.makeNode(), "links": try block.children(nil, Link.self).all().makeNode()
    //        ])
    //    }
    //
    //
    //    return try blocksWithLinks.makeJSON()  //section.children(nil, Block.self).all().makeJSON()
}
