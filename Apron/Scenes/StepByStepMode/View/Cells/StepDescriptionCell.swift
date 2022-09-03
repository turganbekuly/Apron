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
    func timerDidFinish(stepNumber: Int)
    func ingredientsTapped()
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
    private var stepCount = 0
    private var instruction = RecipeInstruction()
    private var timer = TimerScheduleManager.shared
    private var buttonState: ButtonState = .initial {
        didSet {
            switch buttonState {
            case .initial:
                timerButton.configure(with: .timer(counter: "Начать таймер"))
                timer.stopTimer(instruction: self.instruction)
            case .ongoing:
                timer.startTimer(instruction: self.instruction) { progress, seconds, isFinished, instr in
                    guard instr == self.instruction else {
                        self.buttonState = .initial
                        return
                    }
                    self.observeTimer(progress: progress, seconds: seconds, isFinished: isFinished)
                    if isFinished {
                        self.delegate?.timerDidFinish(stepNumber: self.stepCount)
                    }
                }

                UIView.animate(withDuration: 0.3, animations: {
                    self.timerButtonWidth?.update(offset: 100)
                    self.layoutIfNeeded()
                }, completion: nil)
            case .stopped:
                UIView.animate(withDuration: 0.3, animations: {
                    self.timerButtonWidth?.update(offset: 100)
                    self.layoutIfNeeded()
                }, completion: nil)
                timerButton.configure(with: .timer(counter: String(format: "%02d:%02d:%02d", 0, 0, 0)))
            }
        }
    }

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
        label.font = TypographyFonts.bold20
        label.numberOfLines = 0
        label.sizeToFit()
        return label
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
        return scrollView
    }()

    private lazy var scrollContentView = UIView()

    private lazy var timerButton: StepStickyBottomButton = {
        let timerView = StepStickyBottomButton()
        timerView.addGestureRecognizer(
            UITapGestureRecognizer(
                target: self,
                action: #selector(startTimerTapped)
            )
        )
        return timerView
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

    // MARK: - Setup Views

    private func setupViews() {
        contentView.addSubviews(scrollView, timerButton, ingredientsButton)
        scrollView.addSubview(scrollContentView)
        scrollContentView.addSubview(stackView)
        makeContraints()
        timer.setDuration(Double(counter))
        ingredientsButton.configure(with: .ingredient)
    }

    private func makeContraints() {
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        scrollContentView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.leading.trailing.bottom.width.equalToSuperview()
        }

        stackView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }

        imageView.snp.makeConstraints {
            $0.height.equalTo(UIScreen.main.bounds.width)
        }

        for view in stackView.arrangedSubviews {
            view.snp.makeConstraints {
                $0.width.equalToSuperview()
            }
        }

        timerButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16)
            $0.leading.equalTo(snp.centerX).offset(8)
            $0.bottom.equalToSuperview().inset(16)
            timerButtonWidth = $0.width.greaterThanOrEqualTo(150).constraint
            $0.height.equalTo(38)
        }

        ingredientsButton.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalTo(snp.centerX).offset(-8)
            $0.bottom.equalToSuperview().inset(16)
            $0.height.equalTo(38)
        }
    }

    // MARK: - User actions

    @objc
    private func ingredientsTapped() {
        delegate?.ingredientsTapped()
    }

    @objc
    private func startTimerTapped() {
        switch buttonState {
        case .initial:
            buttonState = .ongoing
        case .ongoing:
            buttonState = .stopped
        case .stopped:
            buttonState = .ongoing
        }
    }

    private func observeTimer(progress: CGFloat, seconds: TimeInterval, isFinished: Bool) {
        guard timer.isTaskRunning(instruction: instruction) else {
            buttonState = .initial
            return
        }
        let duration = timer.getDuration()
        var h: Int
        var m: Int
        var s: Int

        let counter = (Int(duration) - Int(seconds))
        h = counter / 3600
        m = (counter % 3600) / 60
        s = (counter % 3600) % 60
        timerButton.configure(with: .timer(counter: String(format: "%02d:%02d:%02d", h, m, s)))
    }

    // MARK: - Methods

    func configure(with viewModel: StepDescriptionViewModelProtocol) {
        guard let instruction = viewModel.recipeInstruction else { return }
        self.instruction = instruction
        self.stepCount = viewModel.stepCount
        stackView.removeAllArrangedSubviews()
        if let image = instruction.image {
            imageView.kf.setImage(with: URL(string: image))
            stackView.addArrangedSubview(imageView)
        }
        recipeDescriptionLabel.text = instruction.description
        stackView.addArrangedSubview(recipeDescriptionLabel)
        stackView.layoutIfNeeded()

        timer.observe(instruction: instruction) { progress, seconds, isFinished, instr in
//            guard let task = self.timer.taskProgress(instruction: self.instruction) else {
//                self.buttonState = .initial
//                return
//            }
            self.observeTimer(progress: progress, seconds: seconds, isFinished: isFinished)
            if isFinished {
                self.delegate?.timerDidFinish(stepNumber: self.stepCount)
            }
        }
    }
}
