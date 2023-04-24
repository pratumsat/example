//
//  DetailView.swift
//  example
//
//  Created by Thanawat prathumset on 24/4/2566 BE.
//

import SwiftUI

struct DetailView: View {
    @EnvironmentObject var viewModel: ContentViewModel
    private let code: String?
    
    init(code: String?) {
        self.code = code
    }
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(0..<viewModel.getCurrencyList(code: code).count, id: \.self) { index in
                    let item = viewModel.getCurrencyList(code: code)[index]
                    HStack {
                        Text("\(item.code)/BTC")
                        Spacer()
                        Text("\(item.rate)")
                    }
                }
            }
            .padding()
            Spacer()
        }
        
    }
}
