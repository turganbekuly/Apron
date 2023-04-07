//
//  AssignBottomSheetViewController.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 13/04/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import APRUIKit
import UIKit
import PanModal

final class AssignBottomSheetViewController: ViewController, PanModalPresentable {
    // MARK: - Properties

    var state: State {
        didSet {
            updateState()
        }
    }

    weak var delegate: AssignTypesSelectedDelegate?

    var type: AssignTypes?

    var selectedValue = ""
    let servingComponents = ["-"] + Array(1...99).map { "\($0)"}
    let hourComponents = Array(0...23).map { "\($0)" }
    let minComponments = Array(0...59).map { "\($0)" }
    let secComponents = Array(0...59).map { "\($0)" }
    let hourSeparator = L10n.Common.Measure.hours
    let minSeparator = L10n.Common.Measure.min
    let secSeparator = L10n.Common.Measure.seconds

    // MARK: - PanModal Properties

    var panScrollable: UIScrollView? {
        return nil
    }

    var longFormHeight: PanModalHeight {
        return .contentHeight(400)
    }

    var cornerRadius: CGFloat {
        return 25
    }

    var transitionDuration: Double {
        return 0.4
    }

    // MARK: - Views factory

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = TypographyFonts.semibold17
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()

    private lazy var subtitlLabel: UILabel = {
        let label = UILabel()
        label.font = TypographyFonts.regular12
        label.textColor = APRAssets.gray.color
        label.textAlignment = .left
        label.numberOfLines = 2
        return label
    }()

    private lazy var picker: UIPickerView = {
        let picker = UIPickerView()
        picker.delegate = self
        picker.dataSource = self
        return picker
    }()

    private lazy var saveButton: BlackOpButton = {
        let button = BlackOpButton()
        button.setTitle(L10n.Common.Save.title, for: .normal)
        button.backgroundType = .blackBackground
        button.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        button.layer.cornerRadius = 17
        button.layer.masksToBounds = true
        return button
    }()

    // MARK: - Init

    init(state: State) {
        self.state = state

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        return nil
    }

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        state = { state }()
        setupViews()
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        configureColors()
    }

    // MARK: - Methods

    // MARK: - Setup Views

    private func setupViews() {
        [titleLabel, subtitlLabel, picker, saveButton].forEach { view.addSubview($0) }
        switch type {
        case .servings:
            titleLabel.text = L10n.RecipeCreation.Recipe.ServingCount.title
            subtitlLabel.text = L10n.RecipeCreation.Recipe.ServingCount.subtitle
        case .cookTime:
            titleLabel.text = L10n.RecipeCreation.Recipe.CookTime.title
            subtitlLabel.text = L10n.RecipeCreation.Recipe.CookTime.subtitle
        case let .timer(step):
            titleLabel.text = L10n.Recipe.StepByStep.Timer.title
            subtitlLabel.text = "\(L10n.Recipe.StepByStep.Timer.step)\(step)"
        default: break
        }
        configureColors()
        setupConstraints()
    }

    private func setupConstraints() {
        saveButton.snp.makeConstraints {
            $0.bottom.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(16)
            $0.height.equalTo(38)
        }

        titleLabel.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview().inset(16)
        }

        subtitlLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
        }

        picker.snp.makeConstraints {
            $0.top.equalTo(subtitlLabel.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalTo(saveButton.snp.top).offset(-16)
        }
    }

    private func configureColors() {
        view.backgroundColor = APRAssets.secondary.color
    }

    deinit {
        NSLog("deinit \(self)")
    }

    // MARK: - User actions

    @objc
    private func saveButtonTapped() {
        dismiss(animated: true) {
            self.delegate?.didSelected(type: self.type ?? .servings(""))
        }
    }

}
