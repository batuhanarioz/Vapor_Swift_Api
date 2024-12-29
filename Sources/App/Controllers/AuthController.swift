//
//  File.swift
//  ApiDocker
//
//  Created by reel on 27.12.2024.
//

import Foundation
import Vapor
import Fluent

struct AuthController: AuthProtocol {
    @Sendable func loginHandler(_ req: Request) throws -> EventLoopFuture<TokenModel> {
        let user = try req.auth.require(UserModel.self)
        let token = try TokenModel.generate(for: user)
        return token.save(on: req.db).map {
            token
        }
    }
}
