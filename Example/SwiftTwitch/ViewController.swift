//
//  ViewController.swift
//  SwiftTwitch
//
//  Created by chrisfromtemporaryid@gmail.com on 01/03/2019.
//  Copyright (c) 2019 chrisfromtemporaryid@gmail.com. All rights reserved.
//

import UIKit
import SwiftTwitch

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        TwitchTokenManager.shared.accessToken = "$MyToken"
        
        let user1Id = "5678"
        let user2Id = "1234"
        Twitch.Users.getUsersFollows(followerId: user1Id, followedId: user2Id) {
            switch $0 {
            case .success(let getUsersFollowsData):
                if getUsersFollowsData.total == 1 {
                    print("User \(user1Id) is following user \(user2Id)!")
                } else {
                    print("User \(user1Id) is not following user \(user2Id)")
                }
            case .failure(let data, let response, let error):
                print("The API call failed! Unable to determine relationship.")
                break
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

