//
//  File.swift
//  ApiDocker
//
//  Created by reel on 27.12.2024.
//

import Foundation
import Fluent
import Vapor

struct CourseController: ContentHandlerProtocol {
    
    typealias answer = CourseContext
    typealias model = CourseModel
    typealias request = Request
    typealias status = HTTPStatus
    
    @Sendable func create(_ req: Vapor.Request) async throws -> Vapor.HTTPStatus {
        let author = req.auth.get(UserModel.self)
        let course = try req.content.decode(CreateCourseDTO.self)
        return try await CourseServices.create(req, createDTO: course, author: author!)
    }
    
    @Sendable func get(_ req: Vapor.Request) async throws -> CourseModel {
        let course = req.parameters.get("slug")
        return try await CourseServices.get(req, object: course!)
    }
    
    @Sendable func getAll(_ req: Vapor.Request) async throws -> [CourseModel] {
        return try await CourseServices.getAll(req)
    }
    
    @Sendable func update(_ req: Vapor.Request) async throws -> CourseModel {
        let course = req.parameters.get("slug")
        let updatedCourse = try req.content.decode(UpdateCourseDTO.self)
        return try await CourseServices.update(req, object: course!, updateDTO: updatedCourse)
    }
    
    @Sendable func delete(_ req: Vapor.Request) async throws -> Vapor.HTTPStatus {
        let course = req.parameters.get("slug")
        return try await CourseServices.delete(req, object: course!)
    }
    
}

extension CourseController: BackendFilterHandlerProtocol {
    @Sendable func getByStatus(_ req: Vapor.Request) async throws -> [CourseModel] {
        let status = req.parameters.get("status")
        return try await CourseServices.getByStatus(req, status: status!)
    }
    
    @Sendable func search(_ req: Vapor.Request) async throws -> [CourseModel] {
        let term = req.parameters.get("term")
        return try await CourseServices.search(req, term: term!)
    }
    
    
}

extension CourseController: FrontendHandlerProtocol {
    @Sendable func getObject(_ req: Vapor.Request) async throws -> CourseContext {
        let course = req.parameters.get("slug")
        return try await CourseServices.getObject(req, object: course!)
    }
    
    @Sendable func getAllObject(_ req: Vapor.Request) async throws -> [CourseModel] {
        return try await CourseServices.getAllObject(req)
    }
    
}
