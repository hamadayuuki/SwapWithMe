//
//  SwapedPopup.swift
//
//
//  Created by 濵田　悠樹 on 2023/07/27.
//

import SwiftUI

public struct SwapedPopup: View {
    let myCardURL: URL?
    let partnerCardURL: URL?
    var isQuestionPopup: Binding<Bool>
    var isTransPartner: Binding<Bool>

    public init(myCardURL: URL?, partnerCardURL: URL?, isQuestionPopup: Binding<Bool>, isTransPartner: Binding<Bool>) {
        self.myCardURL = myCardURL
        self.partnerCardURL = partnerCardURL
        self.isQuestionPopup = isQuestionPopup
        self.isTransPartner = isTransPartner
    }

    public var body: some View {
        VStack(spacing: 32) {
            ZStack {
                HStack(spacing: 12) {
                    card(isPartner: false)
                        .rotationEffect(.degrees(-20))
                    card(isPartner: true)
                        .rotationEffect(.degrees(20))
                }

                Image(systemName: "heart.circle")
                    .resizable()
                    .frame(width: 60, height: 60)
                    .offset(x: 0, y: 50)
                    .foregroundColor(.pink)
            }

            VStack(spacing: 12) {
                Text("Swapしました！")
                    .font(.system(size: 24, weight: .bold, design: .rounded))
                    .foregroundColor(.green)

                Text("AIが作るSwapしたユーザーへの質問を見てみましょう")
                    .font(.system(size: 12, weight: .semibold, design: .rounded))
                    .foregroundColor(.gray)
            }
            .padding(.bottom, 24)

            VStack(spacing: 0) {
                Button(
                    action: {
                        isTransPartner.wrappedValue = true
                    },
                    label: {
                        toQuestionButtonText()
                    })

                Button(
                    action: {
                        self.isQuestionPopup.wrappedValue = false
                    },
                    label: {
                        cancelButtonText()
                    })
            }
        }
        .frame(width: 350, height: 460)
        .background(.white)
        .cornerRadius(20)
        .shadow(radius: 5)
    }

    private func card(isPartner: Bool) -> some View {
        ZStack {
            if isPartner {
                Image("partner")
                    .resizable()
                    .scaledToFill()
                //                AsyncImage(url: self.partnerCardURL!) { image in
                //                    image
                //                        .resizable()
                //                        .scaledToFill()
                //                } placeholder: {
                //                    ProgressView()
                //                }
            } else {
                Image("my")
                    .resizable()
                    .scaledToFill()
                //                AsyncImage(url: self.myCardURL!) { image in
                //                    image
                //                        .resizable()
                //                        .scaledToFill()
                //                } placeholder: {
                //                    ProgressView()
                //                }
            }
        }
        .frame(width: 250 * 0.4, height: 400 * 0.4)
        .cornerRadius(20)
        .shadow(radius: 2)
    }

    private func toQuestionButtonText() -> some View {
        Text("質問を見る")
            .font(.system(size: 14, weight: .bold, design: .rounded))
            .frame(width: 250, height: 40)
            .background(.green)
            .foregroundColor(.white)
    }

    private func cancelButtonText() -> some View {
        Text("キャンセル")
            .font(.system(size: 14, weight: .bold, design: .rounded))
            .frame(width: 250, height: 40)
            .foregroundColor(.gray)
    }
}
