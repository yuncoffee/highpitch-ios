//
//  ProjectView.swift
//  highpitch-ios
//
//  Created by yuncoffee on 2/26/24.
//

import Foundation
import UIKit
import SwiftUI
import PinLayout
import FlexLayout

final class ProjectView: UIView {
    fileprivate let titleLabel = UILabel()
    let practicesView = PracticesView()

    init() {
        super.init(frame: .zero)
        titleLabel.text = "title"
        titleLabel.textAlignment = .center
        
        backgroundColor = .white
        addSubview(titleLabel)
        addSubview(practicesView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        practicesView.pin.all()
    }
}

extension ProjectView {
    func configure(with project: ProjectModel) {
        titleLabel.text = project.name
        practicesView.configure(with: project.practices)
    }
}

struct ProjectView_Previews: PreviewProvider {
    static var previews: some View {
        ViewPreview {
            ProjectView()
        }
    }
}
