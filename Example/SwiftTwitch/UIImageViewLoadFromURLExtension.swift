//
//  UIImageViewLoadFromURLExtension.swift
//  SwiftTwitch_Example
//
//  Created by Christopher Perkins on 1/6/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//
// Taken from https://stackoverflow.com/questions/24231680/loading-downloading-image-from-url-on-swift
// This is not meant to be production code, just example code. :)

import UIKit

extension UIImageView {
    public func setImage(from url: URL) {
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else {
                self.image = nil
                return
            }
            DispatchQueue.main.async() {
                self.image = UIImage(data: data)
            }
        }
    }
    
    private func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
}
