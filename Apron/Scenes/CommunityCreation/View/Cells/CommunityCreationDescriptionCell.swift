//
//  CommunityCreationDescriptionCell.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 10.05.2022.
//

import UIKit
import APRUIKit

protocol CommunityDescriptionCellDelegate: AnyObject {
    func cell(_ cell: CommunityCreationDescriptionCell, didEnteredDesc descr: String?)
}

final class CommunityCreationDescriptionCell: UITableViewCell {
    // MARK: - Public properties

    weak var delegate: CommunityDescriptionCellDelegate?

    // MARK: - Private properties

    var placeholder = ""

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
        label.font = TypographyFonts.regular14
        label.textColor = .black
        label.textAlignment = .left
        label.text = "Описание"
        return label
    }()

    private lazy var roudedTextView: RoundedTextView = {
        let textView = RoundedTextView(placeholder: "О чем это сообщество?")
        textView.textView.delegate = self
        return textView
    }()

    // MARK: - Setup Views

    private func setupViews() {
        selectionStyle = .none
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
        roudedTextView.textView.text = description ?? ""
    }
}

extension CommunityCreationDescriptionCell: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        self.delegate?.cell(self, didEnteredDesc: textView.text)
    }
}

