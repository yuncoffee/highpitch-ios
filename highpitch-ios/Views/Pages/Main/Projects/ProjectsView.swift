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

final class ProjectsView: UIView {
    fileprivate let rootContainerView = UIView()
    let headerView = UIButton()
    let myLabel = UILabel()
    
    let collectionView: UICollectionView
    fileprivate let flowLayout = UICollectionViewFlowLayout()
    fileprivate let cellTemplate = ProjectCell()
    fileprivate let headerCellTemplate = ProjectHeaderCell()
    
    fileprivate var projects: [ProjectModel] = []
    
    weak var delegate: ProjectsViewDelegate?

    init() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        
        super.init(frame: .zero)
        
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.sectionHeadersPinToVisibleBounds  = true
        
        backgroundColor = .white
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ProjectCell.self, forCellWithReuseIdentifier: ProjectCell.identifier)
        collectionView.register(ProjectHeaderCell.self, 
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: ProjectHeaderCell.identifier
        )
        
        collectionView.backgroundColor = .yellow
        
        let label = UILabel()
        label.text = "Flexbox layouting is simple, powerfull and fast.!!!!"
        label.numberOfLines = 0
        
        let label2 = UILabel()
        label2.text = "powerfull and fast.????"
        label2.numberOfLines = 0
        
        myLabel.text = "World!"
        
        rootContainerView.flex.padding(16).define { flex in
            flex.addItem(label)
            flex.addItem(label2).marginTop(16)
        }

        headerView.flex.cornerRadius(32).backgroundColor(.blue).width(64).height(64)
        
        addSubview(myLabel)
        addSubview(rootContainerView)
        addSubview(collectionView)
        addSubview(headerView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        myLabel.pin.top(pin.safeArea).horizontally()
        myLabel.flex.layout(mode: .adjustHeight)
        
        collectionView.pin.below(of: myLabel).bottom().horizontally()
        collectionView.flex.layout(mode: .adjustHeight)
        
        headerView.pin.bottom(24).right(16).width(64).height(64).margin(pin.safeArea)
        
    }
}

extension ProjectsView {
    func configure(with projects: [ProjectModel]) {
        self.projects = projects
        collectionView.reloadData()
    }
    
    func viewOrientationDidChange() {
        flowLayout.invalidateLayout()
    }
}

// swiftlint: disable line_length
extension ProjectsView: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        projects.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // swiftlint: disable force_cast
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProjectCell.identifier, for: indexPath) as! ProjectCell
        // swiftlint: enable force_cast
        cell.configure(project: projects[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader,
                let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: ProjectHeaderCell.identifier, for: indexPath)
                as? ProjectHeaderCell
        else { return UICollectionReusableView() }
        
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        cellTemplate.sizeThatFits(.init(width: collectionView.bounds.width, height: .greatestFiniteMagnitude))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        .init(width: collectionView.bounds.width, height: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.pushNavigation(with: projects[indexPath.row])
    }
}
// swiftlint: enable line_length

struct ProjectsView_Preview: PreviewProvider {
    static var previews: some View {
        let view = ProjectsView()
        view.configure(with: MockModel.sampleProjects)
        
        return ViewPreview {
            view
        }
    }
}
