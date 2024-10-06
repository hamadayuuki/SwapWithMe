//
//  QRScannerError+extension.swift
//
//
//  Created by 濵田　悠樹 on 2024/05/22.
//

import QRScanner

// QRScanView で .onChange(of: scannerResponse) {} するために
extension QRScannerError: Equatable {
    public static func == (lhs: QRScannerError, rhs: QRScannerError) -> Bool {
        switch (lhs, rhs) {
        case (.unauthorized(let lhsStatus), .unauthorized(let rhsStatus)):
            return lhsStatus == rhsStatus
        case (.deviceFailure(let lhsError), .deviceFailure(let rhsError)):
            return lhsError == rhsError
        case (.readFailure, .readFailure):
            return true
        case (.unknown, .unknown):
            return true
        default:
            return false
        }
    }
}
