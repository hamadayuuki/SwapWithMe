//
//  SNS.swift
//
//
//  Created by 濵田　悠樹 on 2024/02/11.
//

import Foundation

/// ユーザーが所持しているSNS一覧
public enum SNS: Hashable, Equatable {
    case twitter
    case instagram
    case line
    case other(String)

    public var name: String {
        switch self {
        case .twitter: return "X"
        case .instagram: return "Instagram"
        case .line: return "LINE"
        case let .other(name): return name
        }
    }

    public var iconName: String {
        switch self {
        case .twitter: return "x"
        case .instagram: return "instagram"
        case .line: return "line"
        case .other(_): return ""
        }
    }
}
