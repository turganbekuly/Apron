//
//  MealPlannerHeaderView.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 10.01.2023.
//

import APRUIKit
import UIKit
import Extensions

protocol MealPlannerHeaderViewProtocol: AnyObject {
    func addButtonTapped(for weekDay: MealPlannerWeekDays?)
}

final class MealPlannerHeaderView: UITableViewHeaderFooterView {
    // MARK: - Properties

    weak var delegate: MealPlannerHeaderViewProtocol?
    private var weekDay: MealPlannerWeekDays? {
        didSet {
            guard let weekDay = weekDay else {
                return
            }

            weekDayLabel.text = weekDay.title
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
    // MARK: - Views factory

    lazy var addButton: NavigationButton = {
        let button = NavigationButton()
        button.backgroundType = .grayBackground
        button.setTitle("+ ДОБАВИТЬ", for: .normal)
        button.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        return button
    }()

    private lazy var weekDayLabel: UILabel = {
        let label = UILabel()
        label.font = TypographyFonts.semibold16
        label.textColor = ApronAssets.gray.color
        return label
    }()

    private lazy var separatorView = SeparatorView()

    // MARK: - Setup Views

    func setupViews() {
        backgroundColor = .white
        addSubviews(weekDayLabel, addButton, separatorView)
        setupConstraints()
    }

    func setupConstraints() {
        separatorView.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(1)
        }

        weekDayLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalTo(snp.centerX)
        }

        addButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(24)
            $0.width.greaterThanOrEqualTo(120)
        }
    }

    // MARK: - User actions

    @objc
    private func addButtonTapped() {
        delegate?.addButtonTapped(for: weekDay)
    }

    // MARK: - Methods

    func configure(with weekDay: MealPlannerWeekDays) {
        self.weekDay = weekDay
    }
}
