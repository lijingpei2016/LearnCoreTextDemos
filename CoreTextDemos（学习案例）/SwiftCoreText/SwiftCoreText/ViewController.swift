//
//  ViewController.swift
//  SwiftCoreText
//
//  Created by aron on 2018/5/28.
//  Copyright © 2018年 aron. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        let ctView = YTCTView(frame: CGRect(x: 0, y: 20, width: self.view.bounds.width / 2, height: self.view.bounds.height / 4))
        self.view.addSubview(ctView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

