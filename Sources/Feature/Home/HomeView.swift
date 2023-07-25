//
//  HomeView.swift
//
//
//  Created by 濵田　悠樹 on 2023/07/25.
//

import ReadabilityModifier
import SwiftUI

public struct HomeView: View {
    @State var cardImage: Image = Image(uiImage: UIImage())
    @State private var translation: CGSize = .zero

    public init() {}

    public var body: some View {
        ZStack {
            card()
        }
        .fitToReadableContentGuide()
        .onAppear {
            loadCardImage()
        }
    }

    private func card() -> some View {
        GeometryReader { (proxy: GeometryProxy) in
            Group {
                cardImage
                    // UI
                    .resizable()
                    .scaledToFill()
                    .frame(width: 250 * 1.2, height: 400 * 1.2)
                    .cornerRadius(20)
                    .shadow(radius: 5)
                    // animation
                    .offset(CGSize(width: 0, height: self.translation.height))
                    .rotationEffect(.degrees(Double(self.translation.width / 300) * 20), anchor: .bottom)
                    .gesture(
                        DragGesture()
                            .onChanged({ self.translation = $0.translation })
                            .onEnded { value in
                                withAnimation(.interpolatingSpring(mass: 1.0, stiffness: 100, damping: 10, initialVelocity: 0)) {
                                    switch value.translation.height {
                                    case let height where height < -300:
                                        self.translation = CGSize(width: 0, height: -1000)
                                    default:
                                        self.translation = .zero
                                    }
                                }
                            }
                    )
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }

    private func loadCardImage() {
        cardImage = Image("kiyohara")
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
