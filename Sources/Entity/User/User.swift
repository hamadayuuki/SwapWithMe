//
//  User.swift
//
//
//  Created by 濵田　悠樹 on 2023/08/07.
//

import FirebaseFirestore
import FirebaseFirestoreSwift
import Swift

struct User: Codable {
    @DocumentID var id: String?
    var iconURL: URL
    var name: String
    var age: Int
    var sex: Sex
    var affiliation: Affiliation
    var animal: Animal
    var personality: Personality
    var description: String
    var createdAt: Timestamp {
        Timestamp()
    }

    init(id: String? = nil, iconURL: URL, name: String, age: Int, sex: Sex, affiliation: Affiliation, animal: Animal, personality: Personality, description: String) {
        self.id = id
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

enum Sex: String, Codable {
    case man
    case woman
}

enum Affiliation: String, Codable {
    case juniorHigh
    case high
    case university
    case society
    case others
}

enum Animal: String, Codable {
    case dog
    case cat
}

enum Personality: String, Codable {
    case shy
    case friendly
}
