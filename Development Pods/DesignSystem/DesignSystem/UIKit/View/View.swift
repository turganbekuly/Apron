//
//  View.swift
//  DesignSystem
//
//  Created by Akarys Turganbekuly on 24.05.2022.
//

import UIKit

open class View: UIView {
    public init() {
        super.init(frame: .zero)
        setupViews()
        setupConstraints()
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }

    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    open func setupViews() {
        //
    }

    open func setupConstraints() {
        //
    }
}

