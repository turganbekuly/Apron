//
//  Throttler.swift
//  Extensions
//
//  Created by Akarys Turganbekuly on 31.05.2022.
//

import Foundation

public class Throttler {
    private var workItem = DispatchWorkItem { }
    private var previousRun = Date.distantPast
    private let queue: DispatchQueue
    private let minimumDelay: TimeInterval

    public init(minimumDelay: TimeInterval, queue: DispatchQueue = DispatchQueue.main) {
        self.minimumDelay = minimumDelay
        self.queue = queue
    }

    public func throttle(_ block: @escaping () -> Void) {
        workItem.cancel()
        workItem = DispatchWorkItem { [weak self] in
            self?.previousRun = Date()
            block()
        }
        queue.asyncAfter(deadline: .now() + Double(minimumDelay), execute: workItem)
    }
}

