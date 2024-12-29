//
//  File.swift
//  ApiDocker
//
//  Created by reel on 27.12.2024.
//

import Foundation
import Fluent
import Vapor

struct GuideController: ContentHandlerProtocol {
    
    typealias answer = GuideContext
    typealias model = GuideModel
    typealias request = Request
    typealias status = HTTPStatus
    
    
    @Sendable func create(_ req: Vapor.Request) async throws -> Vapor.HTTPStatus {
        let author = req.auth.get(UserModel.self)
        let guide = try req.content.decode(CreateGuideDTO.self)
        return try await GuideServices.create(req, createDTO: guide, author: author!)
    }
    
    @Sendable func get(_ req: Vapor.Request) async throws -> GuideModel {
        let guide = req.parameters.get("slug")
        return try await GuideServices.get(req, object: guide!)
    }
    
    @Sendable func getAll(_ req: Vapor.Request) async throws -> [GuideModel] {
        return try await GuideServices.getAll(req)
    }
    
    @Sendable func update(_ req: Vapor.Request) async throws -> GuideModel {
        let guide = req.parameters.get("slug")
        let updatedGuide = try req.content.decode(UpdateGuideDTO.self)
        return try await GuideServices.update(req, object: guide!, updateDTO: updatedGuide)
    }
    
    @Sendable func delete(_ req: Vapor.Request) async throws -> Vapor.HTTPStatus {
        let guide = req.parameters.get("slug")
        return try await GuideServices.delete(req, object: guide!)
    }

    
}



extension GuideController: BackendFilterHandlerProtocol {
    @Sendable func getByStatus(_ req: Vapor.Request) async throws -> [GuideModel] {
        let status = req.parameters.get("status")
        return try await GuideServices.getByStatus(req, status: status!)
    }
    
    @Sendable func search(_ req: Vapor.Request) async throws -> [GuideModel] {
        let term = req.parameters.get("term")
        return try await GuideServices.search(req, term: term!)
    }
    
}


extension GuideController: FrontendHandlerProtocol {
    @Sendable func getObject(_ req: Vapor.Request) async throws -> GuideContext {
        let guide = req.parameters.get("slug")
        return try await GuideServices.getObject(req, object: guide!)
    }
    
    @Sendable func getAllObject(_ req: Vapor.Request) async throws -> [GuideModel] {
        return try await GuideServices.getAllObject(req)
    }
    
}
