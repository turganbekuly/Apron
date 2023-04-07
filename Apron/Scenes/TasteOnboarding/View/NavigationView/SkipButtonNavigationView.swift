//
//  SkipButtonNavigationView.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 06.01.2022.
//

import APRUIKit
import UIKit

protocol ISkipButtonActionHander: AnyObject {
    func skipButtonTapped()
}

final class SkipButtonNavigationView: UIView {
    // MARK: - Properties

    weak var delegate: ISkipButtonActionHander?

    // MARK: - Init

    init(delegate: ISkipButtonActionHander?) {
        self.delegate = delegate
        super.init(frame: .zero)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Views factory

    lazy var skipButtonLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Пропустить"
        label.font = TypographyFonts.regular16
        label.textColor = .black
        label.isUserInteractionEnabled = true
        return label
    }()

    // MARK: - Setup Views

    private func setupViews() {
        isUserInteractionEnabled = true
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(buttonTapped))
        skipButtonLabel.addGestureRecognizer(tapGR)
        addSubview(skipButtonLabel)
        setupConstraints()
    }

    private func setupConstraints() {
        skipButtonLabel.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    // MARK: - Action Handler

    @objc
    private func buttonTapped() {
        delegate?.skipButtonTapped()
    }
}
