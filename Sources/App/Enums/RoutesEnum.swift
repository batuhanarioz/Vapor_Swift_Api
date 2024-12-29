//
//  File.swift
//  ApiDocker
//
//  Created by reel on 28.12.2024.
//

import Foundation

enum RoutesEnum: String, Equatable {
    case profile
    case login
    case register = "NotRegister"
    case update
    case delete
    case users
    case courses
    case guides
    case sessions
    case articles
    case search
}

enum RouteParameter: String, Equatable {
    case slug = "slug"
    case id = ":id"
    case status = ":status"
    case term = ":term"
    case article = ":articleSlug" 
}
