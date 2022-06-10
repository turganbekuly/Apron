//
//  InstructionView.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 01.03.2022.
//

import UIKit
import APRUIKit

final class InstructionView: UIView {
    // MARK: - Init

    init(
        counter: Int,
        description: String
    ) {
        super.init(frame: .zero)

        self.stepCountLabel.text = "\(counter) шаг"
        self.textView.text = description

        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Views factory

    private lazy var stepCountLabel: UILabel = {
        let label = UILabel()
        label.textColor = ApronAssets.gray.color
        label.font = TypographyFonts.regular14
        return label
    }()

    private lazy var textView: UILabel = {
        let label = UILabel()
        label.font = TypographyFonts.regular14
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()

    private lazy var separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = ApronAssets.lightGray2.color
        return view
    }()

    // MARK: - Setup Views

    private func setupViews() {
        backgroundColor = .clear
        [stepCountLabel, textView, separatorView].forEach { addSubview($0) }
        setupConstraints()
    }

    private func setupConstraints() {
        separatorView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(1)
        }

        stepCountLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(22)
        }

        textView.snp.makeConstraints {
            $0.top.equalTo(stepCountLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.greaterThanOrEqualTo(separatorView.snp.top).offset(-12)
        }
    }
}

