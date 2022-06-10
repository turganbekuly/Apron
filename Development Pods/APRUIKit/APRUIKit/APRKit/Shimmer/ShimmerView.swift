//
//  ShimmerView.swift
//  DesignSystem
//
//  Created by Akarys Turganbekuly on 08.01.2022.
//

import UIKit

open class ShimmerView: UIView {

    // MARK: - Init

    override public init(frame: CGRect) {
        super.init(frame: frame)

        startAnimating()
    }

    public required init?(coder: NSCoder) {
        nil
    }

    // MARK: - Methods

    public func startAnimating() {
        UIView.animate(
            withDuration: 0.6,
            delay: 0,
            options: [.autoreverse, .repeat, .curveEaseInOut],
            animations: { [weak self] in
                self?.alpha = 0.6
            },
            completion: nil
        )
    }

}

