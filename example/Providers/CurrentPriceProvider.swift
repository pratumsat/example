//
//  CurrentPriceProvider.swift
//  example
//
//  Created by Thanawat prathumset on 24/4/2566 BE.
//

import Moya
import Foundation

enum CurrentPriceProvider {
    case getCurrentPrice
}

extension CurrentPriceProvider: TargetType {
    var baseURL: URL {
        return URL(string: "https://api.coindesk.com")!
    }
    
    var path: String {
        switch self {
        case .getCurrentPrice:
            return "/v1/bpi/currentprice.json"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getCurrentPrice:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .getCurrentPrice:
            return .requestParameters(parameters: [:], encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
    
    var sampleData: Data {
        return Data()
    }
}
