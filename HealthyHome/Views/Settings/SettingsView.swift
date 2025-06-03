//
//  SettingsView.swift
//  HealthyHome
//
//  Created by Fred on 30/05/2025.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var authVM: AuthViewModel
    
    var body: some View {
        
        VStack {
            Button(action: {
                
            }) {
                Text("Log out")
                    .foregroundColor(Color.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color("BtnBlack"))
                    .cornerRadius(8)
            }
        }
        .padding(.horizontal, 20)
    }
}

#Preview {
    SettingsView()
}
