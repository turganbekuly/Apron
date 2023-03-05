//
//  TasteOnboardingHeaderViewModel.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 06.01.2022.
//

public protocol ITasteOnboardingHeaderViewModel {
    var title: String { get }
}

public final class TasteOnboardingHeaderViewModel: ITasteOnboardingHeaderViewModel {
    // MARK: - PreviewHeaderViewModelProtocol

    public var title: String

    // MARK: - Init

    public init(title: String) {
        self.title = title
    }

}
