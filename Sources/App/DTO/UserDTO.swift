//
//  File.swift
//  RestApi
//
//  Created by reel on 25.12.2024.
//

import Foundation
import Fluent
import Vapor

struct CreateUserDTO: Content {
    let email: String
    let password: String
    let verify: String
    let username: String?
}

struct UpdateUserDTO: Content {
    let name: String?
    let lastname: String?
    let username: String?
    let email: String?
    let city: String?
    let address: String?
    let country: String?
    let postalcode: String?
    let bio: String?
}
