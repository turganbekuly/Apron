//
//  RoundedTextView.swift
//  DesignSystem
//
//  Created by Akarys Turganbekuly on 08.04.2022.
//

import UIKit

public class RoundedTextView: UIView {
    // MARK: - Private properties

    private var placeholder: String?

    // MARK: - Init

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    public init(placeholder: String) {
        self.init()
        self.placeholder = placeholder
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Views factory

    private lazy var containerView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        return view
    }()

    public lazy var textView: PlaceholderTextView = {
        let textView = PlaceholderTextView()
        textView.backgroundColor = .clear
        textView.font = TypographyFonts.regular12
        textView.placeholder = placeholder
        return textView
    }()

    // MARK: - Setup Views

    private func setupViews() {
        backgroundColor = .clear
        addSubviews(containerView)
        containerView.addSubview(textView)
        setupConstraints()
    }

    private func setupConstraints() {
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        textView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(8)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
    }
}
