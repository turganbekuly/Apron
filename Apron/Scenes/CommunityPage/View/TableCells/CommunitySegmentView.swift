//
//  CommunitySegmentView.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 18.01.2022.
//

import DesignSystem
import UIKit

public protocol ICommunitySegmentCell: AnyObject {
    func cell(_ cell: CommunitySegmentView, didChangedSegment segment: CommunitySegmentView.CommunitySegment)
}

public final class CommunitySegmentView: UIView {

    public enum CommunitySegment: Int, CaseIterable {
        case recipes = 0, comments = 1

        public var title: String {
            switch self {
            case .recipes:
                return "Рецепты"
            case .comments:
                return "Комментарии"
            }
        }
    }

    // MARK: - Properties

    public weak var delegate: ICommunitySegmentCell?

    // MARK: - Views

    private lazy var segmentedControl: ScrollableSegmentedControl = {
        let segmentedControl = ScrollableSegmentedControl()
        segmentedControl.insertSegment(withTitle: "Рецепты", at: CommunitySegment.recipes.rawValue)
        segmentedControl.insertSegment(withTitle: "Комментарии", at: CommunitySegment.comments.rawValue)
        segmentedControl.underlineSelected = true
        segmentedControl.tintColor = Assets.darkYello.color
        segmentedControl.setTitleTextAttributes(
            [.font: TypographyFonts.medium14, .foregroundColor: UIColor.black],
            for: .selected
        )
        segmentedControl.setTitleTextAttributes(
            [.font: TypographyFonts.regular14, .foregroundColor: Assets.gray.color],
            for: .normal
        )
        segmentedControl.addTarget(self, action: #selector(segmentedControlChanged(_:)), for: .valueChanged)
        return segmentedControl
    }()

    // MARK: - Init

    public override init(frame: CGRect) {
        super.init(frame: frame)
        configureViews()
    }

    public required init?(coder: NSCoder) {
        nil
    }

    // MARK: - Life Cycle

    override public func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        configureColors()
    }

    // MARK: - Methods

    @objc
    private func segmentedControlChanged(_ sender: ScrollableSegmentedControl) {
        let segment = CommunitySegment(rawValue: sender.selectedSegmentIndex)
        delegate?.cell(self, didChangedSegment: segment ?? .recipes)
    }

    public func configure(with viewModel: ICommunitySegmentedCellViewModel) {
        segmentedControl.selectedSegmentIndex = viewModel.index
    }

    private func configureViews() {
        [segmentedControl].forEach {
            addSubview($0)
        }

        configureColors()
        makeConstraints()
    }

    private func makeConstraints() {
        segmentedControl.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    private func configureColors() {
        backgroundColor = .clear
    }

}

