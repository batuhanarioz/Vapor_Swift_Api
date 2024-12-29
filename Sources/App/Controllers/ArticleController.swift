//
//  File.swift
//  ApiDocker
//
//  Created by reel on 27.12.2024.
//

import Foundation
import Fluent
import Vapor

struct ArticleController: ContentHandlerProtocol {
    
    typealias answer = ArticleModel
    typealias model = ArticleModel
    typealias request = Request
    typealias status = HTTPStatus
    
    
    @Sendable func create(_ req: Vapor.Request) async throws -> Vapor.HTTPStatus {
        let author = req.auth.get(UserModel.self)
        let article = try req.content.decode(CreateArticleDTO.self)
        return try await ArticleServices.create(req, createDTO: article, author: author!)
    }
    
    @Sendable func get(_ req: Vapor.Request) async throws -> ArticleModel {
        let article = req.parameters.get("slug")
        return try await ArticleServices.get(req, object: article!)
    }
    
    @Sendable func getAll(_ req: Vapor.Request) async throws -> [ArticleModel] {
        return try await ArticleServices.getAll(req)
    }
    
    @Sendable func update(_ req: Vapor.Request) async throws -> ArticleModel {
        let article = req.parameters.get("slug")
        let updatedArticle = try req.content.decode(UpdateArticleDTO.self)
        return try await ArticleServices.update(req, object: article!, updateDTO: updatedArticle)
    }
    
    @Sendable func delete(_ req: Vapor.Request) async throws -> Vapor.HTTPStatus {
        let article = req.parameters.get("slug")
        return try await ArticleServices.delete(req, object: article!)
    }
    
}


extension ArticleController: BackendFilterHandlerProtocol {
    @Sendable func getByStatus(_ req: Vapor.Request) async throws -> [ArticleModel] {
        let status = req.parameters.get("status")
        return try await ArticleServices.getByStatus(req, status: status!)
    }
    
    @Sendable func search(_ req: Vapor.Request) async throws -> [ArticleModel] {
        let term = req.parameters.get("term")
        return try await ArticleServices.search(req, term: term!)
    }
    
    
}


extension ArticleController: GetSelectedObjectHandler {
    @Sendable func getSelectedObject(_ req: Vapor.Request) async throws -> ArticleModel {
        let article = req.parameters.get("articleSlug")
        return try await ArticleServices.get(req, object: article!)
    }
    
}
