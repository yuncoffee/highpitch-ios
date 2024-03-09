//
//  ProjectDetailSummaryView.swift
//  highpitch-ios
//
//  Created by yuncoffee on 3/6/24.
//

import Foundation
import UIKit
import SwiftUI
import FlexLayout

final class ProjectDetailSummaryView: UIView {
    let scrollView = UIScrollView()
    private let contentView = UIView()
    private let summaryView = SummaryView()
    private let fillerWordChartView = ChartView(title: "습관어 사용횟수")
    private let sppedChartView = ChartView(title: "말 빠르기 범위")
    private let durationChartView = ChartView(title: "연습 소요시간")
    init() {
        super.init(frame: .zero)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
//        backgroundColor = .orange
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        scrollView.contentInsetAdjustmentBehavior = .never
        contentView.flex.define { flex in
            flex.addItem(summaryView)
            flex.addItem(fillerWordChartView)
            flex.addItem(sppedChartView)
            flex.addItem(durationChartView)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        scrollView.pin.all()
        scrollView.flex.layout()
        scrollView.contentSize = contentView.frame.size
    }
}

extension ProjectDetailSummaryView {
    func configure(_ project: ProjectModel) {
        // MARK: 데이터 변환 처리
        summaryView.configure(project)
    }
}

struct ProjectDetailSummaryView_Previews: PreviewProvider {
    static var previews: some View {
        let view = ProjectDetailSummaryView()
        ViewPreview {
            view.configure(MockModel.sampleProjects.first!)
            
            return view
        }
    }
}

extension ProjectDetailSummaryView {
    final class SummaryView: UIView {
        private let rootView = UIView()
        private let titleLabel: UILabel
        private let dateDurationLabel: UILabel
        private let speedAverageView: UIView
        private let fillerwordAverageView: UIView
        private let fillerwordMostView: UIView
        
        let spmLabel: UILabel
        let spmDescriptionLabel: UILabel
        let fillerwordAverageLabel: UILabel
        let fillerwordAverageDescrptionLabel: UILabel
        let fillerwordMostItemContainer: UIView?
        
        init() {
            titleLabel = UILabel()
            titleLabel.font = .pretendard(.title3, weight: .bold)
            titleLabel.text = "총 N번의 연습에 대한 결과예요"
            titleLabel.textColor = UIColor.TextScale.text900
            
            dateDurationLabel = UILabel()
            dateDurationLabel.font = .pretendard(.body, weight: .medium)
            dateDurationLabel.text = "yyyy.mm.dd - yyyy.mm.dd"
            dateDurationLabel.textColor = UIColor.TextScale.text300
            
            speedAverageView = UIView()
            fillerwordAverageView = UIView()
            fillerwordMostView = UIView()
            
            spmLabel = UILabel()
            spmLabel.text = "000SPM"
            spmLabel.font = .pretendard(.title2, weight: .bold)
            spmLabel.textColor = UIColor.PrimaryScale.primary
            
            spmDescriptionLabel = UILabel()
            spmDescriptionLabel.text = "빠르기 설명"
            spmDescriptionLabel.font = .pretendard(.body, weight: .medium)
            spmDescriptionLabel.textColor = UIColor.TextScale.text500
            
            fillerwordAverageLabel = UILabel()
            let fillerwordAverageLabelText = NSMutableAttributedString(
                string: "분 당 0.0회",
                attributes: [
                    .font: UIFont.pretendard(.title2, weight: .bold),
                    .foregroundColor: UIColor.PrimaryScale.primary
                ]
            )
            fillerwordAverageLabelText.addAttributes([
                .font: UIFont.pretendard(.caption1, weight: .semiBold),
                .foregroundColor: UIColor.TextScale.text500
            ], range: .init(location: 0, length: 3))
            fillerwordAverageLabel.attributedText = fillerwordAverageLabelText
            
            fillerwordAverageDescrptionLabel = UILabel()
            fillerwordAverageDescrptionLabel.text = "습관어 수 설명"
            fillerwordAverageDescrptionLabel.font = .pretendard(.body, weight: .medium)
            fillerwordAverageDescrptionLabel.textColor = UIColor.TextScale.text500
            
            fillerwordMostItemContainer = nil
            
            super.init(frame: .zero)
            
            layout()
        }
        
        override func layoutSubviews() {
            super.layoutSubviews()
            rootView.pin.all()
            rootView.flex.layout()
        }
        
