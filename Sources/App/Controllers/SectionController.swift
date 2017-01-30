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
            "sectionName": sectionName,
            "section": sectionParameters
        ])
        
        return try drop.view.make("section", parameters)
    }
    
    func paramatersFrom(section: Section) throws -> [JSON] {
        let blocks = try section.children(nil, Block.self).all()
        
        // These will get removed when the Custom Tag is created
        var index = 0
        var newLine = false
        
        let blocksWithLinks = try blocks.flatMap { block -> JSON in
            let links = try block.children(nil, Link.self).all()
            
            // This is very hacky and will need to be moved into a Custom Tag
            newLine = index % 2 == 0 ? true : false
            index += 1
            
            return try JSON(node: [
                // newLine will also need to be removed
                "newLine": newLine.makeNode(), "block": block.makeNode(), "links": links.makeNode()
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
