//
//  BonusView.swift
//  Apron
//
//  Created by Акарыс Турганбекулы on 22.10.2023.
//

import UIKit
import APRUIKit

final class BonusView: View {
    // MARK: - Properties
    
    var onBonusButtonTapped: (() -> Void)?
    
    // MARK: - Views factory
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .clear
        imageView.layer.cornerRadius = 15
        imageView.image = APRAssets.bonusView.image
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    // MARK: - Setup Views
    
    override func setupViews() {
        super.setupViews()
        backgroundColor = .clear
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(bonusButtonTapped))
        imageView.addGestureRecognizer(tapGR)
        addSubview(imageView)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        snp.makeConstraints {
            $0.width.equalTo(80)
            $0.height.equalTo(30)
        }
        
        imageView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(4)
        }
    }
    
    // MARK: - User actions
    
    @objc
    private func bonusButtonTapped() {
        onBonusButtonTapped?()
    }
}
