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
    return try section.children(nil, Block.self).all().makeJSON()
}

//drop.get(Section.self) { request, section in
//    return try section.children(nil, Block.self).all().makeJSON()
//}

drop.run()
