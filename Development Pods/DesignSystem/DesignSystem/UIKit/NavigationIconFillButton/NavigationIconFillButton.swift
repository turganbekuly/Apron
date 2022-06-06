//
//  NavigationIconFillButton.swift
//  DesignSystem
//
//  Created by Akarys Turganbekuly on 18.01.2022.
//

import UIKit
import SnapKit

public final class NavigationIconFillButton: UIView {
    // MARK: - Public properties

    public var icon: UIImage? {
        didSet {
            button.setImage(icon, for: .normal)
        }
    }

    public var color: UIColor? = ApronAssets.secondary.color {
        didSet {
            button.backgroundConfig = .init(
                normalColor: color,
                disabledColor: color?.withAlphaComponent(0.5),
                highlightedColor: ApronAssets.lightGray.color
            )
        }
    }

    // MARK: - Init

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - User actions

    public var onTouch: (() -> Void)?

    // MARK: - UI Elements

    private lazy var button = Button()

    // MARK: - Public properties

    override public var intrinsicContentSize: CGSize {
        return CGSize(width: 44, height: 44)
    }

    // MARK: - Configuration

    public func setupViews() {
        addSubview(button)
        button.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        button.backgroundConfig = .init(
            normalColor: ApronAssets.secondary.color,
            disabledColor: .white.withAlphaComponent(0.5),
            highlightedColor: ApronAssets.lightGray.color
        )

        button.addTarget(
            self,
            action: #selector(buttonTouched),
            for: .touchUpInside
        )

        layer.cornerRadius = 16
        clipsToBounds = true
    }

    @objc
    private func buttonTouched() {
        onTouch?()
    }
}
