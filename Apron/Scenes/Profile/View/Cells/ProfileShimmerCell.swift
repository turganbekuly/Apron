//
//  ProfileShimmerCell.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 17.07.2022.
//

import APRUIKit
import UIKit

final class ProfileShimmerCell: UITableViewCell {
    // MARK: - Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Views factory

    private lazy var userImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .center
        return view
    }()
}
