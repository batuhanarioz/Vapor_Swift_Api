//
//  File.swift
//  RestApi
//
//  Created by reel on 25.12.2024.
//

import Foundation
import Vapor
import Fluent

protocol UserProtocol {
    associatedtype model
    associatedtype answer
    associatedtype request
    associatedtype createDTO
    associatedtype updateDTO
    associatedtype status
    
    
    static func create(_ req: request, _ createDTO: createDTO) async throws -> answer
    static func get(_ req: request, object: String) async throws -> answer
    static func update(_ req: request, object: String, updateDTO: updateDTO) async throws -> answer
    static func delete(_ req: request, object: String) async throws -> status
    
}

protocol UserHandlerProtocol {
    associatedtype answer
    associatedtype request
    associatedtype status
    
    func create(_ req: request) async throws -> answer
    func get(_ req: request) async throws -> answer
    func update(_ req: request) async throws -> answer
    func delete(_ req: request) async throws -> status
}
