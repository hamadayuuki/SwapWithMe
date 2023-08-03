//
//  HomeView.swift
//
//
//  Created by 濵田　悠樹 on 2023/07/25.
//

import AudioToolbox
import PopupView
import QuestionList
import ReadabilityModifier
import SwiftUI
import ViewComponents

public struct HomeView: View {
    @State var cardImage: Image = Image(uiImage: UIImage())
    @State private var translation: CGSize = .zero
    @State private var isFeedback = false
    @State private var isMatch = false
    @State private var imageScale = 0.2
    @State private var swapImagesOpacity = [0.0, 0.0, 0.0]
    @State private var userInfoOpacity = 0.0
    @State private var isQuestionPopup = false
    @State private var isTransQuestionList = false

    private let swapIconSize = CGSize(width: 1527 / 7, height: 522 / 7)
    private let swapTimer = Timer.publish(every: 0.2, on: .main, in: .common).autoconnect()
    private let nameTimer = Timer.publish(every: 0.8, on: .main, in: .common).autoconnect()  // swapアニメーションが終わるのを待つ

    public init() {}

    public var body: some View {
        ZStack {
            if isMatch {
                partnerCard()
                VStack(spacing: 24) {
                    swapedTextAnimation()
                    partnerInfo(name: "ながのめいですす", age: 23, affiliation: "フレンドリー")
                }
                .offset(x: 0, y: 100)
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                        isQuestionPopup = true
                    }
                }

            } else {
                myCard()
                myInfo(name: "きよはらしょうう", age: 25, affiliation: "人見知り")
                    .offset(x: 0, y: (250 * 0.6) - 12)
            }

            NavigationLink(
                destination: QuestionListView(),
                isActive: $isTransQuestionList
            ) {
                EmptyView()
            }
        }
        .fitToReadableContentGuide()
        .popup(
            isPresented: $isQuestionPopup
        ) {
            SwapedPopup(isQuestionPopup: $isQuestionPopup, isTransQuestionList: $isTransQuestionList)
        } customize: {
            $0
                .type(.default)
                .animation(.easeOut(duration: 0.5))
                .closeOnTap(false)
                .backgroundColor(.black.opacity(0.3))
        }
        .onAppear {
            loadCardImage()
        }
    }

    // 共通化
    private func card() -> some View {
        ZStack {
            cardImage
                .resizable()
                .scaledToFill()

            LinearGradient(
                gradient: Gradient(colors: [.clear, .black.opacity(0.7)]),
                startPoint: .top,
                endPoint: .bottom
            )
        }
        .frame(width: 250 * 1.2, height: 400 * 1.2)
        .cornerRadius(20)
    }

    // MARK: - My card

    private func myCard() -> some View {
        GeometryReader { (proxy: GeometryProxy) in
            card()
                // UI
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
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }

    private func myInfo(name: String, age: Int, affiliation: String) -> some View {
        VStack(spacing: 6) {
            Text("\(name)")
                .font(.system(size: 24, weight: .bold, design: .rounded))

            HStack(spacing: 6) {
                Text("\(age)歳")

                Text("\(affiliation)")
            }
            .font(.system(size: 12, weight: .medium, design: .rounded))
        }
        .foregroundColor(.white)
        .blur(radius: -self.translation.height / 100)
        // animation
        .offset(CGSize(width: 0, height: self.translation.height))
        .rotationEffect(.degrees(Double(self.translation.width / 300) * 20), anchor: .bottom)
    }

    // MARK: - Partner card

    private func partnerCard() -> some View {
        card()
            .scaleEffect(imageScale)
            .onAppear {
                cardImage = Image("nagano")
                withAnimation(Animation.easeInOut(duration: 0.8)) {
                    imageScale = 1.8
                }
            }
    }

    private func swapedTextAnimation() -> some View {
        ZStack {
            ForEach(0..<3) { i in
                Image("swap-\(i)")
                    .resizable()
                    .frame(width: self.swapIconSize.width * (1.0 + CGFloat(i) * 0.3), height: self.swapIconSize.height * (1.0 + CGFloat(i) * 0.3))
                    .opacity(swapImagesOpacity[i])
                    .offset(x: 0, y: CGFloat(-i * 30))
                    .onReceive(swapTimer) { _ in
                        withAnimation(Animation.easeInOut.delay(CGFloat(i) * 0.2)) {
                            if self.swapImagesOpacity[i] == 0.0 {
                                self.swapImagesOpacity[i] = 1.0
                                AudioServicesPlayAlertSoundWithCompletion(SystemSoundID(kSystemSoundID_Vibrate)) {}
                            }
                        }
                    }
            }
        }
    }

    private func partnerInfo(name: String, age: Int, affiliation: String) -> some View {
        VStack(spacing: 12) {
            Text("\(name)")
                .font(.system(size: 36, weight: .bold, design: .rounded))

            HStack(spacing: 12) {
                Text("\(age)歳")

                Text("\(affiliation)")
            }
            .font(.system(size: 18, weight: .medium, design: .rounded))
        }
        .foregroundColor(.white)
        .opacity(self.userInfoOpacity)
        .onReceive(nameTimer) { _ in
            withAnimation(.easeInOut(duration: 0.4)) {
                self.userInfoOpacity = 1.0
            }
        }
    }

    // MARK: - Function

    private func loadCardImage() {
        cardImage = Image("kiyohara")
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
