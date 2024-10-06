//
//  QRScannerViewController.swift
//
//
//  Created by 濵田　悠樹 on 2024/05/22.
//

import AVFoundation
import QRScanner
import UIKit

final class QRScannerViewController: UIViewController {
    var sacannerResponse: ((Result<String, QRScanner.QRScannerError>?) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupQRScanner()
    }

    private func setupQRScanner() {
        let status = AVCaptureDevice.authorizationStatus(for: .video)
        switch status {
        case .authorized:
            setupQRScannerView()
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { [weak self] granted in
                if granted {
                    DispatchQueue.main.async { [weak self] in
                        self?.setupQRScannerView()
                    }
                }
            }
        default:
            showAlert()
        }
    }

    private func setupQRScannerView() {
        let qrScannerView = QRScannerView(frame: view.bounds)
        view.addSubview(qrScannerView)
        qrScannerView.configure(delegate: self, input: .init(isBlurEffectEnabled: true))
        qrScannerView.startRunning()
    }

    private func showAlert() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            let alert = UIAlertController(title: "Error", message: "Camera is required to use in this application", preferredStyle: .alert)
            alert.addAction(.init(title: "OK", style: .default))
            self?.present(alert, animated: true)
        }
    }
}

// MARK: - QRScannerViewDelegate

extension QRScannerViewController: QRScannerViewDelegate {
    // error
    func qrScannerView(_ qrScannerView: QRScanner.QRScannerView, didFailure error: QRScanner.QRScannerError) {
        sacannerResponse?(.failure(error))
    }

    // success
    func qrScannerView(_ qrScannerView: QRScannerView, didSuccess code: String) {
        sacannerResponse?(.success(code))
    }
}
