//
//  StepByStepTimerView.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 03.09.2022.
//

import UIKit
import APRUIKit
import Storages
import Models

final class StepByStepTimerView: View {
    // MARK: - Properties

    var onStopTimer: ((RecipeInstruction) -> Void)?
    var onTimerFinished: (() -> Void)?
    var instruction = RecipeInstruction()
    var duration: Double = 0

    // MARK: - Views factory

    private lazy var containerView: UIView = {
        let view = UIView()
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        view.layer.cornerRadius = 22
        view.clipsToBounds = true
        view.backgroundColor = .black
        return view
    }()

    private lazy var timerTitleLabel: UILabel = {
        let label = UILabel()
        label.font = TypographyFonts.regular10
        label.textColor = .white
        label.textAlignment = .left
        return label
    }()

    private lazy var timerCounterLabel: UILabel = {
        let label = UILabel()
        label.font = TypographyFonts.semibold12
        label.textColor = .white
        label.textAlignment = .left
        return label
    }()

    private lazy var timerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = ApronAssets.recipeCookingTimeIcon.image.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = .white
        return imageView
    }()

    // MARK: - Setup views

    override func setupViews() {
        super.setupViews()
        addSubview(containerView)
        containerView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onStopTapped)))
        containerView.addSubviews(
            timerTitleLabel,
            timerCounterLabel,
            timerImageView
        )
    }

    override func setupConstraints() {
        super.setupConstraints()

        snp.makeConstraints {
            $0.height.equalTo(45)
        }

        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        timerImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(8)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(28)
        }

        timerTitleLabel.snp.makeConstraints {
            $0.top.equalTo(timerImageView.snp.top)
            $0.leading.equalTo(timerImageView.snp.trailing).offset(8)
            $0.trailing.equalToSuperview().inset(8)
        }

        timerCounterLabel.snp.makeConstraints {
            $0.bottom.equalTo(timerImageView.snp.bottom)
            $0.leading.equalTo(timerImageView.snp.trailing).offset(8)
            $0.trailing.equalToSuperview().inset(8)
        }
    }

    // MARK: - Private methods

    private func observeTimer(seconds: TimeInterval) {
        var h: Int
        var m: Int
        var s: Int

        let counter = (Int(duration) - Int(seconds))
        h = counter / 3600
        m = (counter % 3600) / 60
        s = (counter % 3600) % 60
        timerCounterLabel.text = String(format: "%02d:%02d:%02d", h, m, s)
    }

    // MARK: - User actions

    @objc
    private func onStopTapped() {
        onStopTimer?(instruction)
    }

    // MARK: - Mehods

    func configure(title: String, instruction: RecipeInstruction, duration: Double) {
        timerTitleLabel.text = title
        self.instruction = instruction
        self.duration = duration
        TimerScheduleManager.shared.startTimer(instruction: instruction, duration: duration) { progress, seconds, isFinished, instr in
            self.observeTimer(seconds: seconds)

            if isFinished {
                self.onTimerFinished?()
            }
        }
    }
}
