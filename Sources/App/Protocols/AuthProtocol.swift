//
//  File.swift
//  RestApi
//
//  Created by reel on 25.12.2024.
//

import Foundation
import Fluent
import Vapor

protocol AuthProtocol {
    func loginHandler(_ req: Request) throws -> EventLoopFuture<TokenModel>
}
