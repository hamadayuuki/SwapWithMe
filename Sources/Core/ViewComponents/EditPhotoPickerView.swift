//
//  PhotoPickerView.swift
//
//
//  Created by 濵田　悠樹 on 2024/04/17.
//

import SwiftUI

/// 写真選択後に正方形切り抜き可能
public struct EditPhotoPickerView: UIViewControllerRepresentable {
    @Environment(\.dismiss) private var dismiss: DismissAction

    @Binding private var image: UIImage?

    public init(image: Binding<UIImage?>) {
        self._image = image
    }

    public func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    public func makeUIViewController(context: Context) -> UIImagePickerController {
        let uiImagePickerController = UIImagePickerController()
        uiImagePickerController.delegate = context.coordinator
        uiImagePickerController.sourceType = .photoLibrary
        uiImagePickerController.allowsEditing = true
        return uiImagePickerController
    }

    public func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
}

extension EditPhotoPickerView {
    public class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: EditPhotoPickerView

        public init(_ parent: EditPhotoPickerView) {
            self.parent = parent
        }

        public func imagePickerController(
            _ picker: UIImagePickerController,
            didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]
        ) {
            if let image = info[.editedImage] as? UIImage {
                parent.image = image
            } else if let image = info[.originalImage] as? UIImage {
                parent.image = image
            }
            parent.dismiss()
        }
    }
}
