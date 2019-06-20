//
//  File.swift
//  lti-compliance-ios
//
//  Created by Johannes Aram Unruh on 05.06.19.
//  Copyright © 2019 Johannes Aram Unruh. All rights reserved.
//

import Foundation
import UIKit

class VCNode {
    var value: String?
    var viewControllerIdentifier: String
    var children: [VCNode] = []
    weak var parent: VCNode?
    var storyboard: UIStoryboard
    var context: UIViewController
    var isNamed: Bool {
        get {
            return value != nil
        }
    }
    var hasParent: Bool {
        get {
            return parent != nil
        }
    }
    
    init(value: String?, viewControllerIdentifier: String, context: UIViewController) {
        self.value = value
        self.storyboard = UIStoryboard(name: "Main", bundle: nil)
        self.viewControllerIdentifier = viewControllerIdentifier
        
        self.context = context
    }
    
    func getChildFor(name: String) -> VCNode? {
        return self.children.first(where: {$0.value == name})
    }
    
    func add(child: VCNode) {
        children.append(child)
        child.parent = self
    }
    
    func pushViewController(path: [String]) {
        if self.hasParent {
            var path = path
            let thisNode = path.removeFirst()
            let viewController = self.storyboard.instantiateViewController(withIdentifier: self.viewControllerIdentifier)
            self.context.navigationController?.pushViewController(viewController, animated: true)
            print(self.viewControllerIdentifier)
            if(path.count > 0) {
                let childOnPath = self.getChildFor(name: path[0])
                childOnPath?.pushViewController(path: path)
            }
        } else {
            let childOnPath = self.getChildFor(name: path[0])
            childOnPath?.pushViewController(path: path)
        }
    }

//    fileprivate func pushViewController(path: [VCNode]) {
//        var path = path
//        for node in path {
//            let vc = self.storyboard.instantiateViewController(withIdentifier: node.viewControllerIdentifier)
//            self.context.navigationController?.pushViewController(vc, animated: true)
//        }
//    }
//
//    fileprivate func collectPathToViewController(path: [VCNode]) {
//        var path = path
//        if self.hasParent {
//            path.insert(self, at: 0)
//            self.parent!.collectPathToViewController(path: path)
//        } else {
//            self.pushViewController(path: path)
//        }
//    }
//
//    func showViewController() {
//        if self.hasParent {
//            self.parent!.collectPathToViewController(path: [self])
//        }
//    }
    
    func addChildFromString(value: String, with identifier: String) -> VCNode {
        let childNode = VCNode.init(value: value, viewControllerIdentifier: identifier, context: self.context)
        self.children.append(childNode)
        childNode.parent = self
        
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

protocol DeeplinkNode: StoryboardInstantiable {
    static var route: String? { get }
    static var childNodes: [DeeplinkNode.Type] { get }
//    var parentNode: DeeplinkNode? { get set }
    
    static func getChildFor(pathName: String) -> DeeplinkNode.Type?
    
    static func pushViewController(onto navigationController: UINavigationController, using path: [String])
}

extension DeeplinkNode {
    // Default Implementation
    static var childNode: [DeeplinkNode.Type] {
        return []
    }
    
    static func getChildFor(pathName: String) -> DeeplinkNode.Type? {
        return self.childNodes.first(where: {$0.route == pathName})
    }
    
    static func pushViewController(onto navigationController: UINavigationController, using path: [String]) {
        var path = path
        let vc = self.instantiateFromStoryboard()
        navigationController.pushViewController(vc, animated: false)
        if(path.count > 0) {
            let child = getChildFor(pathName: path.removeFirst())
            child?.pushViewController(onto: navigationController, using: path)
        }
    }
}


protocol StoryboardInstantiable where Self: UIViewController {
    static var storyboardId: String { get }
    static var storyboardName: String { get }
    
    static func instantiateFromStoryboard() -> Self
}

extension StoryboardInstantiable {
    static func instantiateFromStoryboard() -> Self {
        let storyboard = UIStoryboard(name: self.storyboardName, bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: self.storyboardId)
        return viewController as! Self
    }
}
