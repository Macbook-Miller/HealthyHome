//
//  HomeView.swift
//  HealthyHome
//
//  Created by Fred on 30/05/2025.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var authVM: AuthViewModel
    
    
    var body: some View {
        
        VStack {
            
            HStack(alignment: .top) {
                
                VStack {
                    Text("64%")
                        .font(.system(size: 68, weight: .light))
                        .lineLimit(1)
                        .minimumScaleFactor(0.5)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                .padding(.top, 60)
                
                
                VStack {
                    
                    Image("Clouds")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 200, height: 150)
                        .offset(x: 25, y: -20)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            }
            .frame(maxWidth: .infinity, maxHeight: 150)
            
            
            
            VStack(spacing: 0) {
                
                HStack(alignment: .bottom) {
                    
                    VStack(alignment: .leading) {
                        
                        Text("Home")
                            .font(.system(size: 18, weight: .regular))
                            .opacity(0.3)
                        Text("Søparken 27")
                            .font(.system(size: 22, weight: .semibold))
                            .lineLimit(1)
                            .minimumScaleFactor(0.5)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 20)
                    
                    Image("House")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 160, height: 100)
                        .offset(y: 18)
                    
                }
                .frame(maxWidth: .infinity)
                
                
                
                VStack {
                    
                    ProgressView(value: 0.64)
                        .progressViewStyle(LinearProgressViewStyle(tint: Color("BtnBlack")))
                        .scaleEffect(x: 1, y: 2, anchor: .center)
                        .offset(y: -10)
                    
                    
                    
                    HStack  {
                        
                        VStack(alignment: .leading) {
                            Text("Type: House")
                            Text("Sqm: 110")
                        }
                        .font(.system(size: 15, weight: .regular))
                        
                        Spacer()
                        
                        VStack(alignment: .leading) {
                            Text("Rooms: 3")
                            Text("Members: 2")
                        }
                        .font(.system(size: 15, weight: .regular))
                        
                        Spacer()
                        
                        VStack(alignment: .trailing) {
                            Button(action: {
                                // Edit home sheet here
                            }) {
                                Image(systemName: "arrow.right")
                                    .foregroundColor(.white)
                                    .font(.system(size: 24, weight: .light))
                                    .frame(width: 40, height: 40)
                                    .background(Color("BtnBlack"))
                                    .cornerRadius(15)
                            }
                            
                        }
                        
                        
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: 110)
                .padding(.horizontal, 20)
                .background(Color.white)
                .cornerRadius(10)
                
                
                
            }
            .frame(maxWidth: .infinity)
            .offset(y: -40)
            
            
            VStack {
                
                HStack {
                    
                    Text("Pending tasks")
                        .font(.system(size: 18, weight: .semibold))
                    
                    Spacer()
                    
                    Button(action: {
                        // Edit home sheet here
                    }) {
                        Text("View all")
                            .foregroundColor(.white)
                            .font(.system(size: 14, weight: .light))
                            .frame(width: 80, height: 24)
                            .background(Color("BtnBlack"))
                            .cornerRadius(8)
                    }
                    
                    
                    
                    
                }
                .padding(.top, 15)
                
               
                
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: 230)
            .padding(.horizontal, 20)
            .background(Color.white)
            .cornerRadius(10)
            .offset(y: -30)
            
            
            HStack {
                
                VStack {
                    
                    HStack {
                        
                        Text("All tasks")
                            .font(.system(size: 14, weight: .semibold))
                        
                        Spacer()
                        
                        Button(action: {
                            // Edit home sheet here
                        }) {
                            Image(systemName: "arrow.right")
                                .foregroundColor(.white)
                                .font(.system(size: 14, weight: .light))
                                .frame(width: 30, height: 30)
                                .background(Color("BtnBlack"))
                                .cornerRadius(8)
                        }
                        
                    }
                    
                    
                    Text("12")
                        .font(.system(size: 40, weight: .regular))
                    
                }
                .frame(maxWidth: 132, maxHeight: 152)
                .padding(.horizontal, 20)
                .background(Color.white)
                .cornerRadius(10)
                
                Spacer()
                
                VStack {
                    
                    HStack {
                        
                        Text("Leaderboard")
                            .font(.system(size: 14, weight: .semibold))
                        
                        Spacer()
                        
                        Button(action: {
                            // To leaderboard Sheet
                        }) {
                            Image(systemName: "arrow.right")
                                .foregroundColor(.white)
                                .font(.system(size: 14, weight: .light))
                                .frame(width: 30, height: 30)
                                .background(Color("BtnBlack"))
                                .cornerRadius(8)
                        }
                        
                    }
                    
                    
                    
                }
                .frame(maxWidth: 132, maxHeight: 152)
                .padding(.horizontal, 20)
                .background(Color.white)
                .cornerRadius(10)
                
            }
            .offset(y: -20)
            
            
            Spacer()
            
        }
        .padding(.horizontal, 20)
        .backgroundGradient()
        
        
        
    }
}

#Preview {
    HomeView()
}
