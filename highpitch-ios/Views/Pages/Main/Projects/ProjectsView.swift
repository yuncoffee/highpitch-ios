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
    fileprivate let rootView = UIView()
    fileprivate let collectionView: UICollectionView
    fileprivate let flowLayout = UICollectionViewFlowLayout()
    fileprivate let cellTemplate = ProjectCell()
    
    fileprivate var projects: [ProjectModel] = []
    
    weak var delegate: ProjectsViewDelegate?
    
    init() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        
        super.init(frame: .zero)
        
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ProjectCell.self, forCellWithReuseIdentifier: ProjectCell.idntifier)
        
        addSubview(collectionView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.pin.all()
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProjectCell.idntifier, for: indexPath) as! ProjectCell
        // swiftlint: enable force_cast
        cell.configure(project: projects[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        cellTemplate.sizeThatFits(.init(width: collectionView.bounds.width, height: .greatestFiniteMagnitude))
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.pushNavigation(with: projects[indexPath.row])
    }
}
// swiftlint: enable line_length

struct ProjectsView_Preview: PreviewProvider {
    static var previews: some View {
        ViewPreview {
            ProjectsView()
        }
    }
}
