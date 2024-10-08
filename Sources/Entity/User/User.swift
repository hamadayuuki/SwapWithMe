//
//  User.swift
//
//
//  Created by 濵田　悠樹 on 2023/08/07.
//

import FirebaseFirestore
import FirebaseFirestoreSwift

public struct User: Codable, Identifiable, Equatable, Hashable {
    // @DocumentID に準拠した場合 型をString?にする必要がある
    // Firestoreからデータ取得するとき 自動的にidへ値が代入される
    // SwiftUI.List で id を使用することを考慮した実装。Firestore にidが格納されるわけではない。あくまで Firestore→App とデータが送られる際にAppの補助のため付与される情報
    @DocumentID public var id: String?
    public var iconURL: URL?
    public var name: String
    public var age: Int
    public var sex: Sex
    public var affiliation: Affiliation
    public var animal: Animal
    public var activity: Activity
    public var personality: Personality
    public var description: String
    public var createdAt: Timestamp

    public init(id: String? = nil, iconURL: URL?, name: String, age: Int, sex: Sex, affiliation: Affiliation, animal: Animal, activity: Activity, personality: Personality, description: String, createdAt: Timestamp = .init()) {
        self.id = id
        self.iconURL = iconURL
        self.name = name
        self.age = age
        self.sex = sex
        self.affiliation = affiliation
        self.animal = animal
        self.activity = activity
        self.personality = personality
        self.description = description
        self.createdAt = createdAt
    }
}

public enum Sex: String, Codable {
    case man
    case woman
    case noGender
}

public enum Affiliation: String, Codable {
    case juniorHigh
    case high
    case university
    case society
    case others
}

public enum Activity: String, Codable {
    case indoor
    case outdoor
}

public enum Animal: String, Codable {
    case dog
    case cat
}

public enum Personality: String, Codable {
    case shy
    case friendly
}

// MARK: - extension

extension User {
    public static func stub() -> Self {
        return Self(
            id: "",
            iconURL: nil,
            name: "",
            age: 0,
            sex: .man,
            affiliation: .juniorHigh,
            animal: .dog,
            activity: .indoor,
            personality: .shy,
            description: "",
            createdAt: .init(date: .init(timeIntervalSince1970: 0))
        )
    }
}
