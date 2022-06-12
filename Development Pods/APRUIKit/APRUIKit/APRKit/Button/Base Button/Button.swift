//
//  Button.swift
//  DesignSystem
//
//  Created by Akarys Turganbekuly on 18.01.2022.
//

import UIKit

public class Button: UIButton {
    public struct BorderConfig {
        public let width: CGFloat
        public let normalColor: CGColor
        public let disabledColor: CGColor
        public let highlightedColor: CGColor

        public func colorFor(enabled: Bool, highlighted: Bool) -> CGColor {
            guard enabled else { return disabledColor }
            return highlighted ? highlightedColor : normalColor
        }
    }

    public struct BackgroundConfig {
        public var normalColor: UIColor?
        public var disabledColor: UIColor?
        public var highlightedColor: UIColor?

        public init(normalColor: UIColor? = nil, disabledColor: UIColor? = nil, highlightedColor: UIColor? = nil) {
            self.normalColor = normalColor
            self.disabledColor = disabledColor
            self.highlightedColor = highlightedColor
        }

        public func colorFor(enabled: Bool, highlighted: Bool) -> UIColor? {
            guard enabled else { return disabledColor }
            return highlighted ? highlightedColor : normalColor
        }
    }

    public struct ImageConfig {
        public let normalImage: UIImage?
        public let disabledImage: UIImage?
        public let highlightedImage: UIImage?

        public init(
            normalImage: UIImage? = nil,
            disabledImage: UIImage? = nil,
            highlightedImage: UIImage? = nil
        ) {
            self.normalImage = normalImage
            self.disabledImage = disabledImage
            self.highlightedImage = highlightedImage
        }

        public func imageFor(enabled: Bool, highlighted: Bool) -> UIImage? {
            guard enabled else { return disabledImage }
            return highlighted ? highlightedImage : normalImage
        }
    }

    public struct TextColorConfig {
        public let normalColor: UIColor?
        public let disabledColor: UIColor?
        public let highlightedColor: UIColor?

        public init(
            normalColor: UIColor? = nil,
            disabledColor: UIColor? = nil,
            highlightedColor: UIColor? = nil
        ) {
            self.normalColor = normalColor
            self.disabledColor = disabledColor
            self.highlightedColor = highlightedColor
        }

        public func colorFor(enabled: Bool, highlighted: Bool) -> UIColor? {
            guard enabled else { return disabledColor }
            return highlighted ? highlightedColor : normalColor
        }
    }

    public enum CornerRadiusType {
        case none
        case exact(CGFloat)
        case fullyRounded
    }

    // MARK: - Main

    override public var isEnabled: Bool {
        didSet {
            setupBorder()
            setupBackgroundColor()
            setupTextColor()
            setupImage()
        }
    }

    override public var isHighlighted: Bool {
        didSet {
            setupBorder()
            setupBackgroundColor()
            setupTextColor()
            setupImage()
        }
    }

    override public var isSelected: Bool {
        didSet {
            setupBorder()
            setupBackgroundColor()
            setupTextColor()
            setupImage()
        }
    }

    override public init(frame: CGRect = .zero) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    convenience init(title: String) {
        self.init()
        setTitle(title, for: .normal)
    }

    public var backgroundConfig: BackgroundConfig? {
        didSet {
            setupBackgroundColor()
        }
    }

    public var borderConfig: BorderConfig? {
        didSet {
            setupBorder()
        }
    }

    public var textColorConfig: TextColorConfig? {
        didSet {
            setupTextColor()
        }
    }

    public var imageConfig: ImageConfig? {
        didSet {
            setupImage()
        }
    }

    public var cornerRadiusType: CornerRadiusType = .none {
        didSet {
            if case .exact(let cornerRadius) = cornerRadiusType {
                layer.cornerRadius = cornerRadius
            }
        }
    }

    public func setupBackgroundColor() {
        guard let config = backgroundConfig else { return }
        backgroundColor = config.colorFor(enabled: isEnabled, highlighted: isHighlighted || isSelected)
    }

    private func setupBorder() {
        guard let config = borderConfig else { return }
        layer.borderColor = config.colorFor(enabled: isEnabled, highlighted: isHighlighted || isSelected)
        layer.borderWidth = config.width
    }

    private func setupTextColor() {
        guard let config = textColorConfig else { return }
        let color = config.colorFor(enabled: isEnabled, highlighted: isHighlighted || isSelected)
        setTitleColor(color, for: state)
    }

    private func setupImage() {
        guard let config = imageConfig else { return }
        let image = config.imageFor(enabled: isEnabled, highlighted: isHighlighted || isSelected)
        setImage(image, for: state)
    }

    override public func layoutSubviews() {
        super.layoutSubviews()
        setupBorder()
        setupBackgroundColor()
        if case .fullyRounded = cornerRadiusType {
            layer.cornerRadius = bounds.height / 2
        }
    }
}
