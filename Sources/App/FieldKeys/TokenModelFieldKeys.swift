//
//  File.swift
//  RestApi
//
//  Created by reel on 26.12.2024.
//

import Foundation
import Vapor
import Fluent

extension TokenModel {
    struct FieldKeys {
        static var value: FieldKey {"value"}
        static var userID: FieldKey {"userID"}
    }
}
