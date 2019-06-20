//
//  ViewControllerL1Lesson2.swift
//  example-iphone-app
//
//  Created by Johannes Aram Unruh on 28.05.19.
//  Copyright © 2019 Johannes Aram Unruh. All rights reserved.
//

import UIKit

class ViewControllerL1Lesson2: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        print("Lecture 1 / Lesson 2")
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ViewControllerL1Lesson2: DeeplinkNode {
    
    static var route: String? {
        return "Lesson2"
    }
    
    static var childNodes: [DeeplinkNode.Type] {
        return []
    }
    
    static var storyboardId: String {
        return "L1Lesson2"
    }
    
    static var storyboardName: String {
        return "Main"
    }
}
