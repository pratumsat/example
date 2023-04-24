//
//  ContentViewModel.swift
//  example
//
//  Created by Thanawat prathumset on 24/4/2566 BE.
//

import Foundation
import Combine

class ContentViewModel: ObservableObject {
    @Published private var currentPriceList: [CurrentPriceModel] =  []
    @Published private var currencyList: [String: [CurrencyModel]] =  [:]
    var currencyUSDList: [CurrencyModel] =  []
    var currencyEURList: [CurrencyModel] =  []
    var currencyGBPList: [CurrencyModel] =  []
    
    private var anyCancellable: Set<AnyCancellable> = .init()
    private var timer: Timer?
    private let getCurrentPriceRepository: GetCurrentPriceRepositoryProtocol
    
    deinit {
        timer?.invalidate()
        timer = nil
    }
    
    init(getCurrentPriceRepository: GetCurrentPriceRepositoryProtocol = GetCurrentPriceRepository()) {
        self.getCurrentPriceRepository = getCurrentPriceRepository
        fetchCurrentPrice()
        timer = Timer.scheduledTimer(timeInterval: 60, target: self, selector: #selector(autoUpdate), userInfo: nil, repeats: true)
    }
    
    
    public func fetchCurrentPrice() {
        getCurrentPriceRepository.getCurrentPrice()
            .sink { completeion in
                switch completeion {
                case let .failure(error):
                    print(error.errorDescription)
                case .finished:
                    break
                }
            } receiveValue: { [weak self] model in
                guard let self = self else { return }
                self.currentPriceList.append(model)
                self.currencyUSDList.append(model.bpi.usd)
                self.currencyEURList.append(model.bpi.eur)
                self.currencyGBPList.append(model.bpi.gbp)
                
                self.currencyList[model.bpi.usd.code] = self.currencyUSDList
                self.currencyList[model.bpi.eur.code] = self.currencyEURList
                self.currencyList[model.bpi.gbp.code] = self.currencyGBPList
            }.store(in: &anyCancellable)
    }
    
    @objc private func autoUpdate() {
        fetchCurrentPrice()
    }
    
    
    public var lastCurrentPriceModel: CurrentPriceModel? {
        return currentPriceList.last
    }
    
    public func getCurrencyList(code: String?) -> [CurrencyModel] {
        guard let code = code, let currencyList = currencyList[code] else { return [] }
        return currencyList
    }
    
    public func priceToBTC(code: String, price: String) -> String {
        guard let currencyList = currencyList[code],
              let rate = currencyList.last?.rateFloat,
              let price = Double(price) else { return "error" }
        let btc = price / rate
        return String(format: "%.6f", btc)
    }
    
}
