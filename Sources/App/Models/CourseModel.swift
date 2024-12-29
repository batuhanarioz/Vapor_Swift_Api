//
//  CourseModel.swift
//  RestApi
//
//  Created by reel on 25.12.2024.
//

import Foundation
import Vapor
import Fluent

final class CourseModel: Model, @unchecked Sendable  {
    static let schema: String = SchemaEnum.courses.rawValue
    
    @ID
    var id: UUID?
    
    @OptionalField(key: FieldKeys.title)
    var title: String?
    
    @OptionalField(key: FieldKeys.slug)
    var slug: String?
    
    @OptionalField(key: FieldKeys.tags)
    var tags: [String]?
    
    @OptionalField(key: FieldKeys.description)
    var description: String?
    
    @OptionalField(key: FieldKeys.status)
    var status: StatusEnum.RawValue?
    
    @OptionalField(key: FieldKeys.price)
    var price: PriceEnum.RawValue?
    
    @OptionalField(key: FieldKeys.headerImage)
    var headerImage: String?
    
    @OptionalField(key: FieldKeys.article)
    var article: String?
    
    @OptionalField(key: FieldKeys.topHexColor)
    var topHexColor: String?
    
    @OptionalField(key: FieldKeys.bottomHexColor)
    var bottomHexColor: String?
    
    @OptionalField(key: FieldKeys.sylabus)
    var sylabus: String?
    
    @OptionalField(key: FieldKeys.assets)
    var assets: String?
    
    @OptionalField(key: FieldKeys.author)
    var author: String?
    
    @Timestamp(key: FieldKeys.createdAt, on: .create)
    var createdAt: Date?
    
    @Timestamp(key: FieldKeys.updatedAt, on: .update)
    var updatedAt: Date?
    
    @OptionalField(key: FieldKeys.publishDate)
    var publishDate: Date?
    
    init() {}
    
    init(title: String?, slug: String?, tags: [String]?, description: String?, status: StatusEnum.RawValue?, price: PriceEnum.RawValue?, headerImage: String?, article: String?, topHexColor: String?, bottomHexColor: String?, sylabus: String?, assets: String?, author: String?, createdAt: Date?, updatedAt: Date?, publishDate: Date?) {
        self.title = title
        self.slug = slug
        self.tags = tags
        self.description = description
        self.status = status
        self.price = price
        self.headerImage = headerImage
        self.article = article
        self.topHexColor = topHexColor
        self.bottomHexColor = bottomHexColor
        self.sylabus = sylabus
        self.assets = assets
        self.author = author
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.publishDate = publishDate
    }
    
    init(status: StatusEnum.RawValue) {
        self.status = status
    }
    
    init(price: PriceEnum.RawValue) {
        self.price = price
    }
}

extension CourseModel: Content {}
