//
//  File.swift
//  RestApi
//
//  Created by reel on 26.12.2024.
//

import Foundation
import Fluent
import Vapor

final class TokenModel: Model, @unchecked Sendable {
    static let schema: String = SchemaEnum.tokens.rawValue
    
    @ID
    var id: UUID?
    
    @Field(key: FieldKeys.value)
    var value: String
    
    @Parent(key: FieldKeys.userID)
    var userID: UserModel
    
    init() {}
    
    init(id: UUID? = nil, value: String, userID: UserModel.IDValue) {
        self.value = value
        self.$userID.id = userID
    }
}

extension TokenModel: Content {
    
}


extension TokenModel: ModelTokenAuthenticatable {
    typealias user = App.UserModel
    static let valueKey = \TokenModel.$value
    static let userKey = \TokenModel.$userID
    var isValid: Bool {
        return true
    }
}


extension TokenModel {
    static func generate(for user: UserModel) throws -> TokenModel {
        let random = [UInt8].random(count: 16).base64
        return try TokenModel(value: random, userID: user.requireID())
    }
}
