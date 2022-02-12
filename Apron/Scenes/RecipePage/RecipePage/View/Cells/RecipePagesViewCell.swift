//
//  RecipePagesViewCell.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 03.02.2022.
//

import UIKit
import DesignSystem

final class RecipePagesViewCell: UITableViewCell {
    // MARK: - Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup Views

    private func setupViews() {
        backgroundColor = .clear
    }

    // MARK: - Public method

    func addChildViewController(viewController: UIViewController, to view: UIViewController) {
        view.addChild(viewController)
        contentView.addSubview(viewController.view)
        viewController.view.snp.makeConstraints {
            $0.top.equalToSuperview().offset(24)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        viewController.didMove(toParent: view)
    }
}
