//
//  ContentView.swift
//  example
//
//  Created by Thanawat prathumset on 24/4/2566 BE.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject private var viewModel = ContentViewModel()
    @State private var price: String = ""
    @State private var selection: String = "USD"
    let currencys = ["USD", "EUR", "GBP"]
    
    var body: some View {
        NavigationStack {
            currencyView
            inputView
        }
        .environmentObject(viewModel)
    }
    
    var currencyView: some View {
        VStack {
            VStack {
                HStack {
                    Text(viewModel.lastCurrentPriceModel?.bpi.usd.code ?? "")
                    Text(viewModel.lastCurrentPriceModel?.bpi.usd.rate ?? "")
                    Spacer()
                    NavigationLink {
                        DetailView(code: viewModel.lastCurrentPriceModel?.bpi.usd.code)
                    } label: {
                        Text("ดูย้อนหลัง")
                            .foregroundColor(.white)
                            .padding(8)
                    }.background(Color.red).cornerRadius(16)
                }
                HStack {
                    Text(viewModel.lastCurrentPriceModel?.bpi.eur.code ?? "")
                    Text(viewModel.lastCurrentPriceModel?.bpi.eur.rate ?? "")
                    Spacer()
                    NavigationLink {
                        DetailView(code: viewModel.lastCurrentPriceModel?.bpi.eur.code)
                    } label: {
                        Text("ดูย้อนหลัง")
                            .foregroundColor(.white)
                            .padding(8)
                    }.background(Color.red).cornerRadius(16)
                }
                HStack {
                    Text(viewModel.lastCurrentPriceModel?.bpi.gbp.code ?? "")
                    Text(viewModel.lastCurrentPriceModel?.bpi.gbp.rate ?? "")
                    Spacer()
                    NavigationLink {
                        DetailView(code: viewModel.lastCurrentPriceModel?.bpi.gbp.code)
                    } label: {
                        Text("ดูย้อนหลัง")
                            .foregroundColor(.white)
                            .padding(8)
                    }.background(Color.red).cornerRadius(16)
                }
            }
        }
        .padding()
    }
    
    var inputView: some View {
        VStack(alignment: .leading){
            HStack {
                Picker("Select Currency", selection: $selection) {
                    ForEach(currencys, id: \.self) { currency in
                        Text(currency)
                    }
                }
                .pickerStyle(.menu)
                TextField("Enter your price", text: $price)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
            }
            Text("\(selection)/BTC = \(viewModel.priceToBTC(code: selection, price: price))")
                .padding()
        }
    }
}
