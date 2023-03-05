//
//  SearchBar.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 14.01.2022.
//

import APRUIKit
import UIKit

public final class SearchBar: UISearchBar {

    // MARK: - Init

    override public init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    public required init?(coder: NSCoder) {
        nil
    }

    // MARK: - Life Cycle

    override public func layoutSubviews() {
        super.layoutSubviews()

//        setShowsCancelButton(false, animated: false)
    }

    // MARK: - Methods

    private func configure() {
        textField?.font = TypographyFonts.regular12
        setImage(ApronAssets.navSearchIcon.image, for: .search, state: .normal)
        setImage(ApronAssets.searchClearButton.image, for: .clear, state: .normal)
        setSearchFieldBackgroundImage(ApronAssets.searchRoundedView.image.withRenderingMode(.alwaysOriginal), for: .normal)
        searchTextPositionAdjustment = UIOffset(horizontal: 8.0, vertical: 0.0)
        setPositionAdjustment(UIOffset(horizontal: 10, vertical: 0), for: .search)
        configureColors()
    }

    private func configureColors() {
        backgroundColor = .clear
        searchBarStyle = .minimal
        textField?.backgroundColor = .clear
        tintColor = ApronAssets.gray.color
    }

}
