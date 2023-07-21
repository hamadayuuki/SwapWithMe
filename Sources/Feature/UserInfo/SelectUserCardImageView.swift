//
//  SelectUserCardImageView.swift
//
//
//  Created by 濵田　悠樹 on 2023/07/21.
//

import SwiftUI

public struct SelectUserCardImageView: View {
    @State private var showImagePicker: Bool = false
    @State private var inputImage: UIImage?
    @State private var image: Image?

    public init() {}

    public var body: some View {
        ZStack(alignment: .bottomTrailing) {
            cardImage()
            selectCardPicButton()
        }
        .frame(width: 250, height: 250)
        .sheet(isPresented: $showImagePicker, onDismiss: toImage) {
            ImagePicker(image: self.$inputImage)
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
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    @Environment(\.presentationMode) var presentationMode

    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.allowsEditing = true
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            if let uiImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
                parent.image = uiImage
            }

            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}

struct SelectUserCardImageView_Previews: PreviewProvider {
    static var previews: some View {
        SelectUserCardImageView()
    }
}
