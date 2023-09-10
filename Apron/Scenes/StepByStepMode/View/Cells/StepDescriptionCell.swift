//
//  StepDescriptionCell.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 24.08.2022.
//

import UIKit
import APRUIKit
import SnapKit
import Storages
import Models

protocol StepDescriptionCellProtocol: AnyObject {
    func ingredientsTapped()
    func startTimer(with stepCount: Int, with instruction: RecipeInstruction)
}

final class StepDescriptionCell: UICollectionViewCell {
    // MARK: - State

    enum ButtonState {
        case initial
        case ongoing
        case stopped
    }

    // MARK: - Properties

    weak var delegate: StepDescriptionCellProtocol?
    private var timerButtonWidth: Constraint?
    private var counter = 120
    private var stepCount = 0 {
        didSet {
            stepLabel.text = "\(L10n.Recipe.StepByStep.Timer.step) \(stepCount)"
        }
    }
    private var instruction = RecipeInstruction()

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupViews()
    }

    deinit {
        print("\(stepCount) deinited")
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        setNeedsLayout()
        layoutIfNeeded()

        let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)

        var frame = layoutAttributes.frame
        frame.size.height = ceil(size.height)
        layoutAttributes.frame = frame

        return layoutAttributes
    }

    // MARK: - Views factory

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        return stackView
    }()

    private lazy var recipeDescriptionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .black
        label.font = TypographyFonts.regular18
        label.numberOfLines = 0
        label.sizeToFit()
        return label
    }()
    
    private lazy var stepLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = APRAssets.primaryTextMain.color
        label.font = TypographyFonts.extraBold24
        return label
    }()
    
    private lazy var roundedCornerView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = APRAssets.tableRoundedCorners.image
        return imageView
    }()

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 55, right: 0)
        scrollView.backgroundColor = .white
        return scrollView
    }()

    private lazy var scrollContentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()

    private lazy var ingredientsButton: StepStickyBottomButton = {
        let ingredientsView = StepStickyBottomButton()
        ingredientsView.addGestureRecognizer(
            UITapGestureRecognizer(
                target: self,
                action: #selector(ingredientsTapped)
            )
        )
        return ingredientsView
    }()

    private lazy var timerButton: StepStickyBottomButton = {
        let timerView = StepStickyBottomButton()
        timerView.addGestureRecognizer(
            UITapGestureRecognizer(
                target: self,
                action: #selector(timerButtonTapped)
            )
        )
        return timerView
    }()

    // MARK: - Setup Views

    private func setupViews() {
        backgroundColor = .clear
        contentView.addSubviews(scrollView)
        scrollView.addSubview(scrollContentView)
        scrollContentView.addSubviews(imageView, stepLabel, recipeDescriptionLabel, timerButton)
        imageView.addSubview(roundedCornerView)
        makeContraints()
        timerButton.configure(with: .timer)
//        ingredientsButton.configure(with: .ingredient)
    }

    private func makeContraints() {
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        scrollContentView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.leading.trailing.bottom.width.equalToSuperview()
        }
        
        imageView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(UIScreen.main.bounds.width / 1.4)
        }
        
        stepLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom)
            $0.leading.trailing.equalToSuperview().inset(8)
        }
        
        roundedCornerView.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(24)
        }
        
        recipeDescriptionLabel.snp.makeConstraints {
            $0.top.equalTo(stepLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(8)
        }

        timerButton.snp.makeConstraints {
            $0.top.equalTo(recipeDescriptionLabel.snp.bottom).offset(8)
            $0.leading.equalToSuperview().offset(8)
            $0.bottom.equalToSuperview().inset(16)
            $0.height.equalTo(38)
        }

//        ingredientsButton.snp.makeConstraints {
//            $0.top.equalTo(stackView.snp.bottom).offset(8)
//            $0.leading.equalToSuperview().offset(16)
//            $0.trailing.equalTo(snp.centerX).offset(-8)
//            $0.bottom.equalToSuperview().inset(16)
//            $0.height.equalTo(38)
//        }
    }

    // MARK: - User actions

    @objc
    private func ingredientsTapped() {
        delegate?.ingredientsTapped()
    }

    @objc
    private func timerButtonTapped() {
        delegate?.startTimer(with: stepCount, with: instruction)
    }

    // MARK: - Methods

    func configure(with viewModel: StepDescriptionViewModelProtocol) {
        guard let instruction = viewModel.recipeInstruction else { return }
        self.instruction = instruction
        self.stepCount = viewModel.stepCount
        imageView.kf.setImage(with: URL(string: instruction.image ?? ""), placeholder: APRAssets.iconPlaceholderCard.image)
        recipeDescriptionLabel.text = instruction.description
    }
}
