//
//  Friend.swift
//  Friends
//
//  Created by DanielChang on 2/25/17.
//
//

import Foundation
import Vapor
import Fluent

struct Friend: Model {
    var exists: Bool = false
    var id: Node?
    let name: String
    let age: Int
    let email: String
    
    init(name: String, age: Int, email: String) {
        self.name = name
        self.age = age
        self.email = email
    }
    
    // NodeInitializable
    init(node: Node, in context: Context) throws {
        id = try node.extract("id")
        name = try node.extract("name")
        age = try node.extract("age")
        email = try node.extract("email")
    }
    
    // NodeRepresentable
    func makeNode(context: Context) throws -> Node {
        return try Node(node: ["id": id,
                               "name": name,
                               "age": age,
                               "email": email])
    }
    
    // Preparation
    static func prepare(_ database: Database) throws {
        try database.create("friends") { friends in
            friends.id()
            friends.string("name")
            friends.int("age")
            friends.string("email")
        }
    }
    
    static func revert(_ database: Database) throws {
        try database.delete("friends")
    }
    
}
