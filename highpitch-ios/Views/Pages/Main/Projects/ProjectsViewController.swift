//
//  ProjectsViewController.swift
//  highpitch-ios
//
//  Created by yuncoffee on 2/21/24.
//

import UIKit
import SwiftUI

protocol ProjectsViewDelegate: AnyObject {
    func pushNavigation(with: ProjectModel)
}

final class ProjectsViewController: UIViewController, ProjectsViewDelegate {
    
    // swiftlint: disable force_cast
    fileprivate var mainView: ProjectsView {
        return self.view as! ProjectsView
    }
    // swiftlint: enable force_cast
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func loadView() {
        view = ProjectsView()
        mainView.configure(with: MockModel.sampleProjects)
    }
    
    // swiftlint: disable line_length
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        mainView.viewOrientationDidChange()
    }
    // swiftlint: enable line_length
    
    private func setup() {
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "My Projects"
        mainView.delegate = self
    }
    
    func pushNavigation(with project: ProjectModel) {
        let projectVC = ProjectViewController()
        projectVC.configure(with: project)
        
        navigationController?.pushViewController(projectVC, animated: true)
    }
    
    deinit {
        print("ProjectsVC Deinit")
    }
}

struct ProjectsViewController_Previews: PreviewProvider {
    static var previews: some View {
        ViewControllerPreview {
            ProjectsViewController()
        }
    }
}
