//
//  ProjectCell.swift
//  highpitch-ios
//
//  Created by yuncoffee on 2/26/24.
//

import UIKit
import SwiftUI
import PinLayout
import FlexLayout

class ProjectCell: UICollectionViewCell {
    static let identifier = "ProjectCell"
    
    fileprivate let titleLabel = UILabel()
    fileprivate let descriptionLabel = UILabel()
    fileprivate let dateLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        titleLabel.text = "Title"
        descriptionLabel.text = "Description"
        dateLabel.text = "Date * Time * Duration"
        
        titleLabel.font = .pretendard(.headline, weight: .semiBold)
        descriptionLabel.font = .pretendard(.body, weight: .medium)
        dateLabel.font = .pretendard(.body, weight: .medium)
        
        contentView.flex.paddingHorizontal(24).gap(8).define { flex in
            flex.addItem(titleLabel)
            flex.addItem(descriptionLabel)
            flex.addItem(dateLabel).marginBottom(4)
            flex.addItem().height(1).backgroundColor(.lightGray).marginBottom(12)
        }
        
    }
    
    private func layout() {
        contentView.flex.layout(mode: .adjustHeight)
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        contentView.pin.width(size.width)
        layout()
        
        return contentView.frame.size
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layout()
    }
}

extension ProjectCell {
    func configure(project: ProjectModel) {
        titleLabel.text = project.name
        titleLabel.flex.markDirty()
        
        descriptionLabel.text = "\(project.practices.count) 개의 연습이 있어요."
        descriptionLabel.flex.markDirty()
        
        dateLabel.text = Date.createAtToHMS(input: project.creatAt.description) + " • 12분"
        dateLabel.flex.markDirty()
        
        setNeedsLayout()
    }
}

struct ProjectCell_Preview: PreviewProvider {
    static var previews: some View {
        let cell = ProjectCell()
        let projectModel = ProjectModel(name: "프로젝트 명", creatAt: Date(), editAt: Date())
        
        ViewPreview {
            cell.configure(project: projectModel)
            return cell
        }
    }
}
