//
//  File.swift
//  ApiDocker
//
//  Created by reel on 27.12.2024.
//

import Foundation
import Vapor
import Fluent

struct CheckAdminMiddleWare: AsyncMiddleware {
    func respond(to request: Request, chainingTo next: any AsyncResponder) async throws -> Response {
        guard let user = request.auth.get(UserModel.self), user.role == RoleEnum.admin.rawValue else {
            throw Abort(.forbidden, reason: "Sorry, you need admin rights to access this resources. Please contact an sysadmin if you think this is incorrect.")
        }
        return try await next.respond(to: request)
    }
}
