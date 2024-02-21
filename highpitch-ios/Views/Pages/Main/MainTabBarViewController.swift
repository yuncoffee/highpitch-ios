//
//  MainTabBarViewController.swift
//  highpitch-ios
//
//  Created by yuncoffee on 2/21/24.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Hello highpitch!"
        
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        // Do any additional setup after loading the view.
        setup()
    }
    
    override func loadView() {
        super.loadView()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    private func setup() {
        let vcs = [ProjectsViewController(), RecordingViewController(), SettingsViewController()]
        let tabBarItems = [
            UITabBarItem(title: "Project", image: UIImage(systemName: "note.text"), tag: 0),
            UITabBarItem(title: "Recording", image: UIImage(systemName: "mic.fill"), tag: 1),
            UITabBarItem(title: "Settings", image: UIImage(systemName: "gearshape.fill"), tag: 2)
        ]
        
        vcs.enumerated().forEach { index, viewController in
            viewController.tabBarItem = tabBarItems[index]
            viewController.navigationItem.largeTitleDisplayMode = .always
            viewController.navigationItem.title = tabBarItems[index].title
        }
        
        setViewControllers( vcs.map { UINavigationController(rootViewController: $0) }, animated:  true)
        tabBar.backgroundColor = .white
    }
}

