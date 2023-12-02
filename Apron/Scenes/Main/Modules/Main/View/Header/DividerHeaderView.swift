//
//  DividerHeaderView.swift
//  Apron
//
//  Created by Акарыс Турганбекулы on 02.12.2023.
//

import UIKit
import APRUIKit

final class DividerHeaderView: UICollectionReusableView {
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Views factory
    
    private lazy var dividerView = SeparatorView()
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = TypographyFonts.semibold18
        label.textColor = .black
        label.textAlignment = .left
        label.text = "Недавние рецепты"
        return label
    }()
    
    // MARK: - Setup Views
    
    private func setupViews() {
        addSubviews(titleLabel)
        makeConstraints()
    }
    
    private func makeConstraints() {
        titleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(16)
        }
    }
}
