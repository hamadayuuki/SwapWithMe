//
//  QRScannerViewControllerRepresentable.swift
//
//
//  Created by 濵田　悠樹 on 2024/05/22.
//

import QRScanner  // QRScanner.QRScannerError
import SwiftUI

struct QRScannerViewControllerRepresentable: UIViewControllerRepresentable {
    @Binding var scannerRes: Result<String, QRScanner.QRScannerError>?

    func makeUIViewController(context: Context) -> QRScannerViewController {
        let qrScannerViewController = QRScannerViewController()
        qrScannerViewController.sacannerResponse = { res in
            DispatchQueue.main.async {
                scannerRes = res
            }
        }
        return qrScannerViewController
    }

    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}

    class Coordinator {}

    func makeCoordinator() -> Coordinator {
        Coordinator()
    }

}
