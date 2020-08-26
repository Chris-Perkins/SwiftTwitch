//
//  TwitchVideosTableViewController.swift
//  SwiftTwitch
//
//  Created by chrisfromtemporaryid@gmail.com on 01/03/2019.
//  Copyright (c) 2019 chrisfromtemporaryid@gmail.com. All rights reserved.
//

import UIKit
import SwiftTwitch

class TwitchVideosTableViewController: UITableViewController {
    
    /// `videos` specifies the data of the videos to be displayed in this TableViewController.
    var videos = [VideoData]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    /// onLoad: Open the videos for user with ID "60056333". The results of the Twitch API call for
    /// this user will be set to the data to be displayed in the table view.
    override func viewDidLoad() {
        super.viewDidLoad()

        TwitchTokenManager.shared.accessToken = "$YourTokenHere"
        TwitchTokenManager.shared.clientID = "$YourClientIDHere"

        Twitch.Videos.getVideos(videoIds: nil, userId: "60056333", gameId: nil) {
            switch $0 {
            case .success(let getVideosData):
               self.videos = getVideosData.videoData
            case .failure(let data, _, _):
                print("The API call failed! Unable to get videos. Did you set an access token?")
                if let data = data,
                    let jsonObject = try? JSONSerialization.jsonObject(with: data, options: .allowFragments),
                    let jsonDict = jsonObject as? [String: Any]{
                    print(jsonDict)
                }
                self.videos = [VideoData]()
            }
        }
    }
    
    /// Retrieves the number of cells to display; this is equal to the number of videos we have.
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos.count
    }
    
    /// Whenever the cell is selected, open the Twitch URL to that video
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let videoData = videos[indexPath.row]
        UIApplication.shared.openURL(videoData.url)
    }
    
    /// Retrieve a TwitchVideoTableViewCell with the reuse identifier "twitchyCell". Its video data
    /// should be set to the video at the index path specified.
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "twitchyCell"),
            let twitchCell = cell as? TwitchVideoTableViewCell else {
            fatalError("Unable to dequeue a TwitchVideoTableViewCell!")
        }
        twitchCell.videoData = videos[indexPath.row]
        return twitchCell
    }
}

