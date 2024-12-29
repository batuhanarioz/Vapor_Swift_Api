//
//  File.swift
//  RestApi
//
//  Created by reel on 25.12.2024.
//

import Foundation
import Fluent
import Vapor

protocol TransformProtocol {
    associatedtype answerWithId
    
    static func getIdFromSlug(_ req: Request, slug: String) async throws -> answerWithId
}
