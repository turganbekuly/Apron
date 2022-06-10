//
//  SeparatorView.swift
//  DesignSystem
//
//  Created by Akarys Turganbekuly on 21.05.2022.
//

import UIKit

public final class SeparatorView: UIView {

    public enum SeparatorViewType {
        case horizontal
        case vertial

        public var color: UIColor {
            switch self {
            default:
                return ApronAssets.lightGray2.color
            }
        }
    }

    // MARK: - Proeprties
    private let type: SeparatorViewType

    // MARK: - Init
    public init(type: SeparatorViewType = .vertial) {
        self.type = type

        super.init(frame: .zero)

        configure()
    }

    required init?(coder: NSCoder) {
        return nil
    }

    // MARK: - Life Cycle
    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        configureColors()
    }

    // MARK: - Setup Views
    
    private func setupConstraints() {

    }

    // MARK: - Methods
    private func configure() {
        configureColors()
    }

    private func configureColors() {
        backgroundColor = type.color
    }

}
