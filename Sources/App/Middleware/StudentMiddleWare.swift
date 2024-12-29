//
//  File.swift
//  ApiDocker
//
//  Created by reel on 28.12.2024.
//

import Foundation
import Vapor
import Fluent

struct CheckStudentMiddleWare: AsyncMiddleware {
    func respond(to request: Request, chainingTo next: any AsyncResponder) async throws -> Response {
        guard let user = request.auth.get(UserModel.self), user.role == RoleEnum.student.rawValue else {
            throw Abort(.forbidden, reason: "Sorry, you need to be subscribed to be able to read this article or watch this content. Please choose a subscription plan.")
        }
        return try await next.respond(to: request)
    }
}

