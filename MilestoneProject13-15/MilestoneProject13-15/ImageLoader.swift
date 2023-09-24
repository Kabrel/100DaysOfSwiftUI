//
//  ImageLoader.swift
//  MilestoneProject13-15
//
//  Created by Константин Шутов on 24.09.2023.
//

import SwiftUI
import PhotosUI

class ImageLoader: ObservableObject {
    @Published var images = [ImageModel]()


    func loadImages() {
        let fetchOptions = PHFetchOptions()
        let fetchResult = PHAsset.fetchAssets(with: .image, options: fetchOptions)

        DispatchQueue.global(qos: .background).async {
            fetchResult.enumerateObjects { asset, _, _ in
                self.getLocalizedTitle(for: asset) { [weak self] title in
                    guard let title = title, let self = self else { return }

                    self.getImageFromAsset(asset, title: title) { image in
                        if let image = image {
                            let imageModel = ImageModel(name: title, image: Image(uiImage: image))
                            DispatchQueue.main.async {
                                self.images.append(imageModel)
                            }
                        }
                    }
                }
            }
        }
    }

    private func getLocalizedTitle(for asset: PHAsset, completion: @escaping (String?) -> Void) {
        PHAssetResource.assetResources(for: asset).first.flatMap { $0.originalFilename.isEmpty ? nil : $0.originalFilename }
        completion(PHAssetResource.assetResources(for: asset).first?.originalFilename)
    }

    private func getImageFromAsset(_ asset: PHAsset, title: String, completion: @escaping (UIImage?) -> Void) {
        let imageManager = PHCachingImageManager()
        let requestOptions = PHImageRequestOptions()
        requestOptions.isSynchronous = true
        requestOptions.deliveryMode = .highQualityFormat

        let targetSize = CGSize(width: 200, height: 200)

        imageManager.requestImage(for: asset, targetSize: targetSize, contentMode: .aspectFill, options: requestOptions) { image, _ in
            completion(image)
        }
    }
}
