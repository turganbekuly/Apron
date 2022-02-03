//
//  InstructionsPageViewController.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 29/01/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import DesignSystem
import UIKit

protocol InstructionsPageDisplayLogic: AnyObject {
    
}

final class InstructionsPageViewController: ViewController {
    
    struct Section {
        enum Section {
            case steps
        }
        enum Row {
            case step(IInstructionCellViewModel)
        }
        
        let section: Section
        let rows: [Row]
    }
    
    // MARK: - Properties
    let interactor: InstructionsPageBusinessLogic
    var sections: [Section] = [] {
        didSet {
            mainView.reloadData()
        }
    }
    var state: State {
        didSet {
            updateState()
        }
    }

    var steps = [
        InstructionCellViewModel(
            stepCount: "1",
            stepDescription: "Подготовить продукты."
        ),
        InstructionCellViewModel(
            stepCount: "2",
            stepDescription: "Вскипятить 2,5 литра воды с лавровым листом и солью.."
        ),
        InstructionCellViewModel(
            stepCount: "3",
            stepDescription: "Тем временем очистить картофель и нарезать кубиками."
        ),
        InstructionCellViewModel(
            stepCount: "4",
            stepDescription: "В кипящую воду опустить картофель (лавровый лист вынуть). Варить картофель 15 минут."
        ),
        InstructionCellViewModel(
            stepCount: "5",
            stepDescription: "Лук почистить и нарезать кубиками."
        ),
        InstructionCellViewModel(
            stepCount: "6",
            stepDescription: "Грибы нарезать пластинками или кубикам."
        ),
        InstructionCellViewModel(
            stepCount: "7",
            stepDescription: "Нагреть сковороду с растительным маслом. Обжарить лук, помешивая, на среднем огне до румяности."
        ),
        InstructionCellViewModel(
            stepCount: "8",
            stepDescription: "Нагреть сковороду с растительным маслом. Обжарить лук, помешивая, на среднем огне до румяности."
        ),
    ]
    
    // MARK: - Views
    lazy var mainView: InstructionsPageView = {
        let view = InstructionsPageView()
        view.dataSource = self
        view.delegate = self
        view.isScrollEnabled = false
        return view
    }()
    
    // MARK: - Init
    init(interactor: InstructionsPageBusinessLogic, state: State) {
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
        navigationItem.title = ""
    }
    
    private func configureViews() {
        [mainView].forEach { view.addSubview($0) }
        
        configureColors()
        makeConstraints()
    }
    
    private func makeConstraints() {
        mainView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func configureColors() {
        
    }
    
    deinit {
        NSLog("deinit \(self)")
    }
    
}
