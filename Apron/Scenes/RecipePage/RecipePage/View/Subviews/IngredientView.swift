//
//  IngredientView.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 25.02.2022.
//

import UIKit
import APRUIKit
import Kingfisher

final class IngredientView: UIView {
    // MARK: - Properties

    private var initialServingsCount = 0

    private var changedServingsCount = 0 {
        didSet {
            amount = (initialAmount / Double(initialServingsCount)) * Double(changedServingsCount)
        }
    }

    private var amount: Double = 0 {
        didSet {
            self.measureScopeLabel.text = "\(String(format: "%.1f", amount)) \(unit)"
        }
    }

    private var initialAmount: Double = 0 {
        didSet {
            amount = initialAmount
        }
    }
    private var unit: String = ""

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Views factory

    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = TypographyFonts.regular16
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()

    private lazy var measureScopeLabel: UILabel = {
        let label = UILabel()
        label.font = TypographyFonts.bold16
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()

    // MARK: - Setup Views

    private func setupViews() {
        backgroundColor = .clear
        [nameLabel, measureScopeLabel].forEach { addSubviews($0) }
        setupConstraints()
    }

    private func setupConstraints() {
        snp.makeConstraints {
            $0.height.equalTo(38)
        }

        nameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(4)
            $0.leading.equalToSuperview()
            $0.trailing.equalTo(snp.centerX).offset(8)
            $0.bottom.equalToSuperview().inset(4)
        }

        measureScopeLabel.snp.makeConstraints {
            $0.centerY.equalTo(nameLabel.snp.centerY)
            $0.trailing.equalToSuperview()
            $0.leading.equalTo(snp.centerX).offset(16)
        }
    }

    // MARK: - Public methods

    func configure(
        name: String,
        amount: Double,
        unit: String
    ) {
        self.nameLabel.text = name
        self.unit = unit
        self.initialAmount = amount
    }

    func changeServings(initialCount: Int, changedCount: Int) {
        self.initialServingsCount = initialCount
        self.changedServingsCount = changedCount
    }
}
