//
//  File.swift
//  RestApi
//
//  Created by reel on 25.12.2024.
//

import Foundation
import Fluent
import Vapor

struct CourseServices: ContentProtocol {
    typealias answer = CourseContext
    typealias model = CourseModel
    typealias request = Request
    typealias status = HTTPStatus
    typealias createDTO = CreateCourseDTO
    typealias updateDTO = UpdateCourseDTO
    
    static func create(_ req: Vapor.Request, createDTO: CreateCourseDTO, author: UserModel) async throws -> Vapor.HTTPStatus {
        let slug = createDTO.title?.replacingOccurrences(of: " ", with: "-")
        let fullAuthor = "\(String(describing: author.name)) \(String(describing: author.lastname))"
        let course = CourseModel(title: createDTO.title,
                                 slug: slug,
                                 tags: createDTO.tags,
                                 description: createDTO.description,
                                 status: createDTO.status ?? StatusEnum.draft.rawValue,
                                 price: createDTO.price ?? PriceEnum.pro.rawValue,
                                 headerImage: createDTO.headerImage,
                                 article: createDTO.article,
                                 topHexColor: createDTO.topHexColor,
                                 bottomHexColor: createDTO.bottomHexColor,
                                 sylabus: createDTO.sylabus,
                                 assets: createDTO.assets,
                                 author: fullAuthor,
                                 createdAt: Date(),
                                 updatedAt: Date(),
                                 publishDate: createDTO.publishDate
        )
        try await course.save(on: req.db)
        return .ok
    }
    
    static func get(_ req: Vapor.Request, object: String) async throws -> CourseModel {
        guard let course = try await CourseModel.query(on: req.db)
            .filter(\.$slug == object)
            .first() else {
            throw Abort(.notFound, reason: "Could not find course with slug of \(object)")
        }
        return course
    }
    
    static func getAll(_ req: Vapor.Request) async throws -> [CourseModel] {
        return try await CourseModel.query(on: req.db)
            .all()
    }
    
    static func update(_ req: Vapor.Request, object: String, updateDTO: UpdateCourseDTO) async throws -> CourseModel {
        let uuid = try await getIdFromSlug(req, slug: object)
        guard let course = try await CourseModel.find(uuid, on: req.db) else {
            throw Abort(.notFound, reason: "Course with ID of \(uuid) could not be found.")
        }
        
        course.title = updateDTO.title ?? course.title
        course.tags = updateDTO.tags ?? course.tags
        course.description = updateDTO.description ?? course.description
        course.status = updateDTO.status ?? course.status
        course.price = updateDTO.price ?? course.price
        course.headerImage = updateDTO.headerImage ?? course.headerImage
        course.article = updateDTO.article ?? course.article
        course.topHexColor = updateDTO.topHexColor ?? course.topHexColor
        course.bottomHexColor = updateDTO.bottomHexColor ?? course.bottomHexColor
        course.sylabus = updateDTO.sylabus ?? course.sylabus
        course.assets = updateDTO.assets ?? course.assets
        course.publishDate = updateDTO.publishDate ?? course.publishDate
        
        try await course.save(on: req.db)
        return course
        
    }
    
    static func delete(_ req: Vapor.Request, object: String) async throws -> Vapor.HTTPStatus {
        let uuid = try await getIdFromSlug(req, slug: object)
        guard let course = try await CourseModel.find(uuid, on: req.db) else {
            throw Abort(.notFound, reason: "Course with Id of \(uuid) could not be found.")
        }
        try await course.delete(on: req.db)
        return .ok
    }
    
}


extension CourseServices: TransformProtocol {
    typealias answerWithId = UUID

    static func getIdFromSlug(_ req: Vapor.Request, slug: String) async throws -> UUID {
        guard let course = try await CourseModel.query(on: req.db)
            .filter(\.$slug == slug)
            .first() else {
            throw Abort(.notFound, reason: "Course id could not be found")
        }
        return course.id!
    }
    
}


extension CourseServices: BackendContentFilterProtocol {
    static func getByStatus(_ req: Vapor.Request, status: StatusEnum.RawValue) async throws -> [CourseModel] {
        let courses = try await CourseModel.query(on: req.db)
            .filter(\.$status == status)
            .all()
        return courses
    }
    
    static func search(_ req: Vapor.Request, term: String) async throws -> [CourseModel] {
        let courses = try await CourseModel.query(on: req.db)
            .group(.or) { or in
                or.filter(\.$title =~ term)
            }.all()
        return courses
    }
    
}



extension CourseServices: FrontendProtocol {
    static func getObject(_ req: Vapor.Request, object: String) async throws -> CourseContext {
        let user = req.auth.get(UserModel.self)
        guard let course = try await CourseModel.query(on: req.db)
            .filter(\.$slug == object)
            .filter(\.$status == StatusEnum.published.rawValue)
            .first() else {
            throw Abort(.notFound)
            }
        let sessions = try await SessionModel.query(on: req.db)
            .filter(\.$course == course.id)
            .filter(\.$status == StatusEnum.published.rawValue)
            .all()
        
        return user?.role == RoleEnum.student.rawValue ? CourseContext(course: course, sessions: sessions) : CourseContext(course: course, sessions: nil)
    }
    
    static func getAllObject(_ req: Vapor.Request) async throws -> [CourseModel] {
        let courses = try await CourseModel.query(on: req.db)
            .filter(\.$status == StatusEnum.published.rawValue)
            .all()
        return courses
    }
    
    
}
