//
//  File.swift
//  ApiDocker
//
//  Created by reel on 27.12.2024.
//

import Foundation
import Fluent
import Vapor

struct SessionController: ContentHandlerProtocol {
    
    typealias answer = SessionModel
    typealias model = SessionModel
    typealias request = Request
    typealias status = HTTPStatus
    
    
    @Sendable func create(_ req: Vapor.Request) async throws -> Vapor.HTTPStatus {
        let user = req.auth.get(UserModel.self)
        let session = try req.content.decode(CreateSessionDTO.self)
        return try await SessionsService.create(req, createDTO: session, author: user!)
    }
    
    @Sendable func get(_ req: Vapor.Request) async throws -> SessionModel {
        let session = req.parameters.get("slug")
        return try await SessionsService.get(req, object: session!)
    }
    
    @Sendable func getAll(_ req: Vapor.Request) async throws -> [SessionModel] {
        return try await SessionsService.getAll(req)
    }
    
    @Sendable func update(_ req: Vapor.Request) async throws -> SessionModel {
        let session = req.parameters.get("slug")
        let updatedSession = try req.content.decode(UpdateSessionDTO.self)
        return try await SessionsService.update(req, object: session!, updateDTO: updatedSession)
    }
    
    @Sendable func delete(_ req: Vapor.Request) async throws -> Vapor.HTTPStatus {
        let session = req.parameters.get("slug")
        return try await SessionsService.delete(req, object: session!)
    }
    
}


extension SessionController: BackendFilterHandlerProtocol {
    @Sendable func getByStatus(_ req: Vapor.Request) async throws -> [SessionModel] {
        let status = req.parameters.get("status")
        return try await SessionsService.getByStatus(req, status: status!)
    }
    
    @Sendable func search(_ req: Vapor.Request) async throws -> [SessionModel] {
        let term = req.parameters.get("term")
        return try await SessionsService.search(req, term: term!)
    }
    
    
}


extension SessionController: GetSelectedObjectHandler {
    @Sendable func getSelectedObject(_ req: Vapor.Request) async throws -> SessionModel {
        let session = req.parameters.get("sessionSlug")
        return try await SessionsService.get(req, object: session!)
    }
    
}

