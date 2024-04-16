//
//  MyProfileEditView.swift
//
//
//  Created by 濵田　悠樹 on 2024/03/11.
//

import Dependencies
import MyProfileStore
import ReadabilityModifier
import Request
import SwiftUI
import User
import ViewComponents

public struct MyProfileEditView: View {
    @Environment(\.dismiss) private var dismiss
    @Dependency(\.userRequestClient) var userRequestClient

    private var mySns: [SNS] = [.twitter, .instagram, .line, .other("BeReal.")]
    @State private var nickname = "hotta_mayu"
    @State private var selfDescription = "こんにちは。モデルやってます。よろしくお願いします。"

    @State private var isPresentedEditPhotoPickerView = false
    @State private var iconUIImage: UIImage? = UIImage(named: "hotta")!

    public var body: some View {
        NavigationView {
            VStack(spacing: 24) {
                // アイコン
                ZStack(alignment: .bottomTrailing) {
                    Image(uiImage: iconUIImage!)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 150, height: 150)
                        .cornerRadius(75)
                        .overlay(
                            RoundedRectangle(cornerRadius: 75).stroke(Color.black, lineWidth: 4)
                        )

                    Button(action: {
                        isPresentedEditPhotoPickerView = true
                    }) {
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
                }

                /*
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
                 */

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
                        let uid = "18D93893-3CAC-41B3-82AA-3B8A3EFDEBD6"
                        let iconURL = URL(string: "https://firebasestorage.googleapis.com:443/v0/b/swapwithme-51570.appspot.com/o/Users%2Ficon%2F18D93893-3CAC-41B3-82AA-3B8A3EFDEBD6.png?alt=media&token=c3235d81-56b2-41b7-bc30-07d1d56ce600")
                        let user: User = .init(id: uid, iconURL: iconURL, name: nickname, age: 20, sex: .man, affiliation: .high, animal: .dog, activity: .indoor, personality: .shy, description: selfDescription)
                        Task {
                            _ = try await userRequestClient.update(user)
                            dismiss()
                        }
                    }) {
                        Text("保存")
                    }
                }
            }
            .navigationTitle("ユーザー設定")
            .navigationBarTitleDisplayMode(.inline)
            .interactiveDismissDisabled()
            .sheet(isPresented: $isPresentedEditPhotoPickerView) {
                EditPhotoPickerView(image: $iconUIImage)
                    .ignoresSafeArea()
            }
        }

    }
}

#Preview {
    MyProfileEditView()
}
