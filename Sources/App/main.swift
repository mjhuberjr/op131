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

drop.get("/") { request in
    return try Section.all().makeJSON()
}

drop.get(Section.self) { request, section in
    return try section.children(nil, Block.self).all().makeJSON()
}

drop.run()
