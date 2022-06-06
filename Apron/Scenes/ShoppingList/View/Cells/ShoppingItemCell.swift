//
//  ShoppingItemCell.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 05.05.2022.
//

import UIKit
import DesignSystem
import M13Checkbox
import HapticTouch
import Storages

final class ShoppingItemCell: UITableViewCell {
    // MARK: - Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        if selected {
            checkbox.setCheckState(.checked, animated: true)
            HapticTouch.generateMedium()
        } else {
            checkbox.setCheckState(.unchecked, animated: true)
            HapticTouch.generateError()
        }
    }

    // MARK: - Views factory

    private lazy var containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 17
        view.backgroundColor = .white
        view.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.08).cgColor
        view.layer.shadowOffset = CGSize(width: 4, height: 0)
        view.layer.shadowOpacity = 1
        view.layer.shadowRadius = 19
        return view
    }()

    private lazy var sourceRecipsButton: UILabel = {
        let label = UILabel()
        label.font = TypographyFonts.regular12
        label.textColor = ApronAssets.gray.color
        label.textAlignment = .left
        return label
    }()

    private lazy var ingredientNameLabel: UILabel = {
        let label = UILabel()
        label.font = TypographyFonts.bold14
        label.textAlignment = .left
        label.textColor = .black
        return label
    }()

    private lazy var measurementLabel: UILabel = {
        let label = UILabel()
        label.font = TypographyFonts.semibold12
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()

    lazy var checkbox: M13Checkbox = {
        let checkbox = M13Checkbox()
        checkbox.boxType = .square
        checkbox.cornerRadius = 8
        checkbox.stateChangeAnimation = .fill
        checkbox.tintColor = ApronAssets.colorsYello.color
        checkbox.secondaryTintColor = .gray
        checkbox.secondaryCheckmarkTintColor = .black
        return checkbox
    }()

    // MARK: - Setup Views

    private func setupViews() {
        backgroundColor = .clear
        selectionStyle = .none

        contentView.addSubview(containerView)
        containerView.addSubviews(
            sourceRecipsButton,
            ingredientNameLabel,
            measurementLabel,
            checkbox
        )
        setupConstraints()
    }

    private func setupConstraints() {
        containerView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(8)
            $0.leading.trailing.equalToSuperview().inset(16)
        }

        checkbox.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16)
            $0.centerY.equalTo(ingredientNameLabel.snp.centerY)
            $0.size.equalTo(24)
        }

        sourceRecipsButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(4)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalTo(checkbox.snp.leading).offset(-4)
        }

        ingredientNameLabel.snp.makeConstraints {
            $0.top.equalTo(sourceRecipsButton.snp.bottom).offset(4)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalTo(checkbox.snp.leading).offset(-4)
        }

        measurementLabel.snp.makeConstraints {
            $0.top.equalTo(ingredientNameLabel.snp.bottom).offset(4)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalTo(checkbox.snp.leading).offset(-4)
            $0.bottom.equalToSuperview().inset(4)
        }
    }

    // MARK: - Public methods

    func configure(item: CartItem) {
        sourceRecipsButton.text = item.recipeName?.first ?? ""
        ingredientNameLabel.text = item.productName
        measurementLabel.text = "\(item.amount ?? 0) \(item.measurement ?? "")"
    }
}
