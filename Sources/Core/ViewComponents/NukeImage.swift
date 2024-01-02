//
//  NukeImage.swift
//
//
//  Created by 濵田　悠樹 on 2023/08/10.
//

import Nuke
import SwiftUI

public class NukeImage: ObservableObject {
    @Published public var image: UIImage
    let url: URL

    public init(url: URL, placeholder: UIImage = UIImage()) {
        self.image = placeholder
        self.url = url
        loadImage()
    }

    public func loadImage() {
        ImagePipeline.shared.loadImage(with: url) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                self.image = response.image
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
