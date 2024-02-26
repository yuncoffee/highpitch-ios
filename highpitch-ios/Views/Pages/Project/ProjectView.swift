//
//  ProjectView.swift
//  highpitch-ios
//
//  Created by yuncoffee on 2/26/24.
//

import Foundation
import UIKit
import SwiftUI

final class ProjectView: UIView {
    fileprivate let titleLabel = UILabel()
    
    init() {
        super.init(frame: .zero)
        titleLabel.text = "title"
        titleLabel.textAlignment = .center
        
        backgroundColor = .white
        addSubview(titleLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel.pin.all()
    }
}

extension ProjectView {
    func configure(with project: ProjectModel) {
        titleLabel.text = project.name
    }
}

struct ProjectView_Previews: PreviewProvider {
    static var previews: some View {
        ViewPreview {
            ProjectView()
        }
    }
}