        private func layout() {
            rootView.flex.margin(32, 24, 16, 24).define { flex in
                let maxWidth = UIScreen.main.bounds.width - 48
                flex.addItem(titleLabel).marginBottom(4)
                flex.addItem(dateDurationLabel).marginBottom(16)
                flex.addItem().direction(.row).justifyContent(.center).gap(12).define { flex in
                    flex.addItem(speedAverageView).gap(4).alignItems(.center).define { flex in
                        let title = UILabel()
                        title.text = "평균 말 빠르기"
                        title.font = .pretendard(.headline, weight: .medium)
                        title.textColor = UIColor.TextScale.text900
                        
                        flex.addItem(title)
                        flex.addItem(spmLabel)
                        flex.addItem(spmDescriptionLabel)
                    }
                    .padding(28, 24, 16, 24)
                    .width((maxWidth - 12)/2)
                    .border(1, .stroke).backgroundColor(.summaryBox).cornerRadius(12)
                    flex.addItem(fillerwordAverageView).gap(4).alignItems(.center).define { flex in
                        let title = UILabel()
                        title.text = "습관어 사용횟수"
                        title.font = .pretendard(.headline, weight: .medium)
                        title.textColor = UIColor.TextScale.text900
                            
                        flex.addItem(title)
                        flex.addItem(fillerwordAverageLabel)
                        flex.addItem(fillerwordAverageDescrptionLabel)
                    }
                    .padding(28, 24, 16, 24)
                    .width((maxWidth - 12 / 2)/2)
                    .border(1, .stroke).backgroundColor(.summaryBox).cornerRadius(12)
                }
                .marginBottom(14)
                flex.addItem(fillerwordMostView).gap(4).alignItems(.center).define { flex in
                        let title = UILabel()
                        title.text = "많이 사용한 습관어"
                        title.font = .pretendard(.headline, weight: .medium)
                        title.textColor = UIColor.TextScale.text900
                        flex.addItem(title)
                    }
                    .padding(16, 24, 22, 24)
                    .width(maxWidth).minHeight(120)
                    .border(1, .stroke).backgroundColor(.summaryBox).cornerRadius(12)
            }
            addSubview(rootView)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        func configure(_ project: ProjectModel) {
            guard let firstDate = project.practices.first?.creatAt.description, 
                    let lastDate = project.practices.last?.creatAt.description else { return }
            let newTitle = titleLabel.text?.replacingOccurrences(of: "N", with: "\(project.practices.count)")
            let newDateDuration = "\(Date.formatDefault(firstDate)) - \(Date.formatDefault(lastDate))"
            titleLabel.text = newTitle
            dateDurationLabel.text = newDateDuration
            
            // MARK: 가져온 습관어
            
            let most = [(word: "아니", count: 34), (word: "근데", count: 23), (word: "그러니까", count: 12)]
            let superViewWidth = fillerwordMostView.flex.intrinsicSize.width
            fillerwordMostView.flex.addItem(makeMostInfo(most, maxWidth: superViewWidth))
            fillerwordMostView.flex.markDirty()
            setNeedsLayout()
        }
        
        private func makeMostInfo(_ input: [(word: String, count: Int)], maxWidth: CGFloat) -> UIView {
            let view = UIView()

            let cellCount = CGFloat(input.count)
            let cellPerWidth = (maxWidth - cellCount - 2) / cellCount
            
            view.flex.direction(.row).justifyContent(.spaceBetween).define { flex in
                if input.isEmpty {
                    let emptyLabel = UILabel()
                    emptyLabel.text = "사용된 습관어가 없습니다."
                    emptyLabel.font = .pretendard(.body, weight: .medium)
                    emptyLabel.textColor = UIColor.TextScale.text500
                    flex.addItem(emptyLabel).height(40)
                } else {
                    input.enumerated().forEach { index, info in
                        flex.addItem().alignItems(.center).define { flex in
                            let wordLabel = UILabel()
                            let countLabel = UILabel()
                            wordLabel.text = info.word
                            wordLabel.font = .pretendard(.title2, weight: .bold)
                            wordLabel.textColor = UIColor.PrimaryScale.primary
                            
                            countLabel.text = "\(info.count.description)회"
                            countLabel.font = .pretendard(.body, weight: .medium)
                            countLabel.textColor = UIColor.TextScale.text500
                            
                            flex.addItem(wordLabel).height(28)
                            flex.addItem(countLabel)
                        }
                        .width(cellPerWidth)
                        if index != input.count {
                            flex.addItem().width(1).height(28).backgroundColor(.stroke)
                        }
                    }
                }
            }
            .marginTop(12)
            
            return view
        }
    }
}

extension ProjectDetailSummaryView {
    final class ChartView: UIView {
        let rootView = UIView()
        private let titleLabel = UILabel()
        
        init(title: String) {
            titleLabel.text = title
            titleLabel.font = .pretendard(.title2, weight: .bold)
            
            super.init(frame: .zero)
            layout()
            
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        private func layout() {
            rootView.flex.define { flex in
                flex.addItem(titleLabel).marginBottom(14)
                flex.addItem().minHeight(200).backgroundColor(.gray)
            }
            .padding(24)
            addSubview(rootView)
        }
        
        override func layoutSubviews() {
            super.layoutSubviews()
            rootView.pin.all()
            rootView.flex.layout()
        }
    }
}
