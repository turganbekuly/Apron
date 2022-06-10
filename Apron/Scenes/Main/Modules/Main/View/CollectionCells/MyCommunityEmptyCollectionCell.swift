//
//  MyCommunityEmptyCollectionCell.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 26.05.2022.
//

import APRUIKit
import UIKit
import Kingfisher
import HapticTouch
import Storages


final class MyCommunityEmptyCollectionCell: UICollectionViewCell {
    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Views factory

    lazy var emptyLabelTitle: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        let firstAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: ApronAssets.lightGray.color, .font: TypographyFonts.regular12]
        let secondAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.black, .font: TypographyFonts.semibold12]
        let firstString = NSMutableAttributedString(string: "Вы пока еще не вступили не в одно сообщество.\nУзнать ", attributes: firstAttributes)
        let secondString = NSAttributedString(string: "подробнее о сообществах", attributes: secondAttributes)
        firstString.append(secondString)
        label.attributedText = firstString
        label.numberOfLines = 2
        return label
    }()


    // MARK: - Setup Views

    private func setupViews() {
        backgroundColor = .clear
        [emptyLabelTitle].forEach { contentView.addSubview($0) }
        setupConstraints()
        configureCell()
    }

    private func setupConstraints() {
        emptyLabelTitle.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    private func configureCell() {
        backgroundColor = .clear
    }
}

