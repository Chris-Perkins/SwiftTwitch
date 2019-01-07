//
//  TwitchVideoTableViewCell.swift
//  SwiftTwitch_Example
//
//  Created by Christopher Perkins on 1/6/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import SwiftTwitch

class TwitchVideoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var videoThumbnailImageView: UIImageView!
    @IBOutlet weak var viewLabel: UILabel!
    
    var videoData: VideoData? {
        didSet {
            loadVideoData()
        }
    }
    
    public func loadVideoData() {
        guard let videoData = videoData else {
            videoThumbnailImageView.image = nil
            return
        }
        titleLabel.text = videoData.title
        userLabel.text = videoData.ownerName
        viewLabel.text = "\(videoData.viewCount) view(s)"
        if let videoThumbnailURL = getThumbnailImageURLToMatchView(videoThumbnailImageView,
                                                                   fromVideoData: videoData) {
            videoThumbnailImageView.setImage(from: videoThumbnailURL)
        }
    }
    
    private func getThumbnailImageURLToMatchView(_ view: UIView,
                                                 fromVideoData videoData: VideoData) -> URL? {
        return URL(string: videoData.thumbnailURLString
            .replacingOccurrences(of: "%{width}", with: "\(Int(view.frame.width))")
            .replacingOccurrences(of: "%{height}", with: "\(Int(view.frame.height))"))
    }
}
