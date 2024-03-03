//
//  MainTabBarViewController.swift
//  highpitch-ios
//
//  Created by yuncoffee on 2/21/24.
//

import UIKit
import SwiftUI

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    private func setup() {
        setupNavigation()
        setupTabBar()
    }
    
    private func setupTabBar() {
        let vcs = [MyProjectViewController(), MyPracticeAnalysisViewController(), MyPageViewController()]
        let tabBarItems = [
            UITabBarItem(title: "내 프로젝트", image: UIImage(systemName: "house.fill"), tag: 0),
            UITabBarItem(title: "내 연습 분석", image: UIImage(systemName: "newspaper.fill"), tag: 1),
            UITabBarItem(title: "마이페이지", image: UIImage(systemName: "person.fill"), tag: 2)
        ]

        vcs.enumerated().forEach { index, viewController in
            tabBarItems[index].image = tabBarItems[index].image?.withBaselineOffset(fromBottom: 16)
            
            viewController.tabBarItem = tabBarItems[index]
            viewController.tabBarItem.title = nil
            
            viewController.navigationItem.title = tabBarItems[index].title
        }
        setViewControllers( vcs.map { $0 }, animated:  true)
        
        tabBar.backgroundColor = .white
        tabBar.tintColor = .point
    }
    
    private func setupNavigation() {
        let (leftBarItem, rightBarItems) = makeNavigationBar()
        navigationItem.leftBarButtonItem = leftBarItem
        navigationItem.rightBarButtonItems = rightBarItems
    }

    private func navigation(to link: Links) {
        var vc: UIViewController?
        switch link {
        case .searchProject:
            vc = SearchProjectViewController()
        case .notification:
            vc = NotificationViewController()
        default:
            print("do Not Supported")
        }
        if let vc = vc {
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    private func makeNavigationBar() -> (leftBarItem: UIBarButtonItem, rightBarItems: [UIBarButtonItem]) {
        /// leftBarItem
        let symbol = UIImage(named: "headerSymbol")?.resizeImage(size: .init(width: 147, height: 26))
        let mainSymbolButtonAction = UIAction(image: symbol) { _ in print("MainSymbol Click") }
        let mainSymbol = UIBarButtonItem(primaryAction: mainSymbolButtonAction)
        
        let searchButtonAction = UIAction(title: "search") { [weak self] _ in
            self?.navigation(to: .searchProject)
        }
        let notiButtonAction = UIAction(image: UIImage(systemName: "bell.fill")) { [weak self] _ in
            self?.navigation(to: .notification)
        }
        /// rightBarItem
        let searchButton = UIBarButtonItem(systemItem: .search, primaryAction: searchButtonAction)
        let notiButton = UIBarButtonItem(primaryAction: notiButtonAction)
        
        mainSymbol.tintColor = .point
        searchButton.tintColor = .point
        notiButton.tintColor = .point
        
        return (mainSymbol, [searchButton, notiButton])
    }
}

struct MainTabBarViewController_Previews: PreviewProvider {
    static var previews: some View {
        let vc = UINavigationController(rootViewController: MainTabBarViewController())
        
        return ViewControllerPreview {
            vc
        }
    }
}
