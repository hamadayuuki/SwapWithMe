//
//  ImageRequest.swift
//
//
//  Created by 濵田　悠樹 on 2023/08/08.
//

import FirebaseStorage
import SwiftUI

public protocol ImageRequestProtocol {
    static func set(uiImage: UIImage, id: String) async throws -> URL
}

public class ImageRequest: ImageRequestProtocol {
    public static func set(uiImage: UIImage, id: String) async throws -> URL {
        guard let imageData = uiImage.pngData() else { fatalError("Error ImageRequest.set()") }
        let storageRef = Storage.storage().reference()

        let imageRef = storageRef.child("Users/icon/\(id).png")
        let _ = try await imageRef.putDataAsync(imageData)
        let url = try await imageRef.downloadURL()
        return url
    }
}
