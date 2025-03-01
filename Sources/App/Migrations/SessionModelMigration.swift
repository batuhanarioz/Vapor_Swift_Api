//
//  File.swift
//  RestApi
//
//  Created by reel on 25.12.2024.
//

import Foundation
import Fluent
import Vapor

struct SessionModelMigration: AsyncMigration {
    let schema = SessionModel.schema.self
    let keys = SessionModel.FieldKeys.self
    
    func prepare(on database: any Database) async throws {
        try await database.schema(schema)
            .id()
            .field(keys.title, .string)
            .field(keys.mp4URL, .string)
            .field(keys.hlsURL, .string)
            .field(keys.createdAt, .datetime)
            .field(keys.updatedAt, .datetime)
            .field(keys.publishDate, .datetime)
            .field(keys.status, .string)
            .field(keys.price, .string)
            .field(keys.article, .string)
            .field(keys.course, .uuid)
            .field(keys.slug, .string)
            .unique(on: keys.mp4URL)
            .unique(on: keys.hlsURL)
            .create()
    }
    
    func revert(on database: any Database) async throws {
        try await database.schema(schema).delete()
    }
    
}
