//
//  YoutubeViewController.swift
//  sportsApp
//
//  Created by Nermeen on 4/21/21.
//  Copyright © 2021 Nermeen. All rights reserved.
//

import UIKit
import WebKit
class YoutubeViewController: UIViewController {
    var url = ""
 
    override func viewDidLoad() {
        super.viewDidLoad()
        let webKitView = WKWebView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
        self.view.addSubview(webKitView)
        print(url)
        
        webKitView.load(URLRequest(url: URL(string: "https://\(url)")!))
        // Do any additional setup after loading the view.
    }
    

}
