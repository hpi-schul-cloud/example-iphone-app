//
//  File.swift
//  lti-compliance-ios
//
//  Created by Johannes Aram Unruh on 05.06.19.
//  Copyright © 2019 Johannes Aram Unruh. All rights reserved.
//

import Foundation
import UIKit

//class DeeplinkManager {
//
////    var rootString: String
////    var rootViewController: UIViewController
//    let treeRootNode: VCNode
//
//    func testManager(context: UIViewController) {
////        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
////        let newViewController = storyBoard.instantiateViewController(withIdentifier: "L1Lesson2")
//
//        context.navigationController?.pushViewController(self.treeRootNode.getChildren()[0].getViewController(), animated: true)
////        context.present(newViewController, animated: false, completion: nil)
//    }
//
//    init(rootString: String?, with identifier: String) {
////        self.rootString = rootString
////        self.rootViewController = rootViewController
//        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        let rootViewController = storyBoard.instantiateViewController(withIdentifier: identifier)
//
//        self.treeRootNode = VCNode.init(value: nil, viewController: rootViewController)
//    }
//
//    func addChild() {
//        self.treeRootNode.addChildFromString(value: "Lecture1", with: "Lecture1")
//    }
//}

class VCNode {
    private var value: String?
    private var viewController: UIViewController
    private var children: [VCNode] = []
    private weak var parent: VCNode?
    private var storyboard: UIStoryboard
    private var context: UIViewController
    
    init(value: String?, viewControllerIdentifier: String, context: UIViewController) {
        self.value = value
        self.storyboard = UIStoryboard(name: "Main", bundle: nil)
        self.viewController = self.storyboard.instantiateViewController(withIdentifier: viewControllerIdentifier)
        
        self.context = context
    }
    
    func getChildren() -> [VCNode] {
        return self.children
    }
    
    func getChildFor(name: String) -> VCNode? {
        return self.children.first(where: {$0.getValue() == name})
    }
    
    func getParent() -> VCNode? {
        return self.parent
    }
    
    func setParent(parent: VCNode) {
        self.parent = parent
    }
    
    func getValue() -> String? {
        return self.value
    }
    
    func getViewController() -> UIViewController {
        return self.viewController
    }
    
    func getContext() -> UIViewController {
        return self.context
    }
    
    func add(child: VCNode) {
        children.append(child)
        child.parent = self
    }
    
    func pushViewController(path: [String]) {
        var path = path
        let thisNode = path.removeFirst()
//        self.storyboard.instantiateViewController(withIdentifier: thisNode)
        // Hier liegt noch ein Fehler. Wir haben nicht für alle einen NavigationController
        self.context.navigationController?.pushViewController(self.viewController, animated: true)
        print(self.context.navigationController)
        if(path.count > 0) {
            let childOnPath = self.getChildFor(name: path[0])
            childOnPath?.pushViewController(path: path)
        }
    }
    
    func addChildFromString(value: String, with identifier: String) -> VCNode {
        let childNode = VCNode.init(value: value, viewControllerIdentifier: identifier, context: self.context)
        self.children.append(childNode)
        childNode.setParent(parent: self)
        
        return childNode
    }
    
    func getRouteAsArray() -> [String] {
        var history: [String] = []
        if let existingValue = self.value {
            if let existingParent = self.parent {
                history = existingParent.getRouteAsArray()
                history.append(existingValue)
            } else {
                history = [existingValue]
            }
        }
        return history
    }
    
    func getRouteAsString() -> String {
        let history = getRouteAsArray()
        return "/\(history.joined(separator: "/"))"
    }
}
