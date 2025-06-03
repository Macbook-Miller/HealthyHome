//
//  LocationsView.swift
//  HealthyHome
//
//  Created by Fred on 30/05/2025.
//

import SwiftUI

struct LocationsView: View {
    
    
    var body: some View {
        
        VStack {
            VStack {
                Button(action: {
                    
                }) {
                    Text("Create new")
                        .foregroundColor(Color.white)
                        .padding()
                        .frame(maxWidth: 120)
                        .background(Color("BtnBlack"))
                        .cornerRadius(8)
                }
            }
            .padding(.horizontal, 20)
        }
        .backgroundGradient()
    }
    
}

#Preview {
    LocationsView()
}
