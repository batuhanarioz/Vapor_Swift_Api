//
//  File.swift
//  ApiDocker
//
//  Created by reel on 28.12.2024.
//

import Foundation
import Fluent
import Vapor

protocol FrontendProtocol {
    associatedtype model
    associatedtype answer
    associatedtype status
    associatedtype request
    
    static func getObject(_ req: request, object: String) async throws -> answer
    static func getAllObject(_ req: request) async throws -> [model]
}

protocol ChangeUserInformationProtocol {
    associatedtype model
    associatedtype status
    associatedtype request
    
    static func addCoursetoMyCourses(_ req: request, object: UUID) async throws -> status
    static func addCoursetoCompletedCourses(_ req: request, object: UUID) async throws -> status
}


protocol GetSelectedObjectProtocol {
    associatedtype model
    associatedtype request
    
    static func getSelectedObject(_ req: request, object: String) async throws -> model
}


protocol FrontendHandlerProtocol {
    associatedtype model
    associatedtype answer
    associatedtype request
    associatedtype status
    
    func getObject(_ req: request) async throws -> answer
    func getAllObject(_ req: request) async throws -> [model]
}


protocol GetSelectedObjectHandler {
    associatedtype answer
    associatedtype request
    associatedtype model
    
    func getSelectedObject(_ req: request) async throws -> model
}
