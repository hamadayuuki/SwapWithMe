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
    public var set: @Sendable (_ myId: String, _ data: Relationship) throws -> Bool
    public var addFollower: @Sendable (_ myId: String, _ friendId: String) async throws -> Bool
    public var addFollowing: @Sendable (_ myId: String, _ friendId: String) async throws -> Bool
    public var removeFollower: @Sendable (_ myId: String, _ friendId: String) async throws -> Bool
    public var removeFollowing: @Sendable (_ myId: String, _ friendId: String) async throws -> Bool
    public var fetch: @Sendable (_ id: String) async throws -> Relationship
}

// MARK: - DependencyKey

extension RelationshipRequest: DependencyKey {
    public static let liveValue = Self(
        set: { myId, data in
            let db = Firestore.firestore()
            do {
                try db.collection("Relationship").document(myId).setData(from: data)
                return true
            } catch {
                return false
            }
        },
        addFollower: { myId, friendId in
            let db = Firestore.firestore()
            let relationshipRef = db.collection("Relationship").document(myId)

            do {
                try await relationshipRef.updateData([
                    "followersId": FieldValue.arrayUnion([friendId]),
                    "updateAt": Timestamp(),
                ])
                return true
            } catch {
                return false
            }
        },
        addFollowing: { myId, friendId in
            let db = Firestore.firestore()
            let relationshipRef = db.collection("Relationship").document(myId)

            do {
                try await relationshipRef.updateData([
                    "followingsId": FieldValue.arrayUnion([friendId]),
                    "updateAt": Timestamp(),
                ])
                return true
            } catch {
                return false
            }
        },
        removeFollower: { myId, friendId in
            let db = Firestore.firestore()
            let relationshipRef = db.collection("Relationship").document(myId)

            do {
                try await relationshipRef.updateData([
                    "followersId": FieldValue.arrayRemove([friendId]),
                    "updateAt": Timestamp(),
                ])
                return true
            } catch {
                return false
            }
        },
        removeFollowing: { myId, friendId in
            let db = Firestore.firestore()
            let relationshipRef = db.collection("Relationship").document(myId)

            do {
                try await relationshipRef.updateData([
                    "followingsId": FieldValue.arrayRemove([friendId]),
                    "updateAt": Timestamp(),
                ])
                return true
            } catch {
                return false
            }
        },
        fetch: { id in
            let db = Firestore.firestore()
            let user = try await db.collection("Relationship").document(id).getDocument(as: Relationship.self)
            return user
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
