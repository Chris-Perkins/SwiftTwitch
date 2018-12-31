//
//  ViewController.swift
//  NewTwitchAPIWrapper
//
//  Created by chrisfromtemporaryid@gmail.com on 12/13/2018.
//  Copyright (c) 2018 chrisfromtemporaryid@gmail.com. All rights reserved.
//

import UIKit
import NewTwitchAPIWrapper

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        Twitch.Users.getUsers(userIds: ["49370093", "101400190", "60056333"], userLoginNames: nil) { (result) in
            switch result {
            case .failure(let data, let response, let error):
                let x = data!
                guard let jsonObject = try? JSONSerialization.jsonObject(with: x, options: .allowFragments) else {
                    return
                }
                let t = jsonObject as? [String: Any]
                print(t)
                print(response)
                print(error)
            case .success(let thing):
                print(thing)
            }
        }
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

