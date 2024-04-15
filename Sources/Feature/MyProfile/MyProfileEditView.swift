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
    @Environment(\.dismiss) private var dismiss

    private var mySns: [SNS] = [.twitter, .instagram, .line, .other("BeReal.")]
    @State private var nickname = "hotta_mayu"
    @State private var selfDescription = "こんにちは。モデルやってます。よろしくお願いします。"

    public var body: some View {
        NavigationView {
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
                QuestionTextEditor(title: "自己紹介", text: $selfDescription)
            }
            .fitToReadableContentGuide()
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "xmark")
                            .resizable()
                            .frame(width: 15, height: 15)
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        dismiss()
                    }) {
                        Text("保存")
                    }
                }
            }
            .navigationTitle("ユーザー設定")
            .navigationBarTitleDisplayMode(.inline)
            .interactiveDismissDisabled()
        }
    }
}

#Preview {
    MyProfileEditView()
}
