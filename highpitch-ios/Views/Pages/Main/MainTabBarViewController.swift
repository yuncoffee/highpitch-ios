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
        // Do any additional setup after loading the view.
        setup()
    }

    private func setup() {
        let vcs = [ProjectsViewController(), RecordingViewController(), SettingsViewController()]
        let tabBarItems = [
            UITabBarItem(title: "Project", image: UIImage(systemName: "note.text"), tag: 0),
            UITabBarItem(title: "Recording", image: UIImage(systemName: "mic.fill"), tag: 1),
            UITabBarItem(title: "Settings", image: UIImage(systemName: "gearshape.fill"), tag: 2)
        ]
        
        let searchButton = UIBarButtonItem(barButtonSystemItem: .search, 
                                           target: self,
                                           action: #selector(addTapped))
        let notiButton = UIBarButtonItem(image: UIImage(systemName: "bell.fill"), 
                                         style: .plain,
                                         target: self,
                                         action: #selector(playTapped))
        
        searchButton.tintColor = .point
        notiButton.tintColor = .point
        
        let symbol = UIImage(named: "headerSymbol")?
            .resizeImage(size: .init(width: 147, height: 26))
            
        let mainSymbol = UIBarButtonItem(image: symbol, 
                                         style: .plain,
                                         target: self,
                                         action: #selector(addTapped))
        mainSymbol.tintColor = .point
        
        vcs.enumerated().forEach { index, viewController in
            viewController.tabBarItem = tabBarItems[index]
            viewController.navigationItem.title = tabBarItems[index].title
            viewController.navigationItem.leftBarButtonItem = mainSymbol
            viewController.navigationItem.rightBarButtonItems = [notiButton, searchButton]
            viewController.navigationItem.title = nil
        }
        
        setViewControllers( vcs.map { UINavigationController(rootViewController: $0) }, animated:  true)
        tabBar.backgroundColor = .white
    }
    
    @objc func addTapped() {
        print("Tap!")
    }
    
    @objc func playTapped() {
        print("Play!")
    }
}

struct MainTabBarViewController_Previews: PreviewProvider {
    static var previews: some View {
        ViewControllerPreview {
            MainTabBarViewController()
        }
    }
}
