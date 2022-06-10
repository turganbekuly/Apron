//
//  ScreenCounterNavigationView.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 06.01.2022.
//

import APRUIKit
import UIKit

final class ScreenCounterNavigationView: UIView {
    // MARK: - Properties

    var currectPage: String

    // MARK: - Init

    init(currectPage: String) {
        self.currectPage = currectPage

        super.init(frame: .zero)

        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Views factory

    lazy var pageCounterTitle: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        let firstAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.black, .font: TypographyFonts.bold16]
        let secondAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.black, .font: TypographyFonts.regular16]
        let firstParenthsis = NSMutableAttributedString(string: "(", attributes: secondAttributes)
        let firstString = NSMutableAttributedString(string: currectPage, attributes: firstAttributes)
        let secondString = NSMutableAttributedString(string: "/3)", attributes: secondAttributes)
        firstParenthsis.append(firstString)
        firstParenthsis.append(secondString)
        label.attributedText = firstParenthsis
        return label
    }()

    // MARK: - Setup Views

    private func setupViews() {
        addSubview(pageCounterTitle)
        setupConstraints()
    }

    private func setupConstraints() {
        pageCounterTitle.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
