//
//  ImagePicker.swift
//
//
//  Created by 濵田　悠樹 on 2023/07/22.
//

import SwiftUI

public struct ImagePicker: UIViewControllerRepresentable {
    var image: Binding<UIImage?>
    @Environment(\.presentationMode) var presentationMode

    public init(image: Binding<UIImage?>) {
        self.image = image
    }

    public func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.allowsEditing = true
        return picker
    }

    public func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {
    }

    public func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    public class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        var parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            if let uiImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
                parent.image.wrappedValue = uiImage
            }

            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}
