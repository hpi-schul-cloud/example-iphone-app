//
//  ViewController.swift
//  example-iphone-app
//
//  Created by Johannes Aram Unruh on 29.04.19.
//  Copyright © 2019 Johannes Aram Unruh. All rights reserved.
//

import UIKit

class ViewControllerRoot: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var VCRoot = VCNode(value: nil, viewControllerIdentifier: "root", context: self)
        var firstChild = VCRoot.addChildFromString(value: "Lecture1", with: "Lecture1")
        var leaf = firstChild.addChildFromString(value: "Lesson2", with: "L1Lesson2")

        VCRoot.pushViewController(path: ["Lecture1", "Lesson2"])
        
    }

    @IBAction func goToPath1(_ sender: UIButton) {
        
    }
    
    @IBAction func goToPath2(_ sender: UIButton) {
        
    }

}

