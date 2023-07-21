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

        public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            let image = info[.originalImage] as! UIImage
            guard let pickerImage = (info[UIImagePickerController.InfoKey.originalImage] as? UIImage) else { return }

            let cropController = CropViewController(croppingStyle: .default, image: pickerImage)
            cropController.delegate = self
            cropController.customAspectRatio = CGSize(width: 100, height: 100)

            //今回は使わないボタン等を非表示にする。
            cropController.aspectRatioPickerButtonHidden = true
            cropController.resetAspectRatioEnabled = false
            cropController.rotateButtonsHidden = true

            //cropBoxのサイズを固定する。
            cropController.cropView.cropBoxResizeEnabled = false
            //pickerを閉じたら、cropControllerを表示する。
            picker.dismiss(animated: true) {
                self.parent.image.wrappedValue = image
            }
        }
    }
}
