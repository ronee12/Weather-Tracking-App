//
//  ImageDownloader.swift
//  Weather Tracking App
//
//  Created by Mehedi Hasan on 3/3/24.
//

import UIKit

class ImageDownloader {
    static let shared = ImageDownloader()
    
    private let cache: NSCache<NSString, UIImage> = NSCache<NSString, UIImage>()
    private let session = URLSession.shared
    
    private func cachedImage(for urlString: String) -> UIImage? {
        return cache.object(forKey: NSString(string: urlString))
    }
    
    func downloadImage(from urlString: String, completion: @escaping (UIImage?, Error?) -> Void) {
        if let cachedImage = cachedImage(for: urlString) {
            completion(cachedImage, nil)
            return
        }
        
        guard let url = URL(string: urlString) else {
            completion(nil, URLError(.unsupportedURL))
            return
        }
        
        let task = session.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let data = data, let image = UIImage(data: data) else {
                completion(nil, URLError(.cannotDecodeRawData))
                return
            }
            
            self.cache.setObject(image, forKey: NSString(string: urlString))
            completion(image, nil)
        }
        task.resume()
    }
}
