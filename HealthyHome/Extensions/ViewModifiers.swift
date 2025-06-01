//
//  ViewModifiers.swift
//  HealthyHome
//
//  Created by Fred on 01/06/2025.
//

import SwiftUI

struct BackgroundGradientModifier: ViewModifier {
    func body(content: Content) -> some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(stops: [
                    .init(color: Color(red: 0.4, green: 0.7, blue: 1.0), location: 0.0), // Sky blue gradient
                    .init(color: Color(red: 244 / 255, green: 243 / 255, blue: 241 / 255), location: 0.55) // White part of gradint
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            content
        }
    }
}

extension View {
    func backgroundGradient() -> some View {
        self.modifier(BackgroundGradientModifier())
    }
}
