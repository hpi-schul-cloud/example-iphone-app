//
//  ViewControllerLecture1.swift
//  example-iphone-app
//
//  Created by Johannes Aram Unruh on 28.05.19.
//  Copyright © 2019 Johannes Aram Unruh. All rights reserved.
//

import UIKit

class ViewControllerLecture1: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Lecture 1")
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

extension ViewControllerLecture1: DeeplinkNode, StoryboardInstantiable {
    
    static var route: String? {
        return "Lecture1"
    }
    
    static var childNodes: [DeeplinkNode.Type] {
        return [ViewControllerL1Lesson1.self as DeeplinkNode.Type, ViewControllerL1Lesson2.self as DeeplinkNode.Type]
    }
    
    static var storyboardId: String {
        return "Lecture1"
    }
    
    static var storyboardName: String {
        return "Main"
    }
}
