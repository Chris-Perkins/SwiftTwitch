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
        
        Twitch.Analytics.getExtensionAnalytics { (result) in
            switch result {
            case .failure(let data, let response, let error):
                if let data = data {
                    print(NSKeyedUnarchiver.unarchiveObject(with: data) as? Dictionary<String, Any>)
                }
                print(response)
                print(error)
            case .success(let url, let analyticsType, let start, let end, let t, let f):
                print(url)
            }
        }
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

