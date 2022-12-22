//
//  Snap+Extensions.swift
//  Extensions
//
//  Created by Akarys Turganbekuly on 17.03.2022.
//

import SnapKit

extension ConstraintViewDSL {
    public func matchSuperview(insets: UIEdgeInsets = .zero, closure: ((ConstraintMaker) -> Void)? = nil) {
        makeConstraints { make in
            make.matchSuperview(insets: insets)
            closure?(make)
        }
    }

    public func matchView(_ view: UIView, insets: UIEdgeInsets = .zero) {
        makeConstraints { make in
            make.matchView(view.snp, insets: insets)
        }
    }
}

private extension ConstraintMaker {
    public func matchSuperview(insets: UIEdgeInsets = .zero) {
        top.equalToSuperview().offset(insets.top)
        bottom.equalToSuperview().offset(-insets.bottom)
        trailing.equalToSuperview().offset(-insets.right)
        leading.equalToSuperview().offset(insets.left)
    }

    public func matchView(_ reference: ConstraintViewDSL, insets: UIEdgeInsets = .zero) {
        top.equalTo(reference.top).offset(insets.top)
        bottom.equalTo(reference.bottom).offset(-insets.bottom)
        trailing.equalTo(reference.trailing).offset(-insets.right)
        leading.equalTo(reference.leading).offset(insets.left)
    }
}
