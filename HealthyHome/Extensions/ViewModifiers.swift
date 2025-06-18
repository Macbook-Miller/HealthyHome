//
//  ViewModifiers.swift
//  HealthyHome
//
//  Created by Fred on 01/06/2025.
//

import SwiftUI

struct BackgroundGradientModifier: ViewModifier {
    @Environment(\.colorScheme) private var colorScheme
    
    
    func body(content: Content) -> some View {
        ZStack {
            if colorScheme == .dark {
                LinearGradient(
                    gradient: Gradient(stops: [
                        .init(color: Color(red: 28 / 255, green: 29 / 255, blue: 54 / 255), location: 0.0), // Night blue gradient
                        .init(color: Color(red: 28 / 255, green: 35 / 255, blue: 77 / 255), location: 0.35),
                        .init(color: Color(red: 36 / 255, green: 59 / 255, blue: 117 / 255), location: 0.7),
                        .init(color: Color(red: 50 / 255, green: 90 / 255, blue: 180 / 255), location: 1.0)
                    ]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
            }
            else {
                LinearGradient(
                    gradient: Gradient(stops: [
                        .init(color: Color(red: 0.4, green: 0.7, blue: 1.0), location: 0.0), // Sky blue gradient
                        .init(color: Color(red: 244 / 255, green: 243 / 255, blue: 241 / 255), location: 0.55) // White part of gradint
                    ]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
            }
            content

        
        }
        
    }
    
}

extension View {
    func backgroundGradient() -> some View {
        self.modifier(BackgroundGradientModifier())
    }
}
