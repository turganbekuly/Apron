//
//  StepByStepModeViewController.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 24/08/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import APRUIKit
import UIKit
import Models
import AlertMessages
import AVFoundation
import ALProgressView

protocol StepByStepModeDisplayLogic: AnyObject {

}

final class StepByStepModeViewController: ViewController {

    struct Section {
        enum Section {
            case ingredients
            case instructions
            case review
        }
        enum Row {
            case ingredient([RecipeIngredient])
            case instruction(RecipeInstruction)
            case review
        }

        let section: Section
        let rows: [Row]
    }

    struct StepperSection {
        enum Section {
            case ingredients
            case steps
            case review
        }
        enum Row {
            case ingredient
            case step
            case review
        }
        let section: Section
        let rows: [Row]
    }

    // MARK: - Properties
    var player: AVAudioPlayer?
    let interactor: StepByStepModeBusinessLogic
    var sections: [Section] = []
    var stepperSections: [StepperSection] = []
    var onStepperSelected = false
    var finalImage: String?
    var state: State {
        didSet {
            updateState()
        }
    }

    var instructions: [RecipeInstruction] = [] {
        didSet {
            sections = [
                .init(section: .ingredients, rows: [.ingredient(ingredients)]),
                .init(section: .instructions, rows: instructions.compactMap { .instruction($0) }),
                .init(section: .review, rows: [.review])
            ]
            stepperSections = [
                .init(section: .ingredients, rows: [.ingredient]),
                .init(section: .steps, rows: Array(repeating: .step, count: instructions.count)),
                .init(section: .review, rows: [.review])
            ]
        }
    }
    
    var ingredients: [RecipeIngredient] = []

    weak var delegate: StepByStepFinalStepProtocol?

    var cellStepCount = 0
    var cellInstruction = RecipeInstruction()

    // MARK: - Views
    lazy var mainView: StepByStepModeView = {
        let view = StepByStepModeView()
        view.dataSource = self
        view.delegate = self
        return view
    }()

    lazy var stepperView: StepByStepPagerView = {
        let view = StepByStepPagerView()
        view.dataSource = self
        view.delegate = self
        return view
    }()

    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.backgroundColor = .clear
        return stackView
    }()

    lazy var progressBar: ALProgressBar = {
        let view = ALProgressBar()
        view.startColor = APRAssets.mainAppColor.color.withAlphaComponent(0.8)
        view.endColor = APRAssets.mainAppColor.color
        view.duration = 1.5
        view.timingFunction = .easeOutExpo
        return view
    }()

    // MARK: - Init
    init(interactor: StepByStepModeBusinessLogic, state: State) {
        self.interactor = interactor
        self.state = state

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        return nil
    }

    // MARK: - Life Cycle
    override func loadView() {
        super.loadView()

        configureViews()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        state = { state }()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        configureNavigation()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        scrollViewDidEndDecelerating(mainView)
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        configureColors()
    }

    // MARK: - Methods
    private func configureNavigation() {
        navigationItem.title = L10n.Recipe.Cook.StepByStep.title
    }

    private func configureViews() {
        [mainView, stackView, progressBar].forEach { view.addSubview($0) }

        configureColors()
        makeConstraints()
    }

    private func makeConstraints() {
        progressBar.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(8)
            $0.top.equalToSuperview()
            $0.height.equalTo(10)
        }

        mainView.snp.makeConstraints {
            $0.top.equalTo(progressBar.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }

        stackView.snp.makeConstraints {
            $0.trailing.equalToSuperview()
            $0.width.equalTo(120)
            $0.bottom.equalTo(mainView.snp.bottom).offset(-24)
        }
    }

    private func configureColors() {
        view.backgroundColor = APRAssets.secondary.color
    }

    deinit {
        NSLog("deinit \(self)")
    }
}
