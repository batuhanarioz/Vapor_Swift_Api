//
//  File.swift
//  RestApi
//
//  Created by reel on 25.12.2024.
//

import Foundation
import Fluent
import Vapor

struct CreateSessionDTO: Content {
    let title: String?
    let mp4URL: String?
    let hlsURL: String?
    let publishDate: Date?
    let status: StatusEnum.RawValue?
    let price: PriceEnum.RawValue?
    let article: String?
    let course: CourseModel.IDValue?
}

struct UpdateSessionDTO: Content {
    let title: String?
    let mp4URL: String?
    let hlsURL: String?
    let publishDate: Date?
    let status: StatusEnum.RawValue?
    let price: PriceEnum.RawValue?
    let article: String?
    let course: CourseModel.IDValue?
}
