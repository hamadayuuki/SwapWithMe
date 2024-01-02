//
//  Array+extension.swift
//
//
//  Created by 濵田　悠樹 on 2023/11/07.
//

import Foundation

extension Array {
    /// out of index を検知し nil を返す
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
