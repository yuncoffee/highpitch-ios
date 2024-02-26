//
//  ProjectViewController.swift
//  highpitch-ios
//
//  Created by yuncoffee on 2/26/24.
//

import UIKit
import SwiftUI
import PinLayout

class ProjectViewController: UIViewController {
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
        // Do any additional setup after loading the view.
    }

    private func setup() {
        print("SetUp..")
    }
    
    override func loadView() {
        view = ProjectView()
        if let project = project {
            mainView.configure(with: project)
        }
    }
}

struct ProjectViewController_Previews: PreviewProvider {
    static var previews: some View {
        ViewControllerPreview {
            ProjectViewController()
        }
    }
}
