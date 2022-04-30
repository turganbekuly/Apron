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

    private let arrowState: ArrowState

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

    public init(arrowState: ArrowState = .none, frame: CGRect = .zero) {
        self.arrowState = arrowState

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
        setBackgroundColor(.black.withAlphaComponent(0.5), for: .disabled)
        setBackgroundColor(.black, for: .normal)
        setBackgroundColor(.black.highlighted, for: .highlighted)
        setTitleColor(.white, for: .disabled)
        setTitleColor(.white, for: .normal)
        tintColor = isEnabled ? .black : .black.withAlphaComponent(0.5)
    }
}
