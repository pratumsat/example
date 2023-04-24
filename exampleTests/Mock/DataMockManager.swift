//
//  DataMockManager.swift
//  exampleTests
//
//  Created by Thanawat prathumset on 24/4/2566 BE.
//

import Foundation
@testable import example

class DataMockManager {
    static let jsonMock = """
{
    "time": {
        "updated": "Apr 24, 2023 02:49:00 UTC",
        "updatedISO": "2023-04-24T02:49:00+00:00",
        "updateduk": "Apr 24, 2023 at 03:49 BST"
    },
    "disclaimer": "This data was produced from the CoinDesk Bitcoin Price Index (USD). Non-USD currency data converted using hourly conversion rate from openexchangerates.org",
    "chartName": "Bitcoin",
    "bpi": {
        "USD": {
            "code": "USD",
            "symbol": "&#36;",
            "rate": "27,744.4950",
            "description": "United States Dollar",
            "rate_float": 27744.495
        },
        "GBP": {
            "code": "GBP",
            "symbol": "&pound;",
            "rate": "23,183.0780",
            "description": "British Pound Sterling",
            "rate_float": 23183.078
        },
        "EUR": {
            "code": "EUR",
            "symbol": "&euro;",
            "rate": "27,027.1888",
            "description": "Euro",
            "rate_float": 27027.1888
        }
    }
}
"""
    static func getCurrentPriceModel() -> CurrentPriceModel {
        return try! JSONDecoder().decode(CurrentPriceModel.self, from: jsonMock.data(using: .utf8)!)
    }
}
