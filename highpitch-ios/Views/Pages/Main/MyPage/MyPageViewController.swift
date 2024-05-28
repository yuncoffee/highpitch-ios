//
//  SettingsViewController.swift
//  highpitch-ios
//
//  Created by yuncoffee on 2/21/24.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

protocol MyPageViewDelegate: AnyObject {
    func pushNavigation(to link: MyPageLinks)
}

typealias SectionOfMyPageInfo = SectionModel<String, MyPageLinks>

final class MyPageViewController: UIViewController, MyPageViewDelegate {
    // swiftlint: disable force_cast
    private var mainView: MyPageView {
        self.view as! MyPageView
    }
    // swiftlint: enable force_cast
    
    private let vm = MyPageViewModel()
    private let disposeBag = DisposeBag()
    private var dataSource: RxCollectionViewSectionedReloadDataSource<SectionOfMyPageInfo>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        bind()
        
        print(mainView.collectionView.frame.size)
        print(mainView.collectionView.contentSize)
    }
    
    override func loadView() {
        view = MyPageView()
    }
    
    @objc func signOut() {
        dismiss(animated: true)
    }
    
    private func setup() {
        navigationItem.title = "마이페이지"
        mainView.delegate = self
        
        dataSource = RxCollectionViewSectionedReloadDataSource<SectionOfMyPageInfo>(
            configureCell: { _, collectionView, indexPath, myPageLink in
                let cell: MyPageInfoCell = collectionView.dequeueReusableCell(for: indexPath)
                cell.configure(title: myPageLink.rawValue)
                
                return cell
            }, configureSupplementaryView: { dataSource, collectionView, title, indexPath in
                let header: MyPageInfoHeaderCell = collectionView.dequeueReusableSupplementaryView(
                    ofKind: UICollectionView.elementKindSectionHeader,
                    for: indexPath
                )
                
                let title = dataSource.sectionModels[indexPath.section].model
                header.configure(title: title)
                
                return header
            }
        )
        
        vm.sections.accept([
            SectionOfMyPageInfo(model: "내 정보", items: [.profile, .account]),
            SectionOfMyPageInfo(model: "이용 설정", items: [.myFillerWord, .mySpeakingSpeed, .myTheme, .myData]),
            SectionOfMyPageInfo(model: "고객 지원", items: [.help, .terms, .myOpinion, .appVersion])
        ])
    }
    
    private func bind() {
        bindCollectionView()
    }
    
    private func bindCollectionView() {
        guard let dataSource = dataSource else { return }
        
        vm.sections
            .bind(to: mainView.collectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        mainView.collectionView.rx.itemSelected
            .withUnretained(self)
            .subscribe { vc, indexPath in
                guard let pageLink = MyPageLinks(
                    rawValue: vc.vm.sections.value[indexPath.section].items[indexPath.row].rawValue
                ) 
                else { return }
                
                vc.pushNavigation(to: pageLink)
            }
            .disposed(by: disposeBag)
    }
    
    func pushNavigation(to link: MyPageLinks) {
        var vc: UIViewController?
        switch link {
        case .profile:
            vc = UIViewController()
        case .account:
            vc = UIViewController()
        case .myFillerWord:
            vc = UIViewController()
        case .mySpeakingSpeed:
            vc = UIViewController()
        case .myTheme:
            vc = UIViewController()
        case .myData:
            vc = UIViewController()
        case .help:
            vc = UIViewController()
        case .terms:
            vc = UIViewController()
        case .myOpinion:
            vc = UIViewController()
        case .appVersion:
            vc = UIViewController()
        }
        
        if let vc = vc {
            vc.view.backgroundColor = .white
            vc.title = link.rawValue
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    deinit {
        print("MyPageVC Deinit")
    }
}

#if DEBUG
import SwiftUI
struct MyPageViewController_Previews: PreviewProvider {
    static var previews: some View {
        ViewControllerPreview {
            UINavigationController(rootViewController: MyPageViewController())
        }
    }
}
#endif
