//
//  SelectUserCardImageView.swift
//
//
//  Created by 濵田　悠樹 on 2023/07/21.
//

import ComposableArchitecture
import ReadabilityModifier
import SwiftUI
import Tab
import User
import ViewComponents

public struct SelectUserCardImageView: View {
    var store: StoreOf<SelectUserCardImageStore>

    let user: User?

    @State private var showImagePicker: Bool = false
    @State private var showCropImage: Bool = false
    @State private var isCropImage: Bool = false
    @State private var inputImage: UIImage?
    @State private var image: Image?

    private var isButtonEnable: Bool {
        if inputImage != nil && isCropImage {
            return true
        }
        return false
    }
    private var transButtonBackground: Color {
        if isButtonEnable {
            return Color.green
        }
        return Color.gray.opacity(0.5)
    }

    public init(store: StoreOf<SelectUserCardImageStore>, user: User?) {
        self.store = store
        self.user = user
    }

    public var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack(spacing: 24) {
                ScrollView {
                    VStack(spacing: 24) {
                        VStack(alignment: .leading, spacing: 24) {
                            Text("カード画像")
                                .font(.system(size: 24, weight: .bold, design: .rounded))

                            Text("他のユーザーに表示する画像です。満足のいく1枚を選びましょう。登録後に変更可能です。")
                                .font(.system(size: 12, weight: .regular, design: .rounded))
                        }

                        ZStack(alignment: .bottomTrailing) {
                            cardImage()
                            selectCardPicButton()
                                .offset(x: 24, y: 24)
                        }
                        .frame(width: 250, height: 400)
                    }
                }

                Button(
                    action: {
                        viewStore.send(.tappedButton(inputImage))
                    },
                    label: {
                        Text("次へ")
                            .foregroundColor(.white)
                            .font(.system(size: 24, weight: .bold, design: .rounded))
                            .frame(maxWidth: .infinity, maxHeight: 50)
                            .background(transButtonBackground)
                            .cornerRadius(10)
                    }
                )
                .padding(.top, 40)
                .disabled(!isButtonEnable)
            }
            .fitToReadableContentGuide()
            .padding(.top, 24)
            .sheet(isPresented: $showImagePicker, onDismiss: toImage) {
                ImagePicker(image: self.$inputImage)
                    .onDisappear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {  // cropImage を表示させるため必要
                            showCropImage = true
                        }
                    }
            }
            .sheet(isPresented: $showCropImage, onDismiss: toImage) {
                CropImage(image: self.$inputImage)
                    .onDisappear {
                        isCropImage = true
                    }
            }
            .fullScreenCover(
                isPresented: viewStore.binding(
                    get: { $0.isTransAppTabView },
                    send: .bindingIsTransAppTabView(!viewStore.isTransAppTabView)
                )
            ) {
                AppTabView()
            }
            .onAppear {
                viewStore.send(.onAppear(self.user))
            }
        }
    }

    private func cardImage() -> some View {
        Group {
            if image == nil {
                Rectangle()
                    .fill(.gray.opacity(0.5))
                    .cornerRadius(20)
            } else {
                image?
                    .resizable()
                    .cornerRadius(20)
            }
        }
    }

    private func selectCardPicButton() -> some View {
        Button(
            action: {
                self.showImagePicker.toggle()
            },
            label: {
                Image(systemName: "plus.circle.fill")
                    .resizable()
                    .foregroundColor(.green)
                    .background(Color.white)
                    .frame(width: 60, height: 60)
                    .cornerRadius(30)
            })
    }

    func toImage() {
        guard let inputImage = inputImage else { return }
        image = Image(uiImage: inputImage)
    }
}
