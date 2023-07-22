//
//  SelectUserCardImageView.swift
//
//
//  Created by 濵田　悠樹 on 2023/07/21.
//

import ReadabilityModifier
import SwiftUI
import ViewComponents

public struct SelectUserCardImageView: View {
    @State private var showImagePicker: Bool = false
    @State private var showCropImage: Bool = false
    @State private var inputImage: UIImage?
    @State private var image: Image?

    public init() {}

    public var body: some View {
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
        }
        .fitToReadableContentGuide()
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

struct SelectUserCardImageView_Previews: PreviewProvider {
    static var previews: some View {
        SelectUserCardImageView()
    }
}
