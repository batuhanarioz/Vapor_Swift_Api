//
//  File.swift
//  RestApi
//
//  Created by reel on 26.12.2024.
//

import Foundation
import Vapor
import Fluent

struct ArticleServices: ContentProtocol {
    
    typealias answer = ArticleModel
    typealias model = ArticleModel
    typealias request = Request
    typealias status = HTTPStatus
    typealias createDTO = CreateArticleDTO
    typealias updateDTO = UpdateArticleDTO
    
    static func create(_ req: Vapor.Request, createDTO: CreateArticleDTO, author: UserModel) async throws -> Vapor.HTTPStatus {
        let slug = createDTO.title?.replacingOccurrences(of: " ", with: "-")
        guard let guide = try await GuideModel.find(createDTO.guide, on: req.db) else {
            throw Abort(.notFound, reason: "Could not find guide with ID of \(String(describing: createDTO.guide))")
        }
        let article = ArticleModel(title: createDTO.title,
                                   slug: slug,
                                   excerp: createDTO.excerp,
                                   content: createDTO.content,
                                   guide: createDTO.guide!,
                                   headerImage: createDTO.headerImage,
                                   author: "",
                                   status: createDTO.status ?? StatusEnum.draft.rawValue,
                                   price: createDTO.price ?? guide.price,
                                   role: createDTO.role,
                                   createdAt: Date(),
                                   updatedAt: Date(),
                                   publishDate: createDTO.publishDate,
                                   tags: createDTO.tags
        )
        try await article.save(on: req.db)
        return .ok
    }
    
    static func get(_ req: Vapor.Request, object: String) async throws -> ArticleModel {
        guard let article = try await ArticleModel.query(on: req.db)
            .filter(\.$slug == object)
            .first() else {
            throw Abort(.notFound, reason: "Could not find article.")
        }
        return article
    }
    
    static func getAll(_ req: Vapor.Request) async throws -> [ArticleModel] {
        return try await ArticleModel.query(on: req.db)
            .all()
    }
    
    static func update(_ req: Vapor.Request, object: String, updateDTO: UpdateArticleDTO) async throws -> ArticleModel {
        let uuid = try await getIdFromSlug(req, slug: object)
        guard let article = try await ArticleModel.find(uuid, on: req.db) else {
            throw Abort(.notFound, reason: "Could not find Article with ID of \(uuid).")
        }
        
        guard let guide = try await GuideModel.find(updateDTO.guide ?? article.guide, on: req.db) else {
            throw Abort(.notFound, reason: "Guide with ID \(String(describing: updateDTO.guide)) was not found.")
        }
        
        let slug = updateDTO.title?.replacingOccurrences(of: " ", with: "-")
        article.title = updateDTO.title ?? article.title
        article.excerp = updateDTO.excerp ?? article.excerp
        article.slug = slug ?? article.slug
        article.content = updateDTO.content ?? article.content
        article.guide = guide.id
        article.price = guide.price
        article.headerImage = updateDTO.headerImage ?? article.headerImage
        article.status = updateDTO.status ?? article.status
        article.role = updateDTO.role ?? article.role
        article.publishDate = updateDTO.publishDate ?? article.publishDate
        article.tags = updateDTO.tags ?? article.tags
        
        try await article.save(on: req.db)
        return article
    }
    
    static func delete(_ req: Vapor.Request, object: String) async throws -> Vapor.HTTPStatus {
        let uuid = try await getIdFromSlug(req, slug: object)
        guard let article = try await ArticleModel.find(uuid, on: req.db) else {
            throw Abort(.notFound, reason: "Article with ID of \(uuid) could not be found.")
        }
        try await article.delete(on: req.db)
        return .ok
    }
    
}


extension ArticleServices: TransformProtocol {
    static func getIdFromSlug(_ req: Vapor.Request, slug: String) async throws -> UUID {
        guard let article = try await ArticleModel.query(on: req.db)
            .filter(\.$slug == slug)
            .first() else {
                throw Abort(.notFound, reason: "Could not find article with slug \(slug).")
            }
        return article.id!
    }
    
    typealias answerWithId = UUID
    
}


extension ArticleServices: BackendContentFilterProtocol {
    static func getByStatus(_ req: Vapor.Request, status: StatusEnum.RawValue) async throws -> [ArticleModel] {
        let articles = try await ArticleModel.query(on: req.db)
            .filter(\.$status == status)
            .all()
        return articles
    }
    
    static func search(_ req: Vapor.Request, term: String) async throws -> [ArticleModel] {
        let query = try await ArticleModel.query(on: req.db)
            .group(.or) { or in
                or.filter(\.$title =~ term)
            }.all()
        return query
    }
    
    
}


extension ArticleServices: GetSelectedObjectProtocol {
    static func getSelectedObject(_ req: Vapor.Request, object: String) async throws -> ArticleModel {
        _ = req.auth.get(UserModel.self)
        guard let article = try await ArticleModel.query(on: req.db)
            .filter(\.$slug == object)
            .filter(\.$status == StatusEnum.published.rawValue)
            .first() else {
            throw Abort(.notFound)
        }
        return article
    }
    
}
