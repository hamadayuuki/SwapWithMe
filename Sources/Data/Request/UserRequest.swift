//
//  UserRequest.swift
//
//
//  Created by 濵田　悠樹 on 2023/08/08.
//

import FirebaseFirestore
import FirebaseFirestoreSwift
import User

public protocol UserRequestProtocol {
    static func set(data: User) throws
    static func update(data: User) async throws
    static func fetch(id: String) async throws -> User
    static func fetchWithName(name: String) async throws -> [User]
}

public class UserRequest: UserRequestProtocol {
    public static func set(data: User) throws {
        guard let id = data.id else { fatalError("Error UserRequest.set") }
        let db = Firestore.firestore()
        try db.collection("Users").document(id).setData(from: data)
    }

    public static func update(data: User) async throws {
        //TODO: 処理追加
    }

    public static func fetch(id: String) async throws -> User {
        let db = Firestore.firestore()
        let user = try await db.collection("Users").document(id).getDocument(as: User.self)
        return user
    }

    public static func fetchWithName(name: String) async throws -> [User] {
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

}
