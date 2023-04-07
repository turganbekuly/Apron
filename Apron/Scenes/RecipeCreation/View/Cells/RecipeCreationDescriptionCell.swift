//
//  RecipeCreationDescriptionCell.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 08.04.2022.
//

import UIKit
import APRUIKit
import GrowingTextView

protocol DescriptionCellDelegate: AnyObject {
    func cell(_ cell: RecipeCreationDescriptionCell, didEnteredDesc descr: String?)
}

final class RecipeCreationDescriptionCell: UITableViewCell {
    // MARK: - Public properties

    weak var delegate: DescriptionCellDelegate?

    // MARK: - Private properties

    lazy var placeholder = "" {
        didSet {
            roudedTextView.textView.placeholder = placeholder
        }
    }

    // MARK: - Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Views factory

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = TypographyFonts.semibold17
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()

    private lazy var roudedTextView: RoundedTextView = {
        let textView = RoundedTextView()
        textView.textView.delegate = self
        return textView
    }()

    // MARK: - Setup Views

    private func setupViews() {
        selectionStyle = .none
        backgroundColor = .clear
        [titleLabel, roudedTextView].forEach { contentView.addSubview($0) }
        setupConstraints()
    }

    private func setupConstraints() {
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
        }

        roudedTextView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview()
        }
    }

    // MARK: - Public methods

    func configure(description: String?) {
        titleLabel.text = L10n.RecipeCreation.Recipe.description
        guard let description = description else {
            return
        }

        roudedTextView.textView.text = description
    }
}

extension RecipeCreationDescriptionCell: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        self.delegate?.cell(self, didEnteredDesc: textView.text)
    }
}
