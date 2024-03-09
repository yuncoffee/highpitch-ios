//
//  SelectProjectSheetCell.swift
//  highpitch-ios
//
//  Created by yuncoffee on 3/9/24.
//

import Foundation
import UIKit
import SwiftUI
import Reusable
import FlexLayout
import PinLayout

final class SelectProjectSheetCell: UICollectionViewCell, Reusable {
    private let titleLabel: UILabel
    private let selectedImage: UIImageView
    private let selectBoxView: UIView
    private let config = UIImage.SymbolConfiguration(font: .pretendard(name: .bold, size: 10))
    override init(frame: CGRect) {
        titleLabel = UILabel()
        titleLabel.text = "2023.12.30 오후 8시 23분"
        titleLabel.font = .pretendard(.headline, weight: .semiBold)
        
        selectedImage = UIImageView()
        let image = UIImage(systemName: "checkmark", withConfiguration: config)
        selectedImage.image = image?.withTintColor(.white, renderingMode: .alwaysOriginal)
        
        selectBoxView = UIView()
        
        super.init(frame: frame)
        
        contentView.flex.direction(.row).alignItems(.center).justifyContent(.spaceBetween).define { flex in
            flex.addItem(titleLabel).marginLeft(24)
            flex.addItem().define { flex in
                flex.addItem(selectBoxView)
                    .position(.absolute)
                    .left(-4).top(-4)
                    .cornerRadius(10).backgroundColor(UIColor.GrayScale.black).border(1, .clear)
                    .width(20).height(20)
                flex.addItem(selectedImage)
            }
            .marginRight(24)
        }
        .height(48)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.flex.layout(mode: .adjustHeight)
    }
    
    func configure(name: String) {
        titleLabel.text = name
        titleLabel.flex.markDirty()
        setNeedsLayout()
    }
    
    func updateLayout(_ isSelected: Bool) {
        if isSelected {
            let image = UIImage(systemName: "checkmark", withConfiguration: config)
            selectedImage.image = image?.withTintColor(.white, renderingMode: .alwaysOriginal)
            selectBoxView.flex
                .position(.absolute)
                .left(-4).top(-4)
                .cornerRadius(10).backgroundColor(UIColor.GrayScale.black).border(1, .clear)
                .width(20).height(20)
        } else {
            selectedImage.image = nil
            selectBoxView.flex
                .position(.absolute)
                .left(-16).top(-8)
                .cornerRadius(10).backgroundColor(.clear).border(1, .stroke)
                .width(20).height(20)
        }
        selectBoxView.flex.markDirty()
        selectedImage.flex.markDirty()
        setNeedsLayout()
    }
}

struct SelectProjectSheetCell_Preview: PreviewProvider {
    static var previews: some View {
        let cell = SelectProjectSheetCell()
        let projectModel = ProjectModel(name: "프로젝트 명", creatAt: Date(), editAt: Date())
        var toggle = true
        ViewPreview {
            cell.configure(name: projectModel.name)
            return cell
        }
        .onTapGesture {
            // MARK: 클릭되었을 때 값 변경하는 처리 테스트
            toggle = !toggle
            cell.updateLayout(toggle)
        }
    }
}
