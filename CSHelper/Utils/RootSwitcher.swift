//
//  RootSwitcher.swift
//  dandi
//
//  Created by 김윤서 on 2022/12/29.
//

import UIKit

final class RootSwitcher {
    enum Destination {
        case login
        case main
        case custom(UIViewController)
    }

    static func update(_ destination: Destination) {
        
        let tabBarController = UITabBarController()
        let tabBar = tabBarController.tabBar
        tabBar.backgroundColor = .ohsogo_Gray
        tabBar.tintColor = .ohsogo_Blue
        
        let firstViewController = SearchViewController()
        let firstNavigationController = UINavigationController(rootViewController: firstViewController)

        let secondViewController = PreviousViewController()
        let secondNavigationController = UINavigationController(rootViewController: secondViewController)


        let firstTabBarItem = UITabBarItem(title: "새로운 문의", image: UIImage(systemName: "magnifyingglass"), selectedImage: nil)
        firstNavigationController.tabBarItem = firstTabBarItem

        let secondTabBarItem = UITabBarItem(title: "문의 내역", image: UIImage(systemName: "clock"), selectedImage: nil)
        
//        if let items = tabBar.items {
//            for item in items {
//                item.imageInsets = UIEdgeInsets(top: 10, left: 0, bottom: -6, right: 0)
//            }
//        }
        
        
        secondNavigationController.tabBarItem = secondTabBarItem
        tabBarController.viewControllers = [firstNavigationController, secondNavigationController]

        
        guard let delegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate else {
            return
        }
        switch destination {
        case .login:
            delegate.window?.rootViewController = UINavigationController(rootViewController: LoginViewController())
        case .main:
            delegate.window?.rootViewController = tabBarController
        // 테스트에만 사용할것
        case let .custom(viewController):
            delegate.window?.rootViewController = viewController
        }
    }
}
