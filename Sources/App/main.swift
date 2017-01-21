import Vapor
import VaporMySQL

let drop = Droplet()
try drop.addProvider(VaporMySQL.Provider)
drop.preparations += Section.self
drop.preparations += Block.self
drop.preparations += Link.self

drop.get("testdb") { _ in
  if let db = drop.database?.driver as? MySQLDriver {
    let version = try db.raw("SELECT version()")
    return try JSON(node: version)
  } else {
    return "Database connection failed..."
  }
}

drop.get(String.self) { request, sectionString in
    guard let section = try Section.query().filter("title", sectionString).all().first else { throw Abort.notFound }
    guard let sectionID = section.id, let block = try Block.find(sectionID) else { throw Abort.notFound }
    let blocks = try section.children(nil, Block.self).all()
    let blocksWithLinks = try blocks.flatMap { (block) -> JSON in
        return try JSON(node: [
            "block": block.makeNode(), "links": try block.children(nil, Link.self).all().makeNode()
        ])
    }
    
    
    return try blocksWithLinks.makeJSON()  //section.children(nil, Block.self).all().makeJSON()
}

//drop.get(Section.self) { request, section in
//    return try section.children(nil, Block.self).all().makeJSON()
//}

drop.run()
