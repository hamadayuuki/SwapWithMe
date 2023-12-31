//
//  HTTPClientError.swift
//
//
//  Created by 濵田　悠樹 on 2023/11/15.
//

import Foundation

/// クライアントがモデル化されたレスポンスを受け取るまでの間に発生しうるエラーを定義
public enum HTTPClientError: Error {
    /// レスポンスを受け取れなかった
    case responseError

    /// レスポンスを正しくデコードできなかった
    case decodeError

    // 4xx クライアントエラー
    case badRequest  // 400 Bad Request
    case unauthorized  // 401 Unauthorized
    case forbidden  // 403 Forbidden
    case notFound  // 404 Not Found
    case methodNotAllowed  // 405 Method Not Allowed
    case requestTimeout  // 408 Request Timeout
    case conflict  // 409 Conflict
    case tooManyRequests  // 429 Too Many Requests
    case clientError(Int)  // その他の4xxエラー

    // 5xx サーバーエラー
    case internalServerError  // 500 Internal Server Error
    case notImplemented  // 501 Not Implemented
    case badGateway  // 502 Bad Gateway
    case serviceUnavailable  // 503 Service Unavailable
    case gatewayTimeout  // 504 Gateway Timeout
    case serverError(Int)  // その他の5xxエラー

    case unknownError  // 未知のエラー

    /// エラーの説明
    var errorDescription: String {
        switch self {
        case .responseError:
            return "dont't get response"
        case .decodeError:
            return "error decode"
        // 4xx クライアントエラー
        case .badRequest:
            return "無効なリクエスト (400)"
        case .unauthorized:
            return "認証エラー (401)"
        case .forbidden:
            return "アクセス拒否 (403)"
        case .notFound:
            return "リソースが見つかりません (404)"
        case .methodNotAllowed:
            return "許可されていないメソッド (405)"
        case .requestTimeout:
            return "リクエストタイムアウト (408)"
        case .conflict:
            return "リクエストの競合 (409)"
        case .tooManyRequests:
            return "リクエスト回数制限超過 (429)"
        case .clientError(let code):
            return "クライアントエラー (\(code))"
        // 5xx サーバーエラー
        case .internalServerError:
            return "サーバー内部エラー (500)"
        case .notImplemented:
            return "実装されていない機能 (501)"
        case .badGateway:
            return "不正なゲートウェイ (502)"
        case .serviceUnavailable:
            return "サービス利用不可 (503)"
        case .gatewayTimeout:
            return "ゲートウェイタイムアウト (504)"
        case .serverError(let code):
            return "サーバーエラー (\(code))"
        case .unknownError:
            return "未知のエラー"
        }
    }
}
