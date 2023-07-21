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
            VStack(alignment: .leading, spacing: 24) {
                Text("カード画像")
                    .font(.system(size: 24, weight: .bold, design: .rounded))

                Text("他のユーザーに表示する画像です。満足のいく1枚を選びましょう。登録後に変更可能です。")
                    .font(.system(size: 12, weight: .regular, design: .rounded))
            }

            ZStack(alignment: .bottomTrailing) {
                cardImage()
                selectCardPicButton()
            }
            .frame(width: 250, height: 250)
        }
        .fitToReadableContentGuide()
        .sheet(isPresented: $showImagePicker, onDismiss: toImage) {
            ImagePicker(image: self.$inputImage)
        }
        .sheet(isPresented: $showCropImage) {
            CropImage(image: self.$inputImage)
        }
    }

    private func cardImage() -> some View {
        Group {
            if image == nil {
                Circle()
                    .foregroundColor(Color.gray.opacity(0.5))
            } else {
                image?
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(Circle())
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
                    .frame(width: 60, height: 60)
                    .foregroundColor(.green)
            })
    }

    func toImage() {
        guard let inputImage = inputImage else { return }
        image = Image(uiImage: inputImage)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {  // cropImage を表示させるため必要
            showCropImage = true
        }
    }
}

struct SelectUserCardImageView_Previews: PreviewProvider {
    static var previews: some View {
        SelectUserCardImageView()
    }
}
