//
//  ContentViewModelTests.swift
//  exampleTests
//
//  Created by Thanawat prathumset on 24/4/2566 BE.
//

import XCTest
import Moya
import Combine

@testable import example

class ContentViewModelTests: XCTestCase {
 
    private var getCurrentPriceRepositorySpy: GetCurrentPriceRepositorySpy!
    
    override func setUp() {
        super.setUp()
        getCurrentPriceRepositorySpy = GetCurrentPriceRepositorySpy()
    }
    
    func test_FetchCurrentPrice_ShouldSuccess() {
        
        let mock = DataMockManager.getCurrentPriceModel()
        getCurrentPriceRepositorySpy.stubbedGetCurrentPriceResult = Just(mock).setFailureType(to: MoyaError.self).eraseToAnyPublisher()
        
        let sut = ContentViewModel(getCurrentPriceRepository: getCurrentPriceRepositorySpy)
        sut.fetchCurrentPrice()
        
        XCTAssertNotNil(sut.lastCurrentPriceModel)
    }
    
    func test_GetCurrencyList_USD_ShouldNotEmpty() {
        let code = "USD"
        let mock = DataMockManager.getCurrentPriceModel()
        getCurrentPriceRepositorySpy.stubbedGetCurrentPriceResult = Just(mock).setFailureType(to: MoyaError.self).eraseToAnyPublisher()
        
        let sut = ContentViewModel(getCurrentPriceRepository: getCurrentPriceRepositorySpy)
        let result = sut.getCurrencyList(code: code)
        
        XCTAssertTrue(!result.isEmpty)
    }
    
    func test_PriceToBTC_USDToBTC_ShouldCorrect() {
        let code = "USD"
        let price = "27744.495"
        let mock = DataMockManager.getCurrentPriceModel()
        getCurrentPriceRepositorySpy.stubbedGetCurrentPriceResult = Just(mock).setFailureType(to: MoyaError.self).eraseToAnyPublisher()
        
        let sut = ContentViewModel(getCurrentPriceRepository: getCurrentPriceRepositorySpy)
        let result = sut.priceToBTC(code: code, price: price)
        
        XCTAssertEqual(result, "1.000000")
    }
}
