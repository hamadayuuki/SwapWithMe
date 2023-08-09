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

}
