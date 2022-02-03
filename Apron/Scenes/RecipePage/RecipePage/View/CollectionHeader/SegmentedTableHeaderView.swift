//
//  SegmentedTableHeaderView.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 03.02.2022.
//

import UIKit
import DesignSystem

protocol ISegmentedHeader: AnyObject {
    func trackSelectedIndex(_ selectedIndex: Int)
}

final class SegmentedTableHeaderView: UITableViewHeaderFooterView {
    // MARK: - Properties

    enum RecipeSegment: Int, CaseIterable {
        case ingredients = 0
        case instructions
        case calories

        var title: String {
            switch self {
            case .ingredients:
                return "Ингредиенты"
            case .instructions:
                return "Инструкция"
            case .calories:
                return "Калории"
            }
        }
    }

    // MARK: - Init

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    // MARK: - Properties

    weak var delegate: ISegmentedHeader?

    // MARK: - Views factory

    private lazy var segmentedControl: ScrollableSegmentedControl = {
        let segmentedControl = ScrollableSegmentedControl()
        segmentedControl.insertSegment(
            withTitle: RecipeSegment.ingredients.title,
            at: RecipeSegment.ingredients.rawValue
        )
        segmentedControl.insertSegment(
            withTitle: RecipeSegment.instructions.title,
            at: RecipeSegment.instructions.rawValue
        )
        segmentedControl.insertSegment(
            withTitle: RecipeSegment.calories.title,
            at: RecipeSegment.calories.rawValue
        )
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

    // MARK: - Setup Views

    private func setupViews() {
        [segmentedControl].forEach { addSubview($0) }
        setupConstraints()
    }

    private func setupConstraints() {
        segmentedControl.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    // MARK: - Methods

    @objc
    private func segmentedControlChanged(_ sender: ScrollableSegmentedControl) {
        delegate?.trackSelectedIndex(sender.selectedSegmentIndex)
    }
}

