//
//  HapticTouch.swift
//  Pods
//
//  Created by Akarys Turganbekuly on 06.01.2022.
//

import Haptica

public final class HapticTouch {

    // MARK: - Init

    public init() {}

    // MARK: - Methods

    public static func generateError() {
        Haptic.play([.haptic(.notification(.error))])
    }

    public static func generateSuccess() {
        Haptic.play([.haptic(.notification(.success))])
    }

    public static func generateLight() {
        Haptic.impact(.light).generate()
    }

    public static func generateMedium() {
        Haptic.impact(.medium).generate()
    }

}
