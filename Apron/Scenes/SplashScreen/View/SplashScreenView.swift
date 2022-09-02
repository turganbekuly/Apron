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

    private lazy var animationView = AnimationView(name: "splash_lottie_animation")

    // MARK: - SetupViews

    private func setupViews() {
        backgroundColor = .clear
        [animationView].forEach { addSubview($0) }
        setupConstraints()
        animationView.loopMode = .playOnce
        animationView.animationSpeed = 1
        animationView.play() { [weak self] _ in
            self?.delegate?.animationDidFinished()
        }
        animationView.contentMode = .scaleAspectFill
    }

    private func setupConstraints() {
        animationView.snp.makeConstraints {
            $0.centerX.equalToSuperview().offset(7)
            $0.centerY.equalToSuperview().offset(-12)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(250)
        }
    }
}
