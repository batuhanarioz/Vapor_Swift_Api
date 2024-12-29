//
//  File.swift
//  RestApi
//
//  Created by reel on 25.12.2024.
//

import Foundation
import Fluent
import Vapor

protocol ContentFilterProtocol {
    associatedtype request
    associatedtype answer
    associatedtype model
    associatedtype status
    
    func search(_ req: request, term: String) async throws -> [model]
    
}

protocol BackendContentFilterProtocol {
    associatedtype request
    associatedtype answer
    associatedtype model
    associatedtype status
    
    static func getByStatus(_ req: request, status: StatusEnum.RawValue) async throws -> [model]
    static func search(_ req: request, term: String) async throws -> [model]
}

protocol SearchUserProtocol {
    associatedtype request
    
    static func search(_ req: request, term: String) async throws -> [UserModel.Public]
}


protocol BackendFilterHandlerProtocol {
    associatedtype request
    associatedtype model
    associatedtype answer
    
    func getByStatus(_ req: request) async throws -> [model]
    func search(_ req: request) async throws -> [model]
    
}
