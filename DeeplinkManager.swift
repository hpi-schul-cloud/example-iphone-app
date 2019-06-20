//
//  File.swift
//  lti-compliance-ios
//
//  Created by Johannes Aram Unruh on 05.06.19.
//  Copyright © 2019 Johannes Aram Unruh. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    var isModal: Bool {
        
        let presentingIsModal = presentingViewController != nil
        let presentingIsNavigation = navigationController?.presentingViewController?.presentedViewController == navigationController
        let presentingIsTabBar = tabBarController?.presentingViewController is UITabBarController
        
        return presentingIsModal || presentingIsNavigation || presentingIsTabBar
    }
}

protocol DeeplinkNode where Self: UIViewController {
    static var route: String? { get }
    static var childNodes: [DeeplinkNode.Type] { get }
//    var parentNode: DeeplinkNode? { get set }
    
    // Instantiate ViewController hier hin.
    // Zwei Cases implementieren. -> From Storyboard oder Normal
    static func instantiateViewController() -> Self
    
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
    
    static func instantiateViewController() -> Self {
        return self.init()
    }
    
    static func pushViewController(onto navigationController: UINavigationController, using path: [String]) {
        var path = path
        let vc = self.instantiateViewController()
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

extension DeeplinkNode where Self: StoryboardInstantiable {
    static func instantiateViewController() -> Self {
        return self.instantiateFromStoryboard()
    }
}
