//
//  RelationStatus.swift
//
//
//  Created by 濵田　悠樹 on 2024/02/11.
//

import Foundation

/// フォロー, フォロワー, やっほう数
public enum RelationStatus: Hashable, Equatable {
    case following(Int)
    case follower(Int)
    case yahhos(Int)

    public var title: String {
        switch self {
        case .following(_): return "Following"
        case .follower(_): return "Follower"
        case .yahhos(_): return "やっほう数"
        }
    }

    public var num: Int {
        switch self {
        case let .following(num): return num
        case let .follower(num): return num
        case let .yahhos(num): return num
        }
    }
}
