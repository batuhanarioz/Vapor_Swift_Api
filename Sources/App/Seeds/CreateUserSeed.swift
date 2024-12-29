//
//  File.swift
//  RestApi
//
//  Created by reel on 26.12.2024.
//

import Foundation
import Vapor
import Fluent

struct CreateUserSeed: AsyncMigration {
    
    func prepare(on database: any FluentKit.Database) async throws {
        let admin = UserModel(username: "Batuhan", email: "batuhanarioz98@gmail.com", password: try Bcrypt.hash("Test12345678"), role: RoleEnum.admin.rawValue, createdAt: Date(), updatedAt: Date())
        try await admin.create(on: database)
    }
    
    func revert(on database: any FluentKit.Database) async throws {
        try await UserModel.query(on: database).delete()
    }
    
}
