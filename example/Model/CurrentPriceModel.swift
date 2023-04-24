//
//  CurrentPriceModel.swift
//  example
//
//  Created by Thanawat prathumset on 24/4/2566 BE.
//

import Foundation

struct CurrentPriceModel: Decodable {
    let bpi: BpiModel
    
    enum CodingKeys: String, CodingKey {
        case bpi
    }
}

struct BpiModel: Decodable {
    let usd: CurrencyModel
    let gbp: CurrencyModel
    let eur: CurrencyModel
    
    enum CodingKeys: String, CodingKey {
        case usd = "USD"
        case gbp = "GBP"
        case eur = "EUR"
    }
}

struct CurrencyModel: Decodable {
    let code: String
    let symbol: String
    let rate: String
    let description: String
    let rateFloat: Double
    
    enum CodingKeys: String, CodingKey {
        case code
        case symbol
        case rate
        case description
        case rateFloat = "rate_float"
        
    }
}
