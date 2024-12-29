//
//  File.swift
//  RestApi
//
//  Created by reel on 25.12.2024.
//

import Foundation
import Fluent
import Vapor

struct CreateGuideDTO: Content {
    let title: String?
    let description: String?
    let headerImage: String?
    let price: PriceEnum.RawValue?
    let status: StatusEnum.RawValue?
    let tags: [String]?
    let publishDate: Date?
}

struct UpdateGuideDTO: Content {
    let title: String?
    let description: String?
    let headerImage: String?
    let price: PriceEnum.RawValue?
    let status: StatusEnum.RawValue?
    let tags: [String]?
    let publishDate: Date?
}
