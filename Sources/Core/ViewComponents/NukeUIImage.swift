//
//  NukeUIImage.swift
//
//
//  Created by 濵田　悠樹 on 2023/08/10.
//

import Nuke
import SwiftUI

// TODO: - エラーハンドリング
@MainActor
public func nukeUIImage(url: URL) async -> UIImage {
    ImagePipeline.shared = ImagePipeline(configuration: .withDataCache)
    let pipeline = ImagePipeline.shared

    do {
        let image = try await pipeline.image(for: url)
        return image
    } catch {
        print(error)
        return UIImage(named: "swap-2")!
    }
}
