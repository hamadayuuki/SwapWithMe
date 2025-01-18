//
//  UserRequest.swift
//
//
//  Created by 濵田　悠樹 on 2023/08/08.
//

import Dependencies
import FirebaseFirestore
import FirebaseFirestoreSwift
import User

// MARK: - Dependencies

public struct UserRequestClient {
    public var set: @Sendable (_ data: User) throws -> Bool
    public var update: @Sendable (_ data: User) async throws -> Bool
    public var fetch: @Sendable (_ id: String) async throws -> User
    public var fetchWithName: @Sendable (_ name: String) async throws -> [User]
}

// MARK: - DependencyKey

extension UserRequestClient: DependencyKey {
    public static let liveValue = Self(
        set: { data in
            guard let id = data.id else { fatalError("Error UserRequest.set") }
            let db = Firestore.firestore()
            do {
                try db.collection("Users").document(id).setData(from: data)
                return true
            } catch {
                return false
            }
        },
        update: { data in
            guard let id = data.id else { fatalError("Error UserRequest.set") }
            let db = Firestore.firestore()
            do {
                try db.collection("Users").document(id).setData(from: data, merge: true)
                return true
            } catch {
                return false
            }
        },
        fetch: { id in
            let db = Firestore.firestore()
            let user = try await db.collection("Users").document(id).getDocument(as: User.self)
            return user
        },
        fetchWithName: { name in
            var users: [User] = []
            let db = Firestore.firestore()
            let userCollection = db.collection("Users")
            /// ユーザー名の部分一致検索
            /// 注意点 :
            ///    - 部分検索を可能としているためクエリ量が多くなる
            ///    - 検索文字 = クエリ量
            let querySnapshot = try await userCollection.order(by: "name").start(at: [name]).end(at: [name + "\u{f8ff}"]).getDocuments()
            for document in querySnapshot.documents {
                let user = try document.data(as: User.self)
                users.append(user)
            }
            return users
        }
    )
}

extension UserRequestClient: TestDependencyKey {
    public static let previewValue = Self(
        set: { data in
            return true
        },
        update: { data in
            return true
            //TODO: 処理追加
        },
        fetch: { id in
            let user = User.stub()
            return user
        },
        fetchWithName: { name in
            var users: [User] = []
            let user = User.stub()
            users.append(user)
            return users  // [User()]
        }
    )

    public static let testValue = Self(
        set: { data in
            return true
        },
        update: { data in
            return true
            //TODO: 処理追加
        },
        fetch: { id in
            let user = User.stub()
            return user
        },
        fetchWithName: { name in
            var users: [User] = []
            let user = User.stub()
            users.append(user)
            return users  // [User()]
        }
    )
}

// MARK: - DependencyValues

extension DependencyValues {
    public var userRequestClient: UserRequestClient {
        get { self[UserRequestClient.self] }
        set { self[UserRequestClient.self] = newValue }
    }
}
