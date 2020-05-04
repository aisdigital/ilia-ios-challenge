//
//  UIImageViewExtensions.swift
//  Moovy
//
//  Created by Pedro Arenhardt Wagner  on 02/05/20.
//  Copyright © 2020 Pedro Arenhardt Wagner . All rights reserved.
//

import UIKit

var imageCache = NSCache<NSString, UIImage>()

extension UIImageView {
    func downloadImage(for path: String, withSize size: ImageSize, imageType: ImageType) {
        if let cachedImage = imageCache.object(forKey: path as NSString) {
            self.image = cachedImage
        } else {
            let url = APIEnvironment.shared.getImageQueryURL(for: path, size: size, imageType: imageType)
                BaseAPIService.shared.get(url: url ?? "") { (data, error) in
                guard let data = data,
                    let image = UIImage(data: data) else {
                    return
                }
                imageCache.setObject(image, forKey: path as NSString)
                DispatchQueue.main.async {
                    self.image = image
                }
            }
        }
    }
    
    func downloadImage(for url: String) {
        if let cachedImage = imageCache.object(forKey: url as NSString) {
            self.image = cachedImage
        } else {
            BaseAPIService.shared.get(url: url) { (data, error) in
                guard let data = data,
                    let image = UIImage(data: data) else {
                    return
                }
                imageCache.setObject(image, forKey: url as NSString)
                DispatchQueue.main.async {
                    self.image = image
                }
            }
        }
        
    }
}
