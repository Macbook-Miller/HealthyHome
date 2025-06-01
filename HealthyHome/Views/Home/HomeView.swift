//
//  HomeView.swift
//  HealthyHome
//
//  Created by Fred on 30/05/2025.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        
        VStack {
            
            HStack(alignment: .top) {
                
                VStack {
                    Text("75%")
                        .font(.system(size: 72, weight: .light))
                        .lineLimit(1)
                        .minimumScaleFactor(0.5)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                .padding(.top, 40)
                
                VStack {
                    Image("Clouds")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 200, height: 150)
                        .offset(x: 30)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            }
            .frame(maxWidth: .infinity, maxHeight: 250)
            .padding(.horizontal, 20)
            
            
            VStack(spacing: 0) {
                HStack(alignment: .bottom) {
                    VStack(alignment: .leading) {
                        Text("Home")
                            .font(.system(size: 18, weight: .regular))
                            .opacity(0.3)
                        Text("Søparken 27")
                            .font(.system(size: 26, weight: .semibold))
                            .lineLimit(1)
                            .minimumScaleFactor(0.5)
                    }
                    
                    Image("House")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 160, height: 100)
                        .offset(y: 15)
                }
                
                VStack {
                    ProgressView(value: 0.75)
                        .progressViewStyle(LinearProgressViewStyle(tint: .black))
                        .frame(width: 300, height: 14)
                }
                .background(Color.white)
                
            }
            
            Spacer()
        }
        .backgroundGradient()
    }
}

#Preview {
    HomeView()
}
