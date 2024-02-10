//
//  SNS.swift
//
//
//  Created by 濵田　悠樹 on 2024/02/11.
//

import SwiftUI   // Image()

/// ユーザーが所持しているSNS一覧
public enum SNS: Hashable, Equatable {
    case twitter
    case instagram
    case line
    case other(String)

    public var name: String {
        switch self {
        case .twitter: return "Twitter"
        case .instagram: return "Instagram"
        case .line: return "LINE"
        case let .other(name): return name
        }
    }

    public var icon: Image {
        switch self {
        case .twitter: return Image("x")
        case .instagram: return Image("instagram")
        case .line: return Image("line")
        case .other(_): return Image("")
        }
    }
}

