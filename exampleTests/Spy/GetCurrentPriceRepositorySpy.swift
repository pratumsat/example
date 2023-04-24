//
//  GetCurrentPriceRepositorySpy.swift
//  exampleTests
//
//  Created by Thanawat prathumset on 24/4/2566 BE.
//

@testable import example
import Combine
import Moya

class GetCurrentPriceRepositorySpy: GetCurrentPriceRepositoryProtocol {

    var invokedGetCurrentPrice = false
    var invokedGetCurrentPriceCount = 0
    var stubbedGetCurrentPriceResult: AnyPublisher<CurrentPriceModel, MoyaError>!

    func getCurrentPrice() -> AnyPublisher<CurrentPriceModel, MoyaError> {
        invokedGetCurrentPrice = true
        invokedGetCurrentPriceCount += 1
        return stubbedGetCurrentPriceResult
    }
}
