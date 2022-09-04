//
//  TimerScheduleManager.swift
//  Storages
//
//  Created by Akarys Turganbekuly on 31.08.2022.
//

import CoreGraphics
import QuartzCore
import Models

public class TimerScheduleManager {
    public typealias ProgressBlock = (
        _ progress: CGFloat,
        _ seconds: TimeInterval,
        _ isFinished: Bool,
        _ instruction: RecipeInstruction
    ) -> Void

    public struct ProgressInfo {
        public let progress: CGFloat
        public let seconds: Double
        public let instruction: RecipeInstruction
    }

    private init() { }

    private class Task {
        init(instruction: RecipeInstruction, displayLink: CADisplayLink) {
            self.instruction = instruction
            self.displayLink = displayLink
        }

        let instruction: RecipeInstruction
        let displayLink: CADisplayLink
        let startTime = CACurrentMediaTime()
        var progressBlock: ProgressBlock?
        var progress: CGFloat?
    }

    private class Duration {
        init(duration: Double, displayLink: CADisplayLink) {
            self.duration = duration
            self.displayLink = displayLink
        }

        let displayLink: CADisplayLink
        let duration: Double
    }

    public static let shared = TimerScheduleManager()

    private var tasksInProgress: [Task] = []
    private var durations: [Duration] = []

    public func startTimer(
        instruction: RecipeInstruction,
        duration: Double,
        block: @escaping ProgressBlock
    ) {
        guard let task = tasksInProgress.first(where: { $0.instruction.description == instruction.description }) else {
            let displayLink = CADisplayLink(
                target: self,
                selector: #selector(updateDisplayLink)
            )
            let newTask = Task(instruction: instruction, displayLink: displayLink)
            let newDuration = Duration(duration: duration, displayLink: displayLink)
            durations.append(newDuration)
            newTask.progressBlock = block
            tasksInProgress.append(newTask)
            displayLink.add(to: .main, forMode: .common)
            return
        }
        task.progressBlock = block
    }

    public func stopTimer(instruction: RecipeInstruction) {
        guard let taskIndex = tasksInProgress.firstIndex(where: { $0.instruction.description == instruction.description }) else { return }
        tasksInProgress[taskIndex].displayLink.invalidate()
        tasksInProgress[taskIndex].progressBlock = nil
        tasksInProgress.remove(at: taskIndex)
    }

    public func observe(instruction: RecipeInstruction, block: @escaping ProgressBlock) {
        guard let task = tasksInProgress.first(where: { $0.instruction.description == instruction.description }) else { return }
        task.progressBlock = block
        updateDisplayLink(displayLink: task.displayLink)
    }

    public func isTaskRunning(instruction: RecipeInstruction) -> Bool {
        return tasksInProgress.contains(where: { $0.instruction.description == instruction.description })
    }

    public func taskProgress(instruction: RecipeInstruction) -> ProgressInfo? {
        guard let task = tasksInProgress.first(where: { $0.instruction.description == instruction.description }) else { return nil }
        updateDisplayLink(displayLink: task.displayLink)
        guard let taskProgress = task.progress else { return nil }
        return ProgressInfo(
            progress: taskProgress,
            seconds: CACurrentMediaTime() - task.startTime,
            instruction: task.instruction
        )
    }

    public func removeAllTasks() {
        for task in tasksInProgress {
            stopTimer(instruction: task.instruction)
        }
    }

    public func removeTask(instruction: RecipeInstruction) {
        guard let taskIndex = tasksInProgress.firstIndex(where: { $0.instruction.description == instruction.description }) else { return }
        tasksInProgress.remove(at: taskIndex)
    }

    public func getCurrentTaskItems() -> [RecipeInstruction] {
        return tasksInProgress.map { $0.instruction }
    }

//    public func setDuration(_ value: Double) {
//        duration = value
//    }
//
//    public func getDuration() -> Double {
//        return duration
//    }

    @objc
    private func updateDisplayLink(displayLink: CADisplayLink) {
        guard
            let task = tasksInProgress.first(where: { $0.displayLink == displayLink }),
            let timer = durations.first(where: { $0.displayLink == displayLink })
        else { return }
        var elapsedTime = CACurrentMediaTime() - task.startTime
        var isFinished: Bool
        task.progress = elapsedTime / timer.duration
        if elapsedTime >= timer.duration {
            elapsedTime = timer.duration
            isFinished = true
            task.progressBlock?(
                elapsedTime / timer.duration,
                elapsedTime,
                isFinished,
                task.instruction
            )
            stopTimer(instruction: task.instruction)
        } else {
            isFinished = false
            task.progressBlock?(
                elapsedTime / timer.duration,
                elapsedTime,
                isFinished,
                task.instruction
            )
        }
    }
}
