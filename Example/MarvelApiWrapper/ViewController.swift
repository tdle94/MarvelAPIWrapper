//
//  ViewController.swift
//  MarvelApiWrapper
//
//  Created by tdle94 on 11/26/2019.
//  Copyright (c) 2019 tdle94. All rights reserved.
//

import UIKit
import MarvelApiWrapper
import SwiftyJSON

class ViewController: UIViewController {
    
    let privateKey = "replace with your own private key"
    let publicKey = "replace with your own public key"

    override func viewDidLoad() {
        super.viewDidLoad()
        let marvel = MarvelApiWrapper(publicKey: privateKey, privateKey: publicKey)
        var config = StoryConfig()
        config.limit = 1

        marvel.getAllComicStories(config: config) { data, statusCode, error in
            guard let data = data else {
                return
            }
            
            let json = JSON(data)
            print(json)
        }
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

