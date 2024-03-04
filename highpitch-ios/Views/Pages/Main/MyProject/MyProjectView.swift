//
//  ProjectsView.swift
//  highpitch-ios
//
//  Created by yuncoffee on 2/22/24.
//

import Foundation
import FlexLayout
import PinLayout
import UIKit
import SwiftUI

final class MyProjectView: UIView {
    private let rootContainer = UIView()
    
    let fabView = UIButton()
    let collectionView: UICollectionView
    
    private let flowLayout = UICollectionViewFlowLayout()
    private let cellTemplate = ProjectCell()
    private let headerCellTemplate = ProjectHeaderCell()
    
    weak var delegate: MyProjectViewDelegate?

    init() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        super.init(frame: .zero)
        backgroundColor = .white
        
        settingCollectionView()
        settingFabButton()
        
        addSubview(collectionView)
        addSubview(fabView)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func settingCollectionView() {
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.sectionHeadersPinToVisibleBounds  = true
        
        collectionView.delegate = self
        collectionView.register(ProjectCell.self,
                                forCellWithReuseIdentifier: ProjectCell.identifier)
        collectionView.register(ProjectHeaderCell.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: ProjectHeaderCell.identifier
        )
    }
    
    private func settingFabButton() {
        let size = 64.0
        let cornerRadius = size / 2
        let color: UIColor = UIColor.GrayScale.black
        
        let image = UIImage(systemName: "mic.fill")?
            .resizeImage(size: .init(width: 18, height: 28))
            .withTintColor(.white, renderingMode: .alwaysOriginal)

        fabView.setImage(image, for: .normal)
        
        fabView.flex
            .width(size)
            .height(size)
            .backgroundColor(color)
            .cornerRadius(cornerRadius)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.pin.all(pin.safeArea)
        collectionView.flex.layout(mode: .adjustHeight)
        
        fabView.pin.bottom(24).right(16).width(64).height(64).margin(pin.safeArea)
    }
}

extension MyProjectView {
    func viewOrientationDidChange() {
        flowLayout.invalidateLayout()
    }
}

// swiftlint: disable line_length
extension MyProjectView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        cellTemplate.sizeThatFits(.init(width: collectionView.bounds.width, height: .greatestFiniteMagnitude))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        .init(width: collectionView.bounds.width, height: headerCellTemplate.getHeight())
    }
}
// swiftlint: enable line_length

struct ProjectsView_Preview: PreviewProvider {
    static var previews: some View {
        let view = MyProjectView()

        return ViewPreview {
            view
        }
    }
}
