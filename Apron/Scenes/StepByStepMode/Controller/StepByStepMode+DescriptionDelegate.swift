//
//  StepByStepMode+DescriptionDelegate.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 30.08.2022.
//

import Foundation
import Storages
import Models
import AVFoundation
import UIKit
import AlertMessages

enum AlertHandlerType {
    case stopFromCell(instruction: RecipeInstruction)
    case stopFromMain(instruction: RecipeInstruction)
}

extension StepByStepModeViewController: StepDescriptionCellProtocol {
    func ingredientsTapped() {
        // navigate to ingredients
    }

    func startTimer(with stepCount: Int, with instruction: RecipeInstruction) {
        if TimerScheduleManager.shared.isTaskRunning(instruction: instruction) {
            self.handleAlert(with: .stopFromCell(
                instruction: instruction),
                             stepCount: stepCount,
                             timerView: nil
            )
            return
        }
        self.cellStepCount = stepCount
        self.cellInstruction = instruction
        let viewController = AssignBottomSheetBuilder(state: .initial(.timer("\(stepCount)"), self)).build()
        DispatchQueue.main.async {
            self.navigationController?.presentPanModal(viewController)
        }
    }

    private func handleAlert(with type: AlertHandlerType, stepCount: Int, timerView: StepByStepTimerView?) {
        var confirm: AlertActionInfo
        switch type {
        case let .stopFromCell(instruction):
            confirm = AlertActionInfo(
                title: "Да",
                type: .normal,
                action: {
                    TimerScheduleManager.shared.stopTimer(instruction: instruction)
                    for subview in self.stackView.subviews {
                        if (subview as? StepByStepTimerView)?.instruction == instruction {
                            self.stackView.safeRemoveArrangedSubview(subview)
                        }
                    }
                }
            )
        case let .stopFromMain(instruction):
            confirm = AlertActionInfo(
                title: "Да",
                type: .normal,
                action: {
                    guard let timerView = timerView else {
                        return
                    }
                    TimerScheduleManager.shared.stopTimer(instruction: instruction)
                    self.show(type: .error("Таймер шага №\(stepCount) остановлен"))
                    self.stackView.safeRemoveArrangedSubview(timerView)
                }
            )
        }
        let cancel = AlertActionInfo(
            title: "Нет",
            type: .cancel,
            action: { }
        )

        showAlert(
            "Вы точно хотите остановить таймер?",
            message: "",
            actions: [confirm, cancel]
        )
    }

    private func playSound() {
        guard let path = Bundle.main.path(forResource: "timer_alarm_sound_2", ofType:"wav") else {
            return }
        let url = URL(fileURLWithPath: path)

        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()

        } catch let error {
            print(error.localizedDescription)
        }
    }
}

extension StepByStepModeViewController: StepFinalStepCellProtocol {
    func addCommentTapped() {
        delegate?.reviewButtonTapped()
        dismiss(animated: false)
    }
}

extension StepByStepModeViewController: AssignTypesSelectedDelegate {
    func didSelected(type: AssignTypes) {
        switch type {
        case .timer(let string):
            let timerView = StepByStepTimerView()
            timerView.configure(
                title: "Шаг №\(cellStepCount)",
                instruction: cellInstruction,
                duration: Double(string) ?? 0.0
            )
            timerView.onStopTimer = { [weak self] instr in
                guard let self = self else { return }
                self.handleAlert(with: .stopFromMain(
                    instruction: instr),
                                 stepCount: self.cellStepCount,
                                 timerView: timerView
                )
            }
            timerView.onTimerFinished = { [weak self] in
                guard let self = self else { return }
                self.show(type: .error("Таймер шага №\(self.cellStepCount) завершен"))
                self.playSound()
                self.stackView.safeRemoveArrangedSubview(timerView)
            }
            UIView.animate(withDuration: 0.3, animations: {
                self.stackView.addArrangedSubview(timerView)
                self.stackView.layoutIfNeeded()
            }, completion: nil)
        default: break
        }
    }
}
