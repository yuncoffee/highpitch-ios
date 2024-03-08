//
//  PracticeCell.swift
//  highpitch-ios
//
//  Created by yuncoffee on 2/26/24.
//

import UIKit
import SwiftUI
import PinLayout
import FlexLayout
import RxSwift
import RxCocoa
import Reusable

final class PracticeCell: UICollectionViewCell, Reusable {
    static let identifier = "PracticeCell"
    
    fileprivate let titleLabel = UILabel()
    fileprivate let descriptionLabel = UILabel()
    fileprivate let remarkableIconView = UIImageView()
    let remarkableButton = UIButton()
    var disposeBag = DisposeBag()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        titleLabel.text = "Title"
        titleLabel.font = .pretendard(.headline, weight: .semiBold)
        titleLabel.tintColor = UIColor.TextScale.text900
        
        descriptionLabel.text =  "Date * Time * Duration"
        descriptionLabel.font = .pretendard(.body, weight: .medium)
        descriptionLabel.tintColor = UIColor.TextScale.text900
        
        let color = UIColor.GrayScale.gray400
        let image = UIImage(systemName: "star")?
            .resizeImage(size: .init(width: 16, height: 16))
            .withTintColor(color, renderingMode: .alwaysOriginal)
        remarkableButton.setImage(image, for: .normal)
        remarkableIconView.contentMode = .scaleAspectFit
        
        contentView.flex.direction(.column).gap(12).padding(12, 24, 0, 24).define {
            $0.addItem().direction(.row).justifyContent(.spaceBetween).define {
                $0.addItem().gap(8).define {
                    $0.addItem(titleLabel)
                    $0.addItem(descriptionLabel)
                }
                $0.addItem(remarkableButton).minWidth(40).left(10)
            }
            $0.addItem().height(1).backgroundColor(.stroke)
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
    
    override func prepareForReuse() {
         super.prepareForReuse()
          // prepareForReuse 에서 명시적 구독 해제를 해야한다.
         disposeBag = DisposeBag()
     }
}

extension PracticeCell {
    func configure(with practice: PracticeModel) {
        titleLabel.text = practice.name
        descriptionLabel.text = Date.formatCell(practice.creatAt.description) + " • 12분"
        
        let color = practice.isRemarkable ? UIColor.PrimaryScale.primary500 : UIColor.GrayScale.gray400
        let image = UIImage(systemName: practice.isRemarkable ?  "star.fill" : "star")?
            .resizeImage(size: .init(width: 16, height: 16))
            .withTintColor(color, renderingMode: .alwaysOriginal)
        remarkableButton.setImage(image, for: .normal)
        
        setNeedsLayout()
    }
}

struct PracticeCell_Preview: PreviewProvider {
    static var previews: some View {
        let view = PracticeCell()
        let disposeBag = DisposeBag()
        ViewPreview {
            return view
        }
        .onAppear {
            view.remarkableButton.rx.tap.subscribe { _ in
                print("Hello!")
            }
            .disposed(by: disposeBag)
        }
    }
}
