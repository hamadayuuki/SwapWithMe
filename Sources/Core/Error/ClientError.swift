//
//  ClientError.swift
//
//
//  Created by 濵田　悠樹 on 2023/11/15.
//

import Foundation

/// クライアントがモデル化されたレスポンスを受け取るまでの間に発生しうるエラーを定義
public enum ClientError: Error {
    /// 通信エラー
    case networkError(Error)

    /// エラーの説明
    var errorDescription: String {
        switch self {
        case let .networkError(error):
            return "networkError : \(error.localizedDescription)"
        }
    }
}
