//
//  CategorySelectionCell.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 10.05.2022.
//

import UIKit
import DesignSystem
import M13Checkbox
import HapticTouch
import Models

final class CategorySelectionCell: UITableViewCell {
    // MARK: - Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Views factory

    lazy var checkbox: M13Checkbox = {
        let checkbox = M13Checkbox()
        checkbox.boxType = .square
        checkbox.cornerRadius = 8
        checkbox.stateChangeAnimation = .fill
        checkbox.tintColor = Assets.colorsYello.color
        checkbox.secondaryTintColor = .gray
        checkbox.secondaryCheckmarkTintColor = .black
        checkbox.isUserInteractionEnabled = false
        return checkbox
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.textColor = .black
        label.font = TypographyFonts.regular16
        return label
    }()

    private lazy var containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        return view
    }()

    // MARK: - Setup Views

    private func setupViews() {
        contentView.isUserInteractionEnabled = true
        backgroundColor = .clear
        selectionStyle = .none
        [checkbox, titleLabel].forEach { contentView.addSubview($0) }
        setupConstraints()
    }

    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalTo(checkbox.snp.leading).offset(-16)
            make.top.equalTo(checkbox.snp.top)
            make.bottom.equalTo(checkbox.snp.bottom)
        }
        checkbox.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 24, height: 24))
        }
    }

    // MARK: - Methods

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            checkbox.setCheckState(.checked, animated: true)
            containerView.backgroundColor = .white
            HapticTouch.generateSuccess()
        } else {
            checkbox.setCheckState(.unchecked, animated: true)
            containerView.backgroundColor = .clear
            HapticTouch.generateError()
        }
    }

    func configure(with category: CommunityCategory) {
        titleLabel.text = category.name
    }
}
