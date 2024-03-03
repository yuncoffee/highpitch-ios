//
//  ProjectViewController.swift
//  highpitch-ios
//
//  Created by yuncoffee on 2/26/24.
//

import UIKit
import SwiftUI

protocol ProjectViewDelegate: AnyObject {
    func pushNavigation(with: PracticeModel)
}

class ProjectDetailViewController: UIViewController, ProjectViewDelegate {
    // swiftlint: disable force_cast
    fileprivate var mainView: ProjectView {
        return self.view as! ProjectView
    }
    // swiftlint: enable force_cast
    
    var project: ProjectModel?
    
    func configure(with project: ProjectModel) {
        self.project = project
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Iam Here")
        setup()
        print("HHHH")
        UIFont.familyNames.sorted().forEach { familyName in
            print("*** \(familyName) ***")
            UIFont.fontNames(forFamilyName: familyName).forEach { fontName in
                print("\(fontName)")
            }
            print("---------------------")
        }
    }

    private func setup() {
        title = "Project"
    }
    
    override func loadView() {
        view = ProjectView()
        mainView.practicesView.delegate = self
        
        if let project = project {
            mainView.configure(with: project)
        }
    }
    
    func pushNavigation(with practice: PracticeModel) {
        let practiceVC = PracticeDetailViewController()
        practiceVC.practice = practice
        
        navigationController?.pushViewController(practiceVC, animated: true)
    }
    
    deinit {
        print("ProjectVC Deinit")
    }
}

struct ProjectViewController_Previews: PreviewProvider {
    static var previews: some View {
        ViewControllerPreview {
            ProjectDetailViewController()
        }
    }
}
