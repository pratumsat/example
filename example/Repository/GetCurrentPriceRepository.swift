//
//  GetCurrentPriceRepository.swift
//  example
//
//  Created by Thanawat prathumset on 24/4/2566 BE.
//

import CombineMoya
import Combine
import Moya
import Foundation
 
protocol GetCurrentPriceRepositoryProtocol {
    func getCurrentPrice() -> AnyPublisher<CurrentPriceModel, MoyaError>
}

class GetCurrentPriceRepository: GetCurrentPriceRepositoryProtocol {
    let provider = MoyaProvider<CurrentPriceProvider>()
    
    func getCurrentPrice() -> AnyPublisher<CurrentPriceModel, MoyaError> {
        return provider.requestPublisher(.getCurrentPrice)
            .flatMap { response -> AnyPublisher<CurrentPriceModel, MoyaError> in
                do {
                    let model = try JSONDecoder().decode(CurrentPriceModel.self, from: response.data)
                    return Just(model).setFailureType(to: MoyaError.self).eraseToAnyPublisher()
                } catch {
                    return Fail(error: error as! MoyaError).eraseToAnyPublisher()
                }
            }
            .eraseToAnyPublisher()
            
    }
    
}
