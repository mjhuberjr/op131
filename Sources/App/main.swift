import Vapor
import VaporMySQL

let drop = Droplet()
(drop.view as? LeafRenderer)?.stem.cache = nil

try drop.addProvider(VaporMySQL.Provider)
drop.preparations += Section.self
drop.preparations += Block.self
drop.preparations += Link.self

let sectionController = SectionController()
sectionController.addRoutes(droplet: drop)

drop.get("/") { request in
    return try sectionController.section(request: request, sectionName: "apps")
}

drop.run()
