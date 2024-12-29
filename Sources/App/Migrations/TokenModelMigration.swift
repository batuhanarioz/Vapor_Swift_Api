//
//  File.swift
//  RestApi
//
//  Created by reel on 26.12.2024.
//

import Foundation
import Fluent
import Vapor

struct TokenModelMigration: AsyncMigration {
    let keys = TokenModel.FieldKeys.self
    let schema = TokenModel.schema.self
    
    func prepare(on database: any Database) async throws {
        try await database.schema(schema)
            .id()
            .field(keys.value, .string)
            .field(keys.userID, .uuid)
            .create()
    }
    
    func revert(on database: any Database) async throws {
        try await database.schema(schema).delete()
    }
}
