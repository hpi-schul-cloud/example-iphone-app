//
//  ViewController.swift
//  example-iphone-app
//
//  Created by Johannes Aram Unruh on 29.04.19.
//  Copyright © 2019 Johannes Aram Unruh. All rights reserved.
//

import UIKit

final class ViewControllerRoot: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        var VCRoot = VCNode(value: nil, viewControllerIdentifier: "root", context: self)
//        var firstChild = VCRoot.addChildFromString(value: "Lecture1", with: "Lecture1")
//        var leaf = firstChild.addChildFromString(value: "Lesson2", with: "L1Lesson2")
//
//        VCRoot.pushViewController(path: ["Lecture1", "Lesson2"])
        if self.isModal {
            let button1 = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(close(_:)))
            self.navigationItem.leftBarButtonItem  = button1
        }
    }
    
    @IBAction func close(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func goToPath1(_ sender: UIButton) {
        
    }
    
    @IBAction func goToPath2(_ sender: UIButton) {
        
    }
}

extension ViewControllerRoot: DeeplinkNode, StoryboardInstantiable {
    
    static var route: String? {
        return nil
    }
    
    static var childNodes: [DeeplinkNode.Type] {
        return [ViewControllerLecture1.self as DeeplinkNode.Type, ViewControllerLecture2.self as DeeplinkNode.Type]
    }
    
    static var storyboardId: String {
        return "root"
    }
    static var storyboardName: String {
        return "Main"
    }
}

