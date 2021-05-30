//
//  ImageSaver.swift
//  Reddit Client
//
//  Created by Женя on 29.05.2021.
//

import SwiftUI

class ImageSaver: NSObject {
    func savePhoto(from url: String?) {
        if let url = url, let safeURL = URL(string: url),
           let data = try? Data(contentsOf: safeURL),
           let image = UIImage(data: data) {
            writeToPhotoAlbum(image: image)
        }
    }
    
    private func writeToPhotoAlbum(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveError), nil)
    }

    @objc func saveError(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        print("Save finished!")
    }
}
