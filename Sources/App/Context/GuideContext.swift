//
//  File.swift
//  ApiDocker
//
//  Created by reel on 28.12.2024.
//

import Foundation
import Vapor
import Fluent

struct GuideContext: Content {
    let guide: GuideModel
    let articles: [ArticleModel]?
}
