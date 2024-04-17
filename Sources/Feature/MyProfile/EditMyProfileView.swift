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

public struct EditMyProfileView: View {
    @Environment(\.dismiss) private var dismiss
    @Dependency(\.userRequestClient) var userRequestClient

    private var mySns: [SNS] = [.twitter, .instagram, .line, .other("BeReal.")]
    @State private var nickname = "hotta_mayu"
    @State private var selfDescription = "こんにちは。モデルやってます。よろしくお願いします。"

    @State private var showImagePicker: Bool = false
    @State private var showCropImage: Bool = false
    @State private var iconUIImage: UIImage? = UIImage(named: "hotta")!

    public var body: some View {
        NavigationView {
            VStack(spacing: 36) {
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
                        showImagePicker = true
                        showCropImage = false
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
                        Task {
                            let uid = "18D93893-3CAC-41B3-82AA-3B8A3EFDEBD6"
                            guard let uiImage = iconUIImage else { return }
                            let iconURL = try await ImageRequest.set(uiImage: uiImage, id: uid)
                            let user: User = .init(id: uid, iconURL: iconURL, name: nickname, age: 20, sex: .man, affiliation: .high, animal: .dog, activity: .indoor, personality: .shy, description: selfDescription)
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
            .frame(maxHeight: .infinity, alignment: .top)
            .padding(.top, 48)
            .sheet(isPresented: $showImagePicker) {
                ImagePicker(image: $iconUIImage)
                    .ignoresSafeArea()
            }
            .sheet(isPresented: $showCropImage) {
                CropImage(image: $iconUIImage)
            }
            .onChange(of: iconUIImage) { _ in
                showCropImage = true  // ImagePicker表示のタイミングでfalse
            }
        }

    }
}

#Preview {
    EditMyProfileView()
}
