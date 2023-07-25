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
    @State private var isFeedback = false
    @State private var isMatch = false
    @State private var imageScale = 0.2

    public init() {}

    public var body: some View {
        ZStack {
            if isMatch {
                animationCard()
            } else {
                card()
            }
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
                    .blur(radius: -self.translation.height / 100)
                    // animation
                    .offset(CGSize(width: 0, height: self.translation.height))
                    .rotationEffect(.degrees(Double(self.translation.width / 300) * 20), anchor: .bottom)
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                self.translation = value.translation
                                if value.translation.height < -300 {
                                    if !isFeedback {
                                        UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
                                        isFeedback = true
                                    }
                                } else {
                                    isFeedback = false
                                }
                            }
                            .onEnded { value in
                                withAnimation(.interpolatingSpring(mass: 1.0, stiffness: 100, damping: 10, initialVelocity: 0)) {
                                    switch value.translation.height {
                                    case let height where height < -300:
                                        self.translation = CGSize(width: 0, height: -1000)
                                        self.isMatch = true
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

    private func animationCard() -> some View {
        ZStack {
            cardImage
                .resizable()
                .scaledToFill()
                .frame(width: 250 * 1.2, height: 400 * 1.2)
                .cornerRadius(20)
                .scaleEffect(imageScale)
                .onAppear {
                    withAnimation(Animation.easeInOut(duration: 0.8)) {
                        imageScale = 1.8
                    }
                }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
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
