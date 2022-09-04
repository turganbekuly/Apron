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

extension StepByStepModeViewController: StepDescriptionCellProtocol {
    func ingredientsTapped() {
        // navigate to ingredients
    }

    func startTimer(with stepCount: Int, with instruction: RecipeInstruction) {
        if TimerScheduleManager.shared.isTaskRunning(instruction: instruction) {
            let confirm = AlertActionInfo(
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
            let cancel = AlertActionInfo(
                title: "Нет",
                type: .cancel,
                action: {
                    self.dismiss(animated: true)
                }
            )
            self.showAlert(
                "Вы точно хотите остановить таймер?",
                message: "",
                actions: [confirm, cancel]
            )
            return
        }
        let timerView = StepByStepTimerView()
        let duration = Double.random(in: 30...80)
        timerView.configure(title: "Шаг №\(stepCount)", instruction: instruction, duration: duration)
        timerView.onStopTimer = { [weak self] instr in
            guard let self = self else { return }
            TimerScheduleManager.shared.stopTimer(instruction: instr)
            self.show(type: .error("Таймер шага №\(stepCount) остановлен"))
            self.stackView.safeRemoveArrangedSubview(timerView)
        }
        timerView.onTimerFinished = { [weak self] in
            guard let self = self else { return }
            self.show(type: .error("Таймер шага №\(stepCount) завершен"))
            self.playSound()
            self.stackView.safeRemoveArrangedSubview(timerView)
        }
        UIView.animate(withDuration: 0.3, animations: {
            self.stackView.addArrangedSubview(timerView)
            self.stackView.layoutIfNeeded()
        }, completion: nil)
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
