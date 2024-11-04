//
//  StreamApiModel.swift
//  assessmentTask
//
//  Created by Soumyajit Pal on 05/11/24.
//

import Foundation
struct ModelStreamApi : Codable {
    let userBalance : [UserBalance]?
    let error : Int?
    let message : String?

    enum CodingKeys: String, CodingKey {

        case userBalance = "userBalance"
        case error = "error"
        case message = "message"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        userBalance = try values.decodeIfPresent([UserBalance].self, forKey: .userBalance)
        error = try values.decodeIfPresent(Int.self, forKey: .error)
        message = try values.decodeIfPresent(String.self, forKey: .message)
    }

}

struct UserBalance : Codable {
    let customerId : Int?
    let currencyId : Int?
    let currency : String?
    let currencyType : Int?
    let currentBalance : Double?
    let isOptionsMargin : Int?
    let isOptionsFunding : Int?

    enum CodingKeys: String, CodingKey {

        case customerId = "customerId"
        case currencyId = "currencyId"
        case currency = "currency"
        case currencyType = "currencyType"
        case currentBalance = "currentBalance"
        case isOptionsMargin = "isOptionsMargin"
        case isOptionsFunding = "isOptionsFunding"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        customerId = try values.decodeIfPresent(Int.self, forKey: .customerId)
        currencyId = try values.decodeIfPresent(Int.self, forKey: .currencyId)
        currency = try values.decodeIfPresent(String.self, forKey: .currency)
        currencyType = try values.decodeIfPresent(Int.self, forKey: .currencyType)
        currentBalance = try values.decodeIfPresent(Double.self, forKey: .currentBalance)
        isOptionsMargin = try values.decodeIfPresent(Int.self, forKey: .isOptionsMargin)
        isOptionsFunding = try values.decodeIfPresent(Int.self, forKey: .isOptionsFunding)
    }

}
