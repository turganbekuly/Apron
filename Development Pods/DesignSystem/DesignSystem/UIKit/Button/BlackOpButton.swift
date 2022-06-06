//
//  BlackOpButton.swift
//  DesignSystem
//
//  Created by Akarys Turganbekuly on 20.02.2022.
//

import Extensions
import UIKit

public final class BlackOpButton: Button {
    public enum ArrowState {
        case none
        case left
        case right
    }

    public enum ButtonType {
        case blackBackground
        case whiteBackground
        case yelloBackground
    }

    private let arrowState: ArrowState
    private let backgroundType: ButtonType

    public override var isEnabled: Bool {
        didSet {
            configureColors()
        }
    }

    public override var isHighlighted: Bool {
        didSet {
            tintColor = .black.withAlphaComponent(0.7)
        }
    }

    // MARK: - Init

    public init(
        backgroundType: ButtonType = .blackBackground,
        arrowState: ArrowState = .none,
        frame: CGRect = .zero
    ) {
        self.arrowState = arrowState
        self.backgroundType = backgroundType

        super.init(frame: frame)
        configure()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Methods

    public override func titleRect(forContentRect contentRect: CGRect) -> CGRect {
        let rect = super.titleRect(forContentRect: contentRect)
        let imageRect = super.imageRect(forContentRect: contentRect)
        switch arrowState {
        case .none:
            return rect
        case .left:
            return CGRect(
                origin: CGPoint(x: rect.origin.x - imageRect.width / 2, y: rect.origin.y),
                size: CGSize(width: rect.width, height: rect.height)
            )
        case .right:
            return CGRect(
                origin: CGPoint(x: rect.origin.x - imageRect.width / 2, y: rect.origin.y),
                size: CGSize(width: rect.width, height: rect.height)
            )
        }
    }

    override public func imageRect(forContentRect contentRect: CGRect) -> CGRect {
        let bounds = super.bounds
        let rect = super.imageRect(forContentRect: contentRect)
        switch arrowState {
        case .none:
            return rect
        case .left:
            return CGRect(
                origin: CGPoint(x: 16, y: rect.origin.y),
                size: CGSize(width: rect.width, height: rect.height)
            )
        case .right:
            return CGRect(
                origin: CGPoint(x: bounds.width - 16 - rect.height, y: rect.origin.y),
                size: CGSize(width: rect.width, height: rect.height)
            )
        }
    }

    private func configure() {
        titleLabel?.font = TypographyFonts.regular14
        switch arrowState {
        case .left:
            semanticContentAttribute = .forceLeftToRight
        case .right:
            semanticContentAttribute = .forceRightToLeft
        case .none:
            break
        }
        configureColors()
    }

    private func configureColors() {
        switch backgroundType {
        case .blackBackground:
            setBackgroundColor(.black.withAlphaComponent(0.5), for: .disabled)
            setBackgroundColor(.black, for: .normal)
            setBackgroundColor(.black.highlighted, for: .highlighted)
            setTitleColor(.white, for: .disabled)
            setTitleColor(.white, for: .normal)
            tintColor = isEnabled ? .black : .black.withAlphaComponent(0.5)
        case .whiteBackground:
            setBackgroundColor(.white.withAlphaComponent(0.5), for: .disabled)
            setBackgroundColor(.white, for: .normal)
            setBackgroundColor(.white.highlighted, for: .highlighted)
            setTitleColor(.black, for: .disabled)
            setTitleColor(.black, for: .normal)
            tintColor = isEnabled ? .white : .white.withAlphaComponent(0.5)
            layer.borderWidth = 1
            layer.borderColor = UIColor.black.cgColor
        case .yelloBackground:
            setBackgroundColor(ApronAssets.colorsYello.color.withAlphaComponent(0.5), for: .disabled)
            setBackgroundColor(ApronAssets.colorsYello.color, for: .normal)
            setBackgroundColor(ApronAssets.colorsYello.color.highlighted, for: .highlighted)
            setTitleColor(.black, for: .disabled)
            setTitleColor(.black, for: .normal)
            tintColor = isEnabled ? ApronAssets.colorsYello.color : ApronAssets.colorsYello.color.withAlphaComponent(0.5)
            layer.borderWidth = 1
            layer.borderColor = ApronAssets.colorsYello.color.cgColor
        }
    }
}
