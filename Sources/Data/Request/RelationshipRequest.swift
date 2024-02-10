//
//  RelationshipRequest.swift
//
//
//  Created by 濵田　悠樹 on 2024/02/11.
//

import Dependencies
import DependenciesMacros
import FirebaseFirestore
import Relationship

// MARK: - Dependencies

@DependencyClient
public struct RelationshipRequest {
    public var set: @Sendable (_ data: Relationship) throws -> Bool
}

// MARK: - DependencyKey

extension RelationshipRequest: DependencyKey {
    public static let liveValue = Self(
        set: { data in
            guard let id = data.id else { fatalError("Error RelationshipRequest.set") }
            let db = Firestore.firestore()
            do {
                try db.collection("Relationship").document(id).setData(from: data)
                return true
            } catch {
                return false
            }
        }
    )

    public static let testValue = Self()
}

// MARK: - DependencyValues

extension DependencyValues {
    public var relationshipRequest: RelationshipRequest {
        get { self[RelationshipRequest.self] }
        set { self[RelationshipRequest.self] = newValue }
    }
}
