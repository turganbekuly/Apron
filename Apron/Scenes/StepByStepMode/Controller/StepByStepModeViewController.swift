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

protocol StepByStepModeDisplayLogic: AnyObject {
    
}

final class StepByStepModeViewController: ViewController, Messagable {
    
    struct Section {
        enum Section {
            case instructions
            case review
        }
        enum Row {
            case instruction(RecipeInstruction)
            case review
        }
        
        let section: Section
        let rows: [Row]
    }

    struct StepperSection {
        enum Section {
            case steps
            case review
        }
        enum Row {
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
    var state: State {
        didSet {
            updateState()
        }
    }

    var instructions: [RecipeInstruction] = [] {
        didSet {
            sections = [
                .init(section: .instructions, rows: instructions.compactMap { .instruction($0) }),
                .init(section: .review, rows: [.review])
            ]
            stepperSections = [
                .init(section: .steps, rows: Array(repeating: .step, count: instructions.count)),
                .init(section: .review, rows: [.review])
            ]
        }
    }
    
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
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        configureColors()
    }
    
    // MARK: - Methods
    private func configureNavigation() {
        navigationItem.title = "Режим готовки"
    }
    
    private func configureViews() {
        [mainView, stepperView, stackView].forEach { view.addSubview($0) }
        
        configureColors()
        makeConstraints()
    }
    
    private func makeConstraints() {
        stepperView.snp.makeConstraints {
            $0.bottom.leading.trailing.equalToSuperview()
            $0.height.equalTo(60)
        }

        mainView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(stepperView.snp.top)
        }

        stackView.snp.makeConstraints {
            $0.bottom.equalTo(stepperView.snp.top).offset(-8)
            $0.trailing.equalToSuperview()
            $0.width.equalTo(120)
        }
    }
    
    private func configureColors() {
        view.backgroundColor = ApronAssets.secondary.color
    }
    
    deinit {
        NSLog("deinit \(self)")
    }
    
}
