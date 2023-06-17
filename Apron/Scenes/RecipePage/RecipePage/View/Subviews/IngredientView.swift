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
            if initialAmount != 0 {
                amount = (initialAmount / Double(initialServingsCount)) * Double(changedServingsCount)
            }
        }
    }

    private var amount: Double = 0 {
        didSet {
            var value = ""
            if amount != 0.0 {
                value = "\(amount.clean)"
            }
            value += " \(unit)"
            self.measureScopeLabel.text = value
        }
    }

    private var initialAmount: Double = 0.0 {
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

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 19
        imageView.clipsToBounds = true
        return imageView
    }()

    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = TypographyFonts.regular16
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 2
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
        [nameLabel, measureScopeLabel, imageView].forEach { addSubviews($0) }
        setupConstraints()
    }

    private func setupConstraints() {
        snp.makeConstraints {
            $0.height.greaterThanOrEqualTo(55)
        }

        imageView.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
            $0.size.equalTo(38)
        }

        nameLabel.snp.makeConstraints {
            $0.centerY.equalTo(imageView.snp.centerY)
            $0.leading.equalTo(imageView.snp.trailing).offset(8)
            $0.trailing.equalTo(measureScopeLabel.snp.leading).offset(-4)
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
        amount: Double?,
        unit: String?,
        image: String?
    ) {
        self.nameLabel.text = name
        self.unit = unit ?? ""
        self.initialAmount = amount ?? 0.0

        self.imageView.kf.setImage(
            with: URL(string: image ?? ""),
            placeholder: APRAssets.recipeIngredientPlaceholder.image.withRenderingMode(.alwaysTemplate)
        )
        self.imageView.tintColor = .gray
        self.imageView.backgroundColor = .white
    }

    func changeServings(initialCount: Int, changedCount: Int) {
        self.initialServingsCount = initialCount
        self.changedServingsCount = changedCount
    }
}

extension Double {
    var clean: String {
        return self.truncatingRemainder(dividingBy: 1) == 0.0 ?
        String(format: "%.0f", self) : String(format: "%.1f", self)
    }
}
