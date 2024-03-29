//
//  Relationship.swift
//
//
//  Created by 濵田　悠樹 on 2024/02/11.
//

import FirebaseFirestore
import FirebaseFirestoreSwift
import Foundation

/// フォロー, フォロワー機能で使用
public struct Relationship: Codable, Equatable {
    @DocumentID public var id: String?
    public let followersId: [String]  // String ≒ User.id
    public let followingsId: [String]

    public var createdAt: Timestamp = Timestamp()
    public let updateAt: Timestamp

    public init(id: String? = nil, followersId: [String], followingsId: [String], createdAt: Timestamp, updateAt: Timestamp) {
        self.id = id
        self.followersId = followersId
        self.followingsId = followingsId
        self.createdAt = createdAt
        self.updateAt = updateAt
    }
}

// MARK: - extension

extension Relationship {
    public static func stub() -> Self {
        return Self(
            followersId: [""],
            followingsId: [""],
            createdAt: Timestamp(),
            updateAt: Timestamp()
        )
    }
}
