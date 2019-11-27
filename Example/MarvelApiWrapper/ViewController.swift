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
    
    let privateKey = "05b154e4641c958256743a9fa74bd16a"
    let publicKey = "8bd96a0e83daff033aa0e1aaf3fd1644aece99fe"

    override func viewDidLoad() {
        super.viewDidLoad()
        let marvel = MarvelApiWrapper(publicKey: privateKey, privateKey: publicKey)
        var config = EventConfig()
        config.limit = 1
        
        marvel.getAllEvents(config: config) { data, statusCode, error in
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

