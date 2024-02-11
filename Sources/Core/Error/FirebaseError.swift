//
//  FirebaseError.swift
//
//
//  Created by 濵田　悠樹 on 2023/10/29.
//

import FirebaseFirestore
import FirebaseFirestoreSwift
import Foundation

public enum FirebaseError: Error, LocalizedError {
    case error(FirestoreErrorCode.Code)

    public var errorDescription: String? {
        switch self {
        case .error(.cancelled): return "操作がキャンセルされました"
        case .error(.unknown): return "不明なエラーが発生しました"
        case .error(.invalidArgument): return "無効な引数が指定されました"
        case .error(.deadlineExceeded): return "操作がタイムアウトしました"
        case .error(.notFound): return "ドキュメントが見つかりません"
        case .error(.alreadyExists): return "作成しようとしたドキュメントは既に存在しています"
        case .error(.permissionDenied): return "アクセス許可が拒否されました"
        case .error(.resourceExhausted): return "リソースが枯渇しています"
        case .error(.failedPrecondition): return "操作が拒否されました"
        case .error(.aborted): return "操作が中止されました"
        case .error(.outOfRange): return "許可されていない操作です"
        case .error(.unimplemented): return "未実装またはサポートされていません"
        case .error(.internal): return "内部エラーが発生しました"
        case .error(.unavailable): return "サービスが利用できません"
        case .error(.dataLoss): return "データの損失または破損しています"
        case .error(.unauthenticated): return "認証情報が無効です"
        case .error: return "不明なエラーが発生しました"
        }
    }
}
