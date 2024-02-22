//
//  ProjectsViewController.swift
//  highpitch-ios
//
//  Created by yuncoffee on 2/21/24.
//

import UIKit
import SwiftUI
import FlexLayout
import PinLayout

class ProjectsViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        setup()
    }
    
    override func loadView() {
        view = ProjectsView()
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    func setup() {
        print("Hello")
    }
}

struct ProjectsViewController_Previews: PreviewProvider {
    static var previews: some View {
        ViewControllerPreview {
            ProjectsViewController()
        }
    }
}
