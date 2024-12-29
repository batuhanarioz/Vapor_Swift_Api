//
//  File.swift
//  RestApi
//
//  Created by reel on 25.12.2024.
//

import Foundation
import Fluent
import Vapor

struct CourseModelMigration: AsyncMigration {
    let schema = CourseModel.schema.self
    let keys = CourseModel.FieldKeys.self
    
    func prepare(on database: any Database) async throws {
        try await database.schema(schema)
            .id()
            .field(keys.title, .string)
            .field(keys.slug, .string)
            .field(keys.tags, .array(of: .string))
            .field(keys.description, .string)
            .field(keys.status, .string)
            .field(keys.price, .string)
            .field(keys.headerImage, .string)
            .field(keys.article, .string)
            .field(keys.topHexColor, .string)
            .field(keys.bottomHexColor, .string)
            .field(keys.sylabus, .string)
            .field(keys.assets, .string)
            .field(keys.author, .string)
            .field(keys.createdAt, .datetime)
            .field(keys.updatedAt, .datetime)
            .field(keys.publishDate, .datetime)
            .unique(on: keys.sylabus)
            .unique(on: keys.assets)
            .create()
    }
    
    func revert(on database: any Database) async throws {
        try await database.schema(schema).delete()
    }
    
}
