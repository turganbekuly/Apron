//
//  InstructionCell.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 29.01.2022.
//

import UIKit
import DesignSystem

final class InstructionCell: UITableViewCell {
    // MARK: - Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Views factory

    private lazy var stepCountLabel: UILabel = {
        let label = UILabel()
        label.textColor = Assets.gray.color
        label.font = TypographyFonts.regular14
        return label
    }()

    private lazy var textView: UITextView = {
        let textView = UITextView()
        textView.isEditable = false
        textView.font = TypographyFonts.regular14
        textView.textColor = .black
        textView.isScrollEnabled = false
        textView.backgroundColor = .clear
        return textView
    }()

    private lazy var separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = Assets.lightGray2.color
        return view
    }()

    // MARK: - Setup Views

    private func setupViews() {
        selectionStyle = .none
        backgroundColor = .clear
        [stepCountLabel, textView, separatorView].forEach { contentView.addSubview($0) }
        setupConstraints()
    }

    private func setupConstraints() {
        separatorView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(1)
        }

        stepCountLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(22)
        }

        textView.snp.makeConstraints {
            $0.top.equalTo(stepCountLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalTo(separatorView.snp.top).offset(-12)
        }
    }

    // MARK: - Methods

    func configure(with viewModel: IInstructionCellViewModel) {
        self.stepCountLabel.text = viewModel.stepCount + "шаг"
        self.textView.text = viewModel.stepDescription
    }
}
