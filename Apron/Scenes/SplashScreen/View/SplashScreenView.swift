//
//  SplashScreenView.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 20/01/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import UIKit
import APRUIKit
import Lottie

protocol ISplashScreenView: AnyObject {
    func animationDidFinished()
}

final class SplashScreenView: UIView {
    // MARK: - Properties

    weak var delegate: ISplashScreenView?

    // MARK: - Init

    init(delegate: ISplashScreenView?) {
        self.delegate = delegate

        super.init(frame: .zero)

        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Views factory

    private lazy var backgroundImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "moca-5")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    private lazy var logoImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "moca_logo_green_background")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 20
        return imageView
    }()

    // MARK: - SetupViews

    private func setupViews() {
        backgroundColor = .clear
        [backgroundImage].forEach { addSubview($0) }
        backgroundImage.addSubview(logoImage)
        setupConstraints()
    }

    private func setupConstraints() {
        backgroundImage.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        logoImage.snp.makeConstraints {
            $0.size.equalTo(135)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(safeAreaLayoutGuide.snp.top).offset(45)
        }
    }

    // MARK: - Methods

    func configure() {
        CATransaction.begin()
        CATransaction.setCompletionBlock {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.delegate?.animationDidFinished()
            }
        }

        let slideInFromLeftTransition = CATransition()
        slideInFromLeftTransition.type = .push
        slideInFromLeftTransition.subtype = .fromRight
        slideInFromLeftTransition.duration = 0.7
        slideInFromLeftTransition.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        slideInFromLeftTransition.fillMode = .removed
        logoImage.layer.add(slideInFromLeftTransition, forKey: "slideInFromRightTransition")
        CATransaction.commit()
    }
}
