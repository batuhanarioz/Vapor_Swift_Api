//
//  File.swift
//  RestApi
//
//  Created by reel on 25.12.2024.
//

import Foundation
import Fluent
import Vapor

extension CourseModel {
    struct FieldKeys {
        static var title: FieldKey {"title"}
        static var slug: FieldKey {"slug"}
        static var tags: FieldKey {"tag"}
        static var description: FieldKey {"description"}
        static var status: FieldKey {"status"}
        static var price: FieldKey {"price"}
        static var headerImage: FieldKey {"headerImage"}
        static var article: FieldKey {"article"}
        static var topHexColor: FieldKey {"topHexColor"}
        static var bottomHexColor: FieldKey {"bottomHexColor"}
        static var sylabus: FieldKey {"sylabus"}
        static var assets: FieldKey {"assets"}
        static var author: FieldKey {"author"}
        static var createdAt: FieldKey {"createdAt"}
        static var updatedAt: FieldKey {"updatedAt"}
        static var publishDate: FieldKey {"publishDate"}

    }
}
