import Vapor

let drop = Droplet()

drop.get("hello") { req in
    return "Hello, World!!"
}

drop.run()
