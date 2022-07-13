//
//  SettingsAppCell.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 11.07.2022.
//

import UIKit
import APRUIKit

final class SettingsAppCell: UITableViewCell {
    // MARK: - Views factory

    private lazy var iconImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .center
        return view
    }()

    private lazy var titleLabel = UILabel()
    private lazy var arrowImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleToFill
        return view
    }()

    private lazy var separatorView = SeparatorView()

    // MARK: - Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)


    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }



    // MARK: - Methods

    func configure(with viewModel: SettingsCellViewModelProtocol) {
        arrowImageView.image = viewModel.arrowIcon
        iconImageView.image = viewModel.icon
        titleLabel.attributedText = viewModel.title
    }
}
