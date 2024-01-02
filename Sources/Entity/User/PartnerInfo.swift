//
//  PartnerInfo.swift
//
//
//  Created by 濵田　悠樹 on 2023/11/07.
//

import Foundation

public struct PartnerInfo: Equatable {
    public let name: String
    public let age: Int
    public let personality: String

    public init(name: String, age: Int, personality: String) {
        self.name = name
        self.age = age
        self.personality = personality
    }
}
