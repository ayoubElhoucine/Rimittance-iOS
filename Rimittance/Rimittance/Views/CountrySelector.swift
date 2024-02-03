//
//  CountrySelector.swift
//  Rimittance
//
//  Created by Elhoucine Ayoub on 2/2/2024.
//

import SwiftUI


struct CountrySelector: View {
    let selectedCountry: Country
    let countries: [Country]
    let didSelect: (Country) -> Void
    
    var body: some View {
        Menu {
            ForEach(countries, id: \.self) { country in
                Button {
                    didSelect(country)
                } label: {
                    Text("\(country.iso.flag)   \(country.name)").font(.grey100, .regular, 16)
                }
            }
        } label: {
            HStack(spacing: 10) {
                Text(selectedCountry.iso.flag)
                Text(selectedCountry.name).font(.grey100, .regular, 16)
                Spacer()
                Text("+\(selectedCountry.code)").font(.grey50, .regular, 16)
                Image("ic_arrow_down")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 14)
            }
            .padding(.horizontal, 16)
            .frame(height: 56)
            .overlay {
                RoundedRectangle(cornerRadius: 8)
                    .strokeBorder(Color.grey25, lineWidth: 1)
            }
        }
        .background(.white)
        .cornerRadius(8)
    }
}
