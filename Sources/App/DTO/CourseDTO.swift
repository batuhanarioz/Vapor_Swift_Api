//
//  File.swift
//  RestApi
//
//  Created by reel on 25.12.2024.
//

import Foundation
import Vapor
import Fluent

struct CreateCourseDTO: Content {
    let title: String?
    let tags: [String]?
    let description: String?
    let status: StatusEnum.RawValue?
    let price: PriceEnum.RawValue?
    let headerImage: String?
    let article: String?
    let topHexColor: String?
    let bottomHexColor: String?
    let sylabus: String?
    let assets: String?
    let publishDate: Date?
}

struct UpdateCourseDTO: Content {
    let title: String?
    let tags: [String]?
    let description: String?
    let status: StatusEnum.RawValue?
    let price: PriceEnum.RawValue?
    let headerImage: String?
    let article: String?
    let topHexColor: String?
    let bottomHexColor: String?
    let sylabus: String?
    let assets: String?
    let publishDate: Date?
}
