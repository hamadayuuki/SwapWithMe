//
//  User.swift
//
//
//  Created by 濵田　悠樹 on 2023/08/07.
//

import FirebaseFirestore
import FirebaseFirestoreSwift
import Swift

public struct User: Codable, Identifiable, Equatable, Hashable {
    // @DocumentID に準拠した場合 型をString?にする必要がある
    // Firestoreからデータ取得するとき 自動的にidへ値が代入される
    @DocumentID public var id: String?
    public var iconURL: URL?
    public var name: String
    public var age: Int
    public var sex: Sex
    public var affiliation: Affiliation
    public var animal: Animal
    public var personality: Personality
    public var description: String
    public var createdAt: Timestamp = Timestamp()

    public init(iconURL: URL?, name: String, age: Int, sex: Sex, affiliation: Affiliation, animal: Animal, personality: Personality, description: String) {
        self.id = UUID().uuidString
        self.iconURL = iconURL
        self.name = name
        self.age = age
        self.sex = sex
        self.affiliation = affiliation
        self.animal = animal
        self.personality = personality
        self.description = description
    }
}

public enum Sex: String, Codable {
    case man
    case woman
}

public enum Affiliation: String, Codable {
    case juniorHigh
    case high
    case university
    case society
    case others
}

public enum Animal: String, Codable {
    case dog
    case cat
}

public enum Personality: String, Codable {
    case shy
    case friendly
}
