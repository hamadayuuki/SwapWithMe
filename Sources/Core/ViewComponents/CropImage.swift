//
//  CropImage.swift
//
//
//  Created by 濵田　悠樹 on 2023/07/22.
//

import CropViewController
import SwiftUI

public struct CropImage: UIViewControllerRepresentable {
    var image: Binding<UIImage?>

    @Environment(\.presentationMode) var presentationMode

    public init(image: Binding<UIImage?>) {
        self.image = image
    }

    public func makeUIViewController(context: Context) -> some UIViewController {
        let img = self.image.wrappedValue ?? UIImage()
        let cropViewController = CropViewController(image: img)
        setupCropViewController(cropViewController: cropViewController)
        cropViewController.delegate = context.coordinator
        return cropViewController
    }

    public func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}

    public func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    public class Coordinator: NSObject, CropViewControllerDelegate {
        var parent: CropImage

        init(_ parent: CropImage) {
            self.parent = parent
        }

        public func cropViewController(_ cropViewController: CropViewController, didCropToImage image: UIImage, withRect cropRect: CGRect, angle: Int) {
            updateImageViewWithImage(image, fromCropViewController: cropViewController)
        }

        public func updateImageViewWithImage(_ image: UIImage, fromCropViewController cropViewController: CropViewController) {
            parent.image.wrappedValue = image
            cropViewController.dismiss(animated: true, completion: nil)
        }
    }

    private func setupCropViewController(cropViewController: CropViewController) {
        cropViewController.customAspectRatio = CGSize(width: 250, height: 400)  // トリミングするアスペクト比
        cropViewController.cropView.cropBoxResizeEnabled = false  // アスペクト比を固定する

        // ボタンの表示/非表示
        cropViewController.cancelButtonHidden = true
        cropViewController.aspectRatioPickerButtonHidden = true
        cropViewController.resetAspectRatioEnabled = false
        cropViewController.rotateButtonsHidden = true

    }
}
