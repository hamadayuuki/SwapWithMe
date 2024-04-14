//
//  MyProfileEditView.swift
//
//
//  Created by 濵田　悠樹 on 2024/03/11.
//

import MyProfileStore
import ReadabilityModifier
import SwiftUI
import ViewComponents

public struct MyProfileEditView: View {
    private var mySns: [SNS] = [.twitter, .instagram, .line, .other("BeReal.")]
    @State private var nickname = "hotta_mayu"
    @State private var selfDescription = "こんにちは。モデルやってます。よろしくお願いします。"

    public var body: some View {
        VStack(spacing: 24) {
            // アイコン
            ZStack(alignment: .bottomTrailing) {
                Image("hotta")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 150, height: 150)
                    .cornerRadius(75)
                    .overlay(
                        RoundedRectangle(cornerRadius: 75).stroke(Color.black, lineWidth: 4)
                    )

                ZStack {
                    Circle()
                        .fill(.white)
                        .frame(width: 50, height: 50)
                        .overlay {
                            Circle().stroke(.black, lineWidth: 1).frame(width: 50, height: 50)
                        }

                    Image(systemName: "camera.fill")
                        .resizable()
                        .frame(width: 30, height: 25)
                }
            }

            // SNSアイコン
            HStack(spacing: 16) {
                ForEach(mySns, id: \.self) { sns in
                    Image(sns.iconName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                        .cornerRadius(25)
                        .overlay(
                            RoundedRectangle(cornerRadius: 25).stroke(Color.black, lineWidth: 1)
                        )
                }
            }
            .frame(maxWidth: .infinity)

            QuestionTextField(title: "名前", placeholder: "", text: $nickname)
            QuestionTextField(title: "自己紹介", placeholder: "", text: $selfDescription)
        }
        .fitToReadableContentGuide()
    }
}

#Preview {
    MyProfileEditView()
}
