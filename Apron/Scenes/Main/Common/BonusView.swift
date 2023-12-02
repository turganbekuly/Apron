//
//  BonusView.swift
//  Apron
//
//  Created by Акарыс Турганбекулы on 22.10.2023.
//

import UIKit
import APRUIKit
import Storages
import Models

final class BonusView: View {
    // MARK: - Properties
    
    var onBonusButtonTapped: (() -> Void)?

    private var userStorage: UserStorageProtocol = UserStorage()
    private let provider = AKNetworkProvider<ProfileEndpoint>()
    
    // MARK: - Views factory
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 15
        view.clipsToBounds = true
        view.isUserInteractionEnabled = true
        view.backgroundColor = APRAssets.primaryTextMain.color
        return view
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = APRAssets.bonusIconWhite.image
        return imageView
    }()
    
    private lazy var bonusLabel: UILabel = {
        let label = UILabel()
        label.font = TypographyFonts.bold14
        label.textColor = .white
        label.numberOfLines = 1
        label.textAlignment = .left
        label.text = 0.roundedWithAbbreviations
        return label
    }()
    
    // MARK: - Setup Views
    
    override func setupViews() {
        super.setupViews()
        backgroundColor = .clear
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(bonusButtonTapped))
        containerView.addGestureRecognizer(tapGR)
        addSubview(containerView)
        containerView.addSubviews(imageView, bonusLabel)
        
        if let bonus = userStorage.user?.bonusAmount {
            self.bonusLabel.text = userStorage.user?.bonusAmount?.roundedWithAbbreviations
            getBonus { [weak self] bonusAmount in
                self?.bonusLabel.text = bonusAmount?.roundedWithAbbreviations
            }
        }
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        snp.makeConstraints {
            $0.width.greaterThanOrEqualTo(50)
            $0.height.equalTo(30)
        }
        
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        imageView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(8)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(18)
        }
        
        bonusLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview().offset(2)
            $0.leading.equalTo(imageView.snp.trailing)
            $0.trailing.equalToSuperview().inset(8)
        }
    }
    
    // MARK: - User actions
    
    @objc
    private func bonusButtonTapped() {
        onBonusButtonTapped?()
    }
}

private extension BonusView {
    private func getBonus(completion: @escaping ((Int?) -> Void)) {
        provider.send(target: .getProfile) { result in
            switch result {
            case let .success(json):
                if let json = User(json: json) {
                    self.userStorage.user = json
                    completion(json.bonusAmount)
                }
            case .failure:
                break
            }
        }
    }
}

extension Int {
    var roundedWithAbbreviations: String {
        let number = Double(self)
        let thousand = number / 1000
        let million = number / 1000000
        if million >= 1.0 {
            return "\(round(million*10)/10)M"
        }
        else if thousand >= 1.0 {
            return "\(round(thousand*10)/10)K"
        }
        else {
            return "\(self)"
        }
    }
}
