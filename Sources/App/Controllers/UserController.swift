//
//  File.swift
//  ApiDocker
//
//  Created by reel on 27.12.2024.
//

import Foundation
import Fluent
import Vapor

struct UserController: UserHandlerProtocol {
    
    typealias answer = UserModel.Public
    typealias request = Request
    typealias status = HTTPStatus
    
    @Sendable func create(_ req: Vapor.Request) async throws -> UserModel.Public {
        let user = try req.content.decode(CreateUserDTO.self)
        return try await UserServices.create(req, user)
    }
    
    @Sendable func get(_ req: Vapor.Request) async throws -> UserModel.Public {
        let user = try req.auth.require(UserModel.self)
        return try await UserServices.get(req, object: user.id!.uuidString)
    }
    
    @Sendable func update(_ req: Vapor.Request) async throws -> UserModel.Public {
        let user = try req.auth.require(UserModel.self)
        let updatedUser = try req.content.decode(UpdateUserDTO.self)
        return try await UserServices.update(req, object: user.id!.uuidString, updateDTO: updatedUser)
    }
    
    @Sendable func delete(_ req: Vapor.Request) async throws -> Vapor.HTTPStatus {
        let user = try req.auth.require(UserModel.self)
        return try await UserServices.delete(req, object: user.id!.uuidString)
    }
    
}


extension UserController: SearchUserProtocol {
    
    static func search(_ req: Vapor.Request, term: String) async throws -> [UserModel.Public] {
        let term = req.parameters.get("term")
        return try await UserServices.search(req, term: term!)
    }
    
}
