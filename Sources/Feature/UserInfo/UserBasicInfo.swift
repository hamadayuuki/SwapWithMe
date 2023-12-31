//
//  UserBasicInfo.swift
//
//
//  Created by 濵田　悠樹 on 2023/07/21.
//

import Foundation
import SwiftUI

enum UserBasicInfo {
    case age, sex, affiliation, dogOrCat, activity, personality

    var id: UUID {
        UUID()
    }

    var question: Question {
        switch self {
        case .age: return .age
        case .sex: return .sex
        case .affiliation: return .affiliation
        case .dogOrCat: return .dogOrCat
        case .activity: return .activity
        case .personality: return .personality
        }
    }

    var answer: Answer {
        switch self {
        case .age: return .age
        case .sex: return .sex
        case .affiliation: return .affiliation
        case .dogOrCat: return .dogOrCat
        case .activity: return .activity
        case .personality: return .personality
        }
    }
}

// MARK: - Question

struct Question {
    let title: String

    init(title: String) {
        self.title = title
    }
}

extension Question {
    static let age = Self(
        title: "年齢"
    )

    static let sex = Self(
        title: "性別"
    )

    static let affiliation = Self(
        title: "所属"
    )

    static let dogOrCat = Self(
        title: "好きなのは"
    )
    static let activity = Self(
        title: "休日の過ごし方"
    )

    static let personality = Self(
        title: "知らない人と"
    )
}

// MARK: - Answert

struct Answer {
    let items: [String]

    init(items: [String]) {
        self.items = items
    }
}

extension Answer {
    static let age = Self(
        items: ["-"] + Array(0..<100).map { String($0) }
    )

    static let sex = Self(
        items: ["-", "女性", "男性", "未回答"]
    )

    static let affiliation = Self(
        items: ["-", "中学生", "高校生", "大学生", "社会人", "その他"]
    )

    static let dogOrCat = Self(
        items: ["-", "🐶", "😺"]
    )
    static let activity = Self(
        items: ["-", "インドア", "アウトドア"]
    )

    static let personality = Self(
        items: ["-", "人見知り", "フレンドリー"]
    )
}
